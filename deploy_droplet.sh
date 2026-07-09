#!/usr/bin/env bash
#
# Deploy Vestigette files to the production DigitalOcean droplet.
# (Separate from deploy.sh, which syncs to the local MAMP web root.)
#
# Usage:
#   ./deploy_droplet.sh          # deploy everything (PHP + static + bot)
#   ./deploy_droplet.sh php      # PHP web files + static assets (css/js)
#   ./deploy_droplet.sh bot      # bot scripts + data
#
# Connections are batched (one scp, one ssh per group) to avoid tripping the
# droplet's SSH rate-limiting / fail2ban, which rejects rapid repeat connections.
#
# Secrets (.env, persona_credentials.json) are deliberately NOT deployed here —
# they live on the droplet and rarely change. Deploy them manually if needed.

set -euo pipefail

DROPLET="root@178.128.74.45"
WEB_ROOT="/var/www/html"
BOT_DIR="/var/www/bot"
SRC="/Users/Razzmatazz/vestigette-dev"

PHP_FILES=(
    functions.php
    flesh_out.php
    register.php
    find_similar.php
    search_affiliations.php
    About.php
    Explore.php
    Profile.php
    index.php
    query_current_argument.php
    login.php
    admin_tools.php
    neighborhood.php
    donate.php
    create_donation_session.php
    donate_success.php
    blog.php
    post.php
    page.php
    admin_content.php
    upload_image.php
    og_image.php
    graph_search.php
)

STATIC_FILES=(
    style_vestigette.css
    script_vestigette.js
    robots.txt
    .htaccess
)

# Files under includes/ — synced to $WEB_ROOT/includes/ (not the flat web root).
INCLUDE_FILES=(
    Parsedown.php
    content_chrome.php
    dbconnect.php
)

BOT_FILES=(
    persona_bot.py
    process_seed_queue.py
    seed_argument.py
    seed_cluster.py
    personas_all_26.json
    topic_clusters.json
)

deploy_php() {
    echo "→ Deploying PHP + static assets to $WEB_ROOT (single transfer)"
    local php_paths=() static_paths=()
    for f in "${PHP_FILES[@]}";    do php_paths+=("$SRC/$f"); done
    for f in "${STATIC_FILES[@]}"; do static_paths+=("$SRC/$f"); done
    # One scp connection for everything (-r also syncs pages/ — the
    # standing-page markdown sources rendered by page.php)
    scp -r "${php_paths[@]}" "${static_paths[@]}" "$SRC/pages" "$DROPLET:$WEB_ROOT/"

    # includes/ files (separate destination dir)
    if [ ${#INCLUDE_FILES[@]} -gt 0 ]; then
        local include_paths=()
        for f in "${INCLUDE_FILES[@]}"; do include_paths+=("$SRC/includes/$f"); done
        scp "${include_paths[@]}" "$DROPLET:$WEB_ROOT/includes/"
    fi

    echo "→ Linting deployed PHP (single connection)"
    local lint_cmd=""
    for f in "${PHP_FILES[@]}"; do
        lint_cmd+="php -l $WEB_ROOT/$f || exit 1; "
    done
    for f in "${INCLUDE_FILES[@]}"; do
        lint_cmd+="php -l $WEB_ROOT/includes/$f || exit 1; "
    done
    if ssh "$DROPLET" "$lint_cmd" >/dev/null; then
        echo "   ok: all PHP files lint clean"
    else
        echo "   PHP LINT FAILED — check output above"; exit 1
    fi
}

deploy_bot() {
    echo "→ Deploying bot scripts to $BOT_DIR (single transfer)"
    local bot_paths=()
    for f in "${BOT_FILES[@]}"; do bot_paths+=("$SRC/bots/$f"); done
    ssh "$DROPLET" "mkdir -p $BOT_DIR"
    scp "${bot_paths[@]}" "$DROPLET:$BOT_DIR/"

    echo "→ Compile-checking deployed Python (single connection)"
    ssh "$DROPLET" "cd $BOT_DIR && python3 -m py_compile persona_bot.py process_seed_queue.py seed_argument.py seed_cluster.py" \
        && echo "   ok: python compiles"
}

TARGET="${1:-all}"
case "$TARGET" in
    php) deploy_php ;;
    bot) deploy_bot ;;
    all) deploy_php; deploy_bot ;;
    *)   echo "Unknown target: $TARGET (use php | bot | all)"; exit 1 ;;
esac

echo "Deploy complete."

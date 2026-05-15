#!/bin/bash

# Vestigette Deployment Script
# Safely copies files from dev to MAMP production

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Directories
DEV_DIR="/Users/Razzmatazz/vestigette-dev"
PROD_DIR="/Users/Razzmatazz/localHost/root"
BACKUP_DIR="/Users/Razzmatazz/vestigette-backups"

# Ensure we're in the dev directory
cd "$DEV_DIR"

echo -e "${YELLOW}Vestigette Deployment Script${NC}"
echo "================================"
echo ""

# Check if git repo is clean
if [[ -n $(git status -s) ]]; then
    echo -e "${YELLOW}Warning: You have uncommitted changes${NC}"
    git status -s
    echo ""
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Deployment cancelled"
        exit 1
    fi
fi

# Show current branch
CURRENT_BRANCH=$(git branch --show-current)
echo -e "Current branch: ${GREEN}$CURRENT_BRANCH${NC}"
echo ""

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create timestamped backup of production
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_PATH="$BACKUP_DIR/backup_$TIMESTAMP"

echo "Creating backup of current production..."
mkdir -p "$BACKUP_PATH"
cp -R "$PROD_DIR"/* "$BACKUP_PATH/"
echo -e "${GREEN}✓${NC} Backup created at: $BACKUP_PATH"
echo ""

# Copy files to production (excluding .git and config)
echo "Deploying files to MAMP..."
rsync -av --exclude='.git' \
         --exclude='.gitignore' \
         --exclude='deploy.sh' \
         --exclude='GIT_WORKFLOW.md' \
         --exclude='PROJECT.md' \
         --exclude='includes/config.local.php' \
         "$DEV_DIR/" "$PROD_DIR/"

echo -e "${GREEN}✓${NC} Files deployed successfully"
echo ""

# Verify config exists in production
if [ ! -f "$PROD_DIR/includes/config.local.php" ]; then
    echo -e "${RED}⚠ WARNING: config.local.php not found in production!${NC}"
    echo "You may need to manually copy it from the backup or recreate it"
fi

echo "================================"
echo -e "${GREEN}Deployment Complete!${NC}"
echo ""
echo "Production location: $PROD_DIR"
echo "Backup location: $BACKUP_PATH"
echo ""
echo "Test your changes at: http://localhost/"
echo ""

# Keep only last 10 backups
BACKUP_COUNT=$(ls -1 "$BACKUP_DIR" | wc -l | xargs)
if [ "$BACKUP_COUNT" -gt 10 ]; then
    echo "Cleaning up old backups (keeping 10 most recent)..."
    cd "$BACKUP_DIR"
    ls -t | tail -n +11 | xargs rm -rf
    echo -e "${GREEN}✓${NC} Old backups cleaned"
fi

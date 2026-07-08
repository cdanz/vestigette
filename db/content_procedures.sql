-- CONTENT: simple editable, taggable content pages (FAQ / glossary / essays).
-- Markdown body (rendered with Parsedown). Authored via admin_content.php,
-- read at /post.php?slug=... and listed at /blog.php (optionally ?tag=...).

USE vestigette;

CREATE TABLE IF NOT EXISTS CONTENT (
    contentID  INT UNSIGNED NOT NULL AUTO_INCREMENT,
    slug       VARCHAR(160) NOT NULL,
    title      VARCHAR(200) NOT NULL,
    summary    VARCHAR(400) NULL,
    body       MEDIUMTEXT   NULL,             -- Markdown source
    tags       VARCHAR(300) NULL,             -- comma-separated, lowercased
    status     ENUM('draft','published') NOT NULL DEFAULT 'draft',
    authorID   INT UNSIGNED NULL,
    createdAt  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (contentID),
    UNIQUE KEY uq_slug (slug),
    KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------
-- Table countries
-- ---------------------------
DROP TABLE IF EXISTS countries;
CREATE TABLE IF NOT EXISTS countries (
    id BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    code VARCHAR(10) NOT NULL,
    description VARCHAR(255),
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME
);

CREATE UNIQUE INDEX code_UNIQUE ON countries (code ASC) VISIBLE;
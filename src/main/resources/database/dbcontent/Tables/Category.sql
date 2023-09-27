/*
Author: Rabin Rai
Created On: 9/24/2023
Updated On: 9/26/2023
Description: Create table for Category
*/

-- ---------------------------
-- Table categories
-- ---------------------------
DROP TABLE IF EXISTS categories;

CREATE TABLE IF NOT EXISTS categories (
    id BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME
);

CREATE UNIQUE INDEX name_UNIQUE ON categories (name ASC) VISIBLE;
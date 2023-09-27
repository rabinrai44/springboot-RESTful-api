/*
Author: Rabin Rai
Created On: 9/24/2023
Updated On: 9/26/2023
Description: Create table for cart
*/
-- ---------------------------
-- Table carts
-- ---------------------------
CREATE TABLE IF NOT EXISTS carts (
    id VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()),
    userId VARCHAR(36) NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT NULL
);

CREATE UNIQUE INDEX id_UNIQUE ON carts (id ASC) VISIBLE;
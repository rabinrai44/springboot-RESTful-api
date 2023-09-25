/*
Author: Rabin Rai
Created On: 8/24/2023
Description: Create table for cart
*/
-- ---------------------------
-- Table `dbweb`.`cart`
-- ---------------------------
CREATE TABLE IF NOT EXISTS `dbo.cart` (
    id VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()),
    userId VARCHAR(36) NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT NULL
);

CREATE UNIQUE INDEX `id_UNIQUE` ON `dbo.cart` (`id` ASC) VISIBLE;
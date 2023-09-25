/*
Author: Rabin Rai
Created On: 8/24/2023
Description: Create table for cartItem
*/
-- ---------------------------
-- Table `dbweb`.`dbo.cart_item`
-- ---------------------------
CREATE TABLE IF NOT EXISTS `dbo.cart_item` (
    id VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()),
    cartId VARCHAR(36) NOT NULL,
    itemNo VARCHAR(55) NOT NULL,
    quantity INT NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT NULL
);

CREATE UNIQUE INDEX `id_UNIQUE` ON `dbo.cart_item` (`id` ASC) VISIBLE;
/*
Author: Rabin Rai
Created On: 8/24/2023
Updated On: 9/26/2023
Description: Create table for cartItem
*/
-- ---------------------------
-- Table cart_items
-- ---------------------------
CREATE TABLE IF NOT EXISTS cart_items (
    id VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()),
    cartId VARCHAR(36) NOT NULL,
    itemNo VARCHAR(55) NOT NULL,
    quantity INT NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT NULL
);

CREATE UNIQUE INDEX id_UNIQUE ON cart_items (id ASC) VISIBLE;
/*
Author: Rabin Rai
Created On: 8/24/2023
Description: Create table for item
*/
-- ---------------------------
-- Table `dbcontent`.`dbo.item`
-- ---------------------------
DROP TABLE IF EXISTS `dbo.item` ;

CREATE TABLE IF NOT EXISTS `dbo.item` (
    id BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    itemNo VARCHAR(100) NOT NULL,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(256),
    unitPrice DECIMAL(10,2) NOT NULL,
    inStock BOOLEAN NOT NULL,
    minOrderQty INT NOT NULL,
    maxOrderQty INT NOT NULL,
    imageUrl VARCHAR(255),
    vendorId INT,
    categoryId INT,
    countryId INT NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT NULL
)

CREATE UNIQUE INDEX `item_itemNo_uindex` ON `dbo.item` (`itemNo` ASC) VISIBLE;
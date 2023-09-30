/*
Author: Rabin Rai
Created On: 8/24/2023
Description: Create table for item
*/
-- ---------------------------
-- Table items
-- ---------------------------
DROP TABLE IF EXISTS item;

CREATE TABLE `item` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `itemNo` varchar(100) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(256) DEFAULT NULL,
  `unitPrice` decimal(10,2) NOT NULL,
  `inStock` tinyint(1) NOT NULL,
  `minOrderQty` int NOT NULL,
  `maxOrderQty` int NOT NULL,
  `imageUrl` varchar(255) DEFAULT NULL,
  `vendorId` int DEFAULT NULL,
  `categoryId` int DEFAULT NULL,
  `countryId` int NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `itemNo` (`itemNo`)
);
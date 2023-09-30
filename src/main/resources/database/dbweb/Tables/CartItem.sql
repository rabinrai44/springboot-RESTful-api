/*
Author: Rabin Rai
Created On: 8/24/2023
Updated On: 9/26/2023
Description: Create table for cartItem
*/

CREATE TABLE `cart_item` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cartId` bigint unsigned NOT NULL,
  `itemNo` varchar(55) NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `price` decimal(10,2) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `cart_item_cart_fk` (`cartId`),
  CONSTRAINT `cart_item_cart_fk` FOREIGN KEY (`cartId`) REFERENCES `cart` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
);
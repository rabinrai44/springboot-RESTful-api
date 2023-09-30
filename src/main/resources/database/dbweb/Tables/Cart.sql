/*
Author: Rabin Rai
Created On: 9/24/2023
Updated On: 9/26/2023
Description: Create table for cart
*/
-- ---------------------------
-- Table cart
-- ---------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `userId` binary(16) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQ_cart_userId` (`userId`)
);
/*
Author: Rabin Rai
Created On: 9/24/2023
Updated On: 9/26/2023
Description: Create table for User
*/

-- ---------------------------
-- Table user
-- ---------------------------
DROP TABLE IF EXISTS user;
CREATE TABLE `user` (
  `id` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(12) NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `bio` varchar(255) DEFAULT NULL,
  `imageUrl` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `isNotLocked` tinyint(1) NOT NULL DEFAULT '1',
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
);

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
  `id` varchar(255) NOT NULL DEFAULT (uuid()),
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `bio` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `user_id_not_empty` CHECK ((`id` <> _utf8mb4''))
);
/*
Author: Rabin Rai
Created On: 8/24/2023
Description: Create table for Vendor
*/

-- ---------------------------
-- Table vendor
-- ---------------------------
DROP TABLE IF EXISTS vendor;

CREATE TABLE `vendor` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

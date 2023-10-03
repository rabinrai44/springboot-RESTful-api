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
  `item_no` varchar(100) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(256) DEFAULT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `in_stock` tinyint(1) NOT NULL,
  `min_order_qty` int NOT NULL,
  `max_order_qty` int NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `vendor_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `country_id` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `item_no` (`item_no`)
);
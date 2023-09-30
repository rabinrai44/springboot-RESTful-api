-- ---------------------------
-- Table countries
-- ---------------------------
DROP TABLE IF EXISTS country;
CREATE TABLE `country` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `code` varchar(10) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`)
);

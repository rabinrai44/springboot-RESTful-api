/*
Author: Rabin Rai
Created On: 8/24/2023
Description: Create table for Category
*/

-- ---------------------------
-- Table `dbcontent`.`dbo.category`
-- ---------------------------
DROP TABLE IF EXISTS `dbo.category`;

CREATE TABLE IF NOT EXISTS `dbo.category` (
    id BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME
);

CREATE UNIQUE INDEX `name_UNIQUE` ON `dbo.category` (`name` ASC) VISIBLE;
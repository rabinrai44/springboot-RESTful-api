/*
Author: Rabin Rai
Created On: 8/24/2023
Description: Create table for Vendor
*/

-- ---------------------------
-- Table `dbcontent`.`vendor`
-- ---------------------------
DROP TABLE IF EXISTS `dbo.vendor`;

CREATE TABLE IF NOT EXISTS `dbo.vendor` (
    id BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME
)

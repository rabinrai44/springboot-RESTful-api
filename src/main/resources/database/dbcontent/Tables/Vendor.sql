/*
Author: Rabin Rai
Created On: 8/24/2023
Description: Create table for Vendor
*/

-- ---------------------------
-- Table vendors
-- ---------------------------
DROP TABLE IF EXISTS vendors;

CREATE TABLE IF NOT EXISTS vendors (
    id BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME
)

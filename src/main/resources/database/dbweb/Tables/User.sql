/*
Author: Rabin Rai
Created On: 8/24/2023
Description: Create table for User
*/

-- ---------------------------
-- Table `dbweb`.`user`
-- ---------------------------
CREATE TABLE IF NOT EXISTS `dbo.user` (
    id VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()),
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100),
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(100),
    password VARCHAR(255) NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME
);

CREATE UNIQUE INDEX `email_UNIQUE` ON `dbo.user` (`email` ASC) VISIBLE;
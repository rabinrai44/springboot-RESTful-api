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
    phone VARCHAR(12),
    password VARCHAR(255) NOT NULL,
    title VARCHAR(100),
    bio VARCHAR(255),
    imageUrl VARCHAR(255),
    enabled TINYINT(1) NOT NULL DEFAULT 1,
    isNotLocked TINYINT(1) NOT NULL DEFAULT 1,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME
);

CREATE UNIQUE INDEX `email_UNIQUE` ON `dbo.user` (`email` ASC) VISIBLE;


-- ALTER TABLE 
-- ALTER TABLE `dbo.user` 
-- ADD COLUMN `title` VARCHAR(100) NULL AFTER `password`,
-- ADD COLUMN `bio` VARCHAR(255) NULL AFTER `title`,
-- ADD COLUMN `imageUrl` VARCHAR(255) NULL AFTER `bio`,
-- ADD COLUMN `enabled` TINYINT(1) NOT NULL DEFAULT 1 AFTER `imageUrl`,
-- ADD COLUMN `isNotLocked` TINYINT(1) NOT NULL DEFAULT 1 AFTER `enabled`;

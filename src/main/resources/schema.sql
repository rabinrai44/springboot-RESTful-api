
-- ---------------------------
-- Schema dbweb
-- ---------------------------
DROP SCHEMA IF EXISTS `dbweb`;

CREATE SCHEMA IF NOT EXISTS `dbweb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `dbweb`;

-- ---------------------------
-- Table `dbweb`.`user`
-- ---------------------------
CREATE TABLE IF NOT EXISTS `dbo.user` (
    `id` VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()),
    `firstName` VARCHAR(100) NOT NULL,
    `lastName` VARCHAR(100),
    `email` VARCHAR(100) NOT NULL,
    `phone` VARCHAR(100),
    `password` VARCHAR(255) NOT NULL,
    `createdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedDate` DATETIME
)

DEFAULT CHARACTER SET = utf8mb4;

CREATE UNIQUE INDEX `email_UNIQUE` ON `dbo.user` (`email` ASC) VISIBLE;

-- ---------------------------
-- Table `dbweb`.`country`
-- ---------------------------
CREATE TABLE IF NOT EXISTS `dbo.country` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `code` VARCHAR(10) NOT NULL,
    `description` VARCHAR(255),
    `createdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedDate` DATETIME
)

DEFAULT CHARACTER SET = utf8mb4;

CREATE UNIQUE INDEX `code_UNIQUE` ON `dbo.country` (`code` ASC) VISIBLE;

-- ---------------------------
-- Table `dbweb`.`cart`
-- ---------------------------
CREATE TABLE IF NOT EXISTS `dbo.cart` (
    `id` VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()),
    `userId` VARCHAR(36) NOT NULL,
    `createdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedDate` DATETIME DEFAULT NULL
)

DEFAULT CHARACTER SET = utf8mb4;
CREATE UNIQUE INDEX `id_UNIQUE` ON `dbo.cart` (`id` ASC) VISIBLE;


-- ---------------------------
-- Table `dbweb`.`cart_item`
-- ---------------------------
CREATE TABLE IF NOT EXISTS `dbo.cartItem` (
    `id` VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()),
    `cartId` VARCHAR(36) NOT NULL,
    `itemNo` VARCHAR(55) NOT NULL,
    `quantity` INT NOT NULL,
    `createdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedDate` DATETIME DEFAULT NULL
)

DEFAULT CHARACTER SET = utf8mb4;
CREATE UNIQUE INDEX `id_UNIQUE` ON `dbo.cartItem` (`id` ASC) VISIBLE;



-- ---------------------------
-- Schema dbcontent
-- ---------------------------
CREATE SCHEMA IF NOT EXISTS `dbcontent` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;

USE `dbcontent`;
-- ---------------------------
-- Table `dbcontent`.`dbo.item`
-- ---------------------------
CREATE TABLE IF NOT EXISTS `dbo.item` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `itemNo` VARCHAR(100) NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `description` VARCHAR(256),
    `unitPrice` DECIMAL(10,2) NOT NULL,
    `inStock` BOOLEAN NOT NULL,
    `minOrderQty` INT NOT NULL,
    `maxOrderQty` INT NOT NULL,
    `imageUrl` VARCHAR(255),
    `vendorId` INT,
    `categoryId` INT,
    `countryId` INT NOT NULL,
    `createdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedDate` DATETIME DEFAULT NULL
)

DEFAULT CHARACTER SET = utf8mb4;
CREATE UNIQUE INDEX `itemNo_UNIQUE` ON `dbo.item` (`itemNo` ASC) VISIBLE;

-- ---------------------------
-- Table `dbcontent`.`dbo.category`
-- ---------------------------
CREATE TABLE IF NOT EXISTS `dbo.category` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `description` VARCHAR(255),
    `createdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedDate` DATETIME
)

DEFAULT CHARACTER SET = utf8mb4;
CREATE UNIQUE INDEX `name_UNIQUE` ON `dbo.category` (`name` ASC) VISIBLE;

-- ---------------------------
-- Table `dbcontent`.`vendor`
-- ---------------------------
CREATE TABLE IF NOT EXISTS `dbo.vendor` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `description` VARCHAR(255),
    `createdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedDate` DATETIME
)

DEFAULT CHARACTER SET = utf8mb4;

-- ---------------------------
-- INSERT DATA
-- ---------------------------


-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema dbcontent
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dbcontent
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbcontent` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `dbcontent` ;

-- -----------------------------------------------------
-- Table `dbcontent`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbcontent`.`categories` ;

CREATE TABLE IF NOT EXISTS `dbcontent`.`categories` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbcontent`.`items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbcontent`.`items` ;

CREATE TABLE IF NOT EXISTS `dbcontent`.`items` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemNo` VARCHAR(100) NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `description` VARCHAR(256) NULL DEFAULT NULL,
  `unitPrice` DECIMAL(10,2) NOT NULL,
  `inStock` TINYINT(1) NOT NULL,
  `minOrderQty` INT NOT NULL,
  `maxOrderQty` INT NOT NULL,
  `imageUrl` VARCHAR(255) NULL DEFAULT NULL,
  `vendorId` INT NULL DEFAULT NULL,
  `categoryId` INT NULL DEFAULT NULL,
  `countryId` INT NOT NULL,
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `item_itemNo_uindex` (`itemNo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbcontent`.`vendors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbcontent`.`vendors` ;

CREATE TABLE IF NOT EXISTS `dbcontent`.`vendors` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `dbcontent` ;

-- -----------------------------------------------------
-- procedure spAddCategory
-- -----------------------------------------------------

USE `dbcontent`;
DROP procedure IF EXISTS `dbcontent`.`spAddCategory`;

DELIMITER $$
USE `dbcontent`$$
CREATE PROCEDURE `spAddCategory`(
    IN name VARCHAR(100),
    IN description VARCHAR(255)
)
BEGIN
    -- Validations
    IF name IS NULL OR name = '' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Name cannot be empty';
    END IF;
    
    INSERT INTO `categories` (
        name,
        description
        )
    VALUES(name, description);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spAddItem
-- -----------------------------------------------------

USE `dbcontent`;
DROP procedure IF EXISTS `dbcontent`.`spAddItem`;

DELIMITER $$
USE `dbcontent`$$
CREATE PROCEDURE `spAddItem`(
    IN itemNo VARCHAR(50),
    IN title VARCHAR(100),
    IN description VARCHAR(256),
    IN unitPrice DECIMAL(10,2),
    IN inStock BOOLEAN,
    IN minOrderQty INT(1),
    IN maxOrderQty INT(10),
    IN imageUrl VARCHAR(255),
    IN categoryId INT,
    IN vendorId INT,
    IN countryId INT
)
BEGIN
    -- Validation

    -- Check if itemNo is empty
    IF itemNo = '' OR itemNo IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Item number cannot be empty';
    END IF;

    -- Check if title is empty
    IF title = '' OR title IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Title cannot be empty';
    END IF;

    -- Check if unitPrice is empty
    IF unitPrice = '' OR unitPrice IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Unit price cannot be empty';
    END IF;

    -- Check if countryId is empty
    IF countryId = '' OR countryId IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Country cannot be empty';
    END IF;



    INSERT INTO `items`
    (
        itemNo,
        title,
        description,
        unitPrice,
        inStock,
        minOrderQty,
        maxOrderQty,
        imageUrl,
        categoryId,
        vendorId,
        countryId
    )
    VALUES
    (
        itemNo,
        title,
        description,
        unitPrice,
        inStock,
        minOrderQty,
        maxOrderQty,
        imageUrl,
        categoryId,
        vendorId,
        countryId
    );

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spDeleteCategory
-- -----------------------------------------------------

USE `dbcontent`;
DROP procedure IF EXISTS `dbcontent`.`spDeleteCategory`;

DELIMITER $$
USE `dbcontent`$$
CREATE PROCEDURE `spDeleteCategory`(
    IN categoryId INT
)
BEGIN
    -- Check if categoryId is null
    IF categoryId IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'categoryId cannot be null';
    END IF;

    -- Validation 
    IF (SELECT COUNT(*) FROM categories WHERE id = categoryId) = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Category does not exist';
    END IF;

    -- Delete category
    DELETE FROM category 
    WHERE id = categoryId;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spDeleteItem
-- -----------------------------------------------------

USE `dbcontent`;
DROP procedure IF EXISTS `dbcontent`.`spDeleteItem`;

DELIMITER $$
USE `dbcontent`$$
CREATE PROCEDURE `spDeleteItem`(IN itemNo INT)
BEGIN
    -- Validation
    IF itemNo IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'itemNo cannot be null';
    END IF;

    -- Check if exists in item table
    IF NOT EXISTS(SELECT * FROM item WHERE itemNo = itemNo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'itemNo does not exist in item table';
    END IF;

    -- Delete from item table
    DELETE FROM item WHERE itemNo = itemNo;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spUpdateCategory
-- -----------------------------------------------------

USE `dbcontent`;
DROP procedure IF EXISTS `dbcontent`.`spUpdateCategory`;

DELIMITER $$
USE `dbcontent`$$
CREATE PROCEDURE `spUpdateCategory`(
    IN id INT,
    IN name VARCHAR(100),
    IN description VARCHAR(255)
)
BEGIN
    -- Validations
    -- Check if category exists
    IF id IS NULL OR id <= 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Category id cannot be empty or less than 0';
    END IF;

    -- Check if category exists
    IF NOT EXISTS(SELECT * FROM `dbo.category` WHERE id = id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Category does not exist';
    END IF;

    IF name IS NULL OR name = '' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Name cannot be empty';
    END IF;
    
    -- Update category
    UPDATE `dbo.category` SET
        name = name,
        description = description,
        updatedDate = NOW()
    WHERE id = id;

END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

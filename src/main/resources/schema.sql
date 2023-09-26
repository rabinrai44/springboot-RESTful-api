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
-- -----------------------------------------------------
-- Schema dbweb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dbweb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbweb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `dbcontent` ;
USE `dbweb` ;

-- -----------------------------------------------------
-- Table `dbweb`.`cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbweb`.`cart` (
  `id` VARCHAR(36) NOT NULL DEFAULT (UUID()),
  `userId` VARCHAR(36) NOT NULL,
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbweb`.`cart_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbweb`.`cart_item` (
  `id` VARCHAR(36) NOT NULL DEFAULT (UUID()),
  `cartId` VARCHAR(36) NOT NULL,
  `itemNo` VARCHAR(55) NOT NULL,
  `quantity` INT NOT NULL,
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbweb`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbweb`.`country` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `code` VARCHAR(10) NOT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbweb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbweb`.`user` (
  `id` VARCHAR(36) NOT NULL DEFAULT (UUID()),
  `firstName` VARCHAR(100) NOT NULL,
  `lastName` VARCHAR(100) NULL DEFAULT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(100) NULL DEFAULT NULL,
  `password` VARCHAR(255) NOT NULL,
  `title` VARCHAR(100) NULL DEFAULT NULL,
  `bio` VARCHAR(255) NULL DEFAULT NULL,
  `imageUrl` VARCHAR(255) NULL DEFAULT NULL,
  `enabled` TINYINT(1) NULL DEFAULT NULL,
  `isNotLocked` TINYINT(1) NULL DEFAULT NULL,
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `dbcontent` ;

-- -----------------------------------------------------
-- procedure spAddCategory
-- -----------------------------------------------------

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
    
    INSERT INTO `category` (
        name,
        description
        )
    VALUES(name, description);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spAddItem
-- -----------------------------------------------------

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



    INSERT INTO `item`
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
    IF (SELECT COUNT(*) FROM category WHERE categoryId = categoryId) = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Category does not exist';
    END IF;

    -- Delete category
    DELETE FROM category 
    WHERE categoryId = categoryId;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spDeleteItem
-- -----------------------------------------------------

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
    IF NOT EXISTS(SELECT * FROM `category` WHERE id = id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Category does not exist';
    END IF;

    IF name IS NULL OR name = '' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Name cannot be empty';
    END IF;
    
    -- Update category
    UPDATE `category` SET
        name = name,
        description = description,
        updatedDate = NOW()
    WHERE id = id;

END$$

DELIMITER ;
USE `dbweb` ;

-- -----------------------------------------------------
-- procedure spAddUser
-- -----------------------------------------------------

DELIMITER $$
USE `dbweb`$$
CREATE PROCEDURE `spAddUser`(
    IN firstName VARCHAR(45),
    IN lastName VARCHAR(45),
    IN email VARCHAR(100),
    IN password VARCHAR(100),
    IN phone VARCHAR(12),
    IN title VARCHAR(100),
    IN bio VARCHAR(255),
    IN imageUrl VARCHAR(255),
    IN enabled TINYINT(1),
    IN isNotLocked TINYINT(1)
)
BEGIN
    DECLARE userCount INT DEFAULT 0;
    
    -- Validate firstName
    IF firstName IS NULL OR LENGTH(firstName) = 0 OR firstName = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'First name cannot be empty';
    END IF;

    -- Validate email
    IF email IS NULL OR email = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email cannot be empty';
    END IF;

    -- Check if a user with the given email already exists
    IF email IS NOT NULL THEN
        SELECT COUNT(*) INTO userCount FROM users WHERE email = email;
        IF userCount > 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'A user with the same email already exists';
        END IF;
    END IF;    

    -- Validate password
    IF password IS NULL OR LENGTH(password) = 0 OR password = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Password cannot be empty';
    END IF;
    
    -- Insert the user into the database if all validations pass
      INSERT INTO users (firstName, lastName, email, password, phone, title, bio, imageUrl, enabled, isNotLocked)
      VALUES (firstName, lastName, email, password, phone, title, bio, imageUrl, enabled, isNotLocked);
END$$
DELIMITER ;

-- -----------------------------------------------------
-- procedure spUpdateUser
-- -----------------------------------------------------

DELIMITER $$
USE `dbweb`$$
CREATE PROCEDURE `spUpdateUser`(
    IN id VARCHAR(36),
    IN firstName VARCHAR(50),
    IN lastName VARCHAR(50),
    IN email VARCHAR(50),
    IN password VARCHAR(50),
    IN phone VARCHAR(12),
    IN title VARCHAR(100),
    IN bio VARCHAR(255),
    IN imageUrl VARCHAR(255),
    IN enabled TINYINT(1),
    IN isNotLocked TINYINT(1)
)
BEGIN

 -- Validation
 -- Check if user exists 
    IF (SELECT EXISTS(SELECT * FROM user WHERE Id = id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User does not exist';
    END IF;

    -- Check if FirstName is null
    IF (firstName IS NULL) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'FirstName cannot be null';
    END IF;

    -- Check if Email is null
    
    IF (email IS NULL) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email cannot be null';
    END IF;

    -- Check if Password is null
    IF (password IS NULL) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password cannot be null';
    END IF;

    UPDATE user SET
        firstName = firstName,
        
        email = email,
        password = password,
        phone = phone,
        title = title,
        bio = bio,
        imageUrl = imageUrl,
        enabled = enabled,
        isNotLocked = isNotLocked,
        updatedAt = NOW()
    WHERE Id = id;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

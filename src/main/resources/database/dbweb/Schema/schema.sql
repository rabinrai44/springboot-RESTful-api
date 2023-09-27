-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema dbweb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `dbweb` ;

-- -----------------------------------------------------
-- Schema dbweb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbweb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `dbweb` ;

-- -----------------------------------------------------
-- Table `dbweb`.`cart_items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbweb`.`cart_items` ;

CREATE TABLE IF NOT EXISTS `dbweb`.`cart_items` (
  `id` VARCHAR(36) NOT NULL DEFAULT (uuid()),
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
-- Table `dbweb`.`carts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbweb`.`carts` ;

CREATE TABLE IF NOT EXISTS `dbweb`.`carts` (
  `id` VARCHAR(36) NOT NULL DEFAULT (uuid()),
  `userId` VARCHAR(36) NOT NULL,
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbweb`.`countries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbweb`.`countries` ;

CREATE TABLE IF NOT EXISTS `dbweb`.`countries` (
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
-- Table `dbweb`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbweb`.`users` ;

CREATE TABLE IF NOT EXISTS `dbweb`.`users` (
  `id` VARCHAR(36) NOT NULL DEFAULT (uuid()),
  `firstName` VARCHAR(100) NOT NULL,
  `lastName` VARCHAR(100) NULL DEFAULT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(12) NULL DEFAULT NULL,
  `password` VARCHAR(255) NOT NULL,
  `title` VARCHAR(100) NULL DEFAULT NULL,
  `bio` VARCHAR(255) NULL DEFAULT NULL,
  `imageUrl` VARCHAR(255) NULL DEFAULT NULL,
  `enabled` TINYINT(1) NOT NULL DEFAULT '1',
  `isNotLocked` TINYINT(1) NOT NULL DEFAULT '1',
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `dbweb` ;

-- -----------------------------------------------------
-- procedure spAddUser
-- -----------------------------------------------------

USE `dbweb`;
DROP procedure IF EXISTS `dbweb`.`spAddUser`;

DELIMITER $$
USE `dbweb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAddUser`(
    IN _firstName VARCHAR(45),
    IN _lastName VARCHAR(45),
    IN _email VARCHAR(100),
    IN _password VARCHAR(100),
    IN _phone VARCHAR(12),
    IN _title VARCHAR(100),
    IN _bio VARCHAR(255),
    IN _imageUrl VARCHAR(255),
    IN _enabled TINYINT(1),
    IN _isNotLocked TINYINT(1)
)
BEGIN    
    DECLARE userCount INT DEFAULT 0;
    -- Validate firstName
    IF _firstName IS NULL OR LENGTH(_firstName) = 0 OR _firstName = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'First name cannot be empty';
    END IF;

    -- Validate email
    IF _email IS NULL OR _email = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email cannot be empty';
    END IF;

    -- Validate password
    IF _password IS NULL OR LENGTH(_password) = 0 OR _password = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Password cannot be empty';
    END IF;

    -- Check if the email already exists using spGetUserByEmail
    CALL spGetUserByEmail(_email, userCount);
    IF  userCount > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A user with the same email already exists';
    END IF;

    -- Insert the user into the database if all validations pass
    INSERT INTO users (firstName, lastName, email, password, phone, title, bio, imageUrl, enabled, isNotLocked)
    VALUES (_firstName, _lastName, _email, _password, _phone, _title, _bio, _imageUrl, _enabled, _isNotLocked);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spGetUserByEmail
-- -----------------------------------------------------

USE `dbweb`;
DROP procedure IF EXISTS `dbweb`.`spGetUserByEmail`;

DELIMITER $$
USE `dbweb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetUserByEmail`(
    IN _email VARCHAR(100),
    OUT _userCount INT
)
BEGIN 
    IF _email IS NOT NULL OR _email != '' THEN
        SET _email = LOWER(_email);
        SELECT * FROM users WHERE email = _email;
        SELECT FOUND_ROWS() INTO _userCount;
    ELSE 
        SET _userCount = 0;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spGetUserById
-- -----------------------------------------------------

USE `dbweb`;
DROP procedure IF EXISTS `dbweb`.`spGetUserById`;

DELIMITER $$
USE `dbweb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetUserById`(
    IN _id VARCHAR(100),
    OUT _userCount INT
)
BEGIN 
    IF _id IS NOT NULL OR _id != '' THEN
        SELECT * FROM users WHERE id = _id;
        SELECT FOUND_ROWS() INTO _userCount;
    ELSE 
        SET _userCount = 0;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure spUpdateUser
-- -----------------------------------------------------

USE `dbweb`;
DROP procedure IF EXISTS `dbweb`.`spUpdateUser`;

DELIMITER $$
USE `dbweb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spUpdateUser`(
    IN _id VARCHAR(36),
    IN _firstName VARCHAR(50),
    IN _lastName VARCHAR(50),
    IN _email VARCHAR(50),
    IN _password VARCHAR(50),
    IN _phone VARCHAR(12),
    IN _title VARCHAR(100),
    IN _bio VARCHAR(255),
    IN _imageUrl VARCHAR(255),
    IN _enabled TINYINT(1),
    IN _isNotLocked TINYINT(1)
)
BEGIN
DECLARE userCount INT;

 -- Validation
 -- Check if user exists 
    CALL spGetUserById(_id, userCount);

    IF userCount = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User does not exist';
    END IF;

    -- Check if FirstName is null
    IF (_firstName IS NULL) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'FirstName cannot be null';
    END IF;

    -- Check if Email is null
    
    IF (_email IS NULL) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email cannot be null';
    END IF;

    -- Check if Password is null
    IF (_password IS NULL) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password cannot be null';
    END IF;

    UPDATE users SET
        firstName = _firstName,
        
        email = _email,
        password = _password,
        phone = _phone,
        title = _title,
        bio = _bio,
        imageUrl = _imageUrl,
        enabled = _enabled,
        isNotLocked = _isNotLocked,
        updatedAt = NOW()
    WHERE Id = _id;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

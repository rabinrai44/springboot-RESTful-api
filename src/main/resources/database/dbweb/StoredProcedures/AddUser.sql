-- ======================================
-- Author:		Rabin Rai
-- Create date: 	2023-09-22
-- Description:	Stored Procedure for Add a new User
-- version:		1.0
-- ======================================
USE dbweb;
DROP PROCEDURE IF EXISTS `spAddUser`;

DELIMITER $$

CREATE PROCEDURE spAddUser(
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

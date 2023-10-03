-- ======================================
-- Author:		Rabin Rai
-- Created On: 	2023-09-22
-- Updated On: 	2023-09-26
-- Description:	Stored Procedure for Add a new User
-- version:		1.0
-- ======================================
USE dbweb;
DROP PROCEDURE IF EXISTS `spAddUser`;

DELIMITER $$

CREATE PROCEDURE spAddUser(
    IN id VARCHAR(255),
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

    -- Validate password
    IF password IS NULL OR LENGTH(password) = 0 OR password = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Password cannot be empty';
    END IF;

    -- Check if the email already exists using spGetUserByEmail
    CALL spGetUserByEmail(email);
    SELECT COUNT(*) INTO userCount;
    IF  userCount > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A user with the same email already exists';
    END IF;

    -- Check if id is not null or is not empty and is a valid uuid format if not then generate a new id
    IF id IS NULL OR id = '' OR LENGTH(id) = 0 OR ELSEIF LENGTH(id) != 36  THEN
        SET id = UUID();
    END IF;


    -- Check if the id is already taken
    SELECT COUNT(*) INTO userCount FROM user WHERE id = id;
   -- IF userCount > 0 THEN generate a new id
        SET id = UUID();
    END IF;

    -- Insert the user into the database if all validations pass
    INSERT INTO user (id, first_name, last_name, email, password, phone, title, bio, image_url, enabled, is_not_locked)
    VALUES (id, firstName, lastName, email, password, phone, title, bio, imageUrl, enabled, isNotLocked);
END$$

DELIMITER ;

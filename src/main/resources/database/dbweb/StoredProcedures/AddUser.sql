-- ======================================
-- Author:		Rabin Rai
-- Created On: 	2023-09-22
-- Updated On: 	9
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
    INSERT INTO user (firstName, lastName, email, password, phone, title, bio, imageUrl, enabled, isNotLocked)
    VALUES (_firstName, _lastName, _email, _password, _phone, _title, _bio, _imageUrl, _enabled, _isNotLocked);
END$$

DELIMITER ;

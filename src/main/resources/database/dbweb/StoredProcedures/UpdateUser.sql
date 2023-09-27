/*
Author: Rabin Rai
Created On: 8/23/2023
Description: Stored procedure to update User
Version: 1.0
*/
USE dbweb;
DROP PROCEDURE IF EXISTS `spUpdateUser`;

DELIMITER $$

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
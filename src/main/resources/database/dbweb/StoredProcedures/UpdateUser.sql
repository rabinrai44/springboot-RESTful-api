/*
Author: Rabin Rai
Created On: 8/23/2023
Description: Stored procedure to update User
Version: 1.0
*/
DROP PROCEDURE IF EXISTS `spUpdateUser`;

DELIMITER $$

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
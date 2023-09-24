/*
Author: Rabin Rai
Created On: 8/23/2023
Description: Stored procedure to update User
Version: 1.0
*/
DROP PROCEDURE IF EXISTS `spUpdateUser`;

DELIMITER $$

CREATE PROCEDURE `spUpdateUser`(
    IN pId INT,
    IN pFirstName VARCHAR(50),
    IN pEmail VARCHAR(50),
    IN pPassword VARCHAR(50),
    IN pPone INT
)
BEGIN

 -- Validation
 -- Check if user exists 
    IF (SELECT EXISTS(SELECT * FROM user WHERE Id = pId)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User does not exist';
    END IF;

    -- Check if FirstName is null
    IF (pFirstName IS NULL) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'FirstName cannot be null';
    END IF;

    -- Check if Email is null
    IF (pEmail IS NULL) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email cannot be null';
    END IF;

    -- Check if Password is null
    IF (pPassword IS NULL) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password cannot be null';
    END IF;

    UPDATE user SET
        firstName = pFirstName,
        email = pEmail,
        password = pPassword,
        phone = pPone,
        updatedDate = NOW()
    WHERE Id = pId;
END$$

DELIMITER ;
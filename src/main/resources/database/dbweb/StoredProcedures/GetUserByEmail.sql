-- ======================================
-- Author:		Rabin Rai
-- Created On: 	2023-09-26
-- Description:	Stored Procedure for getting user by email
-- version:		1.0
-- ======================================
USE dbweb;
DROP PROCEDURE IF EXISTS `spGetUserByEmail`;

DELIMITER $$
CREATE PROCEDURE `spGetUserByEmail`(
    IN _email VARCHAR(100)
)
BEGIN 
    IF _email IS NOT NULL OR _email != '' THEN
        SET _email = LOWER(_email);
        SELECT * FROM users WHERE email = _email;
    ELSE 
        SET _userCount = 0;
    END IF;
END$$
DELIMITER ;
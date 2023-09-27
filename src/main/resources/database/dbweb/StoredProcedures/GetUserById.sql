-- ======================================
-- Author:		Rabin Rai
-- Created On: 	2023-09-26
-- Description:	Stored Procedure for getting user by id
-- version:		1.0
-- ======================================
USE dbweb;
DROP PROCEDURE IF EXISTS `spGetUserById`;

DELIMITER $$
CREATE PROCEDURE `spGetUserById`(
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

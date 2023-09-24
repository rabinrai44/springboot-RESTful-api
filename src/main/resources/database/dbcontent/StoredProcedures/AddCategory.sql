/*
Author: Rabin Rai
Created On: 8/23/2023
Description: Stored procedure to add a new category
Version: 1.0
*/

DROP PROCEDURE IF EXISTS spAddCategory;

DELIMITER $$
CREATE PROCEDURE spAddCategory(
    IN name VARCHAR(100),
    IN description VARCHAR(255)
)
BEGIN
    -- Validations
    IF name IS NULL OR name = '' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Name cannot be empty';
    END IF;
    
    INSERT INTO `dbo.category` (
        name,
        description
        )
    VALUES(name, description);
END$$

DELIMITER ;


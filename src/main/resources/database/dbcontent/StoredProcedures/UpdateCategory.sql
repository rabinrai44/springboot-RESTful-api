/*
Author: Rabin Rai
Created On: 8/23/2023
Description: Stored procedure to update category
Version: 1.0
*/

DROP PROCEDURE IF EXISTS spUpdateCategory;

DELIMITER $$
CREATE PROCEDURE spUpdateCategory(
    IN id INT,
    IN name VARCHAR(100),
    IN description VARCHAR(255)
)
BEGIN
    -- Validations
    -- Check if category exists
    IF id IS NULL OR id <= 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Category id cannot be empty or less than 0';
    END IF;

    -- Check if category exists
    IF NOT EXISTS(SELECT * FROM `dbo.category` WHERE id = id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Category does not exist';
    END IF;

    IF name IS NULL OR name = '' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Name cannot be empty';
    END IF;
    
    -- Update category
    UPDATE `category` SET
        name = name,
        description = description
    WHERE id = id;

END$$

DELIMITER ;

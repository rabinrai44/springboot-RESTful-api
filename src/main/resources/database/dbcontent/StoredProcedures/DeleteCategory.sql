/*
Author: Rabin Rai
Created On: 8/23/2023
Description: Stored procedure to delete category for a given category id
Version: 1.0
*/

DROP PROCEDURE IF EXISTS `spDeleteCategory`;

DELIMITER $$
CREATE PROCEDURE `spDeleteCategory`(
    IN categoryId INT
)
BEGIN
    -- Check if categoryId is null
    IF categoryId IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'categoryId cannot be null';
    END IF;

    -- Validation 
    IF (SELECT COUNT(*) FROM category WHERE categoryId = categoryId) = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Category does not exist';
    END IF;

    -- Delete category
    DELETE FROM category 
    WHERE categoryId = categoryId;
END$$

DELIMITER ;
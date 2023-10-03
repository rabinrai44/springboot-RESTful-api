/*
Author: Rabin Rai
Created On: 8/23/2023
Description: Stored procedure to delete item for a given itemNo
Version: 1.0
*/

DROP PROCEDURE IF EXISTS spDeleteItem;

DELIMITER $$
CREATE PROCEDURE spDeleteItem(IN itemNo INT)
BEGIN
    -- Validation
    IF itemNo IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'itemNo cannot be null';
    END IF;

    -- Check if exists in item table
    IF NOT EXISTS(SELECT * FROM item WHERE item_no = itemNo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'itemNo does not exist in item table';
    END IF;

    -- Delete from item table
    DELETE FROM item WHERE item_no = itemNo;
END$$

DELIMITER ;
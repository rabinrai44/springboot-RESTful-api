/* ======================================
Author:		Rabin Rai
Create date: 	2023-09-23
Description:	Stored Procedure for Add Item
version:		1.0
====================================== */

DROP PROCEDURE IF EXISTS `spAddItem`;

DELIMITER $$
CREATE PROCEDURE `spAddItem`
(
    IN itemNo VARCHAR(50),
    IN title VARCHAR(100),
    IN description VARCHAR(256),
    IN unitPrice DECIMAL(10,2),
    IN inStock BOOLEAN,
    IN minOrderQty INT(1),
    IN maxOrderQty INT(10),
    IN imageUrl VARCHAR(255),
    IN categoryId INT,
    IN vendorId INT,
    IN countryId INT
)
BEGIN
    -- Validation

    -- Check if itemNo is empty
    IF itemNo = '' OR itemNo IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Item number cannot be empty';
    END IF;

    -- Check if title is empty
    IF title = '' OR title IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Title cannot be empty';
    END IF;

    -- Check if unitPrice is empty
    IF unitPrice = '' OR unitPrice IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Unit price cannot be empty';
    END IF;

    -- Check if countryId is empty
    IF countryId = '' OR countryId IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Country cannot be empty';
    END IF;



    INSERT INTO `items`
    (
        itemNo,
        title,
        description,
        unitPrice,
        inStock,
        minOrderQty,
        maxOrderQty,
        imageUrl,
        categoryId,
        vendorId,
        countryId
    )
    VALUES
    (
        itemNo,
        title,
        description,
        unitPrice,
        inStock,
        minOrderQty,
        maxOrderQty,
        imageUrl,
        categoryId,
        vendorId,
        countryId
    );

END$$

DELIMITER ;
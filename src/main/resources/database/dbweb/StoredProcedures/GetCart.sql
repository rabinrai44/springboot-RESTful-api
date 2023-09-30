-- -----------------------------
--  procedure getCart
-- -----------------------------
USE dbweb;
DROP PROCEDURE IF EXISTS getCart;

DELIMITER $$
CREATE PROCEDURE getCart(IN cartId VARCHAR(36))
BEGIN
    DECLARE cartItemCount INT;
    DECLARE cartItems CURSOR FOR SELECT * FROM cartItem WHERE cartId = cartId;

    SELECT COUNT(*) INTO cartItemCount FROM cartItem WHERE cartId = cartId;

    IF cartItemCount = 0 THEN 
        SELECT NULL AS cartId, NULL AS userId;
    ELSE
        SELECT * FROM cart WHERE cartId = cartId;
        
        OPEN cartItems;
        FETCH NEXT FROM cartItems;
        WHILE @@FETCH_STATUS = 0 DO
            SELECT * FROM cartItem WHERE CURRENT OF cartItems;
            FETCH NEXT FROM cartItems;
        END WHILE;
        CLOSE cartItems;
    END IF;
END$$

DELIMITER ;
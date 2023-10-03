/*
Author: Rabin Rai
Created On: 9/29/2023
Description: Create table for role
*/
-- ---------------------------
-- Table role
-- ---------------------------
DROP TABLE IF EXISTS role ;
CREATE TABLE `role` (
  `id` varchar(255) NOT NULL DEFAULT (uuid()),
  `name` varchar(55) NOT NULL,
  `permission` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_name_unique` (`name`),
  KEY `name` (`name`)
)

CREATE PROCEDURE `getRoleByName` (
IN _roleName VARCHAR(55)
)
BEGIN
	IF _roleName IS NOT NULL THEN
    SELECT * FROM role WHERE name = _roleName;
  END IF;
END


-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` (name, permission)
 VALUES ('ROLE_USER', 'READ:USER,READ:CUSTOMER')
        ,('ROLE_MANAGER', 'READ:USER,READ:CUSTOMER,UPDATE:USER,UPDATE:CUSTOMER')
        ,('ROLE_ADMIN', 'READ:USER,READ:CUSTOMER,UPDATE:USER,UPDATE:CUSTOMER,DELETE:USER,DELETE:CUSTOMER')
        ,('ROLE_SUPER_ADMIN', 'READ:USER,READ:CUSTOMER,UPDATE:USER,UPDATE:CUSTOMER,DELETE:USER,DELETE:CUSTOMER');
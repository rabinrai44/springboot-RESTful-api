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
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(55) NOT NULL,
  `permission` varchar(255) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_name_unique` (`name`)
);


-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` (name, permission)
 VALUES ('ROLE_USER', 'READ:USER,READ:CUSTOMER')
        ,('ROLE_MANAGER', 'READ:USER,READ:CUSTOMER,UPDATE:USER,UPDATE:CUSTOMER')
        ,('ROLE_ADMIN', 'READ:USER,READ:CUSTOMER,UPDATE:USER,UPDATE:CUSTOMER,DELETE:USER,DELETE:CUSTOMER')
        ,('ROLE_SUPER_ADMIN', 'READ:USER,READ:CUSTOMER,UPDATE:USER,UPDATE:CUSTOMER,DELETE:USER,DELETE:CUSTOMER');
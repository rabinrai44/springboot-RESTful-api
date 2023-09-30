/*
Author: Rabin Rai
Created On: 9/29/2023
Description: Create table for user_role
*/
-- ---------------------------
-- Table user_role
-- ---------------------------

DROP TABLE IF EXISTS user_role;
CREATE TABLE user_role (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `userId` BINARY(16) NOT NULL,
  `roleId` BIGINT UNSIGNED NOT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (userId) REFERENCES user (id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (roleId) REFERENCES role (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT UQ_userRole_userId UNIQUE (userId)
);
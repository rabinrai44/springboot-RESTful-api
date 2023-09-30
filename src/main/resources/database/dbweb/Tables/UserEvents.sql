/*
Author: Rabin Rai
Created On: 9/29/2023
Description: Create table for user_events
*/
-- ---------------------------
-- Table user_events
-- ---------------------------
DROP TABLE IF EXISTS user_events;
CREATE TABLE user_events (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `userId` BINARY(16) NOT NULL,
  `eventId` BIGINT UNSIGNED NOT NULL,
  `ipAddress` VARCHAR(55) DEFAULT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (userId) REFERENCES user (id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (eventId) REFERENCES events (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT UQ_userEvents_userId UNIQUE (userId)
);
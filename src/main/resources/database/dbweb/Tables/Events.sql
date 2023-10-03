/*
Author: Rabin Rai
Created On: 9/29/2023
Description: Create table for events
*/
-- ---------------------------
-- Table events
-- ---------------------------

DROP TABLE IF EXISTS events;
CREATE TABLE events (
 `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(55) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`),
  CONSTRAINT `CHECK_events_type_IN` CHECK ((`type` in 
  ( 'LOGIN_ATTEMPT',
    'LOGIN_ATTEMPT_FAILURE',
    'LOGIN_ATTEMPT_SUCCESS',
    'LOGOUT_ATTEMPT_SUCCESS',
    'LOGOUT_ATTEMPT_FAILURE',
    'LOGOUT_ATTEMPT',
    'USER_CREATED',
    'USER_UPDATED',
    'USER_DELETED',
    'USER_ROLE_CREATED',
    'USER_ROLE_UPDATED',
    'USER_ROLE_DELETED',
    'ROLE_CREATED',
    'ROLE_UPDATED',
    'ROLE_DELETED',
    'USER_EVENT_CREATED',
    'USER_EVENT_UPDATED',
    'USER_EVENT_DELETED',
    'EVENT_CREATED',
    'EVENT_UPDATED',
    'EVENT_DELETED',
    'USER_ROLE_EVENT_CREATED',
    'USER_ROLE_EVENT_UPDATED',
    'USER_ROLE_EVENT_DELETED',
    'USER_ROLE_EVENT',
    'USER_ROLE_EVENT_FAILURE',
    'USER_ROLE_UPDATED'
    )
    ))
  );
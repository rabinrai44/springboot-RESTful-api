package com.sample.webrestapi.controller;

import java.util.UUID;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.sample.webrestapi.model.AppUser;
import com.sample.webrestapi.repository.UserRepository;

@RestController
@RequestMapping("/api/v1/user")
public class UserController {
    private static final Logger logger = (Logger) LogManager.getLogger(UserController.class);

    @Autowired
    private UserRepository<AppUser> userRepository;

    @RequestMapping("{id}")
    public AppUser getUserById(@PathVariable String id) {
        UUID userId = null;
        try {
            userId = UUID.fromString(id);
        } catch (Exception e) {
            logger.error("Error getting user", e);
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid user id format");
        }

        AppUser user = userRepository.get(userId);
        if (user == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found");
        }

        return user;
    }
}

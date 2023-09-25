package com.sample.webrestapi.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.sample.webrestapi.dto.AppUserAdd;
import com.sample.webrestapi.dto.AppUserDto;
import com.sample.webrestapi.model.AppUser;
import com.sample.webrestapi.service.UserService;

@RestController
@RequestMapping("/api/v1/user")
public class UserController {
    private static final Logger logger = (Logger) LogManager.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    @PostMapping("/register")
    public AppUserDto getUserById(@RequestBody AppUserAdd userDto) {
        AppUser user = new AppUser();
        user.setFirstName(userDto.getFirstName());
        user.setLastName(userDto.getLastName());
        user.setEmail(userDto.getEmail());
        user.setPassword(userDto.getPassword());
        user.setPhone(userDto.getPhone());
        user.setTitle(userDto.getTitle());
        user.setBio(userDto.getBio());
        user.setImageUrl(userDto.getImageUrl());

        try {
            return userService.createUser(user);
        } catch (Exception e) {
            logger.error("Error creating user", e);
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error creating user");
        }
    }
}

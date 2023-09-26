package com.sample.webrestapi.controller;

import java.net.URI;
import java.time.LocalDateTime;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.sample.webrestapi.dto.AppUserAdd;
import com.sample.webrestapi.dto.AppUserDto;
import com.sample.webrestapi.model.AppUser;
import com.sample.webrestapi.model.HttpResponse;
import com.sample.webrestapi.service.UserService;

@RestController
@RequestMapping("/api/v1/user")
public class UserController {
    private static final Logger logger = (Logger) LogManager.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    @PostMapping("/register")
    public ResponseEntity<HttpResponse> saveUser(@RequestBody AppUserAdd userDto) {
        AppUser user = new AppUser();
        user.setFirstName(userDto.getFirstName());
        user.setLastName(userDto.getLastName());
        user.setEmail(userDto.getEmail());
        user.setPassword(userDto.getPassword());
        user.setPhone(userDto.getPhone());
        user.setTitle(userDto.getTitle());
        user.setBio(userDto.getBio());
        user.setImageUrl(userDto.getImageUrl());

        AppUserDto respo = userService.createUser(user);

        logger.info("User was created successfully.");

        return ResponseEntity.created(getURI())
                .body(
                        HttpResponse.builder()
                                .timeStamp(LocalDateTime.now().toString())
                                .data(Map.of("user", respo))
                                .message("User created successfully")
                                .status(HttpStatus.CREATED)
                                .statusCode(HttpStatus.CREATED.value())
                                .build());
    }

    private URI getURI() {
        return URI.create(ServletUriComponentsBuilder.fromCurrentContextPath().path("/user/login").toUriString());
    }
}

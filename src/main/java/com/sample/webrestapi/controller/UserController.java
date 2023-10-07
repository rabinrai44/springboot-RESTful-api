package com.sample.webrestapi.controller;

import java.net.URI;
import java.time.LocalDateTime;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.sample.webrestapi.dto.AppUserAdd;
import com.sample.webrestapi.dto.LoginRequest;
import com.sample.webrestapi.model.AppUser;
import com.sample.webrestapi.model.HttpResponse;
import com.sample.webrestapi.service.UserService;

@RestController
@RequestMapping("/api/v1/user")
public class UserController {
        private static final Logger logger = (Logger) LogManager.getLogger(UserController.class);

        @Autowired
        private UserService userService;

        @Autowired
        private AuthenticationManager authManager;

        @PostMapping("/login")
        public ResponseEntity<HttpResponse> login(@RequestBody LoginRequest request) {
                var result = authManager
                                .authenticate(new UsernamePasswordAuthenticationToken(request.email(),
                                                request.password()));
                return ResponseEntity.ok()
                                .body(
                                                HttpResponse.builder()
                                                                .timeStamp(getTimestamp())
                                                                .data(Map.of("authenticated", result.isAuthenticated()))
                                                                .message("User logged in successfully")
                                                                .status(HttpStatus.OK)
                                                                .statusCode(HttpStatus.OK.value())
                                                                .build());
        }

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
                userService.createUser(user);

                return ResponseEntity.created(getURI("/api/v1/user/login"))
                                .body(
                                                HttpResponse.builder()
                                                                .timeStamp(getTimestamp())
                                                                .message("User created successfully")
                                                                .status(HttpStatus.CREATED)
                                                                .statusCode(HttpStatus.CREATED.value())
                                                                .build());
        }

        private URI getURI(String path) {
                return URI.create(
                                ServletUriComponentsBuilder.fromCurrentContextPath().path(path).toUriString());
        }

        private String getTimestamp() {
                return LocalDateTime.now().toString();
        }
}

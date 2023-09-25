package com.sample.webrestapi.service;

import com.sample.webrestapi.dto.AppUserDto;
import com.sample.webrestapi.model.AppUser;

public interface UserService {
    AppUserDto createUser(AppUser user);
}

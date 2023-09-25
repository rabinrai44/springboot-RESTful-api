package com.sample.webrestapi.dtomapper;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import com.sample.webrestapi.dto.AppUserDto;
import com.sample.webrestapi.model.AppUser;

@Component
public class AppUserDTOMapper {
    public static AppUserDto fromUser(AppUser user) {
        AppUserDto userDto = new AppUserDto();

        BeanUtils.copyProperties(user, userDto);

        return userDto;
    }

    public static AppUser toUser(AppUserDto userDto) {
        AppUser user = new AppUser();

        BeanUtils.copyProperties(userDto, user);

        return user;
    }
}

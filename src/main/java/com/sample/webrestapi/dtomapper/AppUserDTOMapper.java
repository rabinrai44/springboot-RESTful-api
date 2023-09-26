package com.sample.webrestapi.dtomapper;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import com.sample.webrestapi.dto.AppUserDto;
import com.sample.webrestapi.model.AppUser;

@Component
public class AppUserDTOMapper {
    public static AppUserDto fromUser(AppUser user) {
        AppUserDto userDto = new AppUserDto();

        userDto.setId(user.getId());
        userDto.setFirstName(user.getFirstName());
        userDto.setLastName(user.getLastName());
        userDto.setEmail(user.getEmail());
        userDto.setPhone(user.getPhone());
        userDto.setTitle(user.getTitle());
        userDto.setBio(user.getBio());
        userDto.setImageUrl(user.getImageUrl());
        userDto.setEnabled(user.isEnabled());
        userDto.setNotLocked(user.isNotLocked());

        return userDto;
    }

    public static AppUser toUser(AppUserDto userDto) {
        AppUser user = new AppUser();

        // BeanUtils.copyProperties(userDto, user);
        user.setId(userDto.getId());
        user.setFirstName(userDto.getFirstName());
        user.setLastName(userDto.getLastName());
        user.setEmail(userDto.getEmail());
        user.setPhone(userDto.getPhone());
        user.setTitle(userDto.getTitle());
        user.setBio(userDto.getBio());
        user.setImageUrl(userDto.getImageUrl());
        user.setEnabled(userDto.isEnabled());
        user.setNotLocked(userDto.isNotLocked());

        return user;
    }
}

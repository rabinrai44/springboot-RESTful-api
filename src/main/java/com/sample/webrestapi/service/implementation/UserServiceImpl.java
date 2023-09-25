package com.sample.webrestapi.service.implementation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sample.webrestapi.dto.AppUserDto;
import com.sample.webrestapi.dtomapper.AppUserDTOMapper;
import com.sample.webrestapi.model.AppUser;
import com.sample.webrestapi.repository.UserRepository;
import com.sample.webrestapi.service.UserService;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository<AppUser> userRepository;

    @Override
    public AppUserDto createUser(AppUser user) {
        return AppUserDTOMapper.fromUser(userRepository.save(user));
    }

}

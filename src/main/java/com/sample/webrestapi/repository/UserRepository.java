package com.sample.webrestapi.repository;

import java.util.Collection;
import java.util.UUID;

import com.sample.webrestapi.model.AppUser;

public interface UserRepository<T extends AppUser> {
    T findByEmail(String email);

    T save(T user);

    Collection<T> list(int page, int pageSize);

    T get(UUID id);

    T update(T user);

    Boolean delete(UUID id);
}

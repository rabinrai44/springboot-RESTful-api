package com.sample.webrestapi.repository;

import java.util.Collection;
import java.util.UUID;

import com.sample.webrestapi.model.Role;

public interface RoleRepository<T extends Role> {
    /* Basic CRUD Operations */
    T findById(UUID id);

    Collection<T> findAll(int page, int pageSize);

    T save(T role);

    T update(T role);

    Boolean delete(UUID id);

    /* Other Operations */
    void addRoleToUser(UUID userId, String roleName);

    Role findRoleByUserId(UUID userId);

    Role findRoleByUserEmail(String email);

    Role updateUserRole(UUID userId, String roleName);
}

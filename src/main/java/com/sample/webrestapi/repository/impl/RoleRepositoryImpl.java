package com.sample.webrestapi.repository.impl;

import static com.sample.webrestapi.query.RoleQuery.*;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;
import java.util.UUID;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import com.sample.webrestapi.common.AppConstants;
import com.sample.webrestapi.exceptions.ApiException;
import com.sample.webrestapi.mapper.RoleRowMapper;
import com.sample.webrestapi.model.Role;
import com.sample.webrestapi.query.RoleQuery;
import com.sample.webrestapi.repository.RoleRepository;

@Repository
public class RoleRepositoryImpl implements RoleRepository<Role> {

    private static final Logger logger = (Logger) LogManager.getLogger(RoleRepositoryImpl.class);

    @Autowired
    @Qualifier(AppConstants.JDBC_TEMPLATE_WEB)
    private NamedParameterJdbcTemplate jdbc;

    @Override
    public Role findById(UUID id) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'findById'");
    }

    @Override
    public Collection<Role> findAll(int page, int pageSize) {
        try {
            return this.jdbc.query(SELECT_ALL_ROLES, new RoleRowMapper());
        } catch (EmptyResultDataAccessException e) {
            logger.error("No roles found");
        } catch (Exception e) {
            logger.error("Error retrieving roles");
        }

        return new ArrayList<>();
    }

    @Override
    public Role save(Role role) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'save'");
    }

    @Override
    public Role update(Role role) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'update'");
    }

    @Override
    public Boolean delete(UUID id) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'delete'");
    }

    @Override
    public void addRoleToUser(UUID userId, String roleName) {
        logger.info("Adding role {} to user id: {}", roleName, userId);
        try {

            Role role = findRoleByName(roleName);

            if (role == null) {
                logger.error("Role not found by name: {}", roleName);
                throw new ApiException("Role not found by name: " + roleName);
            }

            logger.info("Role found: {}", role.getId());

            jdbc.update(INSERT_ROLE_TO_USER_QUERY,
                    Map.of("userId", userId.toString(), "roleId", role.getId().toString()));
        } catch (EmptyResultDataAccessException e) {
            logger.error("", e);
            throw new ApiException("Role not found by name: " + roleName);
        } catch (Exception e) {
            logger.error("", e);
            throw new ApiException("An error occurred. Please try again.");
        }
    }

    @Override
    public Role findRoleByUserId(UUID userId) {
        try {
            return jdbc.queryForObject(SELECT_ROLE_BY_ID, Map.of("id", userId), new RoleRowMapper());
        } catch (EmptyResultDataAccessException e) {
            logger.error("", e);
            throw new ApiException("Role not found by user id: " + userId);
        } catch (Exception e) {
            logger.error("", e);
            throw new ApiException("An error occurred. Please try again.");
        }
    }

    @Override
    public Role findRoleByUserEmail(String email) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'findRoleByUserEmail'");
    }

    @Override
    public Role updateUserRole(UUID userId, String roleName) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'updateUserRole'");
    }

    @Override
    public Role findRoleByName(String roleName) {
        try {
            return jdbc.queryForObject(RoleQuery.SELECT_ROLE_BY_NAME_QUERY, Map.of("name", roleName),
                    new RoleRowMapper());
        } catch (EmptyResultDataAccessException e) {
            logger.error("", e);
        } catch (Exception e) {
            logger.error("", e);
        }
        return null;
    }

}

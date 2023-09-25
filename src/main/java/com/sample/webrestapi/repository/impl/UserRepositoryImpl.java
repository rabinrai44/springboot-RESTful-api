package com.sample.webrestapi.repository.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.UUID;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sample.webrestapi.common.AppConstants;
import com.sample.webrestapi.mapper.AppUserRowMapper;
import com.sample.webrestapi.model.AppUser;
import com.sample.webrestapi.repository.UserRepository;

@Repository
public class UserRepositoryImpl implements UserRepository<AppUser> {

    private static final Logger logger = (Logger) LogManager.getLogger(UserRepositoryImpl.class);
    private static final String SQL_FIND_BY_EMAIL = "SELECT * FROM dbo.user WHERE email = ?";

    @Autowired
    @Qualifier(AppConstants.JDBC_TEMPLATE_WEB)
    private JdbcTemplate jdbc;

    @Override
    public AppUser findByEmail(String email) {
        try {
            return this.jdbc.query(SQL_FIND_BY_EMAIL, new AppUserRowMapper(), email)
                    .stream()
                    .findFirst()
                    .orElse(null);
        } catch (EmptyResultDataAccessException e) {
            logger.error("Error getting user", e);
        } catch (Exception e) {
            logger.error("Error getting user", e);
        }

        return null;
    }

    @Override
    public AppUser save(AppUser user) {
        try {
            this.jdbc.update(
                    "CALL spAddUser(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                    user.getFirstName(),
                    user.getLastName(),
                    user.getEmail(),
                    user.getPassword(),
                    user.getPhone(),
                    user.getTitle(),
                    user.getBio(),
                    user.getImageUrl(),
                    user.isEnabled(),
                    user.isNotLocked());

            return user;
        } catch (EmptyResultDataAccessException e) {
            logger.error("Error saving user", e);
        } catch (Exception e) {
            logger.error("Error saving user", e);
        }

        return null;
    }

    @Override
    public Collection<AppUser> list(int page, int pageSize) {
        try {
            // do pagination
            String sql = "SELECT * FROM dbo.user ORDER BY id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            return this.jdbc.query(sql, new AppUserRowMapper(), page, pageSize);
        } catch (EmptyResultDataAccessException e) {
            logger.error("Error getting users", e);
            return new ArrayList<>();
        }
    }

    @Override
    public AppUser get(UUID id) {
        try {
            return this.jdbc.query("SELECT * FROM `dbo.user` WHERE id = ?", new AppUserRowMapper(), id)
                    .stream()
                    .findFirst()
                    .orElseThrow();
        } catch (EmptyResultDataAccessException e) {
            logger.error("", e);
        } catch (Exception e) {
            logger.error("Error getting user", e);
        }

        return null;
    }

    @Override
    public AppUser update(AppUser user) {
        try {
            this.jdbc.update(
                    "UPDATE dbo.user SET firstName = ?, lastName = ?, email = ?, password = ?, phone = ? WHERE id = ?",
                    user.getFirstName(),
                    user.getLastName(),
                    user.getEmail(),
                    user.getPassword(),
                    user.getPhone(),
                    user.getId());
            return user;
        } catch (EmptyResultDataAccessException e) {
            logger.error("Error updating user", e);
        } catch (Exception e) {
            logger.error("Error updating user", e);
        }

        return null;
    }

    @Override
    public Boolean delete(UUID id) {
        try {
            return this.jdbc.update("DELETE FROM dbo.user WHERE id = ?", id) > 0;
        } catch (EmptyResultDataAccessException e) {
            logger.error("Error deleting user", e);
        } catch (Exception e) {
            logger.error("Error deleting user", e);
        }

        return false;
    }
}

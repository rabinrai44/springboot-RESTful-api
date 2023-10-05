package com.sample.webrestapi.repository.impl;

import java.sql.Types;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.sample.webrestapi.common.AppConstants;
import com.sample.webrestapi.enumeration.RoleType;
import com.sample.webrestapi.exceptions.ApiException;
import com.sample.webrestapi.mapper.AppUserRowMapper;
import com.sample.webrestapi.mapper.UUIDRowMapper;
import com.sample.webrestapi.model.AppUser;
import com.sample.webrestapi.model.Role;
import com.sample.webrestapi.model.UserPrincipal;
import com.sample.webrestapi.query.UserQuery;
import com.sample.webrestapi.repository.RoleRepository;
import com.sample.webrestapi.repository.UserRepository;

@Repository
public class UserRepositoryImpl implements UserRepository<AppUser>, UserDetailsService {

    private static final Logger logger = (Logger) LogManager.getLogger(UserRepositoryImpl.class);

    @Autowired
    @Qualifier(AppConstants.JDBC_TEMPLATE_WEB)
    private NamedParameterJdbcTemplate jdbc;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Autowired
    private RoleRepository<Role> roleRepository;

    @Override
    public AppUser findByEmail(String email) {
        try {
            // Create a SimpleJdbcCall for the stored procedure
            SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbc.getJdbcTemplate())
                    .withProcedureName("spGetUserByEmail")
                    .declareParameters(
                            new SqlParameter("_email", Types.VARCHAR),
                            new SqlParameter("users", Types.OTHER))
                    .returningResultSet("users", new AppUserRowMapper());

            // Set up the input parameters
            Map<String, Object> inParams = new HashMap<>();
            inParams.put("_email", email);

            // Execute the stored procedure
            Map<String, Object> result = jdbcCall.execute(inParams);

            // Retrieve the user object from the result
            List<AppUser> users = (List<AppUser>) result.get("users");

            return users.stream().findFirst().orElse(null);
        } catch (EmptyResultDataAccessException e) {
            // Handle empty result
            logger.error("No user found", e);
            throw new ApiException("No user found with email: " + email + "");
        } catch (Exception e) {
            // Handle exceptions
            logger.error(e.getMessage());
            throw new ApiException("An error occurred. Please try again later.");
        }
    }

    @Override
    public AppUser save(AppUser user) {
        if (findByEmail(user.getEmail()) != null) {
            logger.error("Email already exists");
            throw new ApiException("Email already in use. Please use a different email and try again.");
        }

        try {
            // Get the user id
            user.setId(generateUniqueId());

            SqlParameterSource parameters = getSqlParameterSource(user);
            jdbc.update(UserQuery.INSERT_USER_QUERY, parameters);

            // // Add role to the user
            roleRepository.addRoleToUser(user.getId(), RoleType.ROLE_USER.name());
            logger.info("User saved successfully");
            return user;
        } catch (EmptyResultDataAccessException e) {
            throw new ApiException("Error saving user");
        } catch (Exception e) {
            logger.error("Error saving user", e);
        }

        return null;
    }

    private SqlParameterSource getSqlParameterSource(AppUser user) {
        return new MapSqlParameterSource()
                .addValue("id", user.getId().toString(), Types.VARCHAR)
                .addValue("firstName", user.getFirstName(), Types.VARCHAR)
                .addValue("lastName", user.getLastName(), Types.VARCHAR)
                .addValue("email", user.getEmail(), Types.VARCHAR)
                .addValue("password", passwordEncoder.encode(user.getPassword()), Types.VARCHAR);
    }

    @Override
    public Collection<AppUser> list(int page, int pageSize) {
        try {
            return this.jdbc.query(UserQuery.LIST_USER_QUERY, Map.of("page", page, "pageSize", pageSize),
                    new AppUserRowMapper());
        } catch (EmptyResultDataAccessException e) {
            logger.error("Error getting users", e);
        } catch (Exception e) {
            logger.error("Error getting users", e);
        }
        return new ArrayList<>();
    }

    @Override
    public AppUser get(UUID id) {
        return this.jdbc.queryForObject(UserQuery.FIND_USER_BY_ID_QUERY, Map.of("id", id), AppUser.class);
    }

    @Override
    public AppUser update(AppUser user) {
        try {
            SqlParameterSource parameters = getSqlParameterSource(user);
            jdbc.update(UserQuery.UPDATE_USER_QUERY, parameters);
            return user;
        } catch (EmptyResultDataAccessException e) {
            logger.error("Error updating user", e);
            throw new ApiException("Error updating user");
        } catch (Exception e) {
            logger.error("Error updating user", e);
            throw new ApiException("Error updating user");
        }
    }

    @Override
    public Boolean delete(UUID id) {
        try {
            return this.jdbc.update(UserQuery.DELETE_USER_QUERY, Map.of("id", id)) > 0;
        } catch (EmptyResultDataAccessException e) {
            logger.error("Error deleting user", e);
        } catch (Exception e) {
            logger.error("Error deleting user", e);
        }

        return false;
    }

    @Override
    public UUID findUserIdByEmail(String email) {
        return jdbc.queryForObject(UserQuery.FIND_USER_ID_BY_EMAIL, Map.of("email", email), (new UUIDRowMapper()));
    }

    @Override
    public UUID generateUniqueId() {
        UUID uuid = UUID.randomUUID();
        if (isIdTaken(uuid)) {
            return generateUniqueId();
        }
        return uuid;
    }

    private boolean isIdTaken(UUID uuid) {
        try {
            return this.jdbc.queryForObject(UserQuery.FIND_USER_BY_ID_QUERY, Map.of("id", uuid.toString()),
                    AppUser.class) != null;
        } catch (EmptyResultDataAccessException e) {
            logger.error("Error getting user", e);
        } catch (Exception e) {
            logger.error("Error getting user", e);
        }
        return false;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        AppUser user = findByEmail(username);
        if (user == null) {
            logger.error("User not found with username: " + username);
            throw new UsernameNotFoundException("Invalid username or password.");
        }

        logger.info("User found");
        return new UserPrincipal(user, roleRepository.findRoleByUserId(user.getId()).getPermission());
    }
}

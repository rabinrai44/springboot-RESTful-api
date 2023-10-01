package com.sample.webrestapi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

import org.springframework.jdbc.core.RowMapper;

import com.sample.webrestapi.model.AppUser;

public class AppUserRowMapper implements RowMapper<AppUser> {

    @Override
    public AppUser mapRow(ResultSet rs, int rowNum) throws SQLException {
        byte[] bytes = rs.getBytes("id"); // Assuming the column name is 'id'
        UUID userId = bytes != null ? UUID.nameUUIDFromBytes(bytes) : null;
        return new AppUser(
                userId,
                rs.getString("firstName"),
                rs.getString("lastName"),
                rs.getString("email"),
                null,
                rs.getString("phone"),
                rs.getString("title"),
                rs.getString("bio"),
                rs.getString("imageUrl"),
                rs.getBoolean("enabled"),
                rs.getBoolean("isNotLocked"));
    }

}

package com.sample.webrestapi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

import org.springframework.jdbc.core.RowMapper;

import com.sample.webrestapi.model.AppUser;

public class AppUserRowMapper implements RowMapper<AppUser> {

    @Override
    public AppUser mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new AppUser(
                UUID.fromString(rs.getString("id")),
                rs.getString("first_name"),
                rs.getString("last_name"),
                rs.getString("email"),
                null,
                rs.getString("phone"),
                rs.getString("title"),
                rs.getString("bio"),
                rs.getString("image_url"),
                rs.getBoolean("enabled"),
                rs.getBoolean("is_not_locked"));
    }

}

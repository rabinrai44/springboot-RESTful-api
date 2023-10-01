package com.sample.webrestapi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

import org.springframework.jdbc.core.RowMapper;

public class UUIDRowMapper implements RowMapper<UUID> {

    @Override
    public UUID mapRow(ResultSet rs, int rowNum) throws SQLException {
        byte[] uuidBytes = rs.getBytes("id");

        return uuidBytes != null ? UUID.nameUUIDFromBytes(uuidBytes) : null;
    }

}

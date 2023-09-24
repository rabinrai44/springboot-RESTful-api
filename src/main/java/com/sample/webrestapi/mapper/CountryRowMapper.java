package com.sample.webrestapi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.Nullable;

import com.sample.webrestapi.model.Country;

public class CountryRowMapper implements RowMapper<Country> {

    @Override
    @Nullable
    public Country mapRow(ResultSet rs, int rowNum) throws SQLException {
        Country country = new Country();
        country.setId(rs.getLong("id"));
        country.setName(rs.getString("name"));
        country.setCode(rs.getString("code"));

        return country;
    }

}

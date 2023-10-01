package com.sample.webrestapi.service.implementation;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sample.webrestapi.common.AppConstants;
import com.sample.webrestapi.mapper.CountryRowMapper;
import com.sample.webrestapi.model.Country;
import com.sample.webrestapi.service.WebDataService;

@Repository
public class WebDataServiceImpl implements WebDataService {

    private static final Logger logger = LogManager.getLogger(WebDataServiceImpl.class);
    private final NamedParameterJdbcTemplate jdbc;

    public WebDataServiceImpl(@Qualifier(AppConstants.JDBC_TEMPLATE_WEB) NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbc = jdbcTemplate;
    }

    @Override
    public List<Country> getCountries() {
        try {
            return this.jdbc.query("SELECT * FROM countries", new CountryRowMapper());
        } catch (Exception e) {
            logger.error("Error getting countries", e);
            return new ArrayList<>();
        }
    }

    @Override
    public Country getCountry(String countryCode) {
        try {
            return this.jdbc
                    .query("SELECT * FROM countries WHERE code = ?", Map.of("code", countryCode),
                            new CountryRowMapper())
                    .stream().findFirst().orElseThrow();
        } catch (EmptyResultDataAccessException e) {
            logger.error("Error getting country", e);
            return null;
        }

        catch (Exception e) {
            logger.error("Error getting country", e);
            return null;
        }
    }

}

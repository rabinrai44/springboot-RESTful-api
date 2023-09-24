package com.sample.webrestapi.service.implementation;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sample.webrestapi.common.AppConstants;
import com.sample.webrestapi.mapper.CountryRowMapper;
import com.sample.webrestapi.model.Country;
import com.sample.webrestapi.service.WebDataService;

@Repository
public class WebDataServiceImpl implements WebDataService, AutoCloseable {

    private static final Logger logger = LogManager.getLogger(WebDataServiceImpl.class);
    private final JdbcTemplate jdbc;
    private final DataSource dataSource;

    public WebDataServiceImpl(@Qualifier(AppConstants.JDBC_TEMPLATE_WEB) JdbcTemplate jdbcTemplate) {
        this.jdbc = jdbcTemplate;
        this.dataSource = jdbcTemplate.getDataSource();
    }

    @Override
    public List<Country> getCountries() {
        try {
            return this.jdbc.query("SELECT * FROM dbo.country", new CountryRowMapper());
        } catch (Exception e) {
            logger.error("Error getting countries", e);
            return new ArrayList<>();
        }
    }

    @Override
    public Country getCountry(String countryCode) {
        try {
            return this.jdbc.query("SELECT * FROM dbo.country WHERE code = ?", new CountryRowMapper(), countryCode)
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

    @Override
    public void close() {
        if (this.dataSource != null) {
            try {
                this.dataSource.getConnection().close();
                logger.info("Datasource connection closed");
            } catch (Exception e) {
                logger.error("Error closing datasource connection", e);
            }
        }
    }

}

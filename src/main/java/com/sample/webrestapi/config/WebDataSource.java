package com.sample.webrestapi.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;

import com.sample.webrestapi.common.AppConstants;

@Configuration
public class WebDataSource {
    private static final String DBWEB = "dbweb";

    @Bean(DBWEB)
    @ConfigurationProperties("spring.datasource.dbweb")
    public DataSource dataSource() {
        return DataSourceBuilder.create().build();
    }

    @Bean(AppConstants.JDBC_TEMPLATE_WEB)
    public JdbcTemplate jdbcTemplate(@Qualifier(DBWEB) DataSource dataSource) {
        return new JdbcTemplate(dataSource);
    }
}

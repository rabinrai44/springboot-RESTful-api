package com.sample.webrestapi.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;

import com.sample.webrestapi.common.AppConstants;

@Configuration
public class ContentDataSource {
    private static final String DBCONTENT = "dbcontent";

    @Bean(DBCONTENT)
    @ConfigurationProperties("spring.datasource.dbcontent")
    public DataSource dataSource() {
        return DataSourceBuilder.create().build();
    }

    @Bean(AppConstants.JDBC_TEMPLATE_CONTENT)
    public NamedParameterJdbcTemplate jdbcTemplate(@Qualifier(DBCONTENT) DataSource dataSource) {
        return new NamedParameterJdbcTemplate(dataSource);
    }
}

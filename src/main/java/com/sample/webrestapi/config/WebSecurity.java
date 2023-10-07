package com.sample.webrestapi.config;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.sample.webrestapi.handler.CustomAccessDeniedHandler;
import com.sample.webrestapi.handler.CustomAuthenticationEntryPoint;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity // prev EnableGlobalMethodSecurity
public class WebSecurity {

    private static final String[] PUBLIC_URLS = {
            "/api/v1/user/login/**",
            "/api/v1/user/register/**",
            "/v2/api-docs/**",
            "/v3/api-docs/**",
            "/configuration/security",
            "/swagger-resource",
            "/swagger-resources/**",
            "/swagger-ui/**",
            "/swagger-ui.html",
    };
    private final CustomAccessDeniedHandler customAccessDeniedHandler;
    private final CustomAuthenticationEntryPoint customAuthenticationEntryPoint;
    private final UserDetailsService userDetailsService;
    private final BCryptPasswordEncoder passwordEncoder;

    public WebSecurity(CustomAccessDeniedHandler customAccessDeniedHandler,
            CustomAuthenticationEntryPoint customAuthenticationEntryPoint, UserDetailsService userDetailsService,
            BCryptPasswordEncoder passwordEncoder) {
        this.customAccessDeniedHandler = customAccessDeniedHandler;
        this.customAuthenticationEntryPoint = customAuthenticationEntryPoint;
        this.userDetailsService = userDetailsService;
        this.passwordEncoder = passwordEncoder;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        return http.csrf((csrf) -> csrf.disable()).cors((crs) -> crs.disable())
                .sessionManagement((session) -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests((authorize) -> authorize
                        .requestMatchers(PUBLIC_URLS).permitAll()
                        .requestMatchers(HttpMethod.DELETE, "/user/delete/**").hasAnyAuthority("DELETE:USER")
                        .requestMatchers(HttpMethod.DELETE, "/customer/delete/**").hasAnyAuthority("DELETE:CUSTOMER")
                        .anyRequest().authenticated())
                .exceptionHandling((exception) -> exception.accessDeniedHandler(customAccessDeniedHandler)
                        .authenticationEntryPoint(customAuthenticationEntryPoint))
                .build();
    }

    @Bean
    public AuthenticationManager authenticationManager() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder);
        return new ProviderManager(authProvider);
    }

}

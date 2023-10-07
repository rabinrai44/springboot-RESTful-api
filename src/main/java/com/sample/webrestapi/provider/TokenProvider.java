package com.sample.webrestapi.provider;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.InvalidClaimException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.sample.webrestapi.model.UserPrincipal;

import io.micrometer.common.util.StringUtils;
import jakarta.servlet.http.HttpServletRequest;

@Component
public class TokenProvider {
    private static final Logger logger = (Logger) LogManager.getLogger(TokenProvider.class);
    private static final String TOKEN_CANNOT_BE_VERIFIED = "Token cannot be verified";
    private static final String COM_ZALOSTATION = "zalostation.com";
    private static final String SHOPPING_API = "ecommerce-api";
    private static final String AUTHORITIES = "authorities";

    @Value("${jwt.secret}")
    private String secret;

    @Value("${jwt.expirationTime}")
    private long expirationTime;

    @Value("${jwt.refreshTokenExpirationTime}")
    private long refreshTokenExpirationTime;

    public String createAccessToken(UserPrincipal userPrincipal) {
        return JWT.create()
                .withIssuer(COM_ZALOSTATION)
                .withAudience(SHOPPING_API)
                .withIssuedAt(new Date())
                .withSubject(userPrincipal.getUsername())
                .withArrayClaim(AUTHORITIES, getClaimsFromUser(userPrincipal))
                .withExpiresAt(new Date(System.currentTimeMillis() + expirationTime))
                .sign(Algorithm.HMAC512(secret.getBytes()))
                .toString();
    }

    public String createRefreshToken(UserPrincipal userPrincipal) {
        return JWT.create()
                .withIssuer(COM_ZALOSTATION)
                .withAudience(SHOPPING_API)
                .withIssuedAt(new Date())
                .withSubject(userPrincipal.getUsername())
                .withExpiresAt(new Date(System.currentTimeMillis() + refreshTokenExpirationTime))
                .sign(Algorithm.HMAC512(secret.getBytes()))
                .toString();
    }

    public List<GrantedAuthority> getAuthorities(String token) {
        return Arrays.stream(getClaimsFromToken(token))
                .map(SimpleGrantedAuthority::new)
                .collect(Collectors.toList());
    }

    public Authentication getAuthentication(String username, List<GrantedAuthority> authorities,
            HttpServletRequest request) {
        UsernamePasswordAuthenticationToken userPasswordAuthToken = new UsernamePasswordAuthenticationToken(username,
                null, authorities);
        userPasswordAuthToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
        return userPasswordAuthToken;
    }

    public boolean isTokenValid(String email, String token) {
        JWTVerifier verifier = getJWTVerifier();
        return StringUtils.isNotEmpty(email) && !isTokenExpired(verifier, token);
    }

    public String getSubject(String token, HttpServletRequest request) {
        try {
            return getJWTVerifier().verify(token)
                    .getSubject();
        } catch (TokenExpiredException e) {
            logger.error("Token has expired: {}", e.getMessage());
            request.setAttribute("expiredMessage", e.getMessage());
        } catch (InvalidClaimException e) {
            logger.error("Invalid claim: {}", e.getMessage());
            request.setAttribute("invalidMessage", e.getMessage());
        } catch (Exception e) {
            logger.error("Exception: {}", e.getMessage());
            throw e;
        }

        return null;
    }

    public Date getExpirationTime(String token) {
        return getJWTVerifier().verify(token)
                .getExpiresAt();
    }

    public Date getRefreshTokenExpirationTime(String refreshToken) {
        return getJWTVerifier().verify(refreshToken)
                .getExpiresAt();
    }

    private boolean isTokenExpired(JWTVerifier verifier, String token) {
        Date expiration = verifier.verify(token)
                .getExpiresAt();
        return expiration.before(new Date());
    }

    private String[] getClaimsFromToken(String token) {
        JWTVerifier verifier = getJWTVerifier();
        return verifier.verify(token)
                .getClaim(AUTHORITIES)
                .asArray(String.class);
    }

    private JWTVerifier getJWTVerifier() {
        JWTVerifier verifier;
        try {
            Algorithm algorithm = Algorithm.HMAC512(secret);
            verifier = JWT.require(algorithm)
                    .withIssuer(COM_ZALOSTATION)
                    .build();
        } catch (JWTVerificationException e) {
            throw new JWTVerificationException(TOKEN_CANNOT_BE_VERIFIED);
        }

        return verifier;
    }

    private String[] getClaimsFromUser(UserPrincipal userPrincipal) {
        return userPrincipal.getAuthorities()
                .stream()
                .map(grantedAuthority -> grantedAuthority.getAuthority())
                .toArray(String[]::new);
    }
}

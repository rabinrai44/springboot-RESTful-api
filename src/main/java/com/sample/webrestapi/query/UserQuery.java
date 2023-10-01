package com.sample.webrestapi.query;

public class UserQuery {
    public static final String INSERT_USER_QUERY = "INSERT INTO user (firstName, lastName, email, password) VALUES (:firstName, :lastName, :email, :password)";
    public static final String FIND_BY_EMAIL_QUERY = "SELECT * FROM user WHERE email = :email";
    public static final String UPDATE_USER_QUERY = "UPDATE user SET firstName = :firstName, lastName = :lastName, email = :email, password = :password, role = :role WHERE id = :id";
    public static final String LIST_USER_QUERY = "SELECT * FROM user";
    public static final String LIST_USER_WITH_PAGE_QUERY = "SELECT * FROM user LIMIT :limit OFFSET :offset";
    public static final String DELETE_USER_QUERY = "SELECT * FROM user WHERE id = :id";
    public static final String FIND_USER_BY_ID_QUERY = "SELECT * FROM user WHERE id = :id";

}

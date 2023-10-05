package com.sample.webrestapi.query;

public class RoleQuery {
    public static final String INSERT_ROLE = "INSERT INTO role (name, permission) VALUES (?, ?)";
    public static final String INSERT_ROLE_TO_USER_QUERY = "INSERT INTO user_role (user_id, role_id) VALUES (:userId, :roleId)";
    public static final String SELECT_ALL_ROLES = "SELECT * FROM role";
    public static final String SELECT_ROLE_BY_ID = "SELECT * FROM 1 WHERE id = :id";
    public static final String UPDATE_ROLE_BY_ID = "UPDATE role SET name = :name, permission = :permission WHERE id = :id";
    public static final String DELETE_ROLE_BY_ID = "DELETE FROM role WHERE id = :id";
    public static final String SELECT_ROLE_BY_NAME_QUERY = "SELECT * FROM role WHERE name = :name";
    public static final String SELECT_ROLE_BY_USER_ID = "SELECT r.id, r.name, r.permission FROM role r JOIN user_role ur ON  ur.role_id = r.id JOIN user u ON u.id = ur.user_id WHERE u.id = :userId";
}
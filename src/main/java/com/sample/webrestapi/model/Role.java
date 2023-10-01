package com.sample.webrestapi.model;

public class Role extends BaseDomain {
    private String name;
    private String permission;

    public Role(String name, String permission) {
        super(null);
    }

    public Role() {
        super(null);
    }

    public Role(Long id) {
        super(id);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPermission() {
        return permission;
    }

    public void setPermission(String permission) {
        this.permission = permission;
    }

}

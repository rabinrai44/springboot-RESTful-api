package com.sample.webrestapi.model;

import java.util.UUID;

public class Role extends BaseDomain<UUID> {
    private String name;
    private String permission;

    public Role(String name, String permission) {
        super(null);
    }

    public Role() {
        super(null);
    }

    public Role(UUID id) {
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

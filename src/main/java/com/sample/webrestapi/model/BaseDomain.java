package com.sample.webrestapi.model;

import java.time.LocalDateTime;

public abstract class BaseDomain {
    protected int id;
    protected LocalDateTime createdAt;
    protected LocalDateTime updatedAt;

    public BaseDomain(int id) {
        this.id = id;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = null;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

}

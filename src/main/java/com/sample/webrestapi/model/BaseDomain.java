package com.sample.webrestapi.model;

import java.time.LocalDateTime;

public abstract class BaseDomain<T> {
    protected T id;
    protected LocalDateTime createdAt;
    protected LocalDateTime updatedAt;

    public BaseDomain(T id) {
        this.id = id;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = null;
    }

    public T getId() {
        return id;
    }

    public void setId(T id) {
        this.id = id;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

}

package com.sample.webrestapi.model;

import java.time.LocalDateTime;
import java.util.Date;

public abstract class BaseDomain {
    protected Long id;
    protected Date createdAt;
    protected Date updatedAt;

    public BaseDomain(Long id) {
        this.id = id;
        this.createdAt = Date.from(LocalDateTime.now().toLocalDate().atStartOfDay().toInstant(null));
        this.updatedAt = null;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

}

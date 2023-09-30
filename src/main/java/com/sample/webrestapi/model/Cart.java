package com.sample.webrestapi.model;

import java.util.List;
import java.util.UUID;

public class Cart extends BaseDomain {
    private UUID userId;
    private List<CartItem> items;

    public Cart(Long id, UUID userId, List<CartItem> items) {
        super(id);
        this.userId = userId;
        this.items = items;
    }

    public Cart(UUID userId, List<CartItem> items) {
        super(null);
        this.userId = userId;
        this.items = items;
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
    }

    public void addItem(CartItem item) {
        this.items.add(item);
    }

    public void removeItem(CartItem item) {
        this.items.remove(item);
    }

    public void updateItem(CartItem item) {
        this.items.remove(item);
        this.items.add(item);
    }

    public UUID getUserId() {
        return userId;
    }

    public void setUserId(UUID userId) {
        this.userId = userId;
    }

}

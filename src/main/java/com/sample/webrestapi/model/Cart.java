package com.sample.webrestapi.model;

import java.util.List;
import java.util.UUID;

public class Cart extends DataObject {
    private UUID userId;
    private List<CartItemSet> items;

    public Cart(UUID id, String name, List<CartItemSet> items, UUID userId) {
        super(id, name);
        this.items = items;
        this.userId = userId;
    }

    public List<CartItemSet> getItems() {
        return items;
    }

    public void setItems(List<CartItemSet> items) {
        this.items = items;
    }

    public void addItem(CartItemSet item) {
        this.items.add(item);
    }

    public void removeItem(CartItemSet item) {
        this.items.remove(item);
    }

    public void updateItem(CartItemSet item) {
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

package com.sample.webrestapi.service;

import java.util.List;

import com.sample.webrestapi.model.Cart;

public interface CartService extends AutoCloseable {

    void addToCart();

    void removeFromCart();

    void updateCart();

    List<Cart> getCarts(String sessionId);
}

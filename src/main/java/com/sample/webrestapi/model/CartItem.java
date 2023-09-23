package com.sample.webrestapi.model;

import java.util.UUID;

public class CartItem extends DataObject implements Comparable<CartItem> {
    private String itemNo;
    private Item item;
    private int quantity;
    private UUID cartId;

    public CartItem(UUID id, String name, Item item, int quantity, UUID cartId) {
        super(id, name);
        this.item = item;
        this.itemNo = item.getItemNo();
        this.quantity = quantity;
        this.cartId = cartId;
    }

    public CartItem(Item item, int quantity, UUID cartId) {
        super(null, item.getItemNo());
        this.item = item;
        this.itemNo = item.getItemNo();
        this.quantity = quantity;
        this.cartId = cartId;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public int compareTo(CartItem o) {
        return this.item.compareTo(o.item);
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof CartItem) {
            CartItem other = (CartItem) obj;
            return this.item.equals(other.item) && this.quantity == other.quantity;
        }

        return false;
    }

    @Override
    public int hashCode() {
        return this.item.hashCode() + this.quantity;
    }

    @Override
    public String toString() {
        return "CartItem [item=" + item + ", quantity=" + quantity + "]";
    }

    public String getItemNo() {
        return itemNo;
    }

    public UUID getCartId() {
        return cartId;
    }

    public void setCartId(UUID cartId) {
        this.cartId = cartId;
    }

    public void setItemNo(String itemNo) {
        this.itemNo = itemNo;
    }

}

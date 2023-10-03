package com.sample.webrestapi.model;

import java.math.BigDecimal;

public class CartItem extends BaseDomain<Long> implements Comparable<CartItem> {
    private String itemNo;
    private int quantity;
    private BigDecimal price;
    private Long cartId;

    public CartItem(Long id, Long cartId, String itemNo, int quantity, BigDecimal price) {
        super(id);
        this.itemNo = itemNo;
        this.cartId = cartId;
        this.quantity = quantity;
        this.price = price;
    }

    public CartItem(Long cartId, String itemNo, int quantity, BigDecimal price) {
        super(null);
        this.itemNo = itemNo;
        this.quantity = quantity;
        this.price = price;
        this.cartId = cartId;
    }

    @Override
    public int compareTo(CartItem o) {
        return this.itemNo.compareTo(o.itemNo);
    }

    @Override
    public boolean equals(Object arg0) {
        // TODO Auto-generated method stub
        return super.equals(arg0);
    }

    @Override
    public int hashCode() {
        return this.itemNo.hashCode();
    }

    @Override
    public String toString() {
        return "CartItem [itemNo=" + itemNo + ", quantity=" + quantity + "]";
    }

    public String getItemNo() {
        return itemNo;
    }

    public void setItemNo(String itemNo) {
        this.itemNo = itemNo;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public void setCartId(Long cartId) {
        this.cartId = cartId;
    }

    public Long getCartId() {
        return cartId;
    }

}

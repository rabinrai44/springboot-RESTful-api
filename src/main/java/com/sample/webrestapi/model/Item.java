package com.sample.webrestapi.model;

import java.math.BigDecimal;

public class Item extends BaseDomain<Long> implements Comparable<Item> {
    private String itemNo;
    private String title;
    private String description;
    private BigDecimal unitPrice;
    private int minOrderQty;
    private int maxOrderQty;
    private boolean inStock;
    private String imageUrl;
    private int vendorId;
    private int countryId;
    private int categoryId;

    public Item() {
        super(null);
        itemNo = "";
        title = "";
        description = "";
        unitPrice = new BigDecimal(0);
        minOrderQty = 1;
        maxOrderQty = 0;
        inStock = true;
        imageUrl = "";
    }

    public String getItemNo() {
        return itemNo;
    }

    public void setItemNo(String itemNo) {
        this.itemNo = itemNo;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public int getMinOrderQty() {
        return minOrderQty;
    }

    @Override
    public int compareTo(Item o) {
        if (itemNo != null && o != null && o.itemNo != null) {
            return itemNo.compareToIgnoreCase(o.itemNo);
        } else {
            return -1;
        }
    }

    public boolean isInStock() {
        return inStock;
    }

    public void setInStock(boolean inStock) {
        this.inStock = inStock;
    }

    public void setMinOrderQty(int minOrderQty) {
        this.minOrderQty = minOrderQty;
    }

    public int getMaxOrderQty() {
        return maxOrderQty;
    }

    public void setMaxOrderQty(int maxOrderQty) {
        this.maxOrderQty = maxOrderQty;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getVendorId() {
        return vendorId;
    }

    public void setVendorId(int vendorId) {
        this.vendorId = vendorId;
    }

    public int getCountryId() {
        return countryId;
    }

    public void setCountryId(int countryId) {
        this.countryId = countryId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

}

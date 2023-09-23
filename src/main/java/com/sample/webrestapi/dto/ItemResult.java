package com.sample.webrestapi.dto;

import java.math.BigDecimal;

import com.sample.webrestapi.model.Category;
import com.sample.webrestapi.model.Country;
import com.sample.webrestapi.model.Vendor;

public class ItemResult {
    private String itemNo;
    private String title;
    private String description;
    private BigDecimal unitPrice;
    private int minOrderQty;
    private int maxOrderQty;
    private boolean inStock;
    private String imageUrl;

    private Country country;
    private Vendor vendor;
    private Category category;

    public ItemResult() {
        itemNo = "";
        title = "";
        description = "";
        unitPrice = new BigDecimal(0);
        minOrderQty = 1;
        maxOrderQty = 0;
        inStock = true;
        imageUrl = "";
        country = null;
        vendor = null;
        category = null;
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

    public void setMinOrderQty(int minOrderQty) {
        this.minOrderQty = minOrderQty;
    }

    public int getMaxOrderQty() {
        return maxOrderQty;
    }

    public void setMaxOrderQty(int maxOrderQty) {
        this.maxOrderQty = maxOrderQty;
    }

    public boolean isInStock() {
        return inStock;
    }

    public void setInStock(boolean inStock) {
        this.inStock = inStock;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Country getCountry() {
        return country;
    }

    public void setCountry(Country country) {
        this.country = country;
    }

    public Vendor getVendor() {
        return vendor;
    }

    public void setVendor(Vendor vendor) {
        this.vendor = vendor;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

}

package com.sample.webrestapi.dto;

import java.math.BigDecimal;

public class AddItem {
        private String itemNo;
        private String title;
        private String description;
        private BigDecimal unitPrice;
        private String imageUrl;
        private int minOrderQty;
        private int maxOrderQty;
        private int vendorId;
        private int countryId;
        private int categoryId;
        private boolean inStock;

        public AddItem() {
                itemNo = "";
                title = "";
                description = "";
                unitPrice = new BigDecimal(0);
                imageUrl = "";
                minOrderQty = 1;
                maxOrderQty = 0;
                vendorId = 0;
                countryId = 0;
                categoryId = 0;
                inStock = true;
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

        public boolean isInStock() {
                return inStock;
        }

        public void setInStock(boolean inStock) {
                this.inStock = inStock;
        }

}
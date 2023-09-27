package com.sample.webrestapi.service.implementation;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.Logger;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.sample.webrestapi.common.AppConstants;
import com.sample.webrestapi.mapper.ItemRowMapper;
import com.sample.webrestapi.model.Item;
import com.sample.webrestapi.service.ContentData;

@Service
public class ContentDataService implements ContentData, AutoCloseable {
    private static final Logger logger = (Logger) LogManager.getLogger(ContentDataService.class);
    private final JdbcTemplate jdbc;

    public ContentDataService(@Qualifier(AppConstants.JDBC_TEMPLATE_CONTENT) JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    @Override
    public void createItem(Item item) {
        try {
            this.jdbc.update("CALL spAddItem(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                    item.getItemNo(),
                    item.getTitle(),
                    item.getDescription(),
                    item.getUnitPrice(),
                    item.isInStock(),
                    item.getMinOrderQty(),
                    item.getMaxOrderQty(),
                    item.getImageUrl(),
                    item.getCategoryId(),
                    item.getVendorId(),
                    item.getCountryId());

        } catch (Exception e) {
            logger.error("Error creating item", e);
        }
    }

    @Override
    public void updateItem(Item item) {
        try {
            this.jdbc.update(
                    "UPDATE items SET title = ?, description = ?, unitPrice = ?, minOrderQty = ?, mxOrderQty = ?, inStock = ?, imageUrl = ?, vendorId = ?, categoryId = ?, countryId = ? WHERE itemNo = ?",
                    item.getTitle(),
                    item.getDescription(),
                    item.getUnitPrice(),
                    item.getMinOrderQty(),
                    item.getMaxOrderQty(),
                    item.isInStock(),
                    item.getImageUrl(),
                    item.getVendorId(),
                    item.getCountryId());
        } catch (Exception e) {
            logger.error("Error updating item", e);
        }
    }

    @Override
    public void deleteItem(String itemNo) {
        try {
            this.jdbc.update("DELETE FROM items WHERE itemNo = ?", itemNo);
        } catch (Exception e) {
            logger.error("Error deleting item", e);
        }
    }

    @Override
    public Item getItem(String itemNo) {
        try {
            return this.jdbc.query("SELECT * FROM items WHERE itemNo = ?", new ItemRowMapper(), itemNo)
                    .stream().findFirst().orElseThrow();
        } catch (EmptyResultDataAccessException e) {
            logger.error("Error getting item", e);
            return null;
        } catch (Exception e) {
            logger.error("", e);
            return null;
        }
    }

    @Override
    public List<Item> getItems() {
        try {
            return this.jdbc.query("SELECT * FROM items", new ItemRowMapper());
        } catch (Exception e) {
            logger.error("Error getting items", e);
            return new ArrayList<>();
        }
    }

    @Override
    public void close() {
        if (jdbc != null) {
            try {
                jdbc.getDataSource().getConnection().close();
            } catch (Exception e) {
                logger.error("Error closing JDBC connection", e);
            }
        }
    }
}

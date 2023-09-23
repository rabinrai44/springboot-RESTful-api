package com.sample.webrestapi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.Nullable;

import com.sample.webrestapi.model.Item;

public class ItemRowMapper implements RowMapper<Item> {

    @Override
    @Nullable
    public Item mapRow(ResultSet rs, int rowNum) throws SQLException {
        Item item = new Item();
        item.setItemNo(rs.getString("item_no"));
        item.setTitle(rs.getString("title"));
        item.setDescription(rs.getString("description"));
        item.setUnitPrice(rs.getBigDecimal("unit_price"));
        item.setMinOrderQty(rs.getInt("min_order_qty"));
        item.setMaxOrderQty(rs.getInt("max_order_qty"));
        item.setInStock(rs.getBoolean("in_stock"));
        item.setVendorId(rs.getInt("vendor_id"));
        item.setCategoryId(rs.getInt("category_id"));
        item.setCountryId(rs.getInt("country_id"));
        item.setImageUrl(rs.getString("image_url"));

        return item;
    }

}

package com.sample.webrestapi.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sample.webrestapi.dto.AddItem;
import com.sample.webrestapi.model.Item;
import com.sample.webrestapi.service.WebDataService;

@RestController
@RequestMapping("/api/v1/web")
public class WebController {

    private final WebDataService repository;

    public WebController(WebDataService repository) {
        this.repository = repository;
    }

    @GetMapping("/items")
    public List<Item> getItems() {
        return repository.getItems();
    }

    @GetMapping("/items/{itemNo}")
    public Item getItem(String itemNo) {
        return repository.getItem(itemNo);
    }

    @PostMapping("/items")
    public void createItem(@RequestBody AddItem itemDto) {
        Item item = new Item();
        item.setItemNo(itemDto.getItemNo());
        item.setTitle(itemDto.getTitle());
        item.setDescription(itemDto.getDescription());
        item.setUnitPrice(itemDto.getUnitPrice());
        item.setMinOrderQty(itemDto.getMinOrderQty());
        item.setMaxOrderQty(itemDto.getMaxOrderQty());
        item.setInStock(itemDto.isInStock());
        item.setImageUrl(itemDto.getImageUrl());
        item.setCountryId(itemDto.getCountryId());
        item.setVendorId(itemDto.getVendorId());
        item.setCategoryId(itemDto.getCategoryId());

        repository.createItem(item);
    }

}

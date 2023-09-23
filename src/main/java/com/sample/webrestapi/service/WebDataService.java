package com.sample.webrestapi.service;

import java.util.List;

import com.sample.webrestapi.model.Country;
import com.sample.webrestapi.model.Item;

public interface WebDataService {

    void createItem(Item item);

    void updateItem(Item item);

    void deleteItem(String itemNo);

    Item getItem(String itemNo);

    List<Item> getItems();

    List<Country> getCountries();

    Country getCountry(String countryCode);

}

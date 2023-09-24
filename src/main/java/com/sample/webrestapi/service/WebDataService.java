package com.sample.webrestapi.service;

import java.util.List;

import com.sample.webrestapi.model.Country;

public interface WebDataService {

    List<Country> getCountries();

    Country getCountry(String countryCode);
}

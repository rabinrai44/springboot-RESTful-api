package com.sample.webrestapi.model;

public class Country extends BaseDomain<Long> {
    private String code;
    private String name;

    public Country(Long id, String name, String code) {
        super(id);
        this.name = name;
        this.code = code;
    }

    public Country() {
        this("", "");
    }

    public Country(String name, String code) {
        this(null, name, code);
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}

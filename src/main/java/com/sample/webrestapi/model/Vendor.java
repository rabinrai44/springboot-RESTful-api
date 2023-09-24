package com.sample.webrestapi.model;

public class Vendor extends BaseDomain implements Comparable<Vendor> {
    private String name;
    private String description;

    public Vendor(Long id, String name, String description) {
        super(id);
        this.name = name;
        this.description = description;
    }

    public Vendor() {
        this("", "");
    }

    public Vendor(String name, String description) {
        super(null);
        this.name = name;
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public int compareTo(Vendor o) {
        return this.getName().compareTo(o.getName());
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}

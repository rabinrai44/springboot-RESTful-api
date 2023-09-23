package com.sample.webrestapi.model;

public class Category extends BaseDomain implements Comparable<Category> {
    private String name;
    private String description;

    public Category(int id, String name, String description) {
        super(id);
        this.name = name;
        this.description = description;
    }

    public Category(String name, String description) {
        super(0);
        this.name = name;
        this.description = description;
    }

    public Category() {
        this("", "");
    }

    @Override
    public int compareTo(Category o) {
        return this.getName().compareTo(o.getName());
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}

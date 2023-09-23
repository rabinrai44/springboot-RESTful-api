package com.sample.webrestapi.model;

import java.util.UUID;

public class AppUser extends DataObject implements Comparable<AppUser> {
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String phone;

    public AppUser(UUID id, String firstName, String lastName, String email, String password, String phone) {
        super(id, firstName + " " + lastName);
    }

    public AppUser(String firstName, String lastName, String email, String password, String phone) {
        super(null, firstName + " " + lastName);
    }

    @Override
    public int compareTo(AppUser o) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'compareTo'");
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    
}

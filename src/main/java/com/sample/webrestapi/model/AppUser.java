package com.sample.webrestapi.model;

import java.util.UUID;

public class AppUser extends DataObject implements Comparable<AppUser> {
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String phone;
    private String title;
    private String bio;
    private String imageUrl;
    private boolean enabled;
    private boolean isNotLocked;

    public AppUser(UUID id, String firstName, String lastName, String email, String password, String phone,
            String title, String bio, String imageUrl, boolean enabled, boolean isNotLocked) {
        super(id, firstName + " " + lastName);
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.title = title;
        this.bio = bio;
        this.imageUrl = imageUrl;
        this.enabled = enabled;
        this.isNotLocked = isNotLocked;
    }

    public AppUser(String firstName, String lastName, String email, String phone, String title, String bio,
            String imageUrl) {
        super(null, null);
    }

    public AppUser() {
        super(null, null);
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public boolean isNotLocked() {
        return isNotLocked;
    }

    public void setNotLocked(boolean isNotLocked) {
        this.isNotLocked = isNotLocked;
    }

}

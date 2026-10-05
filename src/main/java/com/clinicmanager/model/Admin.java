package com.clinicmanager.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "admins")
public class Admin extends User {
    public Admin(){

    }
    @Override
    public String getRole() {
        return "ADMIN";
    }
}
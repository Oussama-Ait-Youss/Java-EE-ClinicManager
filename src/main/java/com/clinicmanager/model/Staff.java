package com.clinicmanager.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "staffs")
public class Staff extends User {
    @Override
    public String getRole() {
        return "STAFF";
    }
}
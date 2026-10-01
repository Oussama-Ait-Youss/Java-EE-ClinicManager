package com.clinicmanager.config;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaTest {
    public static void main(String[] args) {
        EntityManagerFactory test = Persistence.createEntityManagerFactory("clinicPU");
        System.out.println("Hebernates start succefully...");
        test.close();
    }
}

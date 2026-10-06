package com.clinicmanager.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {

    private static final String PERSISTENCE_UNIT_NAME = "clinicPU";
    private static final EntityManagerFactory emf;

    private static String envOrDefault(String key, String defaultValue) {
        String value = System.getenv(key);
        return (value == null || value.isBlank()) ? defaultValue : value;
    }

    private static void setPropertyIfMissing(String key, String value) {
        if (System.getProperty(key) == null || System.getProperty(key).isBlank()) {
            System.setProperty(key, value);
        }
    }

    // Static block runs once when the class is first loaded by the JVM
    static {
        try {
            setPropertyIfMissing("jakarta.persistence.jdbc.url",
                    envOrDefault("DB_URL", "jdbc:postgresql://localhost:5433/clinic_db"));
            setPropertyIfMissing("jakarta.persistence.jdbc.user",
                    envOrDefault("DB_USER", "clinic_user"));
            setPropertyIfMissing("jakarta.persistence.jdbc.password",
                    envOrDefault("DB_PASSWORD", "clinic_password"));
            setPropertyIfMissing("jakarta.persistence.jdbc.driver",
                    "org.postgresql.Driver");

            emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
        } catch (Throwable ex) {
            System.err.println("Initial EntityManagerFactory creation failed: " + ex.getMessage());
            throw new ExceptionInInitializerError(ex);
        }
    }

    // Provides a fresh EntityManager for a repository operation
    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    // Closes the factory when the application shuts down
    public static void shutdown() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
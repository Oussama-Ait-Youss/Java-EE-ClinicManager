package com.clinicmanager.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {

    private static final String PERSISTENCE_UNIT_NAME = "clinicPU";
    private static final EntityManagerFactory emf;

    // Static block runs once when the class is first loaded by the JVM
    static {
        try {
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
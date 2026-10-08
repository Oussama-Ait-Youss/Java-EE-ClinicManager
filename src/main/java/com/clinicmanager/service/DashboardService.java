package com.clinicmanager.service;

import com.clinicmanager.repository.impl.DashboardRepositoryImpl;
import com.clinicmanager.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.function.Function;

public class DashboardService {
    public Long getTotalDoctors() {
        return inTransaction("Could not load the total doctor count.",
                em -> new DashboardRepositoryImpl(em).getTotalDoctors());
    }

    public Long getTotalPatients() {
        return inTransaction("Could not load the total patient count.",
                em -> new DashboardRepositoryImpl(em).getTotalPatients());
    }

    public Long getTotalStaff() {
        return inTransaction("Could not load the total staff count.",
                em -> new DashboardRepositoryImpl(em).getTotalStaff());
    }

    public Long getTodayAppointments() {
        return inTransaction("Could not load today's appointment count.",
                em -> new DashboardRepositoryImpl(em).getTodayAppointments());
    }

    private <T> T inTransaction(String errorMessage, Function<EntityManager, T> operation) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            T result = operation.apply(em);
            tx.commit();
            return result;
        } catch (RuntimeException e) {
            if (tx.isActive()) {
                try {
                    tx.rollback();
                } catch (RuntimeException rollbackFailure) {
                    e.addSuppressed(rollbackFailure);
                }
            }
            throw new com.clinicmanager.exception.ServiceException(errorMessage, e);
        } finally {
            em.close();
        }
    }
}

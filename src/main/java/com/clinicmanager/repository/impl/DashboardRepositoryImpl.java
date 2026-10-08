package com.clinicmanager.repository.impl;

import com.clinicmanager.repository.DashboardRepository;
import jakarta.persistence.EntityManager;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class DashboardRepositoryImpl implements DashboardRepository {
    private final EntityManager em;

    public DashboardRepositoryImpl(EntityManager em) {
        this.em = em;
    }

    @Override
    public Long getTotalDoctors() {
        return em.createQuery("SELECT COUNT(d) FROM Doctor d", Long.class).getSingleResult();
    }

    @Override
    public Long getTotalPatients() {
        return em.createQuery("SELECT COUNT(p) FROM Patient p", Long.class).getSingleResult();
    }

    @Override
    public Long getTotalStaff() {
        return em.createQuery("SELECT COUNT(s) FROM Staff s", Long.class).getSingleResult();
    }

    @Override
    public Long getTodayAppointments() {
        LocalDateTime startOfDay = LocalDate.now().atStartOfDay();
        LocalDateTime endOfDay = startOfDay.plusDays(1).minusNanos(1);
        return em.createQuery(
                        "SELECT COUNT(a) FROM Appointment a WHERE a.appointmentDateTime >= :start " +
                                "AND a.appointmentDateTime <= :end",
                        Long.class)
                .setParameter("start", startOfDay)
                .setParameter("end", endOfDay)
                .getSingleResult();
    }
}

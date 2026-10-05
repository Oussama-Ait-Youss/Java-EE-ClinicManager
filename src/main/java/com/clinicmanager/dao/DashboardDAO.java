package com.clinicmanager.dao;

import com.clinicmanager.util.JPAUtil;
import jakarta.persistence.EntityManager;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class DashboardDAO {

    public Long getTotalDoctors() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(d) FROM Doctor d", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }

    public Long getTotalPatients() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(p) FROM Patient p", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }

    public Long getTotalStaff() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(s) FROM Staff s", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }

    public Long getTodayAppointments() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            LocalDateTime startOfDay = LocalDate.now().atStartOfDay();
            LocalDateTime endOfDay = startOfDay.plusDays(1).minusNanos(1);

            return em.createQuery(
                            "SELECT COUNT(a) FROM Appointment a WHERE a.appointmentDateTime >= :start AND a.appointmentDateTime <= :end",
                            Long.class)
                    .setParameter("start", startOfDay)
                    .setParameter("end", endOfDay)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }
}
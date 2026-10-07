package com.clinicmanager.dao;

import com.clinicmanager.model.Appointment;
import com.clinicmanager.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

public class AppointmentDAO {

    public List<Appointment> getAllAppointments() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT a FROM Appointment a JOIN FETCH a.patient JOIN FETCH a.doctor ORDER BY a.appointmentDateTime DESC", Appointment.class).getResultList();
        } finally {
            em.close();
        }
    }

    public List<Appointment> getAppointmentsByPatientId(Long patientId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // FIXED: Changed a.appointmentDate to a.appointmentDateTime
            return em.createQuery("SELECT a FROM Appointment a JOIN FETCH a.patient JOIN FETCH a.doctor WHERE a.patient.id = :patientId ORDER BY a.appointmentDateTime DESC", Appointment.class)
                    .setParameter("patientId", patientId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public Appointment getAppointmentById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Appointment.class, id);
        } finally {
            em.close();
        }
    }

    public void save(Appointment appointment) throws Exception {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(appointment);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new Exception("Could not schedule appointment.", e);
        } finally {
            em.close();
        }
    }

    public void update(Appointment appointment) throws Exception {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(appointment);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new Exception("Could not update appointment details.", e);
        } finally {
            em.close();
        }
    }

    public void delete(Long id) throws Exception {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Appointment appointment = em.find(Appointment.class, id);
            if (appointment != null) {
                em.remove(appointment);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new Exception("Could not delete appointment.", e);
        } finally {
            em.close();
        }
    }
}
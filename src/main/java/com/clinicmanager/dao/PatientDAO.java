package com.clinicmanager.dao;

import com.clinicmanager.model.Patient;
import com.clinicmanager.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

public class PatientDAO {

    public List<Patient> getAllPatients() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // Using LEFT JOIN FETCH for appointments to safely show appointment counts in the JSP without LazyInitializationException
            return em.createQuery("SELECT DISTINCT p FROM Patient p LEFT JOIN FETCH p.appointments ORDER BY p.id DESC", Patient.class).getResultList();
        } finally {
            em.close();
        }
    }

    public Patient getPatientById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Patient.class, id);
        } finally {
            em.close();
        }
    }

    public void save(Patient patient) throws Exception {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(patient);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new Exception("Could not save patient. The email might already be in use.", e);
        } finally {
            em.close();
        }
    }

    public void update(Patient patient) throws Exception {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(patient);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new Exception("Could not update patient details.", e);
        } finally {
            em.close();
        }
    }

    public void delete(Long id) throws Exception {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Patient patient = em.find(Patient.class, id);
            if (patient != null) {
                if (patient.getAppointments() != null && !patient.getAppointments().isEmpty()) {
                    throw new Exception("Cannot delete this patient because they have existing appointments.");
                }
                em.remove(patient);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new Exception(e.getMessage(), e);
        } finally {
            em.close();
        }
    }
}
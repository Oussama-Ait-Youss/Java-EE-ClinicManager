package com.clinicmanager.repository.impl;

import com.clinicmanager.model.Patient;
import com.clinicmanager.repository.PatientRepository;
import jakarta.persistence.EntityManager;

import java.util.List;

public class PatientRepositoryImpl implements PatientRepository {
    private final EntityManager em;

    public PatientRepositoryImpl(EntityManager em) {
        this.em = em;
    }

    @Override
    public List<Patient> getAllPatients() {
        return em.createQuery(
                        "SELECT DISTINCT p FROM Patient p LEFT JOIN FETCH p.appointments ORDER BY p.id DESC",
                        Patient.class)
                .getResultList();
    }

    @Override
    public Patient getPatientById(Long id) {
        return em.find(Patient.class, id);
    }

    @Override
    public void save(Patient patient) {
        em.persist(patient);
    }

    @Override
    public void update(Patient patient) {
        em.merge(patient);
    }

    @Override
    public void delete(Long id) {
        Patient patient = em.find(Patient.class, id);
        if (patient != null) {
            em.remove(patient);
        }
    }
}

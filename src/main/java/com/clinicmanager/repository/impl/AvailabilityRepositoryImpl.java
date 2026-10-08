package com.clinicmanager.repository.impl;

import com.clinicmanager.model.Availability;
import com.clinicmanager.repository.AvailabilityRepository;
import jakarta.persistence.EntityManager;

import java.util.List;

public class AvailabilityRepositoryImpl implements AvailabilityRepository {
    private final EntityManager em;

    public AvailabilityRepositoryImpl(EntityManager em) {
        this.em = em;
    }

    @Override
    public List<Availability> findAll() {
        return em.createQuery(
                        "SELECT a FROM Availability a JOIN FETCH a.doctor ORDER BY a.dayOfWeek, a.startTime",
                        Availability.class)
                .getResultList();
    }

    @Override
    public Availability findById(Long id) {
        return em.createQuery(
                        "SELECT a FROM Availability a JOIN FETCH a.doctor WHERE a.id = :id",
                        Availability.class)
                .setParameter("id", id)
                .getResultStream()
                .findFirst()
                .orElse(null);
    }

    @Override
    public List<Availability> findByDoctorId(Long doctorId) {
        return em.createQuery(
                        "SELECT a FROM Availability a JOIN FETCH a.doctor WHERE a.doctor.id = :doctorId " +
                                "ORDER BY a.dayOfWeek, a.startTime",
                        Availability.class)
                .setParameter("doctorId", doctorId)
                .getResultList();
    }

    @Override
    public void save(Availability availability) {
        em.persist(availability);
    }

    @Override
    public void update(Availability availability) {
        em.merge(availability);
    }

    @Override
    public void delete(Long id) {
        Availability availability = em.find(Availability.class, id);
        if (availability != null) {
            em.remove(availability);
        }
    }
}

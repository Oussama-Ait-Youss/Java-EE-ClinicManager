package com.clinicmanager.repository.impl;

import com.clinicmanager.model.MedicalNote;
import com.clinicmanager.repository.MedicalNoteRepository;
import jakarta.persistence.EntityManager;

import java.util.List;

public class MedicalNoteRepositoryImpl implements MedicalNoteRepository {
    private final EntityManager em;

    public MedicalNoteRepositoryImpl(EntityManager em) {
        this.em = em;
    }

    @Override
    public List<MedicalNote> findAll() {
        return em.createQuery(
                        "SELECT n FROM MedicalNote n " +
                                "JOIN FETCH n.appointment a " +
                                "JOIN FETCH a.patient " +
                                "JOIN FETCH a.doctor " +
                                "ORDER BY n.noteDate DESC",
                        MedicalNote.class)
                .getResultList();
    }

    @Override
    public MedicalNote findById(Long id) {
        return em.createQuery(
                        "SELECT n FROM MedicalNote n " +
                                "JOIN FETCH n.appointment a " +
                                "JOIN FETCH a.patient " +
                                "JOIN FETCH a.doctor " +
                                "WHERE n.id = :id",
                        MedicalNote.class)
                .setParameter("id", id)
                .getResultStream()
                .findFirst()
                .orElse(null);
    }

    @Override
    public MedicalNote findByAppointmentId(Long appointmentId) {
        return em.createQuery(
                        "SELECT n FROM MedicalNote n WHERE n.appointment.id = :appointmentId",
                        MedicalNote.class)
                .setParameter("appointmentId", appointmentId)
                .getResultStream()
                .findFirst()
                .orElse(null);
    }

    @Override
    public void save(MedicalNote note) {
        em.persist(note);
    }

    @Override
    public void update(MedicalNote note) {
        em.merge(note);
    }

    @Override
    public void delete(Long id) {
        MedicalNote note = em.createQuery(
                        "SELECT n FROM MedicalNote n WHERE n.id = :id",
                        MedicalNote.class)
                .setParameter("id", id)
                .getResultStream()
                .findFirst()
                .orElse(null);
        if (note != null) {
            em.remove(note);
        }
    }
}

package com.clinicmanager.service;

import com.clinicmanager.exception.ServiceException;
import com.clinicmanager.model.Appointment;
import com.clinicmanager.model.MedicalNote;
import com.clinicmanager.model.enums.AppointmentStatus;
import com.clinicmanager.repository.impl.AppointmentRepositoryImpl;
import com.clinicmanager.repository.impl.MedicalNoteRepositoryImpl;
import com.clinicmanager.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.time.LocalDateTime;
import java.util.List;
import java.util.function.Function;

public class MedicalNoteService {
    public List<MedicalNote> getAllNotes() {
        return inTransaction("Could not load medical notes.",
                em -> new MedicalNoteRepositoryImpl(em).findAll());
    }

    public MedicalNote getNoteById(Long id) {
        return inTransaction("Could not load medical note details.",
                em -> new MedicalNoteRepositoryImpl(em).findById(id));
    }

    public MedicalNote findByAppointmentId(Long appointmentId) {
        return inTransaction("Could not load the appointment's medical note.",
                em -> new MedicalNoteRepositoryImpl(em).findByAppointmentId(appointmentId));
    }

    public void saveNoteAndCompleteAppointment(MedicalNote note, Long appointmentId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();

            AppointmentRepositoryImpl appointmentRepository = new AppointmentRepositoryImpl(em);
            MedicalNoteRepositoryImpl medicalNoteRepository = new MedicalNoteRepositoryImpl(em);

            Appointment appointment = appointmentRepository.getAppointmentById(appointmentId);
            if (appointment == null) {
                throw new ServiceException("The selected appointment could not be found.");
            }
            if (appointment.getStatus() != AppointmentStatus.SCHEDULED) {
                throw new ServiceException("A medical note can only be added to a scheduled appointment.");
            }
            if (medicalNoteRepository.findByAppointmentId(appointmentId) != null) {
                throw new ServiceException("A medical note already exists for this appointment.");
            }

            note.setAppointment(appointment);
            note.setNoteDate(LocalDateTime.now());
            note.setReadOnly(true);

            medicalNoteRepository.save(note);
            appointment.setStatus(AppointmentStatus.COMPLETED);
            appointment.setMedicalNote(note);
            appointmentRepository.update(appointment);

            tx.commit();
        } catch (ServiceException e) {
            rollback(tx, e);
            throw e;
        } catch (RuntimeException e) {
            rollback(tx, e);
            throw new ServiceException("Could not save the medical note and complete the appointment.", e);
        } finally {
            em.close();
        }
    }

    private <T> T inTransaction(String errorMessage, Function<EntityManager, T> operation) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            T result = operation.apply(em);
            tx.commit();
            return result;
        } catch (ServiceException e) {
            rollback(tx, e);
            throw e;
        } catch (RuntimeException e) {
            rollback(tx, e);
            throw new ServiceException(errorMessage, e);
        } finally {
            em.close();
        }
    }

    private void rollback(EntityTransaction tx, RuntimeException failure) {
        if (tx.isActive()) {
            try {
                tx.rollback();
            } catch (RuntimeException rollbackFailure) {
                failure.addSuppressed(rollbackFailure);
            }
        }
    }
}

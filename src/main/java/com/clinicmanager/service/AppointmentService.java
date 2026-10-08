package com.clinicmanager.service;

import com.clinicmanager.exception.ServiceException;
import com.clinicmanager.model.Appointment;
import com.clinicmanager.repository.AppointmentRepository;
import com.clinicmanager.repository.impl.AppointmentRepositoryImpl;
import com.clinicmanager.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.time.LocalDateTime;
import java.util.List;
import java.util.function.Function;

public class AppointmentService {
    public boolean isDoctorScheduledToWork(Long doctorId, LocalDateTime dateTime) {
        return inTransaction("Could not check the doctor's schedule.",
                em -> new AppointmentRepositoryImpl(em).isDoctorScheduledToWork(doctorId, dateTime));
    }

    public boolean isDoctorAvailable(Long doctorId, LocalDateTime dateTime) {
        return inTransaction("Could not check the doctor's appointment availability.",
                em -> new AppointmentRepositoryImpl(em).isDoctorAvailable(doctorId, dateTime));
    }

    public List<Appointment> getAllAppointments() {
        return inTransaction("Could not load appointments.",
                em -> new AppointmentRepositoryImpl(em).getAllAppointments());
    }

    public List<Appointment> getAppointmentsByPatientId(Long patientId) {
        return inTransaction("Could not load the patient's appointments.",
                em -> new AppointmentRepositoryImpl(em).getAppointmentsByPatientId(patientId));
    }

    public Appointment getAppointmentById(Long id) {
        return inTransaction("Could not load appointment details.",
                em -> new AppointmentRepositoryImpl(em).getAppointmentById(id));
    }

    public void save(Appointment appointment) {
        inTransaction("Could not schedule appointment.", em -> {
            AppointmentRepository repository = new AppointmentRepositoryImpl(em);
            repository.save(appointment);
            return null;
        });
    }

    public void scheduleAppointment(Appointment appointment) {
        inTransaction("Could not schedule appointment.", em -> {
            AppointmentRepository repository = new AppointmentRepositoryImpl(em);
            Long doctorId = appointment.getDoctor().getId();
            LocalDateTime dateTime = appointment.getAppointmentDateTime();
            if (!repository.isDoctorScheduledToWork(doctorId, dateTime)) {
                throw new ServiceException("The selected doctor is not scheduled to work on this day or at this time.");
            }
            if (!repository.isDoctorAvailable(doctorId, dateTime)) {
                throw new ServiceException("This doctor already has an appointment booked at this exact time.");
            }
            repository.save(appointment);
            return null;
        });
    }

    public void update(Appointment appointment) {
        inTransaction("Could not update appointment details.", em -> {
            AppointmentRepository repository = new AppointmentRepositoryImpl(em);
            repository.update(appointment);
            return null;
        });
    }

    public void delete(Long id) {
        inTransaction("Could not delete appointment.", em -> {
            AppointmentRepository repository = new AppointmentRepositoryImpl(em);
            repository.delete(id);
            return null;
        });
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

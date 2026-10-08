package com.clinicmanager.repository.impl;

import com.clinicmanager.model.Appointment;
import com.clinicmanager.repository.AppointmentRepository;
import jakarta.persistence.EntityManager;

import java.time.LocalDateTime;
import java.util.List;

public class AppointmentRepositoryImpl implements AppointmentRepository {
    private final EntityManager em;

    public AppointmentRepositoryImpl(EntityManager em) {
        this.em = em;
    }

    @Override
    public boolean isDoctorScheduledToWork(Long doctorId, LocalDateTime dateTime) {
        Long count = em.createQuery(
                        "SELECT COUNT(v) FROM Availability v WHERE v.doctor.id = :doctorId " +
                                "AND v.dayOfWeek = :dayOfWeek " +
                                "AND v.startTime <= :time AND v.endTime >= :time " +
                                "AND v.validityStart <= :date AND v.validityEnd >= :date",
                        Long.class)
                .setParameter("doctorId", doctorId)
                .setParameter("dayOfWeek", dateTime.getDayOfWeek())
                .setParameter("time", dateTime.toLocalTime())
                .setParameter("date", dateTime.toLocalDate())
                .getSingleResult();
        return count > 0;
    }

    @Override
    public boolean isDoctorAvailable(Long doctorId, LocalDateTime dateTime) {
        Long count = em.createQuery(
                        "SELECT COUNT(a) FROM Appointment a WHERE a.doctor.id = :doctorId " +
                                "AND a.appointmentDateTime = :dateTime AND a.status != 'CANCELED'",
                        Long.class)
                .setParameter("doctorId", doctorId)
                .setParameter("dateTime", dateTime)
                .getSingleResult();
        return count == 0;
    }

    @Override
    public List<Appointment> getAllAppointments() {
        return em.createQuery(
                        "SELECT a FROM Appointment a JOIN FETCH a.patient JOIN FETCH a.doctor " +
                                "ORDER BY a.appointmentDateTime DESC",
                        Appointment.class)
                .getResultList();
    }

    @Override
    public List<Appointment> getAppointmentsByPatientId(Long patientId) {
        return em.createQuery(
                        "SELECT a FROM Appointment a JOIN FETCH a.patient JOIN FETCH a.doctor " +
                                "WHERE a.patient.id = :patientId ORDER BY a.appointmentDateTime DESC",
                        Appointment.class)
                .setParameter("patientId", patientId)
                .getResultList();
    }

    @Override
    public Appointment getAppointmentById(Long id) {
        return em.createQuery(
                        "SELECT a FROM Appointment a JOIN FETCH a.patient JOIN FETCH a.doctor WHERE a.id = :id",
                        Appointment.class)
                .setParameter("id", id)
                .getResultStream()
                .findFirst()
                .orElse(null);
    }

    @Override
    public void save(Appointment appointment) {
        em.persist(appointment);
    }

    @Override
    public void update(Appointment appointment) {
        em.merge(appointment);
    }

    @Override
    public void delete(Long id) {
        Appointment appointment = em.find(Appointment.class, id);
        if (appointment != null) {
            em.remove(appointment);
        }
    }
}

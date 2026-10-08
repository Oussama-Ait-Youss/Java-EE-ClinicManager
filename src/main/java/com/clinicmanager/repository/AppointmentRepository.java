package com.clinicmanager.repository;

import com.clinicmanager.model.Appointment;

import java.time.LocalDateTime;
import java.util.List;

public interface AppointmentRepository {
    boolean isDoctorScheduledToWork(Long doctorId, LocalDateTime dateTime);

    boolean isDoctorAvailable(Long doctorId, LocalDateTime dateTime);

    List<Appointment> getAllAppointments();

    List<Appointment> getAppointmentsByPatientId(Long patientId);

    Appointment getAppointmentById(Long id);

    void save(Appointment appointment);

    void update(Appointment appointment);

    void delete(Long id);
}

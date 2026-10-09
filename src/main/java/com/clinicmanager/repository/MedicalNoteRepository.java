package com.clinicmanager.repository;

import com.clinicmanager.model.MedicalNote;

import java.util.List;

public interface MedicalNoteRepository {
    List<MedicalNote> findAll();

    MedicalNote findById(Long id);

    MedicalNote findByAppointmentId(Long appointmentId);

    void save(MedicalNote note);

    void update(MedicalNote note);

    void delete(Long id);
}

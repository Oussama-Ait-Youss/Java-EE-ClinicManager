package com.clinicmanager.repository;

import com.clinicmanager.model.Patient;

import java.util.List;

public interface PatientRepository {
    List<Patient> getAllPatients();

    Patient getPatientById(Long id);

    void save(Patient patient);

    void update(Patient patient);

    void delete(Long id);
}

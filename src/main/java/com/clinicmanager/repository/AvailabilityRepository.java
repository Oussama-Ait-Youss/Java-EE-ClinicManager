package com.clinicmanager.repository;

import com.clinicmanager.model.Availability;

import java.util.List;

public interface AvailabilityRepository {
    List<Availability> findAll();

    Availability findById(Long id);

    List<Availability> findByDoctorId(Long doctorId);

    void save(Availability availability);

    void update(Availability availability);

    void delete(Long id);
}

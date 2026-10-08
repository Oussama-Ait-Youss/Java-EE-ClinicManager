package com.clinicmanager.repository;

import com.clinicmanager.model.Department;
import com.clinicmanager.model.Doctor;
import com.clinicmanager.model.Specialty;

import java.util.List;

public interface DoctorRepository {
    List<Doctor> getAllDoctors();

    void save(Doctor doctor);

    List<Department> getAllDepartments();

    List<Specialty> getAllSpecialties();

    Department getDepartmentById(Long id);

    Specialty getSpecialtyById(Long id);

    Doctor getDoctorById(Long id);

    void update(Doctor doctor);

    void delete(Long id);
}

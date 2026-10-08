package com.clinicmanager.repository.impl;

import com.clinicmanager.model.Department;
import com.clinicmanager.model.Doctor;
import com.clinicmanager.model.Specialty;
import com.clinicmanager.repository.DoctorRepository;
import jakarta.persistence.EntityManager;

import java.util.List;

public class DoctorRepositoryImpl implements DoctorRepository {
    private final EntityManager em;

    public DoctorRepositoryImpl(EntityManager em) {
        this.em = em;
    }

    @Override
    public List<Doctor> getAllDoctors() {
        return em.createQuery("SELECT d FROM Doctor d ORDER BY d.id DESC", Doctor.class).getResultList();
    }

    @Override
    public void save(Doctor doctor) {
        em.persist(doctor);
    }

    @Override
    public List<Department> getAllDepartments() {
        return em.createQuery("SELECT d FROM Department d", Department.class).getResultList();
    }

    @Override
    public List<Specialty> getAllSpecialties() {
        return em.createQuery("SELECT s FROM Specialty s", Specialty.class).getResultList();
    }

    @Override
    public Department getDepartmentById(Long id) {
        return em.find(Department.class, id);
    }

    @Override
    public Specialty getSpecialtyById(Long id) {
        return em.find(Specialty.class, id);
    }

    @Override
    public Doctor getDoctorById(Long id) {
        return em.find(Doctor.class, id);
    }

    @Override
    public void update(Doctor doctor) {
        em.merge(doctor);
    }

    @Override
    public void delete(Long id) {
        Doctor doctor = em.find(Doctor.class, id);
        if (doctor != null) {
            em.remove(doctor);
        }
    }
}

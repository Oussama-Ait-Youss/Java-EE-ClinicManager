package com.clinicmanager.service;

import com.clinicmanager.model.Department;
import com.clinicmanager.model.Doctor;
import com.clinicmanager.model.Specialty;
import com.clinicmanager.repository.DoctorRepository;
import com.clinicmanager.repository.impl.DoctorRepositoryImpl;
import com.clinicmanager.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;
import java.util.function.Function;

public class DoctorService {
    public List<Doctor> getAllDoctors() {
        return inTransaction("Could not load doctors.",
                em -> new DoctorRepositoryImpl(em).getAllDoctors());
    }

    public void save(Doctor doctor) {
        inTransaction("Could not save doctor. The Email or Matricule might already exist.", em -> {
            DoctorRepository repository = new DoctorRepositoryImpl(em);
            repository.save(doctor);
            return null;
        });
    }

    public List<Department> getAllDepartments() {
        return inTransaction("Could not load departments.",
                em -> new DoctorRepositoryImpl(em).getAllDepartments());
    }

    public List<Specialty> getAllSpecialties() {
        return inTransaction("Could not load specialties.",
                em -> new DoctorRepositoryImpl(em).getAllSpecialties());
    }

    public Department getDepartmentById(Long id) {
        return inTransaction("Could not load department details.",
                em -> new DoctorRepositoryImpl(em).getDepartmentById(id));
    }

    public Specialty getSpecialtyById(Long id) {
        return inTransaction("Could not load specialty details.",
                em -> new DoctorRepositoryImpl(em).getSpecialtyById(id));
    }

    public Doctor getDoctorById(Long id) {
        return inTransaction("Could not load doctor details.",
                em -> new DoctorRepositoryImpl(em).getDoctorById(id));
    }

    public void update(Doctor doctor) {
        inTransaction("Could not update doctor details. The Matricule or Email might conflict with another user.", em -> {
            DoctorRepository repository = new DoctorRepositoryImpl(em);
            repository.update(doctor);
            return null;
        });
    }

    public void delete(Long id) {
        inTransaction("Could not delete this doctor. They may be linked to existing appointments or records.", em -> {
            DoctorRepository repository = new DoctorRepositoryImpl(em);
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
        } catch (RuntimeException e) {
            if (tx.isActive()) {
                try {
                    tx.rollback();
                } catch (RuntimeException rollbackFailure) {
                    e.addSuppressed(rollbackFailure);
                }
            }
            throw new com.clinicmanager.exception.ServiceException(errorMessage, e);
        } finally {
            em.close();
        }
    }
}

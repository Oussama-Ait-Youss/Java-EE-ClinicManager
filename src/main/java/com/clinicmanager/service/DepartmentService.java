package com.clinicmanager.service;

import com.clinicmanager.exception.ServiceException;
import com.clinicmanager.model.Department;
import com.clinicmanager.repository.DepartmentRepository;
import com.clinicmanager.repository.impl.DepartmentRepositoryImpl;
import com.clinicmanager.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;
import java.util.function.Function;

public class DepartmentService {
    public List<Department> getAllDepartments() {
        return inTransaction("Could not load departments.",
                em -> new DepartmentRepositoryImpl(em).getAllDepartments());
    }

    public Department getDepartmentById(Long id) {
        return inTransaction("Could not load department details.",
                em -> new DepartmentRepositoryImpl(em).getDepartmentById(id));
    }

    public void save(Department department) {
        inTransaction("Could not save department. It might already exist.", em -> {
            DepartmentRepository repository = new DepartmentRepositoryImpl(em);
            repository.save(department);
            return null;
        });
    }

    public void update(Department department) {
        inTransaction("Could not update department.", em -> {
            DepartmentRepository repository = new DepartmentRepositoryImpl(em);
            repository.update(department);
            return null;
        });
    }

    public void delete(Long id) {
        inTransaction("Could not delete department.", em -> {
            DepartmentRepository repository = new DepartmentRepositoryImpl(em);
            Department department = repository.getDepartmentById(id);
            if (department != null && department.getDoctors() != null && !department.getDoctors().isEmpty()) {
                throw new ServiceException("Cannot delete department because doctors are currently assigned to it.");
            }
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

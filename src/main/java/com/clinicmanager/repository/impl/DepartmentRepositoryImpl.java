package com.clinicmanager.repository.impl;

import com.clinicmanager.model.Department;
import com.clinicmanager.repository.DepartmentRepository;
import jakarta.persistence.EntityManager;

import java.util.List;

public class DepartmentRepositoryImpl implements DepartmentRepository {
    private final EntityManager em;

    public DepartmentRepositoryImpl(EntityManager em) {
        this.em = em;
    }

    @Override
    public List<Department> getAllDepartments() {
        return em.createQuery("SELECT d FROM Department d ORDER BY d.id DESC", Department.class)
                .getResultList();
    }

    @Override
    public Department getDepartmentById(Long id) {
        return em.find(Department.class, id);
    }

    @Override
    public void save(Department department) {
        em.persist(department);
    }

    @Override
    public void update(Department department) {
        em.merge(department);
    }

    @Override
    public void delete(Long id) {
        Department department = em.find(Department.class, id);
        if (department != null) {
            em.remove(department);
        }
    }
}

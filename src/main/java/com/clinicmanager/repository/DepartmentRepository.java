package com.clinicmanager.repository;

import com.clinicmanager.model.Department;

import java.util.List;

public interface DepartmentRepository {
    List<Department> getAllDepartments();

    Department getDepartmentById(Long id);

    void save(Department department);

    void update(Department department);

    void delete(Long id);
}

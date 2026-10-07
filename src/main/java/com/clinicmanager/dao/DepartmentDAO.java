package com.clinicmanager.dao;

import com.clinicmanager.model.Department;
import com.clinicmanager.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

public class DepartmentDAO {

    public List<Department> getAllDepartments() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT d FROM Department d ORDER BY d.id DESC", Department.class).getResultList();
        } finally {
            em.close();
        }
    }

    public Department getDepartmentById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Department.class, id);
        } finally {
            em.close();
        }
    }

    public void save(Department department) throws Exception {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(department);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new Exception("Could not save department. It might already exist.", e);
        } finally {
            em.close();
        }
    }

    public void update(Department department) throws Exception {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(department);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new Exception("Could not update department.", e);
        } finally {
            em.close();
        }
    }

    public void delete(Long id) throws Exception {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Department dept = em.find(Department.class, id);
            if (dept != null) {
                if(dept.getDoctors() != null && !dept.getDoctors().isEmpty()) {
                    throw new Exception("Cannot delete department because doctors are currently assigned to it.");
                }
                em.remove(dept);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new Exception(e.getMessage(), e);
        } finally {
            em.close();
        }
    }
}
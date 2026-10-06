package com.clinicmanager.dao;

import com.clinicmanager.model.Department;
import com.clinicmanager.model.Doctor;
import com.clinicmanager.model.Specialty;
import com.clinicmanager.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

public class DoctorDAO {

    public List<Doctor> getAllDoctors() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT d FROM Doctor d ORDER BY d.id DESC", Doctor.class).getResultList();
        } finally {
            em.close();
        }
    }
    public void save(Doctor doctor) throws Exception {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.persist(doctor);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw new Exception("Could not save doctor. The Email or Matricule might already exist.", e);
        } finally {
            em.close();
        }
    }

    public List<Department> getAllDepartments() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT d FROM Department d", Department.class).getResultList();
        } finally {
            em.close();
        }
    }

    public List<Specialty> getAllSpecialties() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT s FROM Specialty s", Specialty.class).getResultList();
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

    public Specialty getSpecialtyById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Specialty.class, id);
        } finally {
            em.close();
        }
    }
    public Doctor getDoctorById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Doctor.class, id);
        } finally {
            em.close();
        }
    }

    public void update(Doctor doctor) throws Exception {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(doctor); // merge() is used to update existing entities
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw new Exception("Could not update doctor details. The Matricule or Email might conflict with another user.", e);
        } finally {
            em.close();
        }
    }

    public void delete(Long id) throws Exception {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Doctor doctor = em.find(Doctor.class, id);
            if (doctor != null) {
                em.remove(doctor);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw new Exception("Could not delete this doctor. They may be linked to existing appointments or records.", e);
        } finally {
            em.close();
        }
    }
}
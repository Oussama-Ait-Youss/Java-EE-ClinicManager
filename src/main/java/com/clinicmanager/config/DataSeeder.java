package com.clinicmanager.config;

import com.clinicmanager.model.*;
import com.clinicmanager.model.enums.BloodGroup;
import com.clinicmanager.model.enums.Gender;
import com.clinicmanager.util.JPAUtil;
import com.clinicmanager.util.PasswordUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.time.LocalDate;
import java.util.Optional;

public class DataSeeder {

    public static void main(String[] args) {
        System.out.println("⏳ Starting Database Initialization...");
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            // 1. Check if data already exists to avoid duplicate constraint errors
            Long userCount = em.createQuery("SELECT COUNT(u) FROM User u", Long.class).getSingleResult();
            if (userCount > 0) {
                System.out.println(" Database is already populated. Seeder aborted.");
                return;
            }

            String defaultPassword = PasswordUtil.hashPassword(Optional.of("admin123"));

            // 2. Create Organizational Entities First (Dependencies for Doctor)
            Department cardiology = new Department("Cardiology", "Heart and cardiovascular system");
            em.persist(cardiology);

            Specialty surgery = new Specialty("Cardiothoracic Surgery");
            em.persist(surgery);

            // 3. Create Admin
            Admin admin = new Admin();
            admin.setFirst_name("Super");
            admin.setLast_name("Admin");
            admin.setEmail("admin@clinic.com");
            admin.setPhone("0600000001");
            admin.setGender(Gender.MALE);
            admin.setPassword(defaultPassword);
            admin.setActive(true);
            em.persist(admin);

            // 4. Create Doctor (Linked to Department and Specialty)
            Doctor doctor = new Doctor();
            doctor.setMatricule("DOC-001");
            doctor.setTitle("Pr.");
            doctor.setFirst_name("John");
            doctor.setLast_name("Doe");
            doctor.setEmail("doctor@clinic.com");
            doctor.setPhone("0600000002");
            doctor.setGender(Gender.MALE);
            doctor.setPassword(defaultPassword);
            doctor.setActive(true);
            doctor.setDepartment(cardiology);
            doctor.setSpecialty(surgery);
            em.persist(doctor);

            // 5. Create Staff
            Staff staff = new Staff();
            staff.setFirst_name("Jane");
            staff.setLast_name("Smith");
            staff.setEmail("staff@clinic.com");
            staff.setPhone("0600000003");
            staff.setGender(Gender.FEMALE);
            staff.setPassword(defaultPassword);
            staff.setActive(true);
            em.persist(staff);

            // 6. Create Patient
            Patient patient = new Patient();
            patient.setCin("EE123456");
            patient.setBirthDate(LocalDate.of(1990, 5, 15));
            patient.setBloodGroup(BloodGroup.O_PLUS);
            patient.setFirst_name("Karim");
            patient.setLast_name("Alami");
            patient.setEmail("patient@clinic.com");
            patient.setPhone("0600000004");
            patient.setGender(Gender.MALE);
            patient.setPassword(defaultPassword);
            patient.setActive(true);
            em.persist(patient);

            tx.commit();
            System.out.println(" Database seeded successfully!");
            System.out.println(" Use email: admin@clinic.com | Password: admin123");

        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            System.err.println(" Seeding failed:");
            e.printStackTrace();
        } finally {
            em.close();
            // Shut down the EntityManagerFactory to cleanly exit the Java process
            JPAUtil.shutdown();
        }
    }
}
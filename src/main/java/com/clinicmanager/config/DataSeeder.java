package com.clinicmanager.config;

import com.clinicmanager.model.*;
import com.clinicmanager.model.enums.BloodGroup;
import com.clinicmanager.model.enums.Gender;
import com.clinicmanager.model.enums.AvailabilityStatus;
import com.clinicmanager.util.JPAUtil;
import com.clinicmanager.util.PasswordUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

public class DataSeeder {

    public static void main(String[] args) {
        System.out.println("⏳ Starting Database Initialization...");
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            // 1. Count existing records
            Long userCount = em.createQuery("SELECT COUNT(u) FROM User u", Long.class).getSingleResult();
            Long availabilityCount = em.createQuery("SELECT COUNT(a) FROM Availability a", Long.class).getSingleResult();

            // 2. Only seed base users if the database is completely empty
            if (userCount == 0) {
                System.out.println(" Running Full Database Seed...");
                String defaultPassword = PasswordUtil.hashPassword(Optional.of("admin123"));

                Department cardiology = new Department("Cardiology", "Heart and cardiovascular system");
                em.persist(cardiology);

                Specialty surgery = new Specialty("Cardiothoracic Surgery");
                em.persist(surgery);

                Admin admin = new Admin();
                admin.setFirst_name("Super");
                admin.setLast_name("Admin");
                admin.setEmail("admin@clinic.com");
                admin.setPhone("0600000001");
                admin.setGender(Gender.MALE);
                admin.setPassword(defaultPassword);
                admin.setActive(true);
                em.persist(admin);

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

                Staff staff = new Staff();
                staff.setFirst_name("Jane");
                staff.setLast_name("Smith");
                staff.setEmail("staff@clinic.com");
                staff.setPhone("0600000003");
                staff.setGender(Gender.FEMALE);
                staff.setPassword(defaultPassword);
                staff.setActive(true);
                em.persist(staff);

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
            } else {
                System.out.println(" Users already exist. Skipping user creation.");
            }

            // 3. SMART CHECK: If no availabilities exist, create them for the first available doctor
            if (availabilityCount == 0) {
                System.out.println(" No availabilities found. Seeding default shifts...");

                // Fetch a doctor from the database to assign the shifts to
                List<Doctor> doctors = em.createQuery("SELECT d FROM Doctor d", Doctor.class).setMaxResults(1).getResultList();

                if (!doctors.isEmpty()) {
                    Doctor targetDoctor = doctors.get(0);

                    for (DayOfWeek day : DayOfWeek.values()) {
                        if (day != DayOfWeek.SATURDAY && day != DayOfWeek.SUNDAY) {
                            Availability shift = new Availability();
                            shift.setDoctor(targetDoctor);
                            shift.setDayOfWeek(day);
                            shift.setStartTime(LocalTime.of(8, 0));  // 08:00 AM
                            shift.setEndTime(LocalTime.of(18, 0));   // 06:00 PM
                            shift.setValidityStart(LocalDate.of(2026, 1, 1));
                            shift.setValidityEnd(LocalDate.of(2030, 12, 31));
                            shift.setStatus(AvailabilityStatus.AVAILABLE);
                            em.persist(shift);
                        }
                    }
                    System.out.println(" Added standard Mon-Fri shifts for Doctor: " + targetDoctor.getFirst_name() + " " + targetDoctor.getLast_name());
                } else {
                    System.out.println(" Could not create shifts: No doctors found in the database!");
                }
            } else {
                System.out.println(" Availabilities already exist. Skipping shift creation.");
            }

            tx.commit();
            System.out.println(" Database verification and seeding completed successfully!");

        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            System.err.println(" Seeding failed:");
            e.printStackTrace();
        } finally {
            em.close();
            JPAUtil.shutdown();
        }
    }
}
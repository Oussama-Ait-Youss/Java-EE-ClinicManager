package com.clinicmanager.service;

import com.clinicmanager.exception.ServiceException;
import com.clinicmanager.model.Availability;
import com.clinicmanager.model.Doctor;
import com.clinicmanager.model.enums.AvailabilityStatus;
import com.clinicmanager.repository.AvailabilityRepository;
import com.clinicmanager.repository.impl.AvailabilityRepositoryImpl;
import com.clinicmanager.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.function.Function;

public class AvailabilityService {
    public List<Availability> findAll() {
        return inTransaction("Could not load doctor availabilities.",
                repository -> repository.findAll());
    }

    public Availability findById(Long id) {
        return inTransaction("Could not load availability details.",
                repository -> repository.findById(id));
    }

    public List<Availability> findByDoctorId(Long doctorId) {
        return inTransaction("Could not load availabilities for this doctor.",
                repository -> repository.findByDoctorId(doctorId));
    }

    public void save(Availability availability) {
        inTransaction("Could not create doctor availability.", repository -> {
            validate(availability);
            repository.save(availability);
            return null;
        });
    }

    public void createBatchAvailabilities(Long doctorId, String[] daysOfWeek, LocalTime startTime,
                                          LocalTime endTime, LocalDate validityStart, LocalDate validityEnd,
                                          AvailabilityStatus status) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            if (doctorId == null || daysOfWeek == null || daysOfWeek.length == 0
                    || startTime == null || endTime == null || validityStart == null
                    || validityEnd == null || status == null) {
                throw new ServiceException("All availability fields are required, and at least one day must be selected.");
            }
            if (!endTime.isAfter(startTime)) {
                throw new ServiceException("End time must be later than start time.");
            }
            if (validityEnd.isBefore(validityStart)) {
                throw new ServiceException("Validity end date must not be before the start date.");
            }

            Set<String> uniqueDays = new HashSet<>();
            for (String day : daysOfWeek) {
                if (day == null || !uniqueDays.add(day)) {
                    throw new ServiceException("Selected days must be valid and unique.");
                }
                DayOfWeek.valueOf(day);
            }

            Doctor doctor = em.getReference(Doctor.class, doctorId);
            for (String selectedDay : daysOfWeek) {
                Availability availability = new Availability();
                availability.setDoctor(doctor);
                availability.setDayOfWeek(DayOfWeek.valueOf(selectedDay));
                availability.setStartTime(startTime);
                availability.setEndTime(endTime);
                availability.setValidityStart(validityStart);
                availability.setValidityEnd(validityEnd);
                availability.setStatus(status);
                em.persist(availability);
            }
            tx.commit();
        } catch (ServiceException e) {
            rollback(tx, e);
            throw e;
        } catch (RuntimeException e) {
            rollback(tx, e);
            throw new ServiceException("Could not create doctor availabilities.", e);
        } finally {
            em.close();
        }
    }

    public void update(Availability availability) {
        inTransaction("Could not update doctor availability.", repository -> {
            validate(availability);
            if (repository.findById(availability.getId()) == null) {
                throw new ServiceException("Availability not found.");
            }
            repository.update(availability);
            return null;
        });
    }

    public void delete(Long id) {
        inTransaction("Could not delete doctor availability.", repository -> {
            if (repository.findById(id) == null) {
                throw new ServiceException("Availability not found.");
            }
            repository.delete(id);
            return null;
        });
    }

    private void validate(Availability availability) {
        if (availability == null
                || availability.getDoctor() == null
                || availability.getDayOfWeek() == null
                || availability.getStartTime() == null
                || availability.getEndTime() == null
                || availability.getStatus() == null
                || availability.getValidityStart() == null
                || availability.getValidityEnd() == null) {
            throw new ServiceException("All availability fields are required.");
        }
        if (!availability.getEndTime().isAfter(availability.getStartTime())) {
            throw new ServiceException("End time must be later than start time.");
        }
        if (availability.getValidityEnd().isBefore(availability.getValidityStart())) {
            throw new ServiceException("Validity end date must not be before the start date.");
        }
    }

    private <T> T inTransaction(String errorMessage, Function<AvailabilityRepository, T> operation) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            T result = operation.apply(new AvailabilityRepositoryImpl(em));
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

package com.clinicmanager.service;

import com.clinicmanager.exception.ServiceException;
import com.clinicmanager.model.Patient;
import com.clinicmanager.repository.PatientRepository;
import com.clinicmanager.repository.impl.PatientRepositoryImpl;
import com.clinicmanager.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;
import java.util.function.Function;

public class PatientService {
    public List<Patient> getAllPatients() {
        return inTransaction("Could not load patients.",
                em -> new PatientRepositoryImpl(em).getAllPatients());
    }

    public Patient getPatientById(Long id) {
        return inTransaction("Could not load patient details.",
                em -> new PatientRepositoryImpl(em).getPatientById(id));
    }

    public void save(Patient patient) {
        inTransaction("Could not save patient. The email might already be in use.", em -> {
            PatientRepository repository = new PatientRepositoryImpl(em);
            repository.save(patient);
            return null;
        });
    }

    public void update(Patient patient) {
        inTransaction("Could not update patient details.", em -> {
            PatientRepository repository = new PatientRepositoryImpl(em);
            repository.update(patient);
            return null;
        });
    }

    public void delete(Long id) {
        inTransaction("Could not delete patient.", em -> {
            PatientRepository repository = new PatientRepositoryImpl(em);
            Patient patient = repository.getPatientById(id);
            if (patient != null && patient.getAppointments() != null && !patient.getAppointments().isEmpty()) {
                throw new ServiceException("Cannot delete this patient because they have existing appointments.");
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

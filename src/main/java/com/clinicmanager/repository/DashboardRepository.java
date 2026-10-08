package com.clinicmanager.repository;

public interface DashboardRepository {
    Long getTotalDoctors();

    Long getTotalPatients();

    Long getTotalStaff();

    Long getTodayAppointments();
}

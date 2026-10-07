package com.clinicmanager.controller.appointment;

import com.clinicmanager.dao.AppointmentDAO;
import com.clinicmanager.dao.DoctorDAO;
import com.clinicmanager.dao.PatientDAO;
import com.clinicmanager.model.Appointment;
import com.clinicmanager.model.enums.AppointmentStatus;
import com.clinicmanager.model.enums.AppointmentType; // ADDED IMPORT
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@WebServlet(name = "AddAppointmentServlet", urlPatterns = "/admin/appointments/add")
public class AddAppointmentServlet extends HttpServlet {
    private final AppointmentDAO appointmentDAO = new AppointmentDAO();
    private final DoctorDAO doctorDAO = new DoctorDAO();
    private final PatientDAO patientDAO = new PatientDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("doctors", doctorDAO.getAllDoctors());
        request.setAttribute("patients", patientDAO.getAllPatients());
        request.getRequestDispatcher("/WEB-INF/views/admin/appointments/add-appointment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Appointment appt = new Appointment();
            appt.setPatient(patientDAO.getPatientById(Long.parseLong(request.getParameter("patient_id"))));
            appt.setDoctor(doctorDAO.getDoctorById(Long.parseLong(request.getParameter("doctor_id"))));

            // Combine HTML Date and Time inputs into your model's LocalDateTime
            LocalDate date = LocalDate.parse(request.getParameter("appointment_date"));
            LocalTime time = LocalTime.parse(request.getParameter("appointment_time"));
            appt.setAppointmentDateTime(LocalDateTime.of(date, time));

            // Parse Enums for Status AND Type
            appt.setStatus(AppointmentStatus.valueOf(request.getParameter("status").toUpperCase()));
            appt.setType(AppointmentType.valueOf(request.getParameter("type").toUpperCase())); // ADDED TYPE PARSING

            // Map 'notes' to 'motif'
            appt.setMotif(request.getParameter("notes"));

            appointmentDAO.save(appt);
            request.getSession().setAttribute("successMessage", "Appointment scheduled successfully.");
            response.sendRedirect(request.getContextPath() + "/admin/appointments");
        } catch (Exception e) {
            request.setAttribute("errorMessage", e.getMessage());
            doGet(request, response);
        }
    }
}
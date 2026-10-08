package com.clinicmanager.controller.appointment;

import com.clinicmanager.service.AppointmentService;
import com.clinicmanager.service.DoctorService;
import com.clinicmanager.service.PatientService;
import com.clinicmanager.model.Appointment;
import com.clinicmanager.model.enums.AppointmentStatus;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@WebServlet(name = "EditAppointmentServlet", urlPatterns = "/admin/appointments/edit")
public class EditAppointmentServlet extends HttpServlet {
    private final AppointmentService appointmentService = new AppointmentService();
    private final DoctorService doctorService = new DoctorService();
    private final PatientService patientService = new PatientService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Appointment appt = appointmentService.getAppointmentById(id);
            if (appt == null) throw new Exception("Appointment not found.");

            request.setAttribute("appointment", appt);
            request.setAttribute("doctors", doctorService.getAllDoctors());
            request.setAttribute("patients", patientService.getAllPatients());
            request.getRequestDispatcher("/WEB-INF/views/admin/appointments/edit-appointment.jsp").forward(request, response);
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Unable to load appointment for editing.");
            response.sendRedirect(request.getContextPath() + "/admin/appointments");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Appointment appt = appointmentService.getAppointmentById(id);

            appt.setPatient(patientService.getPatientById(Long.parseLong(request.getParameter("patient_id"))));
            appt.setDoctor(doctorService.getDoctorById(Long.parseLong(request.getParameter("doctor_id"))));

            // Combine HTML Date and Time inputs into your model's LocalDateTime
            LocalDate date = LocalDate.parse(request.getParameter("appointment_date"));
            LocalTime time = LocalTime.parse(request.getParameter("appointment_time"));
            appt.setAppointmentDateTime(LocalDateTime.of(date, time));

            // Parse Enum and map 'notes' to 'motif'
            appt.setStatus(AppointmentStatus.valueOf(request.getParameter("status").toUpperCase()));
            appt.setMotif(request.getParameter("notes"));

            appointmentService.update(appt);
            request.getSession().setAttribute("successMessage", "Appointment updated successfully.");
            response.sendRedirect(request.getContextPath() + "/admin/appointments");
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/appointments/edit?id=" + request.getParameter("id"));
        }
    }
}
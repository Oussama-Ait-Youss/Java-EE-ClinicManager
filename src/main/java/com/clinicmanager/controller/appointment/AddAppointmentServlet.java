package com.clinicmanager.controller.appointment;

import com.clinicmanager.service.AppointmentService;
import com.clinicmanager.service.DoctorService;
import com.clinicmanager.service.PatientService;
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
    private final AppointmentService appointmentService = new AppointmentService();
    private final DoctorService doctorService = new DoctorService();
    private final PatientService patientService = new PatientService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("doctors", doctorService.getAllDoctors());
        request.setAttribute("patients", patientService.getAllPatients());
        request.getRequestDispatcher("/WEB-INF/views/admin/appointments/add-appointment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long doctorId = Long.parseLong(request.getParameter("doctor_id"));
            LocalDate date = LocalDate.parse(request.getParameter("appointment_date"));
            LocalTime time = LocalTime.parse(request.getParameter("appointment_time"));
            LocalDateTime dateTime = LocalDateTime.of(date, time);

            Appointment appt = new Appointment();
            appt.setPatient(patientService.getPatientById(Long.parseLong(request.getParameter("patient_id"))));
            appt.setDoctor(doctorService.getDoctorById(doctorId));
            appt.setAppointmentDateTime(dateTime);
            appt.setStatus(AppointmentStatus.valueOf(request.getParameter("status").toUpperCase()));
            appt.setType(AppointmentType.valueOf(request.getParameter("type").toUpperCase()));
            appt.setMotif(request.getParameter("notes"));

            appointmentService.scheduleAppointment(appt);

            request.getSession().setAttribute("successMessage", "Appointment scheduled successfully.");
            response.sendRedirect(request.getContextPath() + "/admin/appointments");

        } catch (Exception e) {
            // Unpack DB exceptions if it bypasses our logic
            Throwable rootCause = e;
            while (rootCause.getCause() != null && rootCause != rootCause.getCause()) {
                rootCause = rootCause.getCause();
            }

            request.setAttribute("errorMessage", rootCause.getMessage());
            doGet(request, response);
        }
    }
}
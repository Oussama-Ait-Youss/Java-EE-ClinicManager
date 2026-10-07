package com.clinicmanager.controller.appointment;

import com.clinicmanager.dao.AppointmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AppointmentManagementServlet", urlPatterns = "/admin/appointments")
public class AppointmentManagementServlet extends HttpServlet {
    private final AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String patientIdParam = request.getParameter("patientId");

        // If the eye icon was clicked, patientId will be in the URL. We filter the list.
        if (patientIdParam != null && !patientIdParam.isEmpty()) {
            Long patientId = Long.parseLong(patientIdParam);
            request.setAttribute("appointments", appointmentDAO.getAppointmentsByPatientId(patientId));
            request.setAttribute("isFiltered", true);
        } else {
            // Otherwise, show all appointments
            request.setAttribute("appointments", appointmentDAO.getAllAppointments());
            request.setAttribute("isFiltered", false);
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/appointments/appointments.jsp").forward(request, response);
    }
}
package com.clinicmanager.controller.availability;

import com.clinicmanager.model.enums.AvailabilityStatus;
import com.clinicmanager.service.AvailabilityService;
import com.clinicmanager.service.DoctorService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Arrays;

@WebServlet(name = "AddAvailabilityServlet", urlPatterns = "/admin/availabilities/add")
public class AddAvailabilityServlet extends HttpServlet {
    private final AvailabilityService availabilityService = new AvailabilityService();
    private final DoctorService doctorService = new DoctorService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        showForm(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String[] selectedDays = request.getParameterValues("daysOfWeek");
            if (selectedDays == null || selectedDays.length == 0) {
                throw new IllegalArgumentException("Select at least one day of the week.");
            }

            Long doctorId = Long.parseLong(request.getParameter("doctorId"));
            LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
            LocalTime endTime = LocalTime.parse(request.getParameter("endTime"));
            LocalDate validityStart = LocalDate.parse(request.getParameter("validityStart"));
            LocalDate validityEnd = LocalDate.parse(request.getParameter("validityEnd"));
            AvailabilityStatus status = AvailabilityStatus.valueOf(request.getParameter("status"));

            availabilityService.createBatchAvailabilities(
                    doctorId, selectedDays, startTime, endTime, validityStart, validityEnd, status);
            request.getSession().setAttribute("successMessage", "Doctor availabilities created successfully.");
            response.sendRedirect(request.getContextPath() + "/admin/availabilities");
        } catch (RuntimeException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.setAttribute("selectedDays", Arrays.asList(
                    request.getParameterValues("daysOfWeek") == null
                            ? new String[0]
                            : request.getParameterValues("daysOfWeek")));
            showForm(request, response);
        }
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("doctors", doctorService.getAllDoctors());
        request.setAttribute("daysOfWeek", DayOfWeek.values());
        request.setAttribute("availabilityStatuses", AvailabilityStatus.values());
        request.getRequestDispatcher("/WEB-INF/views/admin/availabilities/add-availability.jsp")
                .forward(request, response);
    }
}

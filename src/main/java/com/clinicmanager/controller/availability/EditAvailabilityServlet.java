package com.clinicmanager.controller.availability;

import com.clinicmanager.model.Availability;
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

@WebServlet(name = "EditAvailabilityServlet", urlPatterns = "/admin/availabilities/edit")
public class EditAvailabilityServlet extends HttpServlet {
    private final AvailabilityService availabilityService = new AvailabilityService();
    private final DoctorService doctorService = new DoctorService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Availability availability = availabilityService.findById(id);
            if (availability == null) {
                request.getSession().setAttribute("errorMessage", "Availability not found.");
                response.sendRedirect(request.getContextPath() + "/admin/availabilities");
                return;
            }
            showForm(request, response, availability);
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid availability ID.");
            response.sendRedirect(request.getContextPath() + "/admin/availabilities");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Availability availability = new Availability();
        try {
            availability.setId(Long.parseLong(request.getParameter("id")));
            availability.setDoctor(doctorService.getDoctorById(Long.parseLong(request.getParameter("doctorId"))));
            availability.setDayOfWeek(DayOfWeek.valueOf(request.getParameter("dayOfWeek")));
            availability.setStartTime(LocalTime.parse(request.getParameter("startTime")));
            availability.setEndTime(LocalTime.parse(request.getParameter("endTime")));
            availability.setValidityStart(LocalDate.parse(request.getParameter("validityStart")));
            availability.setValidityEnd(LocalDate.parse(request.getParameter("validityEnd")));
            availability.setStatus(AvailabilityStatus.valueOf(request.getParameter("status")));

            availabilityService.update(availability);
            request.getSession().setAttribute("successMessage", "Doctor availability updated successfully.");
            response.sendRedirect(request.getContextPath() + "/admin/availabilities");
        } catch (RuntimeException e) {
            request.setAttribute("errorMessage", e.getMessage());
            showForm(request, response, availability);
        }
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response, Availability availability)
            throws ServletException, IOException {
        request.setAttribute("availability", availability);
        request.setAttribute("doctors", doctorService.getAllDoctors());
        request.setAttribute("daysOfWeek", DayOfWeek.values());
        request.setAttribute("availabilityStatuses", AvailabilityStatus.values());
        request.getRequestDispatcher("/WEB-INF/views/admin/availabilities/edit-availability.jsp")
                .forward(request, response);
    }
}

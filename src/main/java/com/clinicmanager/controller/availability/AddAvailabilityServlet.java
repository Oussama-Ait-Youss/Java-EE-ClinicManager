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

@WebServlet(name = "AddAvailabilityServlet", urlPatterns = "/admin/availabilities/add")
public class AddAvailabilityServlet extends HttpServlet {
    private final AvailabilityService availabilityService = new AvailabilityService();
    private final DoctorService doctorService = new DoctorService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        showForm(request, response, new Availability());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Availability availability = new Availability();
        try {
            availability.setDoctor(doctorService.getDoctorById(Long.parseLong(request.getParameter("doctorId"))));
            availability.setDayOfWeek(DayOfWeek.valueOf(request.getParameter("dayOfWeek")));
            availability.setStartTime(LocalTime.parse(request.getParameter("startTime")));
            availability.setEndTime(LocalTime.parse(request.getParameter("endTime")));
            availability.setValidityStart(LocalDate.parse(request.getParameter("validityStart")));
            availability.setValidityEnd(LocalDate.parse(request.getParameter("validityEnd")));
            availability.setStatus(AvailabilityStatus.valueOf(request.getParameter("status")));

            availabilityService.save(availability);
            request.getSession().setAttribute("successMessage", "Doctor availability created successfully.");
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
        request.getRequestDispatcher("/WEB-INF/views/admin/availabilities/add-availability.jsp")
                .forward(request, response);
    }
}

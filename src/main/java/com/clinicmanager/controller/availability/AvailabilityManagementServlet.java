package com.clinicmanager.controller.availability;

import com.clinicmanager.service.AvailabilityService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "AvailabilityManagementServlet", urlPatterns = "/admin/availabilities")
public class AvailabilityManagementServlet extends HttpServlet {
    private final AvailabilityService availabilityService = new AvailabilityService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("availabilities", availabilityService.findAll());
        request.getRequestDispatcher("/WEB-INF/views/admin/availabilities/availabilities.jsp")
                .forward(request, response);
    }
}

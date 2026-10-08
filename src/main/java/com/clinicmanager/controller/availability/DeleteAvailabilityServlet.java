package com.clinicmanager.controller.availability;

import com.clinicmanager.service.AvailabilityService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "DeleteAvailabilityServlet", urlPatterns = "/admin/availabilities/delete")
public class DeleteAvailabilityServlet extends HttpServlet {
    private final AvailabilityService availabilityService = new AvailabilityService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            availabilityService.delete(Long.parseLong(request.getParameter("id")));
            request.getSession().setAttribute("successMessage", "Doctor availability deleted successfully.");
        } catch (RuntimeException e) {
            request.getSession().setAttribute("errorMessage", e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin/availabilities");
    }
}

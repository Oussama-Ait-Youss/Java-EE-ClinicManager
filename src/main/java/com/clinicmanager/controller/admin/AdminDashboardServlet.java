package com.clinicmanager.controller.admin;

import com.clinicmanager.dto.UserSessionDTO;
import com.clinicmanager.service.DashboardService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = "/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private final DashboardService dashboardService = new DashboardService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserSessionDTO currentUser = (UserSessionDTO) session.getAttribute("currentUser");
        if (!"ADMIN".equals(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }

        try {
            request.setAttribute("totalDoctors", dashboardService.getTotalDoctors());
            request.setAttribute("totalPatients", dashboardService.getTotalPatients());
            request.setAttribute("totalStaff", dashboardService.getTotalStaff());
            request.setAttribute("todayAppointments", dashboardService.getTodayAppointments());
        } catch (Exception e) {
            System.err.println("Error fetching dashboard statistics: " + e.getMessage());
            request.getSession().setAttribute("errorMessage", e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}
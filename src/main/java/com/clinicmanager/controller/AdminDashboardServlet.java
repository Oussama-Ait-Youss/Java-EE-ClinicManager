package com.clinicmanager.controller;

import com.clinicmanager.dao.DashboardDAO;
import com.clinicmanager.dto.UserSessionDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = "/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private DashboardDAO dashboardDAO = new DashboardDAO();
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
            request.setAttribute("totalDoctors", dashboardDAO.getTotalDoctors());
            request.setAttribute("totalPatients", dashboardDAO.getTotalPatients());
            request.setAttribute("totalStaff", dashboardDAO.getTotalStaff());
            request.setAttribute("todayAppointments", dashboardDAO.getTodayAppointments());
        } catch (Exception e) {
            System.err.println("Error fetching dashboard statistics: " + e.getMessage());
            // Fallback to 0 if the database query fails so the page doesn't crash
            request.setAttribute("totalDoctors", 0);
            request.setAttribute("totalPatients", 0);
            request.setAttribute("totalStaff", 0);
            request.setAttribute("todayAppointments", 0);
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}
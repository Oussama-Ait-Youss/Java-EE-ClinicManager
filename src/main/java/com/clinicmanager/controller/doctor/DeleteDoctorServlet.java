package com.clinicmanager.controller.doctor;

import java.io.IOException;

import com.clinicmanager.dto.UserSessionDTO;
import com.clinicmanager.service.DoctorService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "DeleteDoctorServlet", urlPatterns = "/admin/doctors/delete")
public class DeleteDoctorServlet extends HttpServlet {

    private final DoctorService doctorService = new DoctorService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
            Long id = Long.parseLong(request.getParameter("id"));
            doctorService.delete(id);
            session.setAttribute("successMessage", "Doctor successfully deleted.");
        } catch (Exception e) {
            session.setAttribute("errorMessage", e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/doctors");
    }
}
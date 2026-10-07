package com.clinicmanager.controller.doctor;

import java.io.IOException;

import com.clinicmanager.dao.DoctorDAO;
import com.clinicmanager.dto.UserSessionDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "DeleteDoctorServlet", urlPatterns = "/admin/doctors/delete")
public class DeleteDoctorServlet extends HttpServlet {

    private DoctorDAO doctorDAO = new DoctorDAO();

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
            doctorDAO.delete(id);
            session.setAttribute("successMessage", "Doctor successfully deleted.");
        } catch (Exception e) {
            session.setAttribute("errorMessage", e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/doctors");
    }
}
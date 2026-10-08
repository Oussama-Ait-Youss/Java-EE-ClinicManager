package com.clinicmanager.controller.doctor;

import java.io.IOException;
import java.util.List;

import com.clinicmanager.dto.UserSessionDTO;
import com.clinicmanager.model.Doctor;
import com.clinicmanager.service.DoctorService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "DoctorManagementServlet", urlPatterns = "/admin/doctors")
public class DoctorManagementServlet extends HttpServlet {

    private final DoctorService doctorService = new DoctorService();

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

        List<Doctor> doctors = doctorService.getAllDoctors();
        request.setAttribute("doctors", doctors);

        request.getRequestDispatcher("/WEB-INF/views/admin/doctors/doctors.jsp").forward(request, response);
    }
}
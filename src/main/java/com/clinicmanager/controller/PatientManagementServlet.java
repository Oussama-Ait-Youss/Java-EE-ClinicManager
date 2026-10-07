package com.clinicmanager.controller;

import com.clinicmanager.dao.PatientDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "PatientManagementServlet", urlPatterns = "/admin/patients")
public class PatientManagementServlet extends HttpServlet {
    private final PatientDAO patientDAO = new PatientDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("patients", patientDAO.getAllPatients());
        request.getRequestDispatcher("/WEB-INF/views/admin/patients/patients.jsp").forward(request, response);
    }
}
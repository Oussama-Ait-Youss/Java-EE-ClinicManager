package com.clinicmanager.controller.patients;

import com.clinicmanager.dao.PatientDAO;
import com.clinicmanager.model.Patient;
import com.clinicmanager.model.enums.Gender;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "EditPatientServlet", urlPatterns = "/admin/patients/edit")
public class EditPatientServlet extends HttpServlet {
    private final PatientDAO patientDAO = new PatientDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Patient patient = patientDAO.getPatientById(id);
            if (patient == null) throw new Exception("Patient not found.");

            request.setAttribute("patient", patient);
            request.getRequestDispatcher("/WEB-INF/views/admin/patients/edit-patient.jsp").forward(request, response);
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Unable to load patient for editing.");
            response.sendRedirect(request.getContextPath() + "/admin/patients");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Patient patient = patientDAO.getPatientById(id);

            patient.setFirst_name(request.getParameter("first_name"));
            patient.setLast_name(request.getParameter("last_name"));
            patient.setEmail(request.getParameter("email"));
            patient.setPhone(request.getParameter("phone"));
            patient.setGender(Gender.valueOf(request.getParameter("gender").toUpperCase()));
            patient.setActive(Boolean.parseBoolean(request.getParameter("active")));

            String newPassword = request.getParameter("password");
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                patient.setPassword(newPassword); // Add PasswordUtil hashing here if needed
            }

            patientDAO.update(patient);
            request.getSession().setAttribute("successMessage", "Patient profile updated successfully.");
            response.sendRedirect(request.getContextPath() + "/admin/patients");
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/patients/edit?id=" + request.getParameter("id"));
        }
    }
}
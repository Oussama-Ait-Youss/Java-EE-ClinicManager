package com.clinicmanager.controller.patient;

import com.clinicmanager.dao.PatientDAO;
import com.clinicmanager.model.Patient;
import com.clinicmanager.model.enums.Gender;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AddPatientServlet", urlPatterns = "/admin/patients/add")
public class AddPatientServlet extends HttpServlet {
    private final PatientDAO patientDAO = new PatientDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/patients/add-patient.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Patient patient = new Patient();
            patient.setFirst_name(request.getParameter("first_name"));
            patient.setLast_name(request.getParameter("last_name"));
            patient.setEmail(request.getParameter("email"));
            patient.setPhone(request.getParameter("phone"));
            patient.setGender(Gender.valueOf(request.getParameter("gender").toUpperCase()));
            patient.setActive(true);

            // Note: Use your PasswordUtil here to hash if implemented in User/Patient model
            patient.setPassword(request.getParameter("password"));

            patientDAO.save(patient);
            request.getSession().setAttribute("successMessage", "Patient registered successfully.");
            response.sendRedirect(request.getContextPath() + "/admin/patients");
        } catch (Exception e) {
            request.setAttribute("errorMessage", e.getMessage());
            doGet(request, response);
        }
    }
}
package com.clinicmanager.controller.patient;

import com.clinicmanager.service.PatientService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DeletePatientServlet", urlPatterns = "/admin/patients/delete")
public class DeletePatientServlet extends HttpServlet {
    private final PatientService patientService = new PatientService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            patientService.delete(id);
            request.getSession().setAttribute("successMessage", "Patient deleted successfully.");
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin/patients");
    }
}
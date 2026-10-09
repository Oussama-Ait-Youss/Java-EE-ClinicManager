package com.clinicmanager.controller.medicalnote;

import com.clinicmanager.service.MedicalNoteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "MedicalNoteManagementServlet", urlPatterns = "/admin/medical-notes")
public class MedicalNoteManagementServlet extends HttpServlet {
    private final MedicalNoteService medicalNoteService = new MedicalNoteService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("medicalNotes", medicalNoteService.getAllNotes());
        request.getRequestDispatcher("/WEB-INF/views/admin/medical_notes/medical-notes.jsp")
                .forward(request, response);
    }
}

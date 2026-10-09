package com.clinicmanager.controller.medicalnote;

import com.clinicmanager.model.MedicalNote;
import com.clinicmanager.service.MedicalNoteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ViewMedicalNoteServlet", urlPatterns = "/admin/medical-notes/view")
public class ViewMedicalNoteServlet extends HttpServlet {
    private final MedicalNoteService medicalNoteService = new MedicalNoteService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            MedicalNote note = medicalNoteService.getNoteById(id);
            if (note == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Medical note not found.");
                return;
            }
            request.setAttribute("medicalNote", note);
            request.getRequestDispatcher("/WEB-INF/views/admin/medical_notes/view-note.jsp")
                    .forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "A valid medical note ID is required.");
        }
    }
}

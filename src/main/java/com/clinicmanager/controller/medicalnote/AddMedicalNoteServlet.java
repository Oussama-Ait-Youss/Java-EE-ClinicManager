package com.clinicmanager.controller.medicalnote;

import com.clinicmanager.exception.ServiceException;
import com.clinicmanager.model.Appointment;
import com.clinicmanager.model.MedicalNote;
import com.clinicmanager.model.enums.AppointmentStatus;
import com.clinicmanager.service.AppointmentService;
import com.clinicmanager.service.MedicalNoteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "AddMedicalNoteServlet", urlPatterns = "/admin/medical-notes/add")
public class AddMedicalNoteServlet extends HttpServlet {
    private final MedicalNoteService medicalNoteService = new MedicalNoteService();
    private final AppointmentService appointmentService = new AppointmentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadForm(request);
        request.getRequestDispatcher("/WEB-INF/views/admin/medical_notes/add-note.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("selectedAppointmentId", request.getParameter("appointmentId"));
        request.setAttribute("diagnostic", request.getParameter("diagnostic"));
        request.setAttribute("content", request.getParameter("content"));

        try {
            String appointmentIdValue = request.getParameter("appointmentId");
            Long appointmentId = Long.parseLong(appointmentIdValue);
            String diagnostic = request.getParameter("diagnostic");
            String content = request.getParameter("content");

            if (diagnostic == null || diagnostic.isBlank()) {
                throw new ServiceException("Enter a diagnostic before saving the note.");
            }
            if (content == null || content.isBlank()) {
                throw new ServiceException("Enter the medical note content before saving.");
            }

            MedicalNote note = new MedicalNote();
            note.setDiagnostic(diagnostic.trim());
            note.setContent(content.trim());
            medicalNoteService.saveNoteAndCompleteAppointment(note, appointmentId);

            request.getSession().setAttribute("successMessage",
                    "Medical note saved and appointment marked as completed.");
            response.sendRedirect(request.getContextPath() + "/admin/medical-notes");
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Select a valid appointment.");
            loadForm(request);
            request.getRequestDispatcher("/WEB-INF/views/admin/medical_notes/add-note.jsp")
                    .forward(request, response);
        } catch (ServiceException e) {
            request.setAttribute("errorMessage", e.getMessage());
            loadForm(request);
            request.getRequestDispatcher("/WEB-INF/views/admin/medical_notes/add-note.jsp")
                    .forward(request, response);
        }
    }

    private void loadForm(HttpServletRequest request) {
        List<Appointment> scheduledAppointments = appointmentService.getAllAppointments().stream()
                .filter(appointment -> appointment.getStatus() == AppointmentStatus.SCHEDULED)
                .collect(Collectors.toList());
        request.setAttribute("scheduledAppointments", scheduledAppointments);
    }
}

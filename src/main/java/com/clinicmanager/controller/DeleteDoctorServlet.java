package com.clinicmanager.controller;

import com.clinicmanager.dao.DoctorDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "DeleteDoctorServlet", urlPatterns = "/admin/doctors/delete")
public class DeleteDoctorServlet extends HttpServlet {

    private DoctorDAO doctorDAO = new DoctorDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            doctorDAO.delete(id);
            request.getSession().setAttribute("successMessage", "Doctor successfully deleted.");
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", e.getMessage());
        }

        // Redirect back to the list
        response.sendRedirect(request.getContextPath() + "/admin/doctors");
    }
}
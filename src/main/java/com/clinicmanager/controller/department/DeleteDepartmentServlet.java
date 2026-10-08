package com.clinicmanager.controller.department;

import com.clinicmanager.service.DepartmentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DeleteDepartmentServlet", urlPatterns = "/admin/departments/delete")
public class DeleteDepartmentServlet extends HttpServlet {
    private final DepartmentService departmentService = new DepartmentService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            departmentService.delete(id);
            request.getSession().setAttribute("successMessage", "Department deleted successfully.");
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin/departments");
    }
}
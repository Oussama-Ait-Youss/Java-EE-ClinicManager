package com.clinicmanager.controller.department;

import com.clinicmanager.service.DepartmentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DepartmentManagementServlet", urlPatterns = "/admin/departments")
public class DepartmentManagementServlet extends HttpServlet {
    private final DepartmentService departmentService = new DepartmentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("departments", departmentService.getAllDepartments());
        request.getRequestDispatcher("/WEB-INF/views/admin/departments/departments.jsp").forward(request, response);
    }
}
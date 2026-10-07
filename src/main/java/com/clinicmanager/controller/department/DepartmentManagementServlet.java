package com.clinicmanager.controller.department;

import com.clinicmanager.dao.DepartmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DepartmentManagementServlet", urlPatterns = "/admin/departments")
public class DepartmentManagementServlet extends HttpServlet {
    private final DepartmentDAO departmentDAO = new DepartmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("departments", departmentDAO.getAllDepartments());
        request.getRequestDispatcher("/WEB-INF/views/admin/departments/departments.jsp").forward(request, response);
    }
}
package com.clinicmanager.controller;

import com.clinicmanager.dao.DepartmentDAO;
import com.clinicmanager.model.Department;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AddDepartmentServlet", urlPatterns = "/admin/departments/add")
public class AddDepartmentServlet extends HttpServlet {
    private final DepartmentDAO departmentDAO = new DepartmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/departments/add-department.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Department dept = new Department();
            dept.setName(request.getParameter("name"));
            dept.setDescription(request.getParameter("description"));

            departmentDAO.save(dept);
            request.getSession().setAttribute("successMessage", "Department created successfully.");
            response.sendRedirect(request.getContextPath() + "/admin/departments");
        } catch (Exception e) {
            request.setAttribute("errorMessage", e.getMessage());
            doGet(request, response); // Stay on the form page to display the error
        }
    }
}
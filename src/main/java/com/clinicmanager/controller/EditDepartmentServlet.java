package com.clinicmanager.controller;

import com.clinicmanager.dao.DepartmentDAO;
import com.clinicmanager.model.Department;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "EditDepartmentServlet", urlPatterns = "/admin/departments/edit")
public class EditDepartmentServlet extends HttpServlet {
    private final DepartmentDAO departmentDAO = new DepartmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Department dept = departmentDAO.getDepartmentById(id);
            if (dept == null) throw new Exception("Department not found.");

            request.setAttribute("department", dept);
            request.getRequestDispatcher("/WEB-INF/views/admin/departments/edit-department.jsp").forward(request, response);
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Unable to load department for editing.");
            response.sendRedirect(request.getContextPath() + "/admin/departments");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Department dept = departmentDAO.getDepartmentById(id);
            dept.setName(request.getParameter("name"));
            dept.setDescription(request.getParameter("description"));

            departmentDAO.update(dept);
            request.getSession().setAttribute("successMessage", "Department updated successfully.");
            response.sendRedirect(request.getContextPath() + "/admin/departments");
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/departments/edit?id=" + request.getParameter("id"));
        }
    }
}
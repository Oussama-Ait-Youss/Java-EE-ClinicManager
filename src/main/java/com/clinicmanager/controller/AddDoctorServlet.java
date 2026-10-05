package com.clinicmanager.controller;

import com.clinicmanager.dao.DoctorDAO;
import com.clinicmanager.model.Department;
import com.clinicmanager.model.Doctor;
import com.clinicmanager.model.Specialty;
import com.clinicmanager.model.enums.Gender;
import com.clinicmanager.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet(name = "AddDoctorServlet", urlPatterns = "/admin/doctors/add")
public class AddDoctorServlet extends HttpServlet {

    private DoctorDAO doctorDAO = new DoctorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch the lists from the database
        List<Department> departments = doctorDAO.getAllDepartments();
        List<Specialty> specialties = doctorDAO.getAllSpecialties();

        // Attach them to the request
        request.setAttribute("departments", departments);
        request.setAttribute("specialties", specialties);

        request.getRequestDispatcher("/WEB-INF/views/admin/add-doctor.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Doctor doctor = new Doctor();

            doctor.setFirst_name(request.getParameter("first_name"));
            doctor.setLast_name(request.getParameter("last_name"));
            doctor.setEmail(request.getParameter("email"));
            doctor.setPhone(request.getParameter("phone"));
            doctor.setGender(Gender.valueOf(request.getParameter("gender").toUpperCase()));

            // 2. Doctor Specific Info
            doctor.setMatricule(request.getParameter("matricule"));
            doctor.setTitle(request.getParameter("title")); // e.g., Dr., Pr.

            // 3. Foreign Key Relationships
            Long deptId = Long.parseLong(request.getParameter("department_id"));
            Long specId = Long.parseLong(request.getParameter("specialty_id"));

            Department dept = doctorDAO.getDepartmentById(deptId);
            Specialty spec = doctorDAO.getSpecialtyById(specId);

            doctor.setDepartment(dept);
            doctor.setSpecialty(spec);

            // 4. Security
            String rawPassword = request.getParameter("password");
            doctor.setPassword(PasswordUtil.hashPassword(Optional.of(rawPassword)));
            doctor.setActive(true);

            // 5. Save and Redirect
            doctorDAO.save(doctor);
            request.getSession().setAttribute("successMessage", "Doctor " + doctor.getTitle() + " " + doctor.getLast_name() + " was successfully registered.");
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");

        } catch (Exception e) {
            request.setAttribute("errorMessage", e.getMessage());
            // If we fail, we must reload the dropdown data before returning to the form
            request.setAttribute("departments", doctorDAO.getAllDepartments());
            request.setAttribute("specialties", doctorDAO.getAllSpecialties());
            request.getRequestDispatcher("/WEB-INF/views/admin/add-doctor.jsp").forward(request, response);
        }
    }
}
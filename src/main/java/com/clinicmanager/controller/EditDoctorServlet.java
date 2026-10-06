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
import java.util.Optional;

@WebServlet(name = "EditDoctorServlet", urlPatterns = "/admin/doctors/edit")
public class EditDoctorServlet extends HttpServlet {

    private DoctorDAO doctorDAO = new DoctorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Doctor doctor = doctorDAO.getDoctorById(id);

            if (doctor == null) {
                request.getSession().setAttribute("errorMessage", "Doctor not found.");
                response.sendRedirect(request.getContextPath() + "/admin/doctors");
                return;
            }

            request.setAttribute("doctor", doctor);
            request.setAttribute("departments", doctorDAO.getAllDepartments());
            request.setAttribute("specialties", doctorDAO.getAllSpecialties());

            request.getRequestDispatcher("/WEB-INF/views/admin/edit-doctor.jsp").forward(request, response);

        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin/doctors");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));

        try {
            // Fetch the existing doctor to retain data we aren't changing (like the old password)
            Doctor doctor = doctorDAO.getDoctorById(id);

            doctor.setFirst_name(request.getParameter("first_name"));
            doctor.setLast_name(request.getParameter("last_name"));
            doctor.setEmail(request.getParameter("email"));
            doctor.setPhone(request.getParameter("phone"));
            doctor.setGender(Gender.valueOf(request.getParameter("gender").toUpperCase()));
            doctor.setMatricule(request.getParameter("matricule"));
            doctor.setTitle(request.getParameter("title"));
            doctor.setActive(Boolean.parseBoolean(request.getParameter("active")));

            Long deptId = Long.parseLong(request.getParameter("department_id"));
            Long specId = Long.parseLong(request.getParameter("specialty_id"));
            doctor.setDepartment(doctorDAO.getDepartmentById(deptId));
            doctor.setSpecialty(doctorDAO.getSpecialtyById(specId));

            // Only update the password if the user actually typed a new one
            String newPassword = request.getParameter("password");
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                doctor.setPassword(PasswordUtil.hashPassword(Optional.of(newPassword)));
            }

            doctorDAO.update(doctor);
            request.getSession().setAttribute("successMessage", "Doctor profile updated successfully.");
            response.sendRedirect(request.getContextPath() + "/admin/doctors");

        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/doctors/edit?id=" + id);
        }
    }
}
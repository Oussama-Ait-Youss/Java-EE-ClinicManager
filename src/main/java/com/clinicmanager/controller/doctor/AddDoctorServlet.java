package com.clinicmanager.controller.doctor;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import com.clinicmanager.dto.UserSessionDTO;
import com.clinicmanager.model.Department;
import com.clinicmanager.model.Doctor;
import com.clinicmanager.model.Specialty;
import com.clinicmanager.model.enums.Gender;
import com.clinicmanager.service.DoctorService;
import com.clinicmanager.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AddDoctorServlet", urlPatterns = "/admin/doctors/add")
public class AddDoctorServlet extends HttpServlet {

    private final DoctorService doctorService = new DoctorService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserSessionDTO currentUser = (UserSessionDTO) session.getAttribute("currentUser");
        if (!"ADMIN".equals(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }

        List<Department> departments = doctorService.getAllDepartments();
        List<Specialty> specialties = doctorService.getAllSpecialties();

        request.setAttribute("departments", departments);
        request.setAttribute("specialties", specialties);

        request.getRequestDispatcher("/WEB-INF/views/admin/doctors/add-doctor.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserSessionDTO currentUser = (UserSessionDTO) session.getAttribute("currentUser");
        if (!"ADMIN".equals(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }

        try {
            Doctor doctor = new Doctor();

            doctor.setFirst_name(request.getParameter("first_name"));
            doctor.setLast_name(request.getParameter("last_name"));
            doctor.setEmail(request.getParameter("email"));
            doctor.setPhone(request.getParameter("phone"));
            doctor.setGender(Gender.valueOf(request.getParameter("gender").toUpperCase()));

            doctor.setMatricule(request.getParameter("matricule"));
            doctor.setTitle(request.getParameter("title")); // e.g., Dr., Pr.


            Long deptId = Long.parseLong(request.getParameter("department_id"));
            Long specId = Long.parseLong(request.getParameter("specialty_id"));

            Department dept = doctorService.getDepartmentById(deptId);
            Specialty spec = doctorService.getSpecialtyById(specId);

            doctor.setDepartment(dept);
            doctor.setSpecialty(spec);

            String rawPassword = request.getParameter("password");
            doctor.setPassword(PasswordUtil.hashPassword(Optional.of(rawPassword)));
            doctor.setActive(true);

            doctorService.save(doctor);
            request.getSession().setAttribute("successMessage", "Doctor " + doctor.getTitle() + " " + doctor.getLast_name() + " was successfully registered.");
            response.sendRedirect(request.getContextPath() + "/admin/doctors");

        } catch (Exception e) {
            request.setAttribute("errorMessage", e.getMessage());

            request.setAttribute("departments", doctorService.getAllDepartments());
            request.setAttribute("specialties", doctorService.getAllSpecialties());
            request.getRequestDispatcher("/WEB-INF/views/admin/doctors/add-doctor.jsp").forward(request, response);
        }
    }
}
package com.clinicmanager.controller;

import com.clinicmanager.dto.LoginRequestDTO;
import com.clinicmanager.dto.UserSessionDTO;
import com.clinicmanager.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {

    private AuthService authService = new AuthService();

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        LoginRequestDTO dto = new LoginRequestDTO(email, password);

        try {
            UserSessionDTO sessionDTO = authService.login(dto);
            HttpSession session = request.getSession(true);

            session.setAttribute("currentUser", sessionDTO);

            String role = sessionDTO.getRole();
            switch (role) {
                case "ADMIN":
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    break;

                case "STAFF":
                    request.getRequestDispatcher("/WEB-INF/views/staff/dashboard.jsp").forward(request, response);
                    break;

                case "DOCTOR":
                    request.getRequestDispatcher("/WEB-INF/views/doctor/dashboard.jsp").forward(request, response);
                    break;

                case "PATIENT":
                    request.getRequestDispatcher("/WEB-INF/views/patient/dashboard.jsp").forward(request, response);
                    break;
            }

        } catch (Exception e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.setAttribute("enteredEmail", email); // Keeps the email in the input field
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
    }
}
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
    public void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        LoginRequestDTO dto = new LoginRequestDTO(email,password);

        try {
            UserSessionDTO sessionDTO = authService.login(dto);
            HttpSession session = request.getSession(true);
            session.setAttribute("currect_user",sessionDTO);



        }catch (Exception e){
            System.out.println(e.getMessage());
            request.getRequestDispatcher("/auth/login.jsp").forward(request,response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
    }
}
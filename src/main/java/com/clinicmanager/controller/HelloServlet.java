package com.clinicmanager.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;

// The @WebServlet annotation maps this class to an incoming URL path
@WebServlet(name = "HelloServlet", urlPatterns = {"/hello"})
public class HelloServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("-----------------------------------------");
        // 1. Process or prepare data
        String message = "Welcome to ClinicManager!";
        LocalDateTime now = LocalDateTime.now();

        // 2. Attach data to the request scope so the JSP can read it
        request.setAttribute("serverMessage", message);
        request.setAttribute("timestamp", now.toString());

        // 3. Forward the request internally to the private JSP view
        request.getRequestDispatcher("/WEB-INF/views/hello.jsp").forward(request, response);
    }
}
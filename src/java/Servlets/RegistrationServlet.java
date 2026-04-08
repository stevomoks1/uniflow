/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Models.MySQLUserDAO;
import Models.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RegistrationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        if (firstName != null) {
            firstName = firstName.trim();
        }
        if (lastName != null) {
            lastName = lastName.trim();
        }
        if (email != null) {
            email = email.trim();
        }
        if (role != null) {
            role = role.trim();
        }

        if (firstName == null || lastName == null || email == null || password == null || role == null
                || firstName.isEmpty() || lastName.isEmpty() || email.isEmpty() || password.isEmpty() || role.isEmpty()) {
            request.setAttribute("error", "Please complete all fields before submitting.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 8) {
            request.setAttribute("error", "Password must be at least 8 characters long.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        User user = new User(email, MySQLUserDAO.hashPassword(password), firstName, lastName, role);
        boolean created;
        try {
            created = MySQLUserDAO.save(user);
        } catch (RuntimeException ex) {
            request.setAttribute("error", "Unable to connect to MySQL. Please verify database settings and try again.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!created) {
            request.setAttribute("error", "An account with that email already exists.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/login?registered=true");
    }

    @Override
    public String getServletInfo() {
        return "Handles user registration and account creation.";
    }
}

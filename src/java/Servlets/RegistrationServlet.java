/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Models.MySQLUserDAO;
import Models.User;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RegistrationServlet extends HttpServlet {
    private static final Set<String> ALLOWED_ROLES = new HashSet<>(Arrays.asList(
            "Timetabling Admin",
            "COD",
            "Class Representative"
    ));

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("role") != null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
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

        firstName = firstName == null ? null : firstName.trim();
        lastName = lastName == null ? null : lastName.trim();
        email = email == null ? null : email.trim();
        role = role == null ? null : role.trim();

        if (firstName == null || lastName == null || email == null || password == null || role == null
                || firstName.isEmpty() || lastName.isEmpty() || email.isEmpty() || password.isEmpty() || role.isEmpty()) {
            request.setAttribute("error", "Please complete all fields before submitting.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!ALLOWED_ROLES.contains(role)) {
            request.setAttribute("error", "Please select a valid role.");
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
            request.setAttribute("error", "Unable to create account at this time. Please try again later.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!created) {
            request.setAttribute("error", "An account with that email already exists.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setAttribute("role", user.getRole());
        session.setAttribute("name", user.getFullName());
        session.setMaxInactiveInterval(30 * 60);

        response.sendRedirect(request.getContextPath() + "/dashboard");
    }

    @Override
    public String getServletInfo() {
        return "Handles user registration and account creation.";
    }
}

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
import javax.servlet.http.HttpSession;

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
        String rawRole = role;
        firstName = firstName == null ? null : firstName.trim();
        lastName = lastName == null ? null : lastName.trim();
        email = email == null ? null : email.trim();
        role = role == null ? null : role.trim();
        role = normalizeRole(role);

        if (firstName == null || lastName == null || email == null || password == null
                || firstName.isEmpty() || lastName.isEmpty() || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Please complete all fields before submitting.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 8) {
            request.setAttribute("error", "Password must be at least 8 characters long.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (isSystemAdminRole(rawRole)) {
            request.setAttribute("error", "Action is unauthourized.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (role == null) {
            request.setAttribute("error", "Invalid role selected. Choose Timetabling Admin, COD, or Class Representative.");
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

        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setAttribute("role", role);
        session.setAttribute("name", user.getFullName());
        session.setMaxInactiveInterval(30 * 60);

        response.sendRedirect(request.getContextPath() + "/login?registered=true");
    }

    @Override
    public String getServletInfo() {
        return "Handles user registration and account creation.";
    }

    private static String normalizeRole(String role) {
        if (role == null) {
            return null;
        }
        String normalized = role.trim().toLowerCase().replace("-", " ");
        switch (normalized) {
            case "system admin":
            case "admin":
                return null;
            case "timetabling admin":
            case "timetable admin":
            case "det":
                return "Timetabling Admin";
            case "cod":
                return "COD";
            case "class representative":
            case "class rep":
            case "classrep":
                return "Class Representative";
            default:
                return null;
        }
    }

    private static boolean isSystemAdminRole(String role) {
        if (role == null) {
            return false;
        }
        String normalized = role.trim().toLowerCase().replace("-", " ");
        return "system admin".equals(normalized) || "admin".equals(normalized);
    }
}



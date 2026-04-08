/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Models.MySQLUserDAO;
import Models.User;
import java.io.IOException;
<<<<<<< HEAD
=======
<<<<<<< HEAD
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
=======
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
<<<<<<< HEAD

public class RegistrationServlet extends HttpServlet {
=======
<<<<<<< HEAD
import javax.servlet.http.HttpSession;

public class RegistrationServlet extends HttpServlet {
    private static final Set<String> ALLOWED_ROLES = new HashSet<>(Arrays.asList(
            "Timetabling Admin",
            "COD",
            "Class Representative"
    ));
=======

public class RegistrationServlet extends HttpServlet {
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
<<<<<<< HEAD
=======
<<<<<<< HEAD
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("role") != null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
=======
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
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
<<<<<<< HEAD
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

=======

<<<<<<< HEAD
        firstName = firstName == null ? null : firstName.trim();
        lastName = lastName == null ? null : lastName.trim();
        email = email == null ? null : email.trim();
        role = role == null ? null : role.trim();

=======
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
        if (firstName == null || lastName == null || email == null || password == null || role == null
                || firstName.isEmpty() || lastName.isEmpty() || email.isEmpty() || password.isEmpty() || role.isEmpty()) {
            request.setAttribute("error", "Please complete all fields before submitting.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

<<<<<<< HEAD
=======
<<<<<<< HEAD
        if (!ALLOWED_ROLES.contains(role)) {
            request.setAttribute("error", "Please select a valid role.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

=======
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
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
<<<<<<< HEAD
            request.setAttribute("error", "Unable to connect to MySQL. Please verify database settings and try again.");
=======
            request.setAttribute("error", "Unable to create account at this time. Please try again later.");
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!created) {
            request.setAttribute("error", "An account with that email already exists.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

<<<<<<< HEAD
        response.sendRedirect(request.getContextPath() + "/login?registered=true");
=======
<<<<<<< HEAD
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setAttribute("role", user.getRole());
        session.setAttribute("name", user.getFullName());
        session.setMaxInactiveInterval(30 * 60);

        response.sendRedirect(request.getContextPath() + "/dashboard");
=======
        response.sendRedirect(request.getContextPath() + "/login?registered=true");
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
    }

    @Override
    public String getServletInfo() {
        return "Handles user registration and account creation.";
    }
}

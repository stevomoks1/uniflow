
package Servlets;

import Models.MySQLUserDAO;
import Models.User;
import java.io.IOException;
import javax.servlet.ServletException;
<<<<<<< HEAD
import javax.servlet.http.Cookie;
=======
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
<<<<<<< HEAD
=======
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
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
        if (email != null) {
            email = email.trim();
        }

        User user;
        try {
            user = MySQLUserDAO.authenticate(email, password);
        } catch (RuntimeException ex) {
            request.setAttribute("error", "Unable to connect to MySQL. Please verify database settings and try again.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
<<<<<<< HEAD
=======
=======

        User user = MySQLUserDAO.authenticate(email, password);
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
        if (user == null) {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("user", user);
<<<<<<< HEAD
        String canonicalRole = normalizeRole(user.getRole());
        session.setAttribute("role", canonicalRole);
        session.setAttribute("name", user.getFullName());
        session.setMaxInactiveInterval(30 * 60);

        Cookie lastUserCookie = new Cookie("uniflowLastUser", user.getFullName());
        lastUserCookie.setHttpOnly(true);
        lastUserCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
        lastUserCookie.setMaxAge(60 * 60 * 24 * 30);
        response.addCookie(lastUserCookie);

        Cookie lastRoleCookie = new Cookie("uniflowLastRole", canonicalRole);
        lastRoleCookie.setHttpOnly(true);
        lastRoleCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
        lastRoleCookie.setMaxAge(60 * 60 * 24 * 30);
        response.addCookie(lastRoleCookie);

=======
        session.setAttribute("role", user.getRole());
        session.setAttribute("name", user.getFullName());
        session.setMaxInactiveInterval(30 * 60);

>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }

    @Override
    public String getServletInfo() {
        return "Handles user login and session creation.";
    }
<<<<<<< HEAD

    private static String normalizeRole(String role) {
        if (role == null) {
            return "";
        }
        String normalized = role.trim().toLowerCase().replace("-", " ");
        switch (normalized) {
            case "system admin":
            case "admin":
                return "System Admin";
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
                return role.trim();
        }
    }
=======
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
}

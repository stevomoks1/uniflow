
package Servlets;

import Models.MySQLUserDAO;
import Models.User;
import java.io.IOException;
import javax.servlet.ServletException;
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
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("role") != null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
=======
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
<<<<<<< HEAD
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
=======

        User user = MySQLUserDAO.authenticate(email, password);
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
        if (user == null) {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
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
        return "Handles user login and session creation.";
    }
}

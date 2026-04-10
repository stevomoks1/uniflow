/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

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

public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
<<<<<<< HEAD
        Cookie roleCookie = new Cookie("uniflowLastRole", "");
        roleCookie.setHttpOnly(true);
        roleCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
        roleCookie.setMaxAge(0);
        response.addCookie(roleCookie);
=======
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
        response.sendRedirect(request.getContextPath() + "/login?logout=true");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Handles logout and session invalidation.";
    }
}

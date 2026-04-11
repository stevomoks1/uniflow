/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class PageRouterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String role = normalizeRole((String) session.getAttribute("role"));
        String target;
        switch (role) {
            case "System Admin":
                target = "/admin/dashboard.jsp";
                break;
            case "Timetabling Admin":
                target = "/timetable/dashboard.jsp";
                break;
            case "COD":
                target = "/cod/dashboard.jsp";
                break;
            case "Class Representative":
                target = "/classrep/dashboard.jsp";
                break;
            default:
                target = "/login.jsp";
                break;
        }

        request.getRequestDispatcher(target).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Routes authenticated users to their role-specific dashboard.";
    }

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
}


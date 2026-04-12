package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RequestServlet extends HttpServlet {

    // Simulating a system queue that decreases and locks when it hits 0.
    private static int requestQueue = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setAttribute("queueCount", requestQueue);
        request.setAttribute("systemLocked", requestQueue <= 0);
        
        request.getRequestDispatcher("/courserequest.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (requestQueue > 0) {
            requestQueue--;
        }
        
        response.sendRedirect(request.getContextPath() + "/courserequest");
    }
}

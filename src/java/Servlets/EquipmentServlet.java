package Servlets;

import java.io.IOException;
import java.util.Base64;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EquipmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Mock distance check (e.g., 250m is within the 300m rule)
        int currentDistance = 250; 
        boolean isWithinRadius = currentDistance <= 300;
        
        request.setAttribute("currentDistance", currentDistance);
        request.setAttribute("isWithinRadius", isWithinRadius);
        
        // Mock QR Byte-streaming (Base64 placeholder string)
        String mockQrBytes = Base64.getEncoder().encodeToString("QR_EQUIPMENT_AUTH_TOKEN_748923".getBytes());
        request.setAttribute("qrByteStream", mockQrBytes);
        
        request.getRequestDispatcher("/equipment.jsp").forward(request, response);
    }
}

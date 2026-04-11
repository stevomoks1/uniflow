package Servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class VenueServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Mock data logic for Trip-based release logic (Green/Red)
        List<Map<String, Object>> venues = new ArrayList<>();
        
        venues.add(createVenue("Auditorium 1", 500, true)); // True = Green (Trip released/available)
        venues.add(createVenue("Science Lab B", 40, false)); // False = Red (Trip locked/in-use)
        venues.add(createVenue("Engineering Workshop", 60, true));
        venues.add(createVenue("Lecture Hall C", 150, false));
        venues.add(createVenue("Computer Lab 4", 30, true));
        
        request.setAttribute("venues", venues);
        request.getRequestDispatcher("/liveMap.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Toggle the simulated status in a real implementation
        response.sendRedirect(request.getContextPath() + "/liveMap");
    }

    private Map<String, Object> createVenue(String name, int capacity, boolean isReleased) {
        Map<String, Object> map = new HashMap<>();
        map.put("name", name);
        map.put("capacity", capacity);
        map.put("isReleased", isReleased);
        return map;
    }
}

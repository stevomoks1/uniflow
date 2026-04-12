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

public class TimetableServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Mock data to demonstrate the 110% buffer logic.
        List<Map<String, Object>> schedule = new ArrayList<>();
        
        schedule.add(createEntry("MATH101", "Calculus I", "Room A", 50, 45));
        schedule.add(createEntry("PHYS201", "Physics II", "Room B", 60, 68)); // 113% - should highlight
        schedule.add(createEntry("COMP301", "Data Structures", "Lab 1", 30, 35)); // 116% - should highlight
        schedule.add(createEntry("LIT102", "Literature", "Room C", 40, 40));
        
        request.setAttribute("schedule", schedule);
        request.getRequestDispatcher("/timetable.jsp").forward(request, response);
    }

    private Map<String, Object> createEntry(String code, String name, String venue, int capacity, int enrolled) {
        Map<String, Object> map = new HashMap<>();
        map.put("courseCode", code);
        map.put("courseName", name);
        map.put("venue", venue);
        map.put("capacity", capacity);
        map.put("enrolled", enrolled);
        map.put("fillPercentage", Math.round(((double)enrolled / capacity) * 100));
        return map;
    }
}

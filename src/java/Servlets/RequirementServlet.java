package Servlets;

import Models.MySQLRequirementDAO;
import Models.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RequirementServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = trim(request.getParameter("action"));
        if ("submitRequirement".equals(action)) {
            handleSubmitRequirement(request, response, user);
            return;
        }
        if ("reportIssue".equals(action)) {
            handleReportIssue(request, response, user);
            return;
        }
        if ("allocateVenue".equals(action)) {
            handleAllocateVenue(request, response, user);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/dashboard");
    }

    private void handleSubmitRequirement(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        if (!"COD".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String courseCode = trim(request.getParameter("courseCode"));
        String semester = trim(request.getParameter("semester"));
        String academicYear = trim(request.getParameter("academicYear"));
        String lecturerName = trim(request.getParameter("lecturerName"));
        String specialNeeds = trim(request.getParameter("specialNeeds"));
        String templateMode = trim(request.getParameter("templateMode"));
        String sourceTemplate = trim(request.getParameter("sourceTemplate"));
        String notes = trim(request.getParameter("notes"));
        int studentCount = parsePositiveInt(request.getParameter("studentCount"));

        if (courseCode == null || semester == null || lecturerName == null || academicYear == null || studentCount <= 0) {
            response.sendRedirect(request.getContextPath() + "/cod/submit_requirements.jsp?status=error");
            return;
        }

        StringBuilder mergedNeeds = new StringBuilder();
        if (specialNeeds != null) {
            mergedNeeds.append(specialNeeds);
        }
        if (templateMode != null) {
            if (mergedNeeds.length() > 0) {
                mergedNeeds.append(" | ");
            }
            mergedNeeds.append("Template mode: ").append(templateMode);
            if ("previous".equalsIgnoreCase(templateMode) && sourceTemplate != null) {
                mergedNeeds.append(" (source: ").append(sourceTemplate).append(")");
            }
        }
        if (notes != null) {
            if (mergedNeeds.length() > 0) {
                mergedNeeds.append(" | ");
            }
            mergedNeeds.append("Notes: ").append(notes);
        }

        long cycleId = MySQLRequirementDAO.getOrCreateCycle(academicYear, semester);
        boolean saved = MySQLRequirementDAO.addCourseRequirement(
                cycleId, courseCode, studentCount, lecturerName, mergedNeeds.toString(), user.getEmail());

        response.sendRedirect(request.getContextPath() + "/cod/submit_requirements.jsp?status=" + (saved ? "success" : "error"));
    }

    private void handleReportIssue(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        if (!"Class Representative".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String issueTitle = trim(request.getParameter("issueTitle"));
        String category = trim(request.getParameter("category"));
        String priority = trim(request.getParameter("priority"));
        String description = trim(request.getParameter("description"));
        String semester = trim(request.getParameter("semester"));
        String academicYear = trim(request.getParameter("academicYear"));

        if (issueTitle == null || category == null || priority == null || description == null
                || semester == null || academicYear == null) {
            response.sendRedirect(request.getContextPath() + "/classrep/report_issue.jsp?status=error");
            return;
        }

        long cycleId = MySQLRequirementDAO.getOrCreateCycle(academicYear, semester);
        String issueType = category + ": " + issueTitle;
        boolean saved = MySQLRequirementDAO.reportIssue(cycleId, null, user.getEmail(), issueType, priority, description);

        response.sendRedirect(request.getContextPath() + "/classrep/report_issue.jsp?status=" + (saved ? "success" : "error"));
    }

    private void handleAllocateVenue(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        if (!"Timetabling Admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String courseRequest = trim(request.getParameter("courseRequest"));
        String venue = trim(request.getParameter("venue"));
        String day = trim(request.getParameter("day"));
        String timeSlot = trim(request.getParameter("timeSlot"));
        String semester = trim(request.getParameter("semester"));
        String academicYear = trim(request.getParameter("academicYear"));

        if (courseRequest == null || venue == null || day == null || timeSlot == null || semester == null || academicYear == null) {
            response.sendRedirect(request.getContextPath() + "/timetable/allocate_venue.jsp?status=error");
            return;
        }

        long cycleId = MySQLRequirementDAO.getOrCreateCycle(academicYear, semester);
        String actionTaken = "Allocated " + courseRequest + " to " + venue + " on " + day + " at " + timeSlot;
        boolean saved = MySQLRequirementDAO.addDetAdjustment(cycleId, null, actionTaken, user.getEmail());

        response.sendRedirect(request.getContextPath() + "/timetable/allocate_venue.jsp?status=" + (saved ? "success" : "error"));
    }

    private static int parsePositiveInt(String value) {
        try {
            int parsed = Integer.parseInt(value);
            return parsed > 0 ? parsed : -1;
        } catch (NumberFormatException ex) {
            return -1;
        }
    }

    private static String trim(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }

    @Override
    public String getServletInfo() {
        return "Handles requirement submission, issue reporting, and allocation actions.";
    }
}

package Servlets;

<<<<<<< HEAD
import Models.User;
import Models.WorkflowDAO;
=======
<<<<<<< HEAD
import Models.User;
import Models.WorkflowDAO;
=======
import Models.MySQLRequirementDAO;
import Models.User;
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
import javax.servlet.http.HttpSession;
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5

public class RequirementServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
<<<<<<< HEAD
        String action = request.getParameter("action");
        User user = (User) request.getSession().getAttribute("user");
=======
<<<<<<< HEAD
        String action = request.getParameter("action");
        User user = (User) request.getSession().getAttribute("user");
=======
        HttpSession session = request.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("user");
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
        try {
            if ("submitRequirement".equals(action)) {
                handleSubmitRequirement(request, response, user);
                return;
            }
            if ("releaseDraft".equals(action)) {
                handleReleaseDraft(request, response, user);
                return;
            }
            if ("finalizeRequirement".equals(action)) {
                handleFinalizeRequirement(request, response, user);
                return;
            }
            if ("reportIssue".equals(action)) {
                handleReportIssue(request, response, user);
                return;
            }
            if ("updateIssueStatus".equals(action)) {
                handleUpdateIssueStatus(request, response, user);
                return;
            }
        } catch (RuntimeException ex) {
            response.sendRedirect(request.getHeader("referer") != null
                    ? request.getHeader("referer")
                    : request.getContextPath() + "/dashboard");
<<<<<<< HEAD
=======
=======
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
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
            return;
        }

        response.sendRedirect(request.getContextPath() + "/dashboard");
    }

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
    private void handleSubmitRequirement(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        if (!"COD".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        String courseCode = request.getParameter("courseCode");
        String lecturerName = request.getParameter("lecturerName");
        String studentCountRaw = request.getParameter("studentCount");
        String specialNeeds = request.getParameter("specialNeeds");
        int studentCount = parseInt(studentCountRaw, -1);
        if (isBlank(courseCode) || isBlank(lecturerName) || studentCount <= 0) {
            response.sendRedirect(request.getContextPath() + "/cod/submit_requirements.jsp?error=invalid");
            return;
        }

        WorkflowDAO.submitRequirement(courseCode, lecturerName, studentCount, specialNeeds, user.getEmail());
        response.sendRedirect(request.getContextPath() + "/cod/submit_requirements.jsp?success=1");
    }

    private void handleReleaseDraft(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        if (!"Timetabling Admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        long requirementId = parseLong(request.getParameter("requirementId"), -1L);
        String venue = request.getParameter("venue");
        String dayOfWeek = request.getParameter("dayOfWeek");
        String timeSlot = request.getParameter("timeSlot");
        String adjustmentNote = request.getParameter("adjustmentNote");

        if (requirementId <= 0 || isBlank(venue) || isBlank(dayOfWeek) || isBlank(timeSlot)) {
            response.sendRedirect(request.getContextPath() + "/timetable/allocate_venue.jsp?error=invalid");
            return;
        }

        WorkflowDAO.releaseDraft(requirementId, venue, dayOfWeek, timeSlot);
        if (!isBlank(adjustmentNote)) {
            WorkflowDAO.markAdjusted(requirementId, adjustmentNote);
        }
        response.sendRedirect(request.getContextPath() + "/timetable/allocate_venue.jsp?success=1");
    }

    private void handleFinalizeRequirement(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        if (!"Timetabling Admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        long requirementId = parseLong(request.getParameter("requirementId"), -1L);
        String finalNote = request.getParameter("finalNote");
        if (requirementId <= 0) {
            response.sendRedirect(request.getContextPath() + "/timetable/manage_schedule.jsp?error=invalid");
            return;
        }

        WorkflowDAO.finalizeRequirement(requirementId, finalNote);
        response.sendRedirect(request.getContextPath() + "/timetable/manage_schedule.jsp?success=1");
    }

    private void handleReportIssue(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        if (!"Class Representative".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        Long requirementId = null;
        long parsedId = parseLong(request.getParameter("requirementId"), -1L);
        if (parsedId > 0) {
            requirementId = parsedId;
        }
        String issueTitle = request.getParameter("issueTitle");
        String category = request.getParameter("category");
        String priority = request.getParameter("priority");
        String description = request.getParameter("description");
        if (isBlank(issueTitle) || isBlank(category) || isBlank(priority) || isBlank(description)) {
            response.sendRedirect(request.getContextPath() + "/classrep/report_issue.jsp?error=invalid");
            return;
        }

        WorkflowDAO.reportIssue(requirementId, issueTitle, category, priority, description, user.getEmail());
        response.sendRedirect(request.getContextPath() + "/classrep/report_issue.jsp?success=1");
    }

    private void handleUpdateIssueStatus(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        if (!"Timetabling Admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        long issueId = parseLong(request.getParameter("issueId"), -1L);
        String status = request.getParameter("status");
        String responseNote = request.getParameter("responseNote");
        String adjustmentForRequirement = request.getParameter("requirementId");
        String adjustmentNote = request.getParameter("adjustmentNote");
        if (issueId <= 0 || isBlank(status)) {
            response.sendRedirect(request.getContextPath() + "/timetable/view_issues.jsp?error=invalid");
            return;
        }

        WorkflowDAO.updateIssueStatus(issueId, status, responseNote);
        long reqId = parseLong(adjustmentForRequirement, -1L);
        if (reqId > 0 && !isBlank(adjustmentNote)) {
            WorkflowDAO.markAdjusted(reqId, adjustmentNote);
        }
        response.sendRedirect(request.getContextPath() + "/timetable/view_issues.jsp?success=1");
    }

    private static boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private static int parseInt(String value, int defaultValue) {
        try {
            return Integer.parseInt(value);
        } catch (Exception ex) {
            return defaultValue;
        }
    }

    private static long parseLong(String value, long defaultValue) {
        try {
            return Long.parseLong(value);
        } catch (Exception ex) {
            return defaultValue;
        }
<<<<<<< HEAD
=======
=======
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
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
    }
}

package Servlets;

import Models.User;
import Models.WorkflowDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RequirementServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

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
            return;
        }

        response.sendRedirect(request.getContextPath() + "/dashboard");
    }

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
    }
}



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Models.WorkflowDAO"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"Timetabling Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<WorkflowDAO.RequirementRecord> requirements = WorkflowDAO.listRequirements();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Week 2 Draft Timetable</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #0f172a; color: #e2e8f0; }
        .page { max-width: 1180px; margin: 0 auto; padding: 32px; }
        .card { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 24px; margin-top: 18px; }
        table { width: 100%; border-collapse: collapse; margin-top: 12px; }
        th, td { padding: 10px 8px; border-bottom: 1px solid #334155; text-align: left; }
        th { color: #cbd5e1; }
        .btn { border: 1px solid #334155; border-radius: 12px; background: #0f172a; color: #e2e8f0; padding: 10px 14px; cursor: pointer; }
        @media print {
            .no-print { display: none; }
            body { background: #fff; color: #000; }
            .card { border: none; background: #fff; }
            th, td { border-bottom: 1px solid #999; }
        }
    </style>
</head>
<body>
    <%@ include file="/includes/header.jsp" %>
    <%@ include file="/includes/navbar.jsp" %>
    <div class="page">
        <div class="no-print">
            <h1>Week 2 Draft Timetable</h1>
            <p>Draft timetable after feedback adjustments (before final publication).</p>
            <button class="btn" type="button" onclick="window.print()">Print week 2 draft</button>
        </div>
        <div class="card">
            <table>
                <thead>
                    <tr><th>Course</th><th>Lecturer</th><th>Students</th><th>Venue</th><th>Day</th><th>Time</th><th>Status</th><th>Adjustment note</th></tr>
                </thead>
                <tbody>
                    <%
                        boolean hasWeek2Draft = false;
                        for (WorkflowDAO.RequirementRecord r : requirements) {
                            boolean printableDraft = "DRAFT_RELEASED".equals(r.status) || "ADJUSTED".equals(r.status);
                            if (printableDraft) {
                                hasWeek2Draft = true;
                    %>
                    <tr>
                        <td><%= r.courseCode %></td>
                        <td><%= r.lecturerName %></td>
                        <td><%= r.studentCount %></td>
                        <td><%= r.venue == null ? "-" : r.venue %></td>
                        <td><%= r.dayOfWeek == null ? "-" : r.dayOfWeek %></td>
                        <td><%= r.timeSlot == null ? "-" : r.timeSlot %></td>
                        <td><%= r.status %></td>
                        <td><%= r.adjustmentNote == null ? "-" : r.adjustmentNote %></td>
                    </tr>
                    <%      }
                        }
                        if (!hasWeek2Draft) {
                    %>
                    <tr><td colspan="8">No week 2 draft timetable entries available yet.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <%@ include file="/includes/footer.jsp" %>
</body>
</html>

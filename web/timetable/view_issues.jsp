<%@page contentType="text/html" pageEncoding="UTF-8"%>
<<<<<<< HEAD
<%@page import="java.util.List"%>
<%@page import="Models.WorkflowDAO"%>
=======
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"Timetabling Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
<<<<<<< HEAD
    List<WorkflowDAO.IssueRecord> issues = WorkflowDAO.listIssues();
=======
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>View Issues</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #0f172a; color: #e2e8f0; }
        .page { max-width: 1180px; margin: 0 auto; padding: 32px; }
        .card { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 24px; margin-top: 24px; }
        table { width: 100%; border-collapse: collapse; margin-top: 18px; }
        th, td { padding: 14px 12px; border-bottom: 1px solid #334155; }
        th { text-align: left; }
        a { color: #38bdf8; text-decoration: none; }
    </style>
</head>
<body>
<<<<<<< HEAD
<div class="app-layout">
<%@ include file="../sidebar.jsp" %>
<div class="app-main">
    <div class="page">
        <div>
            <h1>View Issues</h1>
            <p>Flow step 5: DET reviews class feedback and applies week-2 adjustments.</p>
            <p><a href="<%= request.getContextPath() %>/timetable/dashboard.jsp">Back to dashboard</a></p>
            <% if (request.getParameter("success") != null) { %><p style="color:#86efac;">Issue update saved.</p><% } %>
=======
    <div class="page">
        <div>
            <h1>View Issues</h1>
            <p>Monitor reported scheduling issues and classroom conflicts.</p>
            <p><a href="dashboard.jsp">Back to dashboard</a></p>
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
        </div>

        <div class="card">
            <table>
                <thead>
<<<<<<< HEAD
                    <tr><th>Issue</th><th>Requirement</th><th>Reported by</th><th>Priority</th><th>Status</th><th>Action</th></tr>
                </thead>
                <tbody>
                    <% if (issues.isEmpty()) { %>
                    <tr><td colspan="6">No feedback issues yet.</td></tr>
                    <% } else { for (WorkflowDAO.IssueRecord issue : issues) { %>
                    <tr>
                        <td><%= issue.issueTitle %></td>
                        <td><%= issue.requirementId == null ? "-" : issue.requirementId %></td>
                        <td><%= issue.reportedByEmail %></td>
                        <td><%= issue.priority %></td>
                        <td><%= issue.status %></td>
                        <td>
                            <form method="post" action="<%= request.getContextPath() %>/RequirementServlet">
                                <input type="hidden" name="action" value="updateIssueStatus" />
                                <input type="hidden" name="issueId" value="<%= issue.id %>" />
                                <input type="hidden" name="requirementId" value="<%= issue.requirementId == null ? "" : issue.requirementId %>" />
                                <select name="status" required>
                                    <option <%= "OPEN".equals(issue.status) ? "selected" : "" %>>OPEN</option>
                                    <option <%= "IN_REVIEW".equals(issue.status) ? "selected" : "" %>>IN_REVIEW</option>
                                    <option <%= "RESOLVED".equals(issue.status) ? "selected" : "" %>>RESOLVED</option>
                                </select>
                                <input name="responseNote" type="text" placeholder="Response for class rep" />
                                <input name="adjustmentNote" type="text" placeholder="Adjustment note (week 2)" />
                                <button type="submit" style="margin-top:6px;">Save</button>
                            </form>
                        </td>
                    </tr>
                    <% }} %>
=======
                    <tr><th>Issue</th><th>Reported by</th><th>Priority</th><th>Status</th></tr>
                </thead>
                <tbody>
                    <tr><td>Room unavailable for CS101</td><td>classrep@uniflow.local</td><td>High</td><td>Open</td></tr>
                    <tr><td>Lecture clash for Year 2</td><td>cod@uniflow.local</td><td>Medium</td><td>Investigating</td></tr>
                    <tr><td>Requirement missing venue</td><td>timing@uniflow.local</td><td>Low</td><td>Resolved</td></tr>
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
                </tbody>
            </table>
        </div>
    </div>
<<<<<<< HEAD
</div>
</div>
=======
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
</body>
</html>

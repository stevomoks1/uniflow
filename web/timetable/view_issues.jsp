<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Models.WorkflowDAO"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"Timetabling Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<WorkflowDAO.IssueRecord> issues = WorkflowDAO.listIssues();
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
    <%@ include file="/includes/header.jsp" %>
    <%@ include file="/includes/navbar.jsp" %>
    <div class="page">
        <div>
            <h1>View Issues</h1>
            <p>Flow step 5: DET reviews class feedback and applies week-2 adjustments.</p>
            <p><a href="<%= request.getContextPath() %>/timetable/dashboard.jsp">Back to dashboard</a></p>
            <p><a href="<%= request.getContextPath() %>/timetable/draft_timetable_week2.jsp">Print week 2 draft timetable</a></p>
            <% if (request.getParameter("success") != null) { %><p style="color:#86efac;">Issue update saved.</p><% } %>
        </div>

        <div class="card">
            <table>
                <thead>
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
                </tbody>
            </table>
        </div>
    </div>
    <%@ include file="/includes/footer.jsp" %>
</body>
</html>

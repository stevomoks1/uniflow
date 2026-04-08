<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Models.WorkflowDAO"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"Class Representative".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<WorkflowDAO.IssueRecord> issues = WorkflowDAO.listIssuesByReporter(user.getEmail());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Track Issue</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #0f172a; color: #e2e8f0; }
        .page { max-width: 980px; margin: 0 auto; padding: 32px; }
        .card { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 24px; }
        table { width: 100%; border-collapse: collapse; margin-top: 18px; }
        th, td { padding: 14px 12px; border-bottom: 1px solid #334155; }
        th { text-align: left; }
        a { color: #38bdf8; text-decoration: none; }
    </style>
</head>
<body>
    <div class="page">
        <div>
            <h1>Track Reported Issues</h1>
            <p>Monitor the status of previously reported issues and trends.</p>
            <p><a href="<%= request.getContextPath() %>/classrep/dashboard.jsp">Back to dashboard</a></p>
        </div>
        <div class="card">
            <table>
                <thead>
                    <tr><th>Issue</th><th>Priority</th><th>Status</th><th>Timetable response</th></tr>
                </thead>
                <tbody>
                    <% if (issues.isEmpty()) { %>
                    <tr><td colspan="4">No issues submitted yet.</td></tr>
                    <% } else { for (WorkflowDAO.IssueRecord issue : issues) { %>
                    <tr>
                        <td><%= issue.issueTitle %></td>
                        <td><%= issue.priority %></td>
                        <td><%= issue.status %></td>
                        <td><%= issue.timetableResponse == null ? "-" : issue.timetableResponse %></td>
                    </tr>
                    <% }} %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

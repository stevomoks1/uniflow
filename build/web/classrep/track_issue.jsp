<%@page contentType="text/html" pageEncoding="UTF-8"%>
<<<<<<< HEAD
<%@page import="java.util.List"%>
<%@page import="Models.WorkflowDAO"%>
=======
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"Class Representative".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
<<<<<<< HEAD
    List<WorkflowDAO.IssueRecord> issues = WorkflowDAO.listIssuesByReporter(user.getEmail());
=======
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
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
<<<<<<< HEAD
            <p><a href="<%= request.getContextPath() %>/classrep/dashboard.jsp">Back to dashboard</a></p>
=======
            <p><a href="dashboard.jsp">Back to dashboard</a></p>
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
        </div>
        <div class="card">
            <table>
                <thead>
<<<<<<< HEAD
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
=======
                    <tr><th>Issue</th><th>Priority</th><th>Status</th><th>Updated</th></tr>
                </thead>
                <tbody>
                    <tr><td>Overcrowding in Lab 3</td><td>Urgent</td><td>Pending</td><td>12 min ago</td></tr>
                    <tr><td>Projector failure in Hall B</td><td>Normal</td><td>Resolved</td><td>2 hrs ago</td></tr>
                    <tr><td>Air conditioning issue</td><td>Normal</td><td>Investigating</td><td>1 day ago</td></tr>
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

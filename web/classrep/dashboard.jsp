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
    int pendingIssues = 0;
    int resolvedIssues = 0;
    int highPriorityIssues = 0;
    for (WorkflowDAO.IssueRecord issue : issues) {
        if (!"RESOLVED".equals(issue.status)) {
            pendingIssues++;
        } else {
            resolvedIssues++;
        }
        if ("High".equalsIgnoreCase(issue.priority)) {
            highPriorityIssues++;
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Class Representative Dashboard</title>
    <style>
        * { box-sizing: border-box; }
        body { margin: 0; font-family: Inter, "Segoe UI", Arial, sans-serif; background: linear-gradient(145deg, #020617, #0f172a); color: #e2e8f0; }
        .page { max-width: 1160px; margin: 0 auto; padding: 28px 18px 40px; }
        .top { display: flex; justify-content: space-between; align-items: center; gap: 12px; flex-wrap: wrap; }
        .welcome { color: #94a3b8; margin-top: 6px; }
        .btn { text-decoration: none; color: #f8fafc; border: 1px solid rgba(148,163,184,.35); padding: 10px 14px; border-radius: 12px; background: rgba(15,23,42,.7); }
        .btn.primary { color: #082f49; background: linear-gradient(135deg, #7dd3fc, #38bdf8); border: none; }
        .nav { margin-top: 18px; display: flex; gap: 10px; flex-wrap: wrap; }
        .panel { margin-top: 18px; padding: 20px; border-radius: 16px; border: 1px solid rgba(148,163,184,.25); background: rgba(15,23,42,.82); }
        .grid { display: grid; gap: 14px; grid-template-columns: repeat(auto-fit, minmax(230px, 1fr)); }
        .card { padding: 18px; border-radius: 14px; border: 1px solid rgba(148,163,184,.18); background: rgba(15,23,42,.7); }
        .card h3 { margin: 0 0 8px; }
        .card p { margin: 0; color: #94a3b8; line-height: 1.55; }
        table { width:100%; border-collapse: collapse; margin-top:6px; }
        th, td { padding: 10px 8px; border-bottom: 1px solid #334155; text-align: left; }
        th { color: #cbd5e1; }
    </style>
</head>
<body>
    <div class="page">
        <div class="top">
            <div>
                <h1>Class Representative Dashboard</h1>
                <p class="welcome">Welcome, <strong><%= user.getFullName() %></strong> | <%= user.getRole() %></p>
            </div>
            <div>
                <a class="btn" href="<%= request.getContextPath() %>/dashboard">Refresh route</a>
                <a class="btn primary" href="<%= request.getContextPath() %>/logout">Logout</a>
            </div>
        </div>

        <div class="nav">
            <a class="btn" href="<%= request.getContextPath() %>/classrep/report_issue.jsp">Report issue</a>
            <a class="btn" href="<%= request.getContextPath() %>/classrep/track_issue.jsp">Track issue</a>
            <a class="btn" href="<%= request.getContextPath() %>/">Home</a>
        </div>

        <div class="panel grid">
            <div class="card"><h3>Issue Reporting</h3><p>Submit facility, overcrowding, or equipment issues immediately.</p></div>
            <div class="card"><h3>Status Tracking</h3><p>Track the progress of issues and see how they are being resolved.</p></div>
            <div class="card"><h3>Analytics</h3><p>View counts and trends for reported issues.</p></div>
        </div>

        <div class="panel">
            <h2>Issue snapshot</h2>
            <table>
                <thead><tr><th>Type</th><th>Count</th></tr></thead>
                <tbody>
                    <tr><td>Pending</td><td><%= pendingIssues %></td></tr>
                    <tr><td>Resolved</td><td><%= resolvedIssues %></td></tr>
                    <tr><td>High priority</td><td><%= highPriorityIssues %></td></tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

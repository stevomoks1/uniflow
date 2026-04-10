<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Models.WorkflowDAO"%>
<%@page import="Models.MySQLUserDAO"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"System Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    int totalUsers = MySQLUserDAO.countUsers();
    List<WorkflowDAO.RequirementRecord> requirements = WorkflowDAO.listRequirements();
    List<WorkflowDAO.IssueRecord> issues = WorkflowDAO.listIssues();
    int finalizedRequirements = 0;
    int openIssues = 0;
    for (WorkflowDAO.RequirementRecord r : requirements) {
        if ("FINALIZED".equals(r.status)) {
            finalizedRequirements++;
        }
    }
    for (WorkflowDAO.IssueRecord issue : issues) {
        if (!"RESOLVED".equals(issue.status)) {
            openIssues++;
        }
    }
%>
<jsp:useBean id="summary" class="Models.DashboardSummaryBean" scope="page" />
<jsp:setProperty name="summary" property="metricOne" value="<%= totalUsers %>" />
<jsp:setProperty name="summary" property="metricTwo" value="<%= requirements.size() %>" />
<jsp:setProperty name="summary" property="metricThree" value="<%= finalizedRequirements %>" />
<jsp:setProperty name="summary" property="metricFour" value="<%= openIssues %>" />
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>System Admin Dashboard</title>
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
        table { width: 100%; border-collapse: collapse; margin-top: 6px; }
        th, td { padding: 10px 8px; border-bottom: 1px solid #334155; text-align: left; }
        th { color: #cbd5e1; }
    </style>
</head>
<body>
    <div class="page">
        <div class="top">
            <div>
                <h1>System Admin Dashboard</h1>
                <p class="welcome">Welcome, <strong><%= user.getFullName() %></strong> | <%= user.getRole() %></p>
            </div>
            <div>
                <a class="btn" href="<%= request.getContextPath() %>/dashboard">Refresh route</a>
                <a class="btn primary" href="<%= request.getContextPath() %>/logout">Logout</a>
            </div>
        </div>

        <div class="nav">
            <a class="btn" href="<%= request.getContextPath() %>/admin/manage_users.jsp">Manage users</a>
            <a class="btn" href="<%= request.getContextPath() %>/admin/system_logs.jsp">System logs</a>
            <a class="btn" href="<%= request.getContextPath() %>/">Home</a>
        </div>

        <div class="panel grid">
            <div class="card">
                <h3>User Management</h3>
                <p>View and control user accounts, assign roles, and adjust access permissions.</p>
            </div>
            <div class="card">
                <h3>System Analytics</h3>
                <p>Monitor activity, usage patterns, and login trends across the platform.</p>
            </div>
            <div class="card">
                <h3>Audit Trail</h3>
                <p>Review recent system-level actions and maintain accountability for changes.</p>
            </div>
        </div>

        <div class="panel">
        .status { display: inline-flex; padding: 4px 10px; border-radius: 999px; background: #334155; color: #cbd5e1; font-size: 0.9rem; }
    </style>
</head>
<body>
    <div class="page">
        <div class="layout">
            <aside class="sidebar">
                <h3>Admin Tabs</h3>
                <ul class="tab-list">
                    <li><a href="<%= cp %>/dashboard">Dashboard Home</a></li>
                    <li><a href="<%= cp %>/admin/manage_users.jsp">Manage Users</a></li>
                    <li><a href="<%= cp %>/admin/system_logs.jsp">System Logs</a></li>
                    <li><a href="<%= cp %>/logout">Logout</a></li>
                </ul>
            </aside>
            <main class="content">
                <header>
                    <div>
                        <h1>System Admin Dashboard</h1>
                        <p>Welcome, <strong><%= user.getFullName() %></strong> â€” Role: <%= user.getRole() %></p>
                    </div>
                </header>

                <div class="kpi-grid">
            <div class="kpi"><div>Total users</div><div class="value">42</div></div>
            <div class="kpi"><div>Active sessions</div><div class="value">8</div></div>
            <div class="kpi"><div>Open incidents</div><div class="value">3</div></div>
            <div class="kpi"><div>Audit events today</div><div class="value">29</div></div>
                </div>

                <div class="grid">
            <div class="card">
                <h2>User Management</h2>
                <p>View and control user accounts, assign roles, and adjust access permissions.</p>
            </div>
            <div class="card">
                <h2>System Analytics</h2>
                <p>Monitor activity, usage patterns, and login trends across the platform.</p>
            </div>
            <div class="card">
                <h2>Audit Trail</h2>
                <p>Review recent system-level actions and maintain accountability for changes.</p>
            </div>
                </div>

                <div class="card">
            <h2>Quick Summary</h2>
            <table>
                <thead>
                    <tr><th>Metric</th><th>Value</th></tr>
                </thead>
                <tbody>
                    <tr><td>Total users</td><td>${summary.metricOne}</td></tr>
                    <tr><td>Total requirements</td><td>${summary.metricTwo}</td></tr>
                    <tr><td>Finalized timetable entries</td><td>${summary.metricThree}</td></tr>
                    <tr><td>Open feedback issues</td><td>${summary.metricFour}</td></tr>
                </tbody>
            </table>
        </div>
    </div>
                    <tr><td>Total users</td><td>42</td></tr>
                    <tr><td>Active sessions</td><td>8</td></tr>
                    <tr><td>Recent changes</td><td>13</td></tr>
                    <tr><td>Pending role requests</td><td>2</td></tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
</div>
        </div>
    </div>
</body>
</html>



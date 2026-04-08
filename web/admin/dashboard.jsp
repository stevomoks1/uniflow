<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"System Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>System Admin Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #0f172a; color: #e2e8f0; }
        .page { max-width: 1180px; margin: 0 auto; padding: 32px; }
        header { display: flex; justify-content: space-between; align-items: center; }
        .card { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 24px; margin-top: 24px; }
        .grid { display: grid; gap: 24px; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); }
        a { color: #38bdf8; text-decoration: none; }
        .nav { display: flex; gap: 14px; flex-wrap: wrap; margin-top: 18px; }
        .nav a { background: #1e293b; padding: 10px 16px; border-radius: 12px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px 10px; border-bottom: 1px solid #334155; }
        th { text-align: left; color: #f8fafc; }
        .status { display: inline-flex; padding: 4px 10px; border-radius: 999px; background: #334155; color: #cbd5e1; font-size: 0.9rem; }
    </style>
</head>
<body>
    <div class="page">
        <header>
            <div>
                <h1>System Admin Dashboard</h1>
                <p>Welcome, <strong><%= user.getFullName() %></strong> — Role: <%= user.getRole() %></p>
            </div>
            <div><a href="<%= request.getContextPath() %>/logout">Logout</a></div>
        </header>

        <div class="nav">
            <a href="manage_users.jsp">Manage Users</a>
            <a href="system_logs.jsp">System Logs</a>
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
                    <tr><td>Total users</td><td>42</td></tr>
                    <tr><td>Active sessions</td><td>8</td></tr>
                    <tr><td>Recent changes</td><td>13</td></tr>
                    <tr><td>Pending role requests</td><td>2</td></tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

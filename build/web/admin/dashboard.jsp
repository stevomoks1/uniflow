<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"System Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>System Admin Dashboard</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: Arial, sans-serif; margin: 0; background: #0f172a; color: #e2e8f0; }
        .page { max-width: 1280px; margin: 0 auto; padding: 24px; }
        .layout { display: grid; grid-template-columns: 250px 1fr; gap: 20px; align-items: start; }
        .sidebar { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 18px; position: sticky; top: 20px; }
        .sidebar h3 { margin: 0 0 14px; font-size: 1rem; color: #cbd5e1; }
        .tab-list { list-style: none; margin: 0; padding: 0; display: grid; gap: 10px; }
        .tab-list a { display: block; padding: 10px 12px; border-radius: 10px; background: #0b1220; color: #e2e8f0; text-decoration: none; border: 1px solid #334155; }
        .tab-list a:hover { background: #1e293b; }
        .content { min-width: 0; }
        header { display: flex; justify-content: space-between; align-items: center; gap: 16px; flex-wrap: wrap; }
        .card { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 22px; margin-top: 22px; }
        .grid { display: grid; gap: 18px; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)); }
        a { color: #38bdf8; text-decoration: none; }
        .nav { display: flex; gap: 12px; flex-wrap: wrap; margin-top: 16px; }
        .nav a { background: #1e293b; padding: 10px 16px; border-radius: 12px; color: #e2e8f0; }
        .nav a:hover { background: #334155; }
        .kpi-grid { display: grid; gap: 16px; grid-template-columns: repeat(auto-fit, minmax(210px, 1fr)); margin-top: 22px; }
        .kpi { background: #0b1220; border: 1px solid #334155; border-radius: 14px; padding: 16px; }
        .kpi .value { font-size: 1.9rem; font-weight: 700; margin-top: 8px; }
        table { width: 100%; border-collapse: collapse; margin-top: 14px; }
        th, td { padding: 12px 10px; border-bottom: 1px solid #334155; text-align: left; }
        th { color: #f8fafc; }
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
                        <p>Welcome, <strong><%= user.getFullName() %></strong> — Role: <%= user.getRole() %></p>
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
                    <tr><td>Pending role requests</td><td>2</td></tr>
                    <tr><td>New registrations (24h)</td><td>6</td></tr>
                    <tr><td>Failed login attempts (24h)</td><td>4</td></tr>
                    <tr><td>Access policy changes (24h)</td><td>1</td></tr>
                </tbody>
            </table>
                </div>
            </main>
        </div>
    </div>
</body>
</html>

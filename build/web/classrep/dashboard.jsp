<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"Class Representative".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Class Representative Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #0f172a; color: #e2e8f0; }
        .page { max-width: 1180px; margin: 0 auto; padding: 32px; }
        header { display: flex; justify-content: space-between; align-items: center; }
        .nav { display: flex; gap: 14px; flex-wrap: wrap; margin-top: 18px; }
        .nav a { background: #1e293b; padding: 10px 16px; border-radius: 12px; color: #e2e8f0; text-decoration:none; }
        .card { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 24px; margin-top: 24px; }
    </style>
</head>
<body>
    <div class="page">
        <header>
            <div>
                <h1>Class Representative Dashboard</h1>
                <p>Welcome, <strong><%= user.getFullName() %></strong> — Role: <%= user.getRole() %></p>
            </div>
            <div><a href="<%= request.getContextPath() %>/logout">Logout</a></div>
        </header>

        <div class="nav">
            <a href="report_issue.jsp">Report issue</a>
            <a href="track_issue.jsp">Track issue</a>
        </div>

        <div class="grid" style="display:grid; gap:24px; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));">
            <div class="card"><h2>Issue reporting</h2><p>Submit facility, overcrowding, or equipment issues immediately.</p></div>
            <div class="card"><h2>Status tracking</h2><p>Track the progress of issues and see how they are being resolved.</p></div>
            <div class="card"><h2>Analytics</h2><p>View counts and trends for reported issues.</p></div>
        </div>

        <div class="card">
            <h2>Issue snapshot</h2>
            <table style="width:100%; border-collapse: collapse; margin-top:18px;">
                <thead><tr><th>Type</th><th>Count</th></tr></thead>
                <tbody>
                    <tr><td>Pending</td><td>4</td></tr>
                    <tr><td>Resolved</td><td>9</td></tr>
                    <tr><td>Urgent</td><td>2</td></tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

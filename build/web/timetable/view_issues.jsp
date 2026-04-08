<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"Timetabling Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
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
    <div class="page">
        <div>
            <h1>View Issues</h1>
            <p>Monitor reported scheduling issues and classroom conflicts.</p>
            <p><a href="dashboard.jsp">Back to dashboard</a></p>
        </div>

        <div class="card">
            <table>
                <thead>
                    <tr><th>Issue</th><th>Reported by</th><th>Priority</th><th>Status</th></tr>
                </thead>
                <tbody>
                    <tr><td>Room unavailable for CS101</td><td>classrep@uniflow.local</td><td>High</td><td>Open</td></tr>
                    <tr><td>Lecture clash for Year 2</td><td>cod@uniflow.local</td><td>Medium</td><td>Investigating</td></tr>
                    <tr><td>Requirement missing venue</td><td>timing@uniflow.local</td><td>Low</td><td>Resolved</td></tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

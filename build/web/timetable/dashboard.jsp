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
    <title>Timetabling Admin Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #0f172a; color: #e2e8f0; }
        .page { max-width: 1180px; margin: 0 auto; padding: 32px; }
        header { display: flex; justify-content: space-between; align-items: center; }
        .card { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 24px; margin-top: 24px; }
        .grid { display: grid; gap: 24px; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); }
        a { color: #38bdf8; text-decoration: none; }
        .nav { display: flex; gap: 14px; flex-wrap: wrap; margin-top: 18px; }
        .nav a { background: #1e293b; padding: 10px 16px; border-radius: 12px; }
        table { width: 100%; border-collapse: collapse; margin-top: 18px; }
        th, td { padding: 12px 10px; border-bottom: 1px solid #334155; }
    </style>
</head>
<body>
    <div class="page">
        <header>
            <div>
                <h1>Timetabling Admin Dashboard</h1>
                <p>Welcome, <strong><%= user.getFullName() %></strong> — Role: <%= user.getRole() %></p>
            </div>
            <div><a href="<%= request.getContextPath() %>/logout">Logout</a></div>
        </header>

        <div class="nav">
            <a href="allocate_venue.jsp">Allocate venue</a>
            <a href="manage_schedule.jsp">Manage schedule</a>
            <a href="view_issues.jsp">View issues</a>
        </div>

        <div class="grid">
            <div class="card">
                <h2>Venue Allocation</h2>
                <p>Assign classrooms and halls to course requests while avoiding conflicts.</p>
            </div>
            <div class="card">
                <h2>Schedule Review</h2>
                <p>Inspect existing timetable blocks and adjust allocations.</p>
            </div>
            <div class="card">
                <h2>Conflict Detection</h2>
                <p>Monitor overlapping bookings and room usage issues.</p>
            </div>
        </div>

        <div class="card">
            <h2>Today's Summary</h2>
            <table>
                <thead>
                    <tr><th>Metric</th><th>Value</th></tr>
                </thead>
                <tbody>
                    <tr><td>Submitted requirements</td><td>18</td></tr>
                    <tr><td>Pending allocations</td><td>7</td></tr>
                    <tr><td>Detected conflicts</td><td>2</td></tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

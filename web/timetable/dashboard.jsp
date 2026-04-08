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
<div class="app-layout">
<%@ include file="../sidebar.jsp" %>
<div class="app-main">
    <div class="page">
        <div class="top">
            <div>
                <h1>Timetabling Admin Dashboard</h1>
                <p class="welcome">Welcome, <strong><%= user.getFullName() %></strong> | <%= user.getRole() %></p>
            </div>
            <div>
                <a class="btn" href="<%= request.getContextPath() %>/dashboard">Refresh route</a>
                <a class="btn primary" href="<%= request.getContextPath() %>/logout">Logout</a>
            </div>
        </div>

        <div class="nav">
            <a class="btn" href="<%= request.getContextPath() %>/timetable/allocate_venue.jsp">Allocate venue</a>
            <a class="btn" href="<%= request.getContextPath() %>/timetable/manage_schedule.jsp">Manage schedule</a>
            <a class="btn" href="<%= request.getContextPath() %>/timetable/view_issues.jsp">View issues</a>
            <a class="btn" href="<%= request.getContextPath() %>/">Home</a>
        </div>

        <div class="panel grid">
            <div class="card">
                <h3>Venue Allocation</h3>
                <p>Assign classrooms and halls to course requests while avoiding conflicts.</p>
            </div>
            <div class="card">
                <h3>Schedule Review</h3>
                <p>Inspect existing timetable blocks and adjust allocations.</p>
            </div>
            <div class="card">
                <h3>Conflict Detection</h3>
                <p>Monitor overlapping bookings and room usage issues.</p>
            </div>
        </div>

        <div class="panel">
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
</div>
</div>
</body>
</html>

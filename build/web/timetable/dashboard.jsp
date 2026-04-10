<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"Timetabling Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
    String cp = request.getContextPath();
    String[] venues = {
        "PST 1", "PST 2", "PST 3", "PST 4", "PST 5",
        "NPL 1", "NPL 2", "NPL 3", "NPL 4", "NPL 5", "NPL 6",
        "B1", "B2", "B3", "B4", "B5",
        "CB1", "CB2", "CB3", "CB4", "CB5",
        "ED1", "ED2", "ED3", "ED4"
    };
=======
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Timetabling Admin Dashboard</title>
    <style>
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
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
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
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
        .badge { display: inline-block; padding: 4px 10px; border-radius: 999px; background: #1e293b; font-size: 0.85rem; }
        .badge.risk { background: #7f1d1d; }
        .badge.review { background: #78350f; }
        .badge.ok { background: #14532d; }
=======
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
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
    </style>
</head>
<body>
    <div class="page">
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
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
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
        <div class="layout">
            <aside class="sidebar">
                <h3>Timetabling Tabs</h3>
                <ul class="tab-list">
                    <li><a href="<%= cp %>/dashboard">Dashboard Home</a></li>
                    <li><a href="<%= cp %>/timetable/allocate_venue.jsp">Allocate Venue</a></li>
                    <li><a href="<%= cp %>/timetable/manage_schedule.jsp">Manage Schedule</a></li>
                    <li><a href="<%= cp %>/timetable/view_issues.jsp">View Issues</a></li>
                    <li><a href="<%= cp %>/logout">Logout</a></li>
                </ul>
            </aside>
            <main class="content">
                <header>
                    <div>
                        <h1>Timetabling Admin Dashboard</h1>
                        <p>Welcome, <strong><%= user.getFullName() %></strong> — Role: <%= user.getRole() %></p>
                    </div>
                </header>

                <div class="grid">
=======
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
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
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
<<<<<<< HEAD
                </div>

                <div class="kpi-grid">
            <div class="kpi"><div>Courses received</div><div class="value">0</div></div>
            <div class="kpi"><div>Allocated</div><div class="value">0</div></div>
            <div class="kpi"><div>Open clashes</div><div class="value">0</div></div>
            <div class="kpi"><div>Adjustment week</div><div class="value">2</div></div>
                </div>

                <div class="card">
            <h2>Approved Venue Inventory</h2>
            <table>
                <thead>
                    <tr><th>Venue</th><th>Category</th><th>Allocation Status</th></tr>
                </thead>
                <tbody>
                    <% for (String venue : venues) { %>
                    <tr>
                        <td><%= venue %></td>
                        <td>Campus Venue</td>
                        <td><span class="badge review">Not allocated yet</span></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
                </div>
            </main>
=======
        </div>

        <div class="card">
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
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
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
        </div>
    </div>
</body>
</html>

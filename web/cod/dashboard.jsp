<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"COD".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
<<<<<<< HEAD
    String cp = request.getContextPath();
=======
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>COD Dashboard</title>
    <style>
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
        .nav { display: flex; gap: 12px; flex-wrap: wrap; margin-top: 16px; }
        .nav a { background: #1e293b; padding: 10px 16px; border-radius: 12px; color: #e2e8f0; text-decoration: none; }
        .nav a:hover { background: #334155; }
        .kpi-grid { display: grid; gap: 16px; grid-template-columns: repeat(auto-fit, minmax(210px, 1fr)); margin-top: 22px; }
        .kpi { background: #0b1220; border: 1px solid #334155; border-radius: 14px; padding: 16px; }
        .kpi .value { font-size: 1.9rem; font-weight: 700; margin-top: 8px; }
        .flow-list { margin: 0; padding-left: 20px; line-height: 1.8; }
        table { width: 100%; border-collapse: collapse; margin-top: 14px; }
        th, td { padding: 12px 10px; border-bottom: 1px solid #334155; text-align: left; }
        th { color: #f8fafc; }
        .badge { display: inline-block; padding: 4px 10px; border-radius: 999px; background: #1e293b; font-size: 0.85rem; }
        .badge.open { background: #7f1d1d; }
        .badge.done { background: #14532d; }
        .logout { color: #38bdf8; text-decoration: none; }
=======
        body { font-family: Arial, sans-serif; margin: 0; background: #0f172a; color: #e2e8f0; }
        .page { max-width: 1180px; margin: 0 auto; padding: 32px; }
        header { display: flex; justify-content: space-between; align-items: center; }
        .card { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 24px; margin-top: 24px; }
        .nav { display: flex; gap: 14px; flex-wrap: wrap; margin-top: 18px; }
        .nav a { background: #1e293b; padding: 10px 16px; border-radius: 12px; color: #e2e8f0; text-decoration:none; }
        table { width: 100%; border-collapse: collapse; margin-top: 18px; }
        th, td { padding: 12px 10px; border-bottom: 1px solid #334155; }
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
    </style>
</head>
<body>
    <div class="page">
<<<<<<< HEAD
        <div class="layout">
            <aside class="sidebar">
                <h3>COD Tabs</h3>
                <ul class="tab-list">
                    <li><a href="<%= cp %>/dashboard">Dashboard Home</a></li>
                    <li><a href="<%= cp %>/cod/submit_requirements.jsp">Submit Requirements</a></li>
                    <li><a href="<%= cp %>/cod/edit_requirements.jsp">Edit Requirements</a></li>
                    <li><a href="<%= cp %>/cod/manage_requests.jsp">Manage Requests</a></li>
                    <li><a href="<%= cp %>/logout">Logout</a></li>
                </ul>
            </aside>
            <main class="content">
                <header>
                    <div>
                        <h1>COD Dashboard</h1>
                        <p>Welcome, <strong><%= user.getFullName() %></strong> — Role: <%= user.getRole() %></p>
                    </div>
                </header>

                <div class="kpi-grid">
            <div class="kpi"><div>Submitted courses</div><div class="value">18</div></div>
            <div class="kpi"><div>Needs review</div><div class="value">5</div></div>
            <div class="kpi"><div>Draft-ready</div><div class="value">13</div></div>
            <div class="kpi"><div>Week</div><div class="value">1</div></div>
                </div>

                <div class="card">
            <h2>Workflow Focus</h2>
            <ol class="flow-list">
                <li>Submit course code, student count, lecturer, and special needs.</li>
                <li>Confirm consolidated entries before draft timetable release.</li>
                <li>Monitor class rep issues and update requests quickly.</li>
                <li>Prepare clean dataset for DET week-2 adjustment cycle.</li>
            </ol>
                </div>

                <div class="card">
            <h2>Recent Requirement Activity</h2>
            <table>
                <thead><tr><th>Course</th><th>Students</th><th>Special Needs</th><th>Status</th></tr></thead>
                <tbody>
                    <tr><td>CS101</td><td>120</td><td>Projector + PA</td><td><span class="badge done">Consolidated</span></td></tr>
                    <tr><td>IT203</td><td>80</td><td>Computer Lab</td><td><span class="badge open">Awaiting Review</span></td></tr>
                    <tr><td>SE301</td><td>65</td><td>None</td><td><span class="badge done">Consolidated</span></td></tr>
                </tbody>
            </table>
                </div>
            </main>
=======
        <header>
            <div>
                <h1>COD Dashboard</h1>
                <p>Welcome, <strong><%= user.getFullName() %></strong> — Role: <%= user.getRole() %></p>
            </div>
            <div><a href="<%= request.getContextPath() %>/logout">Logout</a></div>
        </header>

        <div class="nav">
            <a href="submit_requirements.jsp">Submit requirements</a>
            <a href="edit_requirements.jsp">Edit requirements</a>
            <a href="manage_requests.jsp">Manage requests</a>
        </div>

        <div class="grid" style="display:grid; gap:24px; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));">
            <div class="card"><h2>Requirement submission</h2><p>Submit new course requirements and attach supporting details.</p></div>
            <div class="card"><h2>Template reuse</h2><p>Reuse previous semester templates to save time when uploading course requests.</p></div>
            <div class="card"><h2>Request tracking</h2><p>Track submission status across all active requests.</p></div>
        </div>

        <div class="card">
            <h2>Current status</h2>
            <table>
                <thead><tr><th>Metric</th><th>Count</th></tr></thead>
                <tbody>
                    <tr><td>Submitted requests</td><td>12</td></tr>
                    <tr><td>Pending approvals</td><td>5</td></tr>
                    <tr><td>Templates available</td><td>3</td></tr>
                </tbody>
            </table>
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
        </div>
    </div>
</body>
</html>

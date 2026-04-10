<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Models.WorkflowDAO"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"COD".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<WorkflowDAO.RequirementRecord> requirements = WorkflowDAO.listRequirements();
    int submittedByMe = 0;
    int pendingByMe = 0;
    int finalizedByMe = 0;
    for (WorkflowDAO.RequirementRecord r : requirements) {
        if (user.getEmail().equalsIgnoreCase(r.submittedByEmail)) {
            submittedByMe++;
            if ("FINALIZED".equals(r.status)) {
                finalizedByMe++;
            } else {
                pendingByMe++;
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>COD Dashboard</title>
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
                <h1>COD Dashboard</h1>
                <p class="welcome">Welcome, <strong><%= user.getFullName() %></strong> | <%= user.getRole() %></p>
            </div>
            <div>
                <a class="btn" href="<%= request.getContextPath() %>/dashboard">Refresh route</a>
                <a class="btn primary" href="<%= request.getContextPath() %>/logout">Logout</a>
            </div>
        </div>

        <div class="nav">
            <a class="btn" href="<%= request.getContextPath() %>/cod/submit_requirements.jsp">Submit requirements</a>
            <a class="btn" href="<%= request.getContextPath() %>/cod/edit_requirements.jsp">Edit requirements</a>
            <a class="btn" href="<%= request.getContextPath() %>/cod/manage_requests.jsp">Manage requests</a>
            <a class="btn" href="<%= request.getContextPath() %>/">Home</a>
        </div>

        <div class="panel grid">
            <div class="card"><h3>Requirement Submission</h3><p>Submit new course requirements and attach supporting details.</p></div>
            <div class="card"><h3>Template Reuse</h3><p>Reuse previous semester templates to save time when uploading course requests.</p></div>
            <div class="card"><h3>Request Tracking</h3><p>Track submission status across all active requests.</p></div>
        </div>

        <div class="panel">
    </style>
</head>
<body>
    <div class="page">
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
                        <p>Welcome, <strong><%= user.getFullName() %></strong> â€” Role: <%= user.getRole() %></p>
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
            <h2>Current status</h2>
            <table>
                <thead><tr><th>Metric</th><th>Count</th></tr></thead>
                <tbody>
                    <tr><td>My submitted requests</td><td><%= submittedByMe %></td></tr>
                    <tr><td>My pending requests</td><td><%= pendingByMe %></td></tr>
                    <tr><td>My finalized requests</td><td><%= finalizedByMe %></td></tr>
                </tbody>
            </table>
        </div>
    </div>
        </div>
    </div>
</body>
</html>



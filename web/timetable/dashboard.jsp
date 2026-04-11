<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Models.WorkflowDAO"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    if (!"Timetabling Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/dashboard");
        return;
    }
    List<WorkflowDAO.RequirementRecord> requirements = WorkflowDAO.listRequirements();
    List<WorkflowDAO.IssueRecord> issues = WorkflowDAO.listIssues();
    int submittedRequirements = 0;
    int pendingAllocations = 0;
    int openIssues = 0;
    int finalizedCount = 0;
    for (WorkflowDAO.RequirementRecord r : requirements) {
        if ("SUBMITTED".equals(r.status)) {
            submittedRequirements++;
        }
        if (r.venue == null || r.dayOfWeek == null || r.timeSlot == null) {
            pendingAllocations++;
        }
        if ("FINALIZED".equals(r.status)) {
            finalizedCount++;
        }
    }
    for (WorkflowDAO.IssueRecord issue : issues) {
        if (!"RESOLVED".equals(issue.status)) {
            openIssues++;
        }
    }
%>
<jsp:useBean id="summary" class="Models.DashboardSummaryBean" scope="page" />
<jsp:setProperty name="summary" property="metricOne" value="<%= submittedRequirements %>" />
<jsp:setProperty name="summary" property="metricTwo" value="<%= pendingAllocations %>" />
<jsp:setProperty name="summary" property="metricThree" value="<%= openIssues %>" />
<jsp:setProperty name="summary" property="metricFour" value="<%= finalizedCount %>" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Timetabling Admin Dashboard</title>
    <style>
        * { box-sizing: border-box; }
        body { margin: 0; font-family: 'Segoe UI', system-ui, -apple-system, sans-serif; background: linear-gradient(135deg, #0f172a 0%, #1a2940 100%); color: #e2e8f0; min-height: 100vh; }
        .layout { display: grid; grid-template-columns: 280px 1fr; gap: 0; min-height: 100vh; }
        .app-sidebar { padding: 28px 20px; background: rgba(15, 23, 42, 0.95); border-right: 1px solid rgba(148, 163, 184, 0.15); position: sticky; top: 0; max-height: 100vh; overflow-y: auto; }
        .app-sidebar h2 { margin: 0 0 20px; color: #38bdf8; font-size: 1.1rem; font-weight: 600; letter-spacing: 0.5px; }
        .app-sidebar ul { list-style: none; padding: 0; margin: 0; }
        .app-sidebar ul li { margin: 0 0 8px; }
        .app-sidebar ul li a { display: block; color: #cbd5e1; text-decoration: none; padding: 12px 14px; border-radius: 10px; border: 1px solid transparent; background: rgba(30, 41, 59, 0.5); transition: all 0.2s; font-size: 0.95rem; }
        .app-sidebar ul li a:hover { background: rgba(56, 189, 248, 0.15); color: #38bdf8; border-color: rgba(56, 189, 248, 0.3); }
        .page { padding: 0; display: flex; flex-direction: column; }
        .top-bar { background: rgba(15, 23, 42, 0.7); backdrop-filter: blur(10px); border-bottom: 1px solid rgba(148, 163, 184, 0.1); padding: 20px 32px; display: flex; justify-content: space-between; align-items: center; gap: 24px; }
        .top { flex: 1; }
        .top h1 { margin: 0; font-size: 2rem; font-weight: 700; color: #f8fafc; }
        .welcome { color: #94a3b8; margin-top: 4px; font-size: 0.95rem; }
        .top-actions { display: flex; gap: 12px; align-items: center; }
        .btn { text-decoration: none; color: #f8fafc; border: 1px solid rgba(148, 163, 184, 0.25); padding: 10px 18px; border-radius: 10px; background: rgba(30, 41, 59, 0.7); cursor: pointer; transition: all 0.2s; font-size: 0.9rem; font-weight: 500; }
        .btn:hover { background: rgba(56, 189, 248, 0.1); border-color: rgba(56, 189, 248, 0.4); }
        .btn.primary { color: #0f172a; background: linear-gradient(135deg, #38bdf8, #0284c7); border: none; font-weight: 600; }
        .btn.primary:hover { transform: translateY(-1px); box-shadow: 0 8px 24px rgba(56, 189, 248, 0.3); }
        .content { flex: 1; padding: 32px; overflow-y: auto; }
        .nav { display: flex; gap: 12px; flex-wrap: wrap; margin-bottom: 28px; }
        .panel { margin-bottom: 28px; padding: 24px; border-radius: 16px; border: 1px solid rgba(148, 163, 184, 0.15); background: rgba(30, 41, 59, 0.6); backdrop-filter: blur(10px); }
        .panel h2 { margin: 0 0 18px; font-size: 1.3rem; color: #f8fafc; font-weight: 600; }
        .grid { display: grid; gap: 18px; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); margin-bottom: 0; }
        .card { padding: 22px; border-radius: 14px; border: 1px solid rgba(148, 163, 184, 0.12); background: rgba(15, 23, 42, 0.8); transition: all 0.3s; }
        .card:hover { transform: translateY(-2px); border-color: rgba(56, 189, 248, 0.3); background: rgba(15, 23, 42, 0.95); }
        .card h3 { margin: 0 0 10px; font-size: 1.05rem; color: #f8fafc; }
        .card p { margin: 0; color: #94a3b8; line-height: 1.6; font-size: 0.9rem; }
        table { width: 100%; border-collapse: collapse; }
        table th, table td { padding: 14px 12px; border: 1px solid rgba(148, 163, 184, 0.1); text-align: left; }
        table th { color: #cbd5e1; font-weight: 600; background: rgba(30, 41, 59, 0.5); }
        table td { color: #e2e8f0; }
        table tbody tr:hover { background: rgba(56, 189, 248, 0.08); }
    </style>
</head>
<body>
    <div class="layout">
        <jsp:include page="/includes/sidebar.jsp" />
        <div class="page">
            <div class="top-bar">
                <div class="top">
                    <h1>Timetabling Admin Dashboard</h1>
                    <p class="welcome">Welcome, <strong><%= user.getFullName() %></strong> | <%= user.getRole() %></p>
                </div>
                <div class="top-actions">
                    <a class="btn primary" href="<%= request.getContextPath() %>/logout">Logout</a>
                </div>
            </div>
            <div class="content">
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
                    <tr><td>Submitted requirements</td><td>${summary.metricOne}</td></tr>
                    <tr><td>Pending allocations</td><td>${summary.metricTwo}</td></tr>
                    <tr><td>Open feedback issues</td><td>${summary.metricThree}</td></tr>
                    <tr><td>Finalized timetable entries</td><td>${summary.metricFour}</td></tr>
                </tbody>
            </table>
        </div>
        </div>
    </div>
    <jsp:include page="/includes/cookieConsent.jsp" />
</body>
</html>



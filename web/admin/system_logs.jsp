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
    <title>System Logs</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #0f172a; color: #e2e8f0; }
        .page { max-width: 1180px; margin: 0 auto; padding: 32px; }
        .topbar { display: flex; justify-content: space-between; align-items: center; }
        .card { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 24px; margin-top: 24px; }
        table { width: 100%; border-collapse: collapse; margin-top: 18px; }
        th, td { padding: 14px 12px; border-bottom: 1px solid #334155; }
        th { text-align: left; }
        a { color: #38bdf8; text-decoration: none; }
        .status { font-size: 0.9rem; color: #94a3b8; }
    </style>
</head>
<body>
    <%@ include file="/includes/header.jsp" %>
    <%@ include file="/includes/navbar.jsp" %>
    <div class="page">
        <div class="topbar">
            <div>
                <h1>System Logs</h1>
                <p>Review recent platform activity and key audit events.</p>
            </div>
            <div><a href="<%= request.getContextPath() %>/admin/dashboard.jsp">Back to dashboard</a></div>
        </div>

        <div class="card">
            <h2>Recent Activity</h2>
            <table>
                <thead>
                    <tr><th>Time</th><th>User</th><th>Action</th><th>Status</th></tr>
                </thead>
                <tbody>
                    <tr><td>11:45 AM</td><td>admin@uniflow.local</td><td>Created user timetable@uniflow.local</td><td class="status">Success</td></tr>
                    <tr><td>10:12 AM</td><td>cod@uniflow.local</td><td>Submitted course requirement</td><td class="status">Success</td></tr>
                    <tr><td>09:55 AM</td><td>classrep@uniflow.local</td><td>Reported scheduling conflict</td><td class="status">Pending</td></tr>
                </tbody>
            </table>
        </div>
    </div>
    <%@ include file="/includes/footer.jsp" %>
</body>
</html>

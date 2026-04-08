<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"COD".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>COD Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #0f172a; color: #e2e8f0; }
        .page { max-width: 1180px; margin: 0 auto; padding: 32px; }
        header { display: flex; justify-content: space-between; align-items: center; }
        .card { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 24px; margin-top: 24px; }
        .nav { display: flex; gap: 14px; flex-wrap: wrap; margin-top: 18px; }
        .nav a { background: #1e293b; padding: 10px 16px; border-radius: 12px; color: #e2e8f0; text-decoration:none; }
        table { width: 100%; border-collapse: collapse; margin-top: 18px; }
        th, td { padding: 12px 10px; border-bottom: 1px solid #334155; }
    </style>
</head>
<body>
    <div class="page">
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
        </div>
    </div>
</body>
</html>

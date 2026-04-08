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
    <title>Manage Requests</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #0f172a; color: #e2e8f0; }
        .page { max-width: 980px; margin: 0 auto; padding: 32px; }
        .card { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 24px; }
        table { width: 100%; border-collapse: collapse; margin-top: 18px; }
        th, td { padding: 14px 12px; border-bottom: 1px solid #334155; }
        th { text-align: left; }
        a { color: #38bdf8; text-decoration:none; }
        button { padding:10px 14px; border-radius:12px; border:1px solid #334155; background:#0f172a; color:#e2e8f0; }
    </style>
</head>
<body>
    <div class="page">
        <div>
            <h1>Manage Cross-Department Requests</h1>
            <p>Review and coordinate requests from other departments.</p>
            <p><a href="dashboard.jsp">Back to dashboard</a></p>
        </div>
        <div class="card">
            <table>
                <thead>
                    <tr><th>Request</th><th>Department</th><th>Status</th><th>Action</th></tr>
                </thead>
                <tbody>
                    <tr><td>Extra lab hours</td><td>Engineering</td><td>Open</td><td><button type="button">Review</button></td></tr>
                    <tr><td>Shared venue</td><td>Business</td><td>Assigned</td><td><button type="button">Review</button></td></tr>
                    <tr><td>Multi-section course</td><td>Science</td><td>Pending</td><td><button type="button">Review</button></td></tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

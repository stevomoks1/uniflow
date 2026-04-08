<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"Class Representative".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Report Issue</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #0f172a; color: #e2e8f0; }
        .page { max-width: 980px; margin: 0 auto; padding: 32px; }
        .card { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 24px; }
        label { display: block; margin-bottom: 16px; color: #cbd5e1; }
        input, select, textarea, button { width: 100%; border-radius: 12px; border: 1px solid #334155; background: #0f172a; color: #e2e8f0; padding: 12px; }
        button { max-width: 220px; }
        a { color: #38bdf8; text-decoration: none; }
    </style>
</head>
<body>
    <div class="page">
        <div>
            <h1>Report an Issue</h1>
            <p>Log a classroom or campus issue with priority and details.</p>
            <p><a href="dashboard.jsp">Back to dashboard</a></p>
        </div>
        <div class="card">
            <form>
                <label>Issue title<input type="text" placeholder="Overcrowding in Lab 3" /></label>
                <label>Category<select><option>Overcrowding</option><option>Equipment failure</option><option>Safety</option><option>Other</option></select></label>
                <label>Priority<select><option>Urgent</option><option>Normal</option></select></label>
                <label>Description<textarea rows="6" placeholder="Describe the issue in detail..."></textarea></label>
                <button type="button">Submit issue</button>
            </form>
        </div>
    </div>
</body>
</html>

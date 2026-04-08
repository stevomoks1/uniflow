<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"Class Representative".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
<<<<<<< HEAD
    String cp = request.getContextPath();
    String status = request.getParameter("status");
=======
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
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
<<<<<<< HEAD
        .flash { margin: 16px 0; padding: 12px 14px; border-radius: 12px; border: 1px solid #334155; }
        .success { background: rgba(22, 101, 52, 0.22); border-color: #166534; }
        .error { background: rgba(127, 29, 29, 0.24); border-color: #7f1d1d; }
=======
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
    </style>
</head>
<body>
    <div class="page">
        <div>
            <h1>Report an Issue</h1>
            <p>Log a classroom or campus issue with priority and details.</p>
<<<<<<< HEAD
            <p><a href="<%= cp %>/dashboard">Back to dashboard</a></p>
        </div>
        <% if ("success".equals(status)) { %>
        <div class="flash success">Issue submitted successfully.</div>
        <% } else if ("error".equals(status)) { %>
        <div class="flash error">Unable to submit issue. Check required fields and retry.</div>
        <% } %>
        <div class="card">
            <form action="<%= cp %>/RequirementServlet" method="post">
                <input type="hidden" name="action" value="reportIssue" />
                <label>Academic year<input type="text" name="academicYear" placeholder="2026/2027" required /></label>
                <label>Semester
                    <select name="semester" required>
                        <option value="Semester 1">Semester 1</option>
                        <option value="Semester 2">Semester 2</option>
                        <option value="Semester 3">Semester 3</option>
                    </select>
                </label>
                <label>Issue title<input type="text" name="issueTitle" placeholder="Overcrowding in Lab 3" required /></label>
                <label>Category<select name="category" required><option>Overcrowding</option><option>Equipment failure</option><option>Safety</option><option>Other</option></select></label>
                <label>Priority<select name="priority" required><option>Urgent</option><option>Normal</option></select></label>
                <label>Description<textarea name="description" rows="6" placeholder="Describe the issue in detail..." required></textarea></label>
                <button type="submit">Submit issue</button>
=======
            <p><a href="dashboard.jsp">Back to dashboard</a></p>
        </div>
        <div class="card">
            <form>
                <label>Issue title<input type="text" placeholder="Overcrowding in Lab 3" /></label>
                <label>Category<select><option>Overcrowding</option><option>Equipment failure</option><option>Safety</option><option>Other</option></select></label>
                <label>Priority<select><option>Urgent</option><option>Normal</option></select></label>
                <label>Description<textarea rows="6" placeholder="Describe the issue in detail..."></textarea></label>
                <button type="button">Submit issue</button>
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
            </form>
        </div>
    </div>
</body>
</html>

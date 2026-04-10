<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Models.WorkflowDAO"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"Class Representative".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<WorkflowDAO.RequirementRecord> requirements = WorkflowDAO.listRequirements();
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
            <p>Flow step 4: Class reps provide feedback on draft timetable issues.</p>
            <p><a href="<%= request.getContextPath() %>/classrep/dashboard.jsp">Back to dashboard</a></p>
            <% if (request.getParameter("success") != null) { %><p style="color:#86efac;">Issue submitted.</p><% } %>
            <% if (request.getParameter("error") != null) { %><p style="color:#fca5a5;">Please complete all required fields.</p><% } %>
        </div>
        <div class="card">
            <form method="post" action="<%= request.getContextPath() %>/RequirementServlet">
                <input type="hidden" name="action" value="reportIssue" />
                <label>Related requirement (optional)
                    <select name="requirementId">
                        <option value="">General issue</option>
                        <% for (WorkflowDAO.RequirementRecord r : requirements) { %>
                        <option value="<%= r.id %>">#<%= r.id %> - <%= r.courseCode %> - <%= r.status %></option>
                        <% } %>
                    </select>
                </label>
                <label>Issue title<input name="issueTitle" type="text" placeholder="Overcrowding in Lab 3" required /></label>
                <label>Category<select name="category" required><option>Overcrowding</option><option>Equipment failure</option><option>Clash</option><option>Safety</option><option>Other</option></select></label>
                <label>Priority<select name="priority" required><option>High</option><option>Normal</option><option>Low</option></select></label>
                <label>Description<textarea name="description" rows="6" placeholder="Describe the issue in detail..." required></textarea></label>
                <button type="submit">Submit issue</button>
            </form>
        </div>
    </div>
</body>
</html>

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
    <title>Submit Requirements</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #0f172a; color: #e2e8f0; }
        .page { max-width: 980px; margin: 0 auto; padding: 32px; }
        .card { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 24px; }
        .form-grid { display:grid; gap:16px; grid-template-columns: 1fr 1fr; }
        label { display:block; color: #cbd5e1; }
        input, select, textarea, button { width:100%; border-radius: 12px; border:1px solid #334155; background: #0f172a; color: #e2e8f0; padding:12px; }
        button { max-width: 200px; }
        a { color: #38bdf8; text-decoration:none; }
    </style>
</head>
<body>
    <div class="page">
        <div>
            <h1>Submit Course Requirements</h1>
            <p>Flow step 1: COD submits course, lecturer, number of students, and special needs.</p>
            <p><a href="<%= request.getContextPath() %>/cod/dashboard.jsp">Back to dashboard</a></p>
            <% if (request.getParameter("success") != null) { %>
            <p style="color:#86efac;">Requirement submitted. Timetabling team can now consolidate this data.</p>
            <% } %>
            <% if (request.getParameter("error") != null) { %>
            <p style="color:#fca5a5;">Please complete all required fields correctly.</p>
            <% } %>
        </div>
        <div class="card">
            <form method="post" action="<%= request.getContextPath() %>/RequirementServlet">
                <input type="hidden" name="action" value="submitRequirement" />
                <div class="form-grid">
                    <label>Course code<input name="courseCode" type="text" placeholder="CS101" required /></label>
                    <label>Lecturer name<input name="lecturerName" type="text" placeholder="Dr. A. Mensah" required /></label>
                    <label>Number of students<input name="studentCount" type="number" min="1" placeholder="120" required /></label>
                    <label>Special needs<textarea name="specialNeeds" rows="6" placeholder="Lab computers, projector, accessibility support, etc."></textarea></label>
                </div>
                <button type="submit" style="margin-top:18px;">Submit requirement</button>
            </form>
        </div>
    </div>
</body>
</html>

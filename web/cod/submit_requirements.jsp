<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"COD".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    String cp = request.getContextPath();
    String status = request.getParameter("status");
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
        .flash { margin: 16px 0; padding: 12px 14px; border-radius: 12px; border: 1px solid #334155; }
        .success { background: rgba(22, 101, 52, 0.22); border-color: #166534; }
        .error { background: rgba(127, 29, 29, 0.24); border-color: #7f1d1d; }
    </style>
</head>
<body>
    <div class="page">
        <div>
            <h1>Submit Course Requirements</h1>
            <p>Use this form to capture course needs, student counts, and resource requests.</p>
            <p><a href="<%= cp %>/dashboard">Back to dashboard</a></p>
        </div>
        <% if ("success".equals(status)) { %>
        <div class="flash success">Requirement submitted successfully.</div>
        <% } else if ("error".equals(status)) { %>
        <div class="flash error">Unable to submit requirement. Check your input and try again.</div>
        <% } %>
        <div class="card">
            <form action="<%= cp %>/RequirementServlet" method="post">
                <input type="hidden" name="action" value="submitRequirement" />
                <div class="form-grid">
                    <label>Academic year<input type="text" name="academicYear" placeholder="2026/2027" required /></label>
                    <label>Semester
                        <select name="semester" required>
                            <option value="Semester 1">Semester 1</option>
                            <option value="Semester 2">Semester 2</option>
                            <option value="Semester 3">Semester 3</option>
                        </select>
                    </label>
                    <label>Template option
                        <select name="templateMode" required>
                            <option value="new">Start new template</option>
                            <option value="previous">Use previous semester template</option>
                        </select>
                    </label>
                    <label>Previous semester template (optional)
                        <select name="sourceTemplate">
                            <option value="">Select previous template</option>
                            <option value="2025/2026-Semester 1">2025/2026 - Semester 1</option>
                            <option value="2025/2026-Semester 2">2025/2026 - Semester 2</option>
                            <option value="2024/2025-Semester 2">2024/2025 - Semester 2</option>
                        </select>
                    </label>
                    <label>Course code<input type="text" name="courseCode" placeholder="CS101" required /></label>
                    <label>Lecturer name<input type="text" name="lecturerName" placeholder="Dr. Njoroge" required /></label>
                    <label>Enrollment estimate<input type="number" name="studentCount" placeholder="120" min="1" required /></label>
                    <label>Special needs<input type="text" name="specialNeeds" placeholder="Projector, PA system" /></label>
                    <label colspan="2">Notes<textarea name="notes" rows="6" placeholder="Enter requirements details..."></textarea></label>
                </div>
                <button type="submit" style="margin-top:18px;">Submit requirement</button>
            </form>
        </div>
    </div>
</body>
</html>

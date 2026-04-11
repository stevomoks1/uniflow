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
        * { box-sizing: border-box; }
        body { margin: 0; font-family: 'Segoe UI', system-ui, -apple-system, sans-serif; background: linear-gradient(135deg, #0f172a 0%, #1a2940 100%); color: #e2e8f0; min-height: 100vh; }
        .layout { display: grid; grid-template-columns: 280px 1fr; min-height: 100vh; }
        .app-sidebar { padding: 28px 20px; background: rgba(15,23,42,0.95); border-right: 1px solid rgba(148,163,184,0.15); position: sticky; top: 0; max-height: 100vh; overflow-y: auto; }
        .app-sidebar h2 { margin: 0 0 20px; color: #38bdf8; font-size: 1.1rem; font-weight: 600; letter-spacing: 0.5px; }
        .app-sidebar ul { list-style: none; padding: 0; margin: 0; }
        .app-sidebar ul li { margin: 0 0 8px; }
        .app-sidebar ul li a { display: block; color: #cbd5e1; text-decoration: none; padding: 12px 14px; border-radius: 12px; border: 1px solid transparent; background: rgba(30,41,59,0.6); transition: all 0.2s; }
        .app-sidebar ul li a:hover { background: rgba(56,189,248,0.15); color: #38bdf8; border-color: rgba(56,189,248,0.35); }
        .page { display: flex; flex-direction: column; }
        .app-header { display: flex; justify-content: space-between; align-items: center; padding: 24px 32px; background: rgba(15,23,42,0.7); border-bottom: 1px solid rgba(148,163,184,0.12); }
        .brand a { color: #38bdf8; text-decoration: none; font-size: 1.2rem; font-weight: 700; }
        .header-actions { display:flex; gap:12px; align-items:center; }
        .button { display: inline-flex; align-items:center; justify-content:center; text-decoration:none; color: #e2e8f0; padding: 10px 16px; border-radius: 12px; border: 1px solid rgba(148,163,184,0.2); background: rgba(30,41,59,0.75); transition: all 0.2s; }
        .button:hover { background: rgba(56,189,248,0.12); }
        .button.primary { background: linear-gradient(135deg, #38bdf8, #0284c7); color: #0f172a; border: none; }
        .content { padding: 32px; }
        .page-title { margin: 0 0 12px; font-size: 2.25rem; line-height: 1.1; }
        .page-description { margin: 0 0 24px; color: #94a3b8; max-width: 860px; }
        .actions { display: flex; flex-wrap: wrap; gap: 12px; margin-bottom: 22px; }
        .card { background: rgba(15,23,42,0.8); border: 1px solid rgba(148,163,184,0.14); border-radius: 20px; padding: 28px; box-shadow: 0 20px 50px rgba(0,0,0,0.12); margin-bottom: 24px; }
        .card h2 { margin-top: 0; font-size: 1.4rem; }
        .form-grid { display: grid; gap: 18px; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); }
        label { display: flex; flex-direction: column; color: #cbd5e1; font-size: 0.95rem; }
        input, select, textarea { width: 100%; border: 1px solid rgba(148,163,184,0.25); border-radius: 14px; background: rgba(15,23,42,0.9); color: #e2e8f0; padding: 14px; margin-top: 10px; font-size: 0.95rem; }
        textarea { resize: vertical; min-height: 100px; }
        .flash { padding: 14px 18px; border-radius: 14px; margin-bottom: 24px; font-weight: 600; }
        .flash.success { background: rgba(16,185,129,0.18); color: #a7f3d0; }
        .flash.error { background: rgba(248,113,113,0.18); color: #fecaca; }
        table { width: 100%; border-collapse: collapse; margin-top: 18px; }
        th, td { padding: 14px 12px; border-bottom: 1px solid rgba(148,163,184,0.12); }
        th { color: #cbd5e1; font-weight: 600; background: rgba(30,41,59,0.7); text-align: left; }
        tbody tr:hover { background: rgba(56,189,248,0.08); }
    </style>
</head>
<body>
    <div class="layout">
        <%@ include file="/includes/sidebar.jsp" %>
        <div class="page">
            <div class="app-header">
                <div class="brand"><a href="${pageContext.request.contextPath}/dashboard">UniFlow</a></div>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/logout" class="button">Logout</a>
                </div>
            </div>
            <div class="content">
                <h1 class="page-title">Submit Course Requirements</h1>
                <p class="page-description">Flow step 1: COD submits course, lecturer, number of students, and special needs.</p>
                <% if (request.getParameter("success") != null) { %>
                <div class="flash success">Requirement submitted. Timetabling team can now consolidate this data.</div>
                <% } %>
                <% if (request.getParameter("error") != null) { %>
                <div class="flash error">Please complete all required fields correctly.</div>
                <% } %>
                <div class="card">
                    <form method="post" action="<%= request.getContextPath() %>/RequirementServlet">
                        <input type="hidden" name="action" value="submitRequirement" />
                        <div class="form-grid">
                            <label>Academic year<input name="academicYear" type="text" placeholder="2026/2027" required /></label>
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
                            <label>Course code<input name="courseCode" type="text" placeholder="CS101" required /></label>
                            <label>Lecturer name<input name="lecturerName" type="text" placeholder="Dr. Njoroge" required /></label>
                            <label>Enrollment estimate<input name="studentCount" type="number" min="1" placeholder="120" required /></label>
                            <label>Special needs<input name="specialNeeds" type="text" placeholder="Projector, PA system" /></label>
                            <label style="grid-column: 1 / -1;">Notes<textarea name="notes" rows="6" placeholder="Enter requirements details..."></textarea></label>
                        </div>
                        <button type="submit" class="button primary" style="margin-top:18px;">Submit requirement</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html><%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <%@ include file="/includes/header.jsp" %>
    <%@ include file="/includes/navbar.jsp" %>
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
    <%@ include file="/includes/footer.jsp" %>
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



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
            <p>Use this form to capture course needs, student counts, and resource requests.</p>
            <p><a href="dashboard.jsp">Back to dashboard</a></p>
        </div>
        <div class="card">
            <form>
                <div class="form-grid">
                    <label>Course code<input type="text" placeholder="CS101" /></label>
                    <label>Semester<select><option>Fall</option><option>Spring</option><option>Summer</option></select></label>
                    <label>Enrollment estimate<input type="number" placeholder="120" /></label>
                    <label>Preferred venue<select><option>Lecture Hall</option><option>Computer Lab</option></select></label>
                    <label colspan="2">Notes<textarea rows="6" placeholder="Enter requirements details..."></textarea></label>
                </div>
                <button type="button" style="margin-top:18px;">Submit requirement</button>
            </form>
        </div>
    </div>
</body>
</html>

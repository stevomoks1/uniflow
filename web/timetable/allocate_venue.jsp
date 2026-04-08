<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"Timetabling Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Allocate Venue</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #0f172a; color: #e2e8f0; }
        .page { max-width: 1180px; margin: 0 auto; padding: 32px; }
        .card { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 24px; margin-top: 24px; }
        input, select, button { width: 100%; border: 1px solid #334155; border-radius: 12px; background: #0f172a; color: #e2e8f0; padding: 12px; margin-top: 12px; }
        a { color: #38bdf8; text-decoration: none; }
        .form-grid { display:grid; gap:16px; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); }
    </style>
</head>
<body>
    <div class="page">
        <div>
            <h1>Allocate Venue</h1>
            <p>Select a course requirement and assign a room and timeslot.</p>
            <p><a href="dashboard.jsp">Back to dashboard</a></p>
        </div>

        <div class="card">
            <form>
                <div class="form-grid">
                    <label>Course request<select><option>CS101 - Lecture</option><option>MATH201 - Tutorial</option></select></label>
                    <label>Venue<select><option>Hall A</option><option>Room 204</option><option>Lab 3</option></select></label>
                    <label>Day<select><option>Monday</option><option>Tuesday</option><option>Wednesday</option></select></label>
                    <label>Time slot<select><option>08:00 - 10:00</option><option>10:30 - 12:30</option><option>14:00 - 16:00</option></select></label>
                </div>
                <button type="button" style="margin-top:16px;">Save allocation</button>
            </form>
        </div>

        <div class="card">
            <h2>Allocation Status</h2>
            <p>Venue assignments will display here once approved.</p>
        </div>
    </div>
</body>
</html>

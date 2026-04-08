<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"Timetabling Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
<<<<<<< HEAD
    String cp = request.getContextPath();
    String[] venues = {
        "PST 1", "PST 2", "PST 3", "PST 4", "PST 5",
        "NPL 1", "NPL 2", "NPL 3", "NPL 4", "NPL 5", "NPL 6",
        "B1", "B2", "B3", "B4", "B5",
        "CB1", "CB2", "CB3", "CB4", "CB5",
        "ED1", "ED2", "ED3", "ED4"
    };
    String status = request.getParameter("status");
=======
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
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
            <h1>Allocate Venue</h1>
            <p>Select a course requirement and assign a room and timeslot.</p>
<<<<<<< HEAD
            <p><a href="<%= cp %>/dashboard">Back to dashboard</a></p>
        </div>
        <% if ("success".equals(status)) { %>
        <div class="flash success">Venue allocation saved successfully.</div>
        <% } else if ("error".equals(status)) { %>
        <div class="flash error">Unable to save allocation. Check required fields and retry.</div>
        <% } %>

        <div class="card">
            <form action="<%= cp %>/RequirementServlet" method="post">
                <input type="hidden" name="action" value="allocateVenue" />
                <div class="form-grid">
                    <label>Academic year<input type="text" name="academicYear" placeholder="2026/2027" required /></label>
                    <label>Semester
                        <select name="semester" required>
                            <option value="Semester 1">Semester 1</option>
                            <option value="Semester 2">Semester 2</option>
                            <option value="Semester 3">Semester 3</option>
                        </select>
                    </label>
                    <label>Course request<input type="text" name="courseRequest" placeholder="CS101 - Lecture" required /></label>
                    <label>Venue
                        <select name="venue" required>
                            <option value="">Select venue</option>
                            <% for (String venue : venues) { %>
                            <option value="<%= venue %>"><%= venue %></option>
                            <% } %>
                        </select>
                    </label>
                    <label>Day<select name="day" required><option>Monday</option><option>Tuesday</option><option>Wednesday</option><option>Thursday</option><option>Friday</option></select></label>
                    <label>Time slot<select name="timeSlot" required><option>08:00 - 10:00</option><option>10:30 - 12:30</option><option>14:00 - 16:00</option></select></label>
                </div>
                <button type="submit" style="margin-top:16px;">Save allocation</button>
=======
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
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
            </form>
        </div>

        <div class="card">
            <h2>Allocation Status</h2>
            <p>Venue assignments will display here once approved.</p>
        </div>
    </div>
</body>
</html>

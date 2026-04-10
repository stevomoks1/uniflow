<%@page contentType="text/html" pageEncoding="UTF-8"%>
<<<<<<< HEAD
<%@page import="java.util.List"%>
<%@page import="Models.WorkflowDAO"%>
=======
<<<<<<< HEAD
<%@page import="java.util.List"%>
<%@page import="Models.WorkflowDAO"%>
=======
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"Timetabling Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
<<<<<<< HEAD
    List<WorkflowDAO.RequirementRecord> requirements = WorkflowDAO.listRequirements();
=======
<<<<<<< HEAD
    List<WorkflowDAO.RequirementRecord> requirements = WorkflowDAO.listRequirements();
=======
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
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
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
    </style>
</head>
<body>
    <%@ include file="/includes/header.jsp" %>
    <%@ include file="/includes/navbar.jsp" %>
=======
<<<<<<< HEAD
    </style>
</head>
<body>
<div class="app-layout">
<%@ include file="../sidebar.jsp" %>
<div class="app-main">
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
    <div class="page">
        <div>
            <h1>Allocate Venue</h1>
            <p>Flow step 2-3: Directorate consolidates requirements and releases draft timetable for feedback (Week 1).</p>
            <p><a href="<%= request.getContextPath() %>/timetable/dashboard.jsp">Back to dashboard</a></p>
            <% if (request.getParameter("success") != null) { %><p style="color:#86efac;">Draft released successfully.</p><% } %>
            <% if (request.getParameter("error") != null) { %><p style="color:#fca5a5;">Please fill all draft fields.</p><% } %>
        </div>

        <div class="card">
            <form method="post" action="<%= request.getContextPath() %>/RequirementServlet">
                <input type="hidden" name="action" value="releaseDraft" />
                <div class="form-grid">
                    <label>Course requirement
                        <select name="requirementId" required>
                            <option value="">Select requirement</option>
                            <% for (WorkflowDAO.RequirementRecord r : requirements) { %>
                            <option value="<%= r.id %>">#<%= r.id %> - <%= r.courseCode %> (<%= r.studentCount %> students)</option>
                            <% } %>
                        </select>
                    </label>
<<<<<<< HEAD
                    <label>Venue
                        <input name="venue" type="text" list="venueList" placeholder="Select or type venue" required />
                        <datalist id="venueList">
                            <option value="PST1"></option>
                            <option value="PST2"></option>
                            <option value="PST3"></option>
                            <option value="PST4"></option>
                            <option value="PST5"></option>
                            <option value="NPL1"></option>
                            <option value="NPL2"></option>
                            <option value="NPL3"></option>
                            <option value="NPL4"></option>
                            <option value="NPL5"></option>
                            <option value="NPL6"></option>
                            <option value="B1"></option>
                            <option value="B2"></option>
                            <option value="B3"></option>
                            <option value="B4"></option>
                            <option value="B5"></option>
                            <option value="ED1"></option>
                            <option value="ED2"></option>
                            <option value="ED3"></option>
                            <option value="ED4"></option>
                            <option value="ED5"></option>
                            <option value="CB1"></option>
                            <option value="CB2"></option>
                            <option value="CB3"></option>
                            <option value="CB4"></option>
                            <option value="CB5"></option>
                        </datalist>
                    </label>
=======
                    <label>Venue<input name="venue" type="text" placeholder="Hall A" required /></label>
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
                    <label>Day<select name="dayOfWeek" required><option>Monday</option><option>Tuesday</option><option>Wednesday</option><option>Thursday</option><option>Friday</option></select></label>
                    <label>Time slot<input name="timeSlot" type="text" placeholder="08:00 - 10:00" required /></label>
                    <label>Week 2 adjustment note (optional)<textarea name="adjustmentNote" rows="3" placeholder="If this is adjusted after feedback, describe update."></textarea></label>
                </div>
                <button type="submit" style="margin-top:16px;">Release draft timetable</button>
<<<<<<< HEAD
=======
=======
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
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
            </form>
        </div>

        <div class="card">
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
            <h2>Consolidated Requirements</h2>
            <table style="width:100%; border-collapse: collapse; margin-top: 12px;">
                <thead>
                    <tr><th style="text-align:left; border-bottom:1px solid #334155; padding:8px;">Course</th><th style="text-align:left; border-bottom:1px solid #334155; padding:8px;">Lecturer</th><th style="text-align:left; border-bottom:1px solid #334155; padding:8px;">Students</th><th style="text-align:left; border-bottom:1px solid #334155; padding:8px;">Status</th></tr>
                </thead>
                <tbody>
                    <% if (requirements.isEmpty()) { %>
                    <tr><td colspan="4" style="padding:8px;">No requirements submitted yet.</td></tr>
                    <% } else { for (WorkflowDAO.RequirementRecord r : requirements) { %>
                    <tr>
                        <td style="padding:8px; border-bottom:1px solid #334155;"><%= r.courseCode %></td>
                        <td style="padding:8px; border-bottom:1px solid #334155;"><%= r.lecturerName %></td>
                        <td style="padding:8px; border-bottom:1px solid #334155;"><%= r.studentCount %></td>
                        <td style="padding:8px; border-bottom:1px solid #334155;"><%= r.status %></td>
                    </tr>
                    <% }} %>
                </tbody>
            </table>
        </div>
    </div>
<<<<<<< HEAD
    <%@ include file="/includes/footer.jsp" %>
=======
</div>
</div>
=======
            <h2>Allocation Status</h2>
            <p>Venue assignments will display here once approved.</p>
        </div>
    </div>
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
</body>
</html>

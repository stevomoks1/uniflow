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
=======
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Manage Schedule</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #0f172a; color: #e2e8f0; }
        .page { max-width: 1180px; margin: 0 auto; padding: 32px; }
        .card { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 24px; margin-top: 24px; }
        .timetable { width: 100%; border-collapse: collapse; margin-top: 18px; }
        .timetable th, .timetable td { border: 1px solid #334155; padding: 12px; }
        th { background: #1e293b; }
        a { color: #38bdf8; text-decoration: none; }
    </style>
</head>
<body>
    <div class="page">
        <div>
            <h1>Manage Schedule</h1>
<<<<<<< HEAD
            <p>Flow step 6: after week-2 adjustments, publish final timetable requirements.</p>
            <p><a href="<%= request.getContextPath() %>/timetable/dashboard.jsp">Back to dashboard</a></p>
            <% if (request.getParameter("success") != null) { %><p style="color:#86efac;">Requirement finalized successfully.</p><% } %>
=======
<<<<<<< HEAD
            <p>Flow step 6: after week-2 adjustments, publish final timetable requirements.</p>
            <p><a href="<%= request.getContextPath() %>/timetable/dashboard.jsp">Back to dashboard</a></p>
            <% if (request.getParameter("success") != null) { %><p style="color:#86efac;">Requirement finalized successfully.</p><% } %>
=======
            <p>Inspect and update the current timetable grid for all venues.</p>
<<<<<<< HEAD
            <p><a href="<%= cp %>/dashboard">Back to dashboard</a></p>
=======
            <p><a href="dashboard.jsp">Back to dashboard</a></p>
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
        </div>

        <div class="card">
            <table class="timetable">
                <thead>
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
                    <tr><th>ID</th><th>Course</th><th>Lecturer</th><th>Venue/Slot</th><th>Status</th><th>Finalize</th></tr>
                </thead>
                <tbody>
                    <% if (requirements.isEmpty()) { %>
                    <tr><td colspan="6">No requirements available yet.</td></tr>
                    <% } else { for (WorkflowDAO.RequirementRecord r : requirements) { %>
                    <tr>
                        <td><%= r.id %></td>
                        <td><%= r.courseCode %></td>
                        <td><%= r.lecturerName %></td>
                        <td><%= (r.venue == null ? "-" : r.venue) %> / <%= (r.dayOfWeek == null ? "-" : r.dayOfWeek) %> / <%= (r.timeSlot == null ? "-" : r.timeSlot) %></td>
                        <td><%= r.status %></td>
                        <td>
                            <% if (!"FINALIZED".equals(r.status)) { %>
                            <form method="post" action="<%= request.getContextPath() %>/RequirementServlet">
                                <input type="hidden" name="action" value="finalizeRequirement" />
                                <input type="hidden" name="requirementId" value="<%= r.id %>" />
                                <input type="text" name="finalNote" placeholder="Finalization note" />
                                <button type="submit">Finalize</button>
                            </form>
                            <% } else { %>
                            Published
                            <% } %>
                        </td>
                    </tr>
                    <% }} %>
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
                    <tr><th>Venue</th><th>Current Allocation</th><th>Status</th></tr>
                </thead>
                <tbody>
                    <% for (String venue : venues) { %>
                    <tr>
                        <td><%= venue %></td>
                        <td>-</td>
                        <td>Awaiting live schedule data</td>
                    </tr>
                    <% } %>
=======
                    <tr><th>Time</th><th>Monday</th><th>Tuesday</th><th>Wednesday</th><th>Thursday</th><th>Friday</th></tr>
                </thead>
                <tbody>
                    <tr><td>08:00-10:00</td><td>CS101 - Hall A</td><td>MATH201 - Room 204</td><td>ENG301 - Lab 3</td><td>FREE</td><td>PHYS110 - Hall B</td></tr>
                    <tr><td>10:30-12:30</td><td>HIST220 - Room 101</td><td>FREE</td><td>CHEM150 - Lab 4</td><td>CS101 - Hall A</td><td>FREE</td></tr>
                    <tr><td>14:00-16:00</td><td>FREE</td><td>CS301 - Hall A</td><td>FREE</td><td>ECON110 - Room 203</td><td>SOC120 - Room 205</td></tr>
>>>>>>> 9c3c207d0856dc0a452a5f7256f575f923bdd52b
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
>>>>>>> 18b08055af7c0f466d3c5b5aca7aea5ac98397d5
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

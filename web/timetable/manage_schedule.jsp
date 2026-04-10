<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Models.WorkflowDAO"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"Timetabling Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<WorkflowDAO.RequirementRecord> requirements = WorkflowDAO.listRequirements();
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
    <%@ include file="/includes/header.jsp" %>
    <%@ include file="/includes/navbar.jsp" %>
    <div class="page">
        <div>
            <h1>Manage Schedule</h1>
            <p>Flow step 6: after week-2 adjustments, publish final timetable requirements.</p>
            <p><a href="<%= request.getContextPath() %>/timetable/dashboard.jsp">Back to dashboard</a></p>
            <p><a href="<%= request.getContextPath() %>/timetable/draft_timetable_week2.jsp">Open week 2 draft timetable</a></p>
            <p><a href="<%= request.getContextPath() %>/timetable/final_timetable.jsp">Open printable final timetable</a></p>
            <% if (request.getParameter("success") != null) { %><p style="color:#86efac;">Requirement finalized successfully.</p><% } %>
        </div>

        <div class="card">
            <table class="timetable">
                <thead>
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
                </tbody>
            </table>
        </div>
    </div>
    <%@ include file="/includes/footer.jsp" %>
</body>
</html>



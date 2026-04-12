<%
    String role = null;
    if (session != null) {
        role = (String) session.getAttribute("role");
    }
%>
<div class="app-sidebar">
    <h2>Quick links</h2>
    <ul>
        <li><a href="<%= request.getContextPath() %>/dashboard">Home</a></li>
        <% if (role != null && role.equals("System Admin")) { %>
            <li><a href="<%= request.getContextPath() %>/admin/manage_users.jsp">Manage Users</a></li>
            <li><a href="<%= request.getContextPath() %>/admin/system_logs.jsp">System Logs</a></li>
        <% } else if (role != null && role.equals("Timetabling Admin")) { %>
            <li><a href="<%= request.getContextPath() %>/timetableadmin/allocate_venue.jsp">Allocate Venue</a></li>
            <li><a href="<%= request.getContextPath() %>/timetableadmin/manage_schedule.jsp">Manage Schedule</a></li>
            <li><a href="<%= request.getContextPath() %>/timetableadmin/view_issues.jsp">View Issues</a></li>
            <li><a href="<%= request.getContextPath() %>/timetableadmin/draft_requirements_week2.jsp">Week 2 Draft</a></li>
            <li><a href="<%= request.getContextPath() %>/timetableadmin/final_rquirements.jsp">Final Requirements</a></li>
        <% } else if (role != null && role.equals("COD")) { %>
            <li><a href="<%= request.getContextPath() %>/cod/submit_requirements.jsp">Submit Requirements</a></li>
            <li><a href="<%= request.getContextPath() %>/cod/edit_requirements.jsp">Edit Requirements</a></li>
            <li><a href="<%= request.getContextPath() %>/cod/manage_requests.jsp">Manage Requests</a></li>
        <% } else if (role != null && role.equals("Class Representative")) { %>
            <li><a href="<%= request.getContextPath() %>/classRep/report_issue.jsp">Report Issue</a></li>
            <li><a href="<%= request.getContextPath() %>/classRep/track_issue.jsp">Track Issue</a></li>
        <% } %>
    </ul>
</div>

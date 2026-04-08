<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String role = session.getAttribute("role") == null ? "" : (String) session.getAttribute("role");
%>
<div class="app-sidebar">
    <h2>Quick links</h2>
    <ul>
        <li><a href="<%= request.getContextPath() %>/dashboard">Home</a></li>
        <% if ("System Admin".equals(role)) { %>
            <li><a href="<%= request.getContextPath() %>/admin/manage_users.jsp">Manage Users</a></li>
            <li><a href="<%= request.getContextPath() %>/admin/system_logs.jsp">System Logs</a></li>
        <% } else if ("Timetabling Admin".equals(role)) { %>
            <li><a href="<%= request.getContextPath() %>/timetable/allocate_venue.jsp">Allocate Venue</a></li>
            <li><a href="<%= request.getContextPath() %>/timetable/manage_schedule.jsp">Manage Schedule</a></li>
            <li><a href="<%= request.getContextPath() %>/timetable/view_issues.jsp">View Issues</a></li>
        <% } else if ("COD".equals(role)) { %>
            <li><a href="<%= request.getContextPath() %>/cod/submit_requirements.jsp">Submit Requirements</a></li>
            <li><a href="<%= request.getContextPath() %>/cod/edit_requirements.jsp">Edit Requirements</a></li>
            <li><a href="<%= request.getContextPath() %>/cod/manage_requests.jsp">Manage Requests</a></li>
        <% } else if ("Class Representative".equals(role)) { %>
            <li><a href="<%= request.getContextPath() %>/classrep/report_issue.jsp">Report Issue</a></li>
            <li><a href="<%= request.getContextPath() %>/classrep/track_issue.jsp">Track Issue</a></li>
        <% } %>
    </ul>
</div>

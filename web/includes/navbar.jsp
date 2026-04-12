<%
    String navRole = (String) session.getAttribute("role");
%>
<nav class="app-navbar">
    <a href="<%= request.getContextPath() %>/dashboard">Dashboard</a>
    <% if (navRole != null && navRole.equals("System Admin")) { %>
        <a href="<%= request.getContextPath() %>/admin/manage_users.jsp">Users</a>
        <a href="<%= request.getContextPath() %>/admin/system_logs.jsp">Logs</a>
    <% } else if (navRole != null && navRole.equals("Timetabling Admin")) { %>
        <a href="<%= request.getContextPath() %>/timetableadmin/allocate_venue.jsp">Allocate</a>
        <a href="<%= request.getContextPath() %>/timetableadmin/manage_schedule.jsp">Schedule</a>
        <a href="<%= request.getContextPath() %>/timetableadmin/view_issues.jsp">Issues</a>
        <a href="<%= request.getContextPath() %>/timetableadmin/draft_requirements_week2.jsp">Week 2 draft</a>
        <a href="<%= request.getContextPath() %>/timetableadmin/final_rquirements.jsp">Final requirements</a>
    <% } else if (navRole != null && navRole.equals("COD")) { %>
        <a href="<%= request.getContextPath() %>/cod/submit_requirements.jsp">Submit</a>
        <a href="<%= request.getContextPath() %>/cod/edit_requirements.jsp">Edit</a>
        <a href="<%= request.getContextPath() %>/cod/manage_requests.jsp">Requests</a>
    <% } else if (navRole != null && navRole.equals("Class Representative")) { %>
        <a href="<%= request.getContextPath() %>/classRep/report_issue.jsp">Report</a>
        <a href="<%= request.getContextPath() %>/classRep/track_issue.jsp">Track</a>
    <% } %>
</nav>

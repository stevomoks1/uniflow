<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String role = session.getAttribute("role") == null ? "" : (String) session.getAttribute("role");
%>
<nav class="app-navbar">
    <a href="<%= request.getContextPath() %>/dashboard">Dashboard</a>
    <% if ("System Admin".equals(role)) { %>
        <a href="<%= request.getContextPath() %>/admin/manage_users.jsp">Users</a>
        <a href="<%= request.getContextPath() %>/admin/system_logs.jsp">Logs</a>
    <% } else if ("Timetabling Admin".equals(role)) { %>
        <a href="<%= request.getContextPath() %>/timetable/allocate_venue.jsp">Allocate</a>
        <a href="<%= request.getContextPath() %>/timetable/manage_schedule.jsp">Schedule</a>
        <a href="<%= request.getContextPath() %>/timetable/view_issues.jsp">Issues</a>
    <% } else if ("COD".equals(role)) { %>
        <a href="<%= request.getContextPath() %>/cod/submit_requirements.jsp">Submit</a>
        <a href="<%= request.getContextPath() %>/cod/edit_requirements.jsp">Edit</a>
        <a href="<%= request.getContextPath() %>/cod/manage_requests.jsp">Requests</a>
    <% } else if ("Class Representative".equals(role)) { %>
        <a href="<%= request.getContextPath() %>/classrep/report_issue.jsp">Report</a>
        <a href="<%= request.getContextPath() %>/classrep/track_issue.jsp">Track</a>
    <% } %>
</nav>

<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String role = session.getAttribute("role") == null ? "" : (String) session.getAttribute("role");
<<<<<<< HEAD
    String ctx = request.getContextPath();
    String uri = request.getRequestURI();
    if (uri == null) {
        uri = "";
    }
%>
<style>
    .app-layout { display: flex; min-height: 100vh; align-items: stretch; }
    .app-sidebar {
        width: 260px;
        flex-shrink: 0;
        background: #0f172a;
        border-right: 1px solid #334155;
        padding: 24px 16px 32px;
        box-sizing: border-box;
    }
    .app-sidebar .brand {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 20px;
        color: #f8fafc;
        font-weight: 800;
        letter-spacing: 0.06em;
        text-transform: uppercase;
        text-decoration: none;
        font-size: 0.95rem;
    }
    .app-sidebar .logo {
        width: 36px;
        height: 36px;
        border-radius: 12px;
        display: grid;
        place-items: center;
        background: linear-gradient(135deg, #67e8f9, #3b82f6);
        color: #0f172a;
        font-weight: 800;
    }
    .app-sidebar h2 {
        margin: 0 0 12px;
        font-size: 0.72rem;
        letter-spacing: 0.14em;
        text-transform: uppercase;
        color: #64748b;
    }
    .app-sidebar ul { list-style: none; margin: 0; padding: 0; }
    .app-sidebar li { margin: 0 0 6px; }
    .app-sidebar a {
        display: block;
        padding: 10px 12px;
        border-radius: 10px;
        color: #e2e8f0;
        text-decoration: none;
        font-size: 0.95rem;
    }
    .app-sidebar a:hover { background: #1e293b; }
    .app-sidebar a.nav-active { background: #1e293b; border: 1px solid #334155; }
    .app-sidebar .nav-foot {
        margin-top: 24px;
        padding-top: 16px;
        border-top: 1px solid #334155;
        font-size: 0.85rem;
        color: #94a3b8;
    }
    .app-sidebar .nav-foot a { display: inline; padding: 0; color: #38bdf8; }
    .app-main {
        flex: 1;
        min-width: 0;
        background: linear-gradient(145deg, #020617, #0f172a);
        color: #e2e8f0;
    }
</style>
<aside class="app-sidebar">
    <a class="brand" href="<%= ctx %>/dashboard">
        <span class="logo">U</span>
        UniFlow
    </a>
    <h2>Navigation</h2>
    <ul>
        <li><a href="<%= ctx %>/dashboard">Dashboard</a></li>
        <% if ("System Admin".equals(role)) { %>
            <li><a href="<%= ctx %>/admin/dashboard.jsp" class="<%= uri.contains("/admin/dashboard.jsp") ? "nav-active" : "" %>">Admin home</a></li>
            <li><a href="<%= ctx %>/admin/manage_users.jsp" class="<%= uri.contains("manage_users") ? "nav-active" : "" %>">Manage users</a></li>
            <li><a href="<%= ctx %>/admin/system_logs.jsp" class="<%= uri.contains("system_logs") ? "nav-active" : "" %>">System logs</a></li>
        <% } else if ("Timetabling Admin".equals(role)) { %>
            <li><a href="<%= ctx %>/timetable/dashboard.jsp" class="<%= uri.contains("/timetable/dashboard.jsp") ? "nav-active" : "" %>">Timetable home</a></li>
            <li><a href="<%= ctx %>/timetable/allocate_venue.jsp" class="<%= uri.contains("allocate_venue") ? "nav-active" : "" %>">Allocate venue</a></li>
            <li><a href="<%= ctx %>/timetable/manage_schedule.jsp" class="<%= uri.contains("manage_schedule") ? "nav-active" : "" %>">Manage schedule</a></li>
            <li><a href="<%= ctx %>/timetable/view_issues.jsp" class="<%= uri.contains("view_issues") ? "nav-active" : "" %>">View issues</a></li>
        <% } else if ("COD".equals(role)) { %>
            <li><a href="<%= ctx %>/cod/dashboard.jsp" class="<%= uri.contains("/cod/dashboard.jsp") ? "nav-active" : "" %>">COD home</a></li>
            <li><a href="<%= ctx %>/cod/submit_requirements.jsp" class="<%= uri.contains("submit_requirements") ? "nav-active" : "" %>">Submit requirements</a></li>
            <li><a href="<%= ctx %>/cod/edit_requirements.jsp" class="<%= uri.contains("edit_requirements") ? "nav-active" : "" %>">Edit requirements</a></li>
            <li><a href="<%= ctx %>/cod/manage_requests.jsp" class="<%= uri.contains("manage_requests") ? "nav-active" : "" %>">Manage requests</a></li>
        <% } else if ("Class Representative".equals(role)) { %>
            <li><a href="<%= ctx %>/classrep/dashboard.jsp" class="<%= uri.contains("/classrep/dashboard.jsp") ? "nav-active" : "" %>">Class rep home</a></li>
            <li><a href="<%= ctx %>/classrep/report_issue.jsp" class="<%= uri.contains("report_issue") ? "nav-active" : "" %>">Report issue</a></li>
            <li><a href="<%= ctx %>/classrep/track_issue.jsp" class="<%= uri.contains("track_issue") ? "nav-active" : "" %>">Track issue</a></li>
        <% } %>
    </ul>
    <div class="nav-foot">
        <a href="<%= ctx %>/logout">Logout</a>
    </div>
</aside>
=======
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
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86

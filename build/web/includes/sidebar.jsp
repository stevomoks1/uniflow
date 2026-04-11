<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="app-sidebar">
    <h2>Quick links</h2>
    <ul>
        <li><a href="${pageContext.request.contextPath}/dashboard">Home</a></li>
        <c:choose>
            <c:when test="${sessionScope.role eq 'System Admin'}">
                <li><a href="${pageContext.request.contextPath}/admin/manage_users.jsp">Manage Users</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/system_logs.jsp">System Logs</a></li>
            </c:when>
            <c:when test="${sessionScope.role eq 'Timetabling Admin'}">
                <li><a href="${pageContext.request.contextPath}/timetable/allocate_venue.jsp">Allocate Venue</a></li>
                <li><a href="${pageContext.request.contextPath}/timetable/manage_schedule.jsp">Manage Schedule</a></li>
                <li><a href="${pageContext.request.contextPath}/timetable/view_issues.jsp">View Issues</a></li>
                <li><a href="${pageContext.request.contextPath}/timetable/draft_timetable_week2.jsp">Week 2 Draft Timetable</a></li>
                <li><a href="${pageContext.request.contextPath}/timetable/final_timetable.jsp">Final Timetable</a></li>
            </c:when>
            <c:when test="${sessionScope.role eq 'COD'}">
                <li><a href="${pageContext.request.contextPath}/cod/submit_requirements.jsp">Submit Requirements</a></li>
                <li><a href="${pageContext.request.contextPath}/cod/edit_requirements.jsp">Edit Requirements</a></li>
                <li><a href="${pageContext.request.contextPath}/cod/manage_requests.jsp">Manage Requests</a></li>
            </c:when>
            <c:when test="${sessionScope.role eq 'Class Representative'}">
                <li><a href="${pageContext.request.contextPath}/classrep/report_issue.jsp">Report Issue</a></li>
                <li><a href="${pageContext.request.contextPath}/classrep/track_issue.jsp">Track Issue</a></li>
            </c:when>
        </c:choose>
    </ul>
</div>

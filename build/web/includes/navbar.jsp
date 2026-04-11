<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="app-navbar">
    <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
    <c:choose>
        <c:when test="${sessionScope.role eq 'System Admin'}">
            <a href="${pageContext.request.contextPath}/admin/manage_users.jsp">Users</a>
            <a href="${pageContext.request.contextPath}/admin/system_logs.jsp">Logs</a>
        </c:when>
        <c:when test="${sessionScope.role eq 'Timetabling Admin'}">
            <a href="${pageContext.request.contextPath}/timetable/allocate_venue.jsp">Allocate</a>
            <a href="${pageContext.request.contextPath}/timetable/manage_schedule.jsp">Schedule</a>
            <a href="${pageContext.request.contextPath}/timetable/view_issues.jsp">Issues</a>
            <a href="${pageContext.request.contextPath}/timetable/draft_timetable_week2.jsp">Week 2 draft</a>
            <a href="${pageContext.request.contextPath}/timetable/final_timetable.jsp">Final timetable</a>
        </c:when>
        <c:when test="${sessionScope.role eq 'COD'}">
            <a href="${pageContext.request.contextPath}/cod/submit_requirements.jsp">Submit</a>
            <a href="${pageContext.request.contextPath}/cod/edit_requirements.jsp">Edit</a>
            <a href="${pageContext.request.contextPath}/cod/manage_requests.jsp">Requests</a>
        </c:when>
        <c:when test="${sessionScope.role eq 'Class Representative'}">
            <a href="${pageContext.request.contextPath}/classrep/report_issue.jsp">Report</a>
            <a href="${pageContext.request.contextPath}/classrep/track_issue.jsp">Track</a>
        </c:when>
    </c:choose>
</nav>

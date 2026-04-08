<%@page contentType="text/html" pageEncoding="UTF-8"%>
<<<<<<< HEAD
<%@page import="java.util.List"%>
<%@page import="Models.WorkflowDAO"%>
=======
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"COD".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
<<<<<<< HEAD
    List<WorkflowDAO.RequirementRecord> requirements = WorkflowDAO.listRequirements();
=======
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Manage Requests</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #0f172a; color: #e2e8f0; }
        .page { max-width: 980px; margin: 0 auto; padding: 32px; }
        .card { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 24px; }
        table { width: 100%; border-collapse: collapse; margin-top: 18px; }
        th, td { padding: 14px 12px; border-bottom: 1px solid #334155; }
        th { text-align: left; }
        a { color: #38bdf8; text-decoration:none; }
        button { padding:10px 14px; border-radius:12px; border:1px solid #334155; background:#0f172a; color:#e2e8f0; }
    </style>
</head>
<body>
<<<<<<< HEAD
<div class="app-layout">
<%@ include file="../sidebar.jsp" %>
<div class="app-main">
    <div class="page">
        <div>
            <h1>Requirement Pipeline Status</h1>
            <p>Flow step 2 onward: track consolidation, draft release, adjustments, and finalization.</p>
            <p><a href="<%= request.getContextPath() %>/cod/dashboard.jsp">Back to dashboard</a></p>
=======
    <div class="page">
        <div>
            <h1>Manage Cross-Department Requests</h1>
            <p>Review and coordinate requests from other departments.</p>
            <p><a href="dashboard.jsp">Back to dashboard</a></p>
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
        </div>
        <div class="card">
            <table>
                <thead>
<<<<<<< HEAD
                    <tr><th>Course</th><th>Lecturer</th><th>Students</th><th>Draft slot</th><th>Status</th></tr>
                </thead>
                <tbody>
                    <% if (requirements.isEmpty()) { %>
                    <tr><td colspan="5">No requirements yet.</td></tr>
                    <% } else { for (WorkflowDAO.RequirementRecord r : requirements) { %>
                    <tr>
                        <td><%= r.courseCode %></td>
                        <td><%= r.lecturerName %></td>
                        <td><%= r.studentCount %></td>
                        <td><%= (r.venue == null ? "-" : r.venue) %> / <%= (r.dayOfWeek == null ? "-" : r.dayOfWeek) %> / <%= (r.timeSlot == null ? "-" : r.timeSlot) %></td>
                        <td><%= r.status %></td>
                    </tr>
                    <% }} %>
=======
                    <tr><th>Request</th><th>Department</th><th>Status</th><th>Action</th></tr>
                </thead>
                <tbody>
                    <tr><td>Extra lab hours</td><td>Engineering</td><td>Open</td><td><button type="button">Review</button></td></tr>
                    <tr><td>Shared venue</td><td>Business</td><td>Assigned</td><td><button type="button">Review</button></td></tr>
                    <tr><td>Multi-section course</td><td>Science</td><td>Pending</td><td><button type="button">Review</button></td></tr>
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
                </tbody>
            </table>
        </div>
    </div>
<<<<<<< HEAD
</div>
</div>
=======
>>>>>>> eb447e73418c656761eba5acc9449c9531f8de86
</body>
</html>

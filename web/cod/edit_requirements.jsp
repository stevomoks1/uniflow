<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"COD".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Edit Requirements</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #0f172a; color: #e2e8f0; }
        .page { max-width: 980px; margin: 0 auto; padding: 32px; }
        .card { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 24px; }
        table { width: 100%; border-collapse: collapse; margin-top: 18px; }
        th, td { padding: 14px 12px; border-bottom: 1px solid #334155; }
        th { text-align: left; }
        button, select, input { width: 100%; border-radius: 12px; border:1px solid #334155; background: #0f172a; color:#e2e8f0; padding:12px; }
        a { color: #38bdf8; text-decoration:none; }
    </style>
</head>
<body>
    <%@ include file="/includes/header.jsp" %>
    <%@ include file="/includes/navbar.jsp" %>
    <div class="page">
        <div>
            <h1>Edit Previous Requirements</h1>
            <p>Choose a previously submitted requirement and update details.</p>
            <p><a href="<%= request.getContextPath() %>/cod/dashboard.jsp">Back to dashboard</a></p>
        </div>
        <div class="card">
            <table>
                <thead>
                    <tr><th>Course</th><th>Semester</th><th>Status</th><th>Action</th></tr>
                </thead>
                <tbody>
                    <tr><td>CS101</td><td>Fall</td><td>Submitted</td><td><button type="button">Edit</button></td></tr>
                    <tr><td>MATH201</td><td>Spring</td><td>Approved</td><td><button type="button">Edit</button></td></tr>
                    <tr><td>ENG301</td><td>Fall</td><td>Pending</td><td><button type="button">Edit</button></td></tr>
                </tbody>
            </table>
        </div>
    </div>
    <%@ include file="/includes/footer.jsp" %>
</body>
</html>



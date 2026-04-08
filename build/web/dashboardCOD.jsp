<%-- 
    Document   : dashboardCOD
    Created on : Apr 8, 2026, 12:59:47 PM
    Author     : steve
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
    if (!"COD".equals(user.getRole())) {
        response.sendRedirect("dashboard");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>COD Dashboard</title>
        <style>
            body { font-family: Arial, sans-serif; background: #0f172a; color: #e2e8f0; margin: 0; padding: 40px; }
            .container { max-width: 900px; margin: auto; background: #111827; border-radius: 18px; padding: 32px; }
            a { color: #38bdf8; text-decoration: none; }
            .header { display: flex; justify-content: space-between; align-items: center; }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <div>
                    <h1>COD Dashboard</h1>
                    <p>Welcome, <strong><%= user.getFullName() %></strong></p>
                    <p>Role: <strong><%= user.getRole() %></strong></p>
                </div>
                <div><a href="logout">Logout</a></div>
            </div>
            <hr style="border-color: #334155; margin: 24px 0;" />
            <p>Submit and manage course requirements from this view.</p>
        </div>
    </body>
</html>

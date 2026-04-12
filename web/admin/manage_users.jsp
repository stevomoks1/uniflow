<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"System Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Manage Users</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #0f172a; color: #e2e8f0; }
        .page { max-width: 1180px; margin: 0 auto; padding: 32px; }
        .topbar { display: flex; justify-content: space-between; align-items: center; }
        .card { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 24px; margin-top: 24px; }
        table { width: 100%; border-collapse: collapse; margin-top: 18px; }
        th, td { padding: 14px 12px; border-bottom: 1px solid #334155; }
        th { text-align: left; }
        button, select { border-radius: 10px; border: 1px solid #334155; background: #0f172a; color: #e2e8f0; padding: 8px 12px; }
        a { color: #38bdf8; text-decoration: none; }
        .actions { display: flex; gap: 10px; }
    </style>
</head>
<body>
    <%@ include file="/includes/header.jsp" %>
    <%@ include file="/includes/navbar.jsp" %>
    <div class="page">
        <div class="topbar">
            <div>
                <h1>Manage Users</h1>
                <p>Use the table below to create, update, and delete user accounts.</p>
            </div>
            <div><a href="<%= request.getContextPath() %>/admin/dashboard.jsp">Back to dashboard</a></div>
        </div>

        <div class="card">
            <h2>Create New User</h2>
            <form>
                <div style="display:grid; grid-template-columns:1fr 1fr; gap:16px;">
                    <label><span>Name</span><input type="text" placeholder="Full name" style="width:100%; margin-top:8px;" /></label>
                    <label><span>Email</span><input type="email" placeholder="email@example.com" style="width:100%; margin-top:8px;" /></label>
                    <label><span>Role</span>
                        <select style="width:100%; margin-top:8px;">
                            <option>System Admin</option>
                            <option>Timetabling Admin</option>
                            <option>COD</option>
                            <option>Class Representative</option>
                        </select>
                    </label>
                    <label><span>Password</span><input type="password" placeholder="Password" style="width:100%; margin-top:8px;" /></label>
                </div>
                <div style="margin-top:18px;"><button type="button">Create user</button></div>
            </form>
        </div>

        <div class="card">
            <h2>User Management Table</h2>
            <table>
                <thead>
                    <tr><th>Email</th><th>Name</th><th>Role</th><th>Status</th><th>Actions</th></tr>
                </thead>
                <tbody>
                    <tr>
                        <td>admin@uniflow.local</td>
                        <td>System Admin</td>
                        <td>System Admin</td>
                        <td>Active</td>
                        <td class="actions"><button>Edit</button><button>Delete</button></td>
                    </tr>
                    <tr>
                        <td>timetable@uniflow.local</td>
                        <td>Timetable Admin</td>
                        <td>Timetabling Admin</td>
                        <td>Active</td>
                        <td class="actions"><button>Edit</button><button>Delete</button></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <%@ include file="/includes/footer.jsp" %>
</body>
</html>



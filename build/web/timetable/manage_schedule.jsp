<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"Timetabling Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    String cp = request.getContextPath();
    String[] venues = {
        "PST 1", "PST 2", "PST 3", "PST 4", "PST 5",
        "NPL 1", "NPL 2", "NPL 3", "NPL 4", "NPL 5", "NPL 6",
        "B1", "B2", "B3", "B4", "B5",
        "CB1", "CB2", "CB3", "CB4", "CB5",
        "ED1", "ED2", "ED3", "ED4"
    };
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Manage Schedule</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #0f172a; color: #e2e8f0; }
        .page { max-width: 1180px; margin: 0 auto; padding: 32px; }
        .card { background: #111827; border: 1px solid #334155; border-radius: 18px; padding: 24px; margin-top: 24px; }
        .timetable { width: 100%; border-collapse: collapse; margin-top: 18px; }
        .timetable th, .timetable td { border: 1px solid #334155; padding: 12px; }
        th { background: #1e293b; }
        a { color: #38bdf8; text-decoration: none; }
    </style>
</head>
<body>
    <div class="page">
        <div>
            <h1>Manage Schedule</h1>
            <p>Inspect and update the current timetable grid for all venues.</p>
            <p><a href="<%= cp %>/dashboard">Back to dashboard</a></p>
        </div>

        <div class="card">
            <table class="timetable">
                <thead>
                    <tr><th>Venue</th><th>Current Allocation</th><th>Status</th></tr>
                </thead>
                <tbody>
                    <% for (String venue : venues) { %>
                    <tr>
                        <td><%= venue %></td>
                        <td>-</td>
                        <td>Awaiting live schedule data</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

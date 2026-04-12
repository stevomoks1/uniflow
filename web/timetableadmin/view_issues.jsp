<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Models.WorkflowDAO"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"Timetabling Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<WorkflowDAO.IssueRecord> issues = WorkflowDAO.listIssues();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>View Issues</title>
    <style>
        * { box-sizing: border-box; }
        body { margin: 0; font-family: 'Segoe UI', system-ui, -apple-system, sans-serif; background: linear-gradient(135deg, #0f172a 0%, #1a2940 100%); color: #e2e8f0; min-height: 100vh; }
        .layout { display: grid; grid-template-columns: 280px 1fr; min-height: 100vh; }
        .app-sidebar { padding: 28px 20px; background: rgba(15,23,42,0.95); border-right: 1px solid rgba(148,163,184,0.15); position: sticky; top: 0; max-height: 100vh; overflow-y: auto; }
        .app-sidebar h2 { margin: 0 0 20px; color: #38bdf8; font-size: 1.1rem; font-weight: 600; letter-spacing: 0.5px; }
        .app-sidebar ul { list-style: none; padding: 0; margin: 0; }
        .app-sidebar ul li { margin: 0 0 8px; }
        .app-sidebar ul li a { display: block; color: #cbd5e1; text-decoration: none; padding: 12px 14px; border-radius: 12px; border: 1px solid transparent; background: rgba(30,41,59,0.6); transition: all 0.2s; }
        .app-sidebar ul li a:hover { background: rgba(56,189,248,0.15); color: #38bdf8; border-color: rgba(56,189,248,0.35); }
        .page { display: flex; flex-direction: column; }
        .app-header { display: flex; justify-content: space-between; align-items: center; padding: 24px 32px; background: rgba(15,23,42,0.7); border-bottom: 1px solid rgba(148,163,184,0.12); }
        .brand a { color: #38bdf8; text-decoration: none; font-size: 1.2rem; font-weight: 700; }
        .header-actions { display:flex; gap:12px; align-items:center; }
        .button { display: inline-flex; align-items:center; justify-content:center; text-decoration:none; color: #e2e8f0; padding: 10px 16px; border-radius: 12px; border: 1px solid rgba(148,163,184,0.2); background: rgba(30,41,59,0.75); transition: all 0.2s; }
        .button:hover { background: rgba(56,189,248,0.12); }
        .button.primary { background: linear-gradient(135deg, #38bdf8, #0284c7); color: #0f172a; border: none; }
        .content { padding: 32px; }
        .page-title { margin: 0 0 12px; font-size: 2.25rem; line-height: 1.1; }
        .page-description { margin: 0 0 24px; color: #94a3b8; max-width: 860px; }
        .actions { display: flex; flex-wrap: wrap; gap: 12px; margin-bottom: 22px; }
        .card { background: rgba(15,23,42,0.8); border: 1px solid rgba(148,163,184,0.14); border-radius: 20px; padding: 28px; box-shadow: 0 20px 50px rgba(0,0,0,0.12); margin-bottom: 24px; }
        .card h2 { margin-top: 0; font-size: 1.4rem; }
        table { width: 100%; border-collapse: collapse; margin-top: 18px; }
        th, td { padding: 14px 12px; border-bottom: 1px solid rgba(148,163,184,0.12); }
        th { color: #cbd5e1; font-weight: 600; background: rgba(30,41,59,0.7); text-align: left; }
        tbody tr:hover { background: rgba(56,189,248,0.08); }
        select, input[type="text"] { width: 100%; border: 1px solid rgba(148,163,184,0.25); border-radius: 14px; background: rgba(15,23,42,0.9); color: #e2e8f0; padding: 12px; margin-top: 10px; }
        button { border: none; border-radius: 14px; background: linear-gradient(135deg, #38bdf8, #0284c7); color: #0f172a; padding: 12px 20px; cursor: pointer; font-weight: 600; margin-top: 10px; }
        .flash { padding: 14px 18px; border-radius: 14px; margin-bottom: 24px; font-weight: 600; }
        .flash.success { background: rgba(16,185,129,0.18); color: #a7f3d0; }
        @media (max-width: 900px) { .layout { grid-template-columns: 1fr; } .app-sidebar { position: relative; max-height: none; } }
    </style>
</head>
<body>
    <div class="layout">
        <jsp:include page="/includes/sidebar.jsp" />
        <div class="page">
            <jsp:include page="/includes/header.jsp" />
            <div class="content">
                <div class="card">
                    <h1 class="page-title">View Issues</h1>
                    <p class="page-description">Flow step 5: review class feedback and update issue statuses before week-2 timetable adjustments.</p>
                    <div class="actions">
                        <a class="button" href="<%= request.getContextPath() %>/timetableadmin/dashboard.jsp">Back to dashboard</a>
                        <a class="button" href="<%= request.getContextPath() %>/timetableadmin/draft_requirements_week2.jsp">Week 2 draft</a>
                    </div>
                    <% if (request.getParameter("success") != null) { %>
                    <div class="flash success">Issue update saved.</div>
                    <% } %>
                </div>
                <div class="card">
                    <table>
                        <thead>
                            <tr><th>Issue</th><th>Requirement</th><th>Reported by</th><th>Priority</th><th>Status</th><th>Action</th></tr>
                        </thead>
                        <tbody>
                            <% if (issues.isEmpty()) { %>
                            <tr><td colspan="6">No feedback issues yet.</td></tr>
                            <% } else { for (WorkflowDAO.IssueRecord issue : issues) { %>
                            <tr>
                                <td><%= issue.issueTitle %></td>
                                <td><%= issue.requirementId == null ? "-" : issue.requirementId %></td>
                                <td><%= issue.reportedByEmail %></td>
                                <td><%= issue.priority %></td>
                                <td><%= issue.status %></td>
                                <td>
                                    <form method="post" action="<%= request.getContextPath() %>/RequirementServlet">
                                        <input type="hidden" name="action" value="updateIssueStatus" />
                                        <input type="hidden" name="issueId" value="<%= issue.id %>" />
                                        <input type="hidden" name="requirementId" value="<%= issue.requirementId == null ? "" : issue.requirementId %>" />
                                        <select name="status" required>
                                            <option <%= "OPEN".equals(issue.status) ? "selected" : "" %>>OPEN</option>
                                            <option <%= "IN_REVIEW".equals(issue.status) ? "selected" : "" %>>IN_REVIEW</option>
                                            <option <%= "RESOLVED".equals(issue.status) ? "selected" : "" %>>RESOLVED</option>
                                        </select>
                                        <input name="responseNote" type="text" placeholder="Response for class rep" />
                                        <input name="adjustmentNote" type="text" placeholder="Adjustment note (week 2)" />
                                        <button type="submit">Save</button>
                                    </form>
                                </td>
                            </tr>
                            <% } } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/includes/cookieConsent.jsp" />
</body>
</html>



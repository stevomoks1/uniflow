<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Models.WorkflowDAO"%>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    if (user == null || !"Timetabling Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<WorkflowDAO.RequirementRecord> requirements = WorkflowDAO.listRequirements();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Allocate Venue</title>
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
        .form-grid { display: grid; gap: 18px; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); }
        label { display: flex; flex-direction: column; color: #cbd5e1; font-size: 0.95rem; }
        input, select, textarea { width: 100%; border: 1px solid rgba(148,163,184,0.25); border-radius: 14px; background: rgba(15,23,42,0.9); color: #e2e8f0; padding: 14px; margin-top: 10px; font-size: 0.95rem; }
        textarea { resize: vertical; min-height: 100px; }
        .flash { padding: 14px 18px; border-radius: 14px; margin-bottom: 24px; font-weight: 600; }
        .flash.success { background: rgba(16,185,129,0.18); color: #a7f3d0; }
        .flash.error { background: rgba(248,113,113,0.18); color: #fecaca; }
        table { width: 100%; border-collapse: collapse; margin-top: 18px; }
        th, td { padding: 14px 12px; border-bottom: 1px solid rgba(148,163,184,0.12); }
        th { color: #cbd5e1; font-weight: 600; background: rgba(30,41,59,0.7); text-align: left; }
        tbody tr:hover { background: rgba(56,189,248,0.08); }
        .wide { grid-column: span 2; }
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
                    <h1 class="page-title">Allocate Venue</h1>
                    <p class="page-description">Flow step 2-3: select a course requirement and assign a hall, day and time slot for the draft timetable.</p>
                    <div class="actions">
                        <a class="button" href="<%= request.getContextPath() %>/requirement/dashboard.jsp">Back to dashboard</a>
                        <a class="button" href="<%= request.getContextPath() %>/requirement/manage_schedule.jsp">Manage schedule</a>
                    </div>
                    <% if (request.getParameter("success") != null) { %>
                    <div class="flash success">Draft released successfully.</div>
                    <% } %>
                    <% if (request.getParameter("error") != null) { %>
                    <div class="flash error">Please fill all draft fields.</div>
                    <% } %>
                </div>
                <div class="card">
                    <h2>Release Draft Timetable</h2>
                    <form method="post" action="<%= request.getContextPath() %>/RequirementServlet">
                        <input type="hidden" name="action" value="releaseDraft" />
                        <div class="form-grid">
                            <label>Course requirement
                                <select name="requirementId" required>
                                    <option value="">Select requirement</option>
                                    <% for (WorkflowDAO.RequirementRecord r : requirements) { %>
                                    <option value="<%= r.id %>">#<%= r.id %> - <%= r.courseCode %> (<%= r.studentCount %> students)</option>
                                    <% } %>
                                </select>
                            </label>
                            <label>Venue
                                <input name="venue" type="text" list="venueList" placeholder="Select or type venue" required />
                                <datalist id="venueList">
                                    <option value="PST1"></option>
                                    <option value="PST2"></option>
                                    <option value="PST3"></option>
                                    <option value="PST4"></option>
                                    <option value="PST5"></option>
                                    <option value="NPL1"></option>
                                    <option value="NPL2"></option>
                                    <option value="NPL3"></option>
                                    <option value="NPL4"></option>
                                    <option value="NPL5"></option>
                                    <option value="NPL6"></option>
                                    <option value="CB1"></option>
                                    <option value="CB2"></option>
                                    <option value="CB3"></option>
                                    <option value="CB4"></option>
                                    <option value="CB5"></option>
                                    <option value="CB6"></option>
                                    <option value="B1"></option>
                                    <option value="B2"></option>
                                    <option value="B3"></option>
                                    <option value="B4"></option>
                                    <option value="B5"></option>
                                    <option value="LAB1"></option>
                                    <option value="LAB2"></option>
                                    <option value="LAB3"></option>
                                    <option value="LAB4"></option>
                                    <option value="LAB5"></option>
                                    <option value="AUD1"></option>
                                    <option value="AUD2"></option>
                                    <option value="AUD3"></option>
                                    <option value="LIB1"></option>
                                    <option value="LIB2"></option>
                                </datalist>
                            </label>
                            <label>Day
                                <select name="dayOfWeek" required>
                                    <option>Monday</option>
                                    <option>Tuesday</option>
                                    <option>Wednesday</option>
                                    <option>Thursday</option>
                                    <option>Friday</option>
                                </select>
                            </label>
                            <label>Time slot
                                <input name="timeSlot" type="text" placeholder="08:00 - 10:00" required />
                            </label>
                            <label class="wide">Week 2 adjustment note (optional)
                                <textarea name="adjustmentNote" placeholder="Describe the adjustment after feedback."></textarea>
                            </label>
                        </div>
                        <button class="button primary" type="submit">Release draft timetable</button>
                    </form>
                </div>
                <div class="card">
                    <h2>Current Requirements</h2>
                    <table>
                        <thead>
                            <tr><th>Course</th><th>Lecturer</th><th>Students</th><th>Status</th></tr>
                        </thead>
                        <tbody>
                            <% if (requirements.isEmpty()) { %>
                            <tr><td colspan="4">No requirements submitted yet.</td></tr>
                            <% } else { for (WorkflowDAO.RequirementRecord r : requirements) { %>
                            <tr>
                                <td><%= r.courseCode %></td>
                                <td><%= r.lecturerName %></td>
                                <td><%= r.studentCount %></td>
                                <td><%= r.status %></td>
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



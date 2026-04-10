<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>UniFlow Register</title>
    <style>
        body { font-family: Inter, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif; margin: 0; min-height: 100vh; background: linear-gradient(135deg, #0f172a 0%, #1e293b 55%, #334155 100%); color: #e2e8f0; display: flex; align-items: center; justify-content: center; }
        .card { width: min(520px, 94vw); background: rgba(15, 23, 42, 0.94); padding: 34px; border: 1px solid rgba(148, 163, 184, 0.18); border-radius: 24px; box-shadow: 0 24px 80px rgba(15, 23, 42, 0.45); }
        h1 { margin-top: 0; font-size: clamp(2rem, 3vw, 2.4rem); color: #f8fafc; }
        label { display: block; margin: 14px 0 6px; color: #cbd5e1; }
        input, select { width: 100%; padding: 12px 14px; border: 1px solid #334155; border-radius: 12px; background: #0f172a; color: #f8fafc; }
        button { width: 100%; margin-top: 18px; padding: 14px; border: none; border-radius: 12px; background: #38bdf8; color: #0f172a; font-weight: 700; cursor: pointer; }
        .error { margin: 18px 0; padding: 14px 16px; border-radius: 14px; background: rgba(248, 113, 113, 0.14); color: #fee2e2; border: 1px solid rgba(248, 113, 113, 0.28); }
        .hint { margin-top: 14px; color: #94a3b8; }
        a { color: #38bdf8; text-decoration: none; }
    </style>
</head>
<body>
    <main class="card">
        <h1>Create a UniFlow Account</h1>
        <c:if test="${not empty requestScope.error}">
        <div class="error">${requestScope.error}</div>
        </c:if>
        <form action="<%= request.getContextPath() %>/register" method="post">
            <label for="firstName">First name</label>
            <input id="firstName" name="firstName" type="text" required />
            <label for="lastName">Last name</label>
            <input id="lastName" name="lastName" type="text" required />
            <label for="email">Email</label>
            <input id="email" name="email" type="email" required />
            <label for="password">Password</label>
            <input id="password" name="password" type="password" required minlength="8" />
            <label for="role">Role</label>
            <select id="role" name="role" required>
                <option value="" disabled selected>Choose your role</option>
                <option value="Timetabling Admin">Timetabling Admin</option>
                <option value="COD">COD</option>
                <option value="Class Representative">Class Representative</option>
            </select>
            <button type="submit">Create account</button>
        </form>
        <p class="hint">System Admin accounts are created manually by database admin only.</p>
        <p class="hint">Already registered? <a href="<%= request.getContextPath() %>/login.jsp">Sign in</a> | <a href="<%= request.getContextPath() %>/index.html">Home</a></p>
    </main>
</body>
</html>



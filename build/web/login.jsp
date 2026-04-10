<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String error = (String) request.getAttribute("error");
    String registered = request.getParameter("registered");
    String logout = request.getParameter("logout");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>UniFlow Login</title>
    <style>
        body { font-family: Inter, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif; margin: 0; min-height: 100vh; background: linear-gradient(135deg, #0f172a 0%, #1e293b 55%, #334155 100%); color: #e2e8f0; display: flex; align-items: center; justify-content: center; }
        .card { width: min(420px, 92vw); background: rgba(15, 23, 42, 0.94); padding: 34px; border: 1px solid rgba(148, 163, 184, 0.18); border-radius: 24px; box-shadow: 0 24px 80px rgba(15, 23, 42, 0.45); }
        h1 { margin-top: 0; font-size: clamp(2rem, 3vw, 2.4rem); color: #f8fafc; }
        label { display: block; margin: 14px 0 6px; color: #cbd5e1; }
        input { width: 100%; padding: 12px 14px; border: 1px solid #334155; border-radius: 12px; background: #0f172a; color: #f8fafc; }
        button { width: 100%; margin-top: 18px; padding: 14px; border: none; border-radius: 12px; background: #38bdf8; color: #0f172a; font-weight: 700; cursor: pointer; }
        .flash { margin: 18px 0; padding: 14px 16px; border-radius: 14px; background: rgba(56, 189, 248, 0.12); color: #e0f2fe; border: 1px solid rgba(56, 189, 248, 0.28); }
        .error { background: rgba(248, 113, 113, 0.14); color: #fee2e2; border: 1px solid rgba(248, 113, 113, 0.28); }
        .hint { margin-top: 14px; color: #94a3b8; }
        a { color: #38bdf8; text-decoration: none; }
    </style>
</head>
<body>
    <main class="card">
        <h1>UniFlow Login</h1>
        <% if (registered != null) { %>
        <div class="flash">Your account was created successfully. Please sign in.</div>
        <% } else if (logout != null) { %>
        <div class="flash">You have been logged out successfully.</div>
        <% } %>
        <% if (error != null) { %>
        <div class="flash error"><%= error %></div>
        <% } %>
        <form action="login" method="post">
            <label for="email">Email</label>
            <input id="email" name="email" type="email" required />
            <label for="password">Password</label>
            <input id="password" name="password" type="password" required />
            <button type="submit">Sign in</button>
        </form>
        <p class="hint">New to UniFlow? <a href="register.jsp">Create an account</a> | <a href="index.html">Home</a></p>
    </main>
</body>
</html>

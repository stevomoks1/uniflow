<%@ page contentType="text/html;charset=UTF-8" %>
<%
    Models.User user = (Models.User) session.getAttribute("user");
    String welcomeName = user != null ? user.getFullName() : "Guest";
%>
<header class="app-header">
    <div class="brand">
        <a href="<%= request.getContextPath() %>/dashboard">UniFlow</a>
    </div>
    <div class="header-actions">
        <span class="welcome-text">Hello, <%= welcomeName %></span>
        <a class="button button-secondary" href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
</header>

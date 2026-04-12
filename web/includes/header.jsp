<%
    String decodedLastUser = null;
    javax.servlet.http.Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (javax.servlet.http.Cookie cookie : cookies) {
            if ("uniflowLastUser".equals(cookie.getName()) && cookie.getValue() != null) {
                decodedLastUser = java.net.URLDecoder.decode(cookie.getValue(), java.nio.charset.StandardCharsets.UTF_8.name());
                break;
            }
        }
    }
    Models.User headerUser = null;
    if (session != null) {
        headerUser = (Models.User) session.getAttribute("user");
    }
    String greeting = "Guest";
    if (headerUser != null && headerUser.getFullName() != null) {
        greeting = headerUser.getFullName();
    } else if (decodedLastUser != null && !decodedLastUser.isEmpty()) {
        greeting = decodedLastUser;
    }
%>
<header class="app-header">
    <div class="brand">
        <a href="<%= request.getContextPath() %>/dashboard">UniFlow</a>
    </div>
    <div class="header-actions">
        <span class="welcome-text">Hello, <%= greeting %></span>
        <a class="button button-secondary" href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
</header>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    request.setAttribute("decodedLastUser", decodedLastUser);
%>
<header class="app-header">
    <div class="brand">
        <a href="${pageContext.request.contextPath}/dashboard">UniFlow</a>
    </div>
    <div class="header-actions">
        <span class="welcome-text">
            Hello,
            <c:choose>
                <c:when test="${not empty sessionScope.user}">${sessionScope.user.fullName}</c:when>
                <c:when test="${not empty decodedLastUser}">${decodedLastUser}</c:when>
                <c:otherwise>Guest</c:otherwise>
            </c:choose>
        </span>
        <a class="button button-secondary" href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</header>

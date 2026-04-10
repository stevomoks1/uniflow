<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="app-header">
    <div class="brand">
        <a href="${pageContext.request.contextPath}/dashboard">UniFlow</a>
    </div>
    <div class="header-actions">
        <span class="welcome-text">
            Hello,
            <c:choose>
                <c:when test="${not empty sessionScope.user}">${sessionScope.user.fullName}</c:when>
                <c:when test="${not empty cookie.uniflowLastUser.value}">${cookie.uniflowLastUser.value}</c:when>
                <c:otherwise>Guest</c:otherwise>
            </c:choose>
        </span>
        <a class="button button-secondary" href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</header>

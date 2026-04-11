<%
    boolean showConsentBanner = true;
    javax.servlet.http.Cookie[] customCookies = request.getCookies();
    if (customCookies != null) {
        for (javax.servlet.http.Cookie c : customCookies) {
            if ("cookie_consent".equals(c.getName())) {
                showConsentBanner = false;
                break;
            }
        }
    }
    if (showConsentBanner) {
%>
    <style>
        .cookie-banner {
            position: fixed;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(15, 23, 42, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(148, 163, 184, 0.2);
            padding: 20px 30px;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            z-index: 10000;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
            width: min(90vw, 500px);
            font-family: Inter, system-ui, sans-serif;
            color: #f8fafc;
        }
        .cookie-banner p {
            margin: 0;
            font-size: 0.95rem;
            line-height: 1.5;
            text-align: center;
            color: #cbd5e1;
        }
        .cookie-actions {
            display: flex;
            gap: 10px;
            width: 100%;
        }
        .cookie-actions form {
            flex: 1;
            display: flex;
            margin: 0;
        }
        .cookie-btn {
            flex: 1;
            border: none;
            padding: 10px 15px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.1s, opacity 0.2s;
            text-align: center;
        }
        .cookie-btn:hover {
            transform: translateY(-1px);
            opacity: 0.9;
        }
        .btn-accept {
            background: #38bdf8;
            color: #0f172a;
        }
        .btn-decline {
            background: rgba(255, 255, 255, 0.1);
            color: #f8fafc;
            border: 1px solid rgba(148, 163, 184, 0.2);
        }
    </style>
    <div class="cookie-banner">
        <p>We use cookies to improve your experience and to analyze our traffic. Please accept or decline the use of cookies.</p>
        <div class="cookie-actions">
            <form action="<%= request.getContextPath() %>/cookieConsent" method="post">
                <input type="hidden" name="consentValue" value="declined" />
                <button type="submit" class="cookie-btn btn-decline">Decline</button>
            </form>
            <form action="<%= request.getContextPath() %>/cookieConsent" method="post">
                <input type="hidden" name="consentValue" value="accepted" />
                <button type="submit" class="cookie-btn btn-accept">Accept All</button>
            </form>
        </div>
    </div>
<% } %>

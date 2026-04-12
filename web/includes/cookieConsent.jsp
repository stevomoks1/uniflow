<%
    boolean showConsentBanner = true;
    String consentFromSession = null;
    
    if (session != null) {
        consentFromSession = (String) session.getAttribute("cookie_consent_shown");
    }
    
    if (consentFromSession != null) {
        // Already shown in this session, check if cookie still exists
        javax.servlet.http.Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (javax.servlet.http.Cookie c : cookies) {
                if ("cookie_consent".equals(c.getName())) {
                    showConsentBanner = false;
                    break;
                }
            }
        }
    } else {
        // First time in this session, show banner
        showConsentBanner = true;
    }
    
    if (showConsentBanner && session != null) {
        session.setAttribute("cookie_consent_shown", "true");
    }
%>
<% if (showConsentBanner) { %>
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
            animation: slideUp 0.3s ease-out;
        }
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateX(-50%) translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateX(-50%) translateY(0);
            }
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
    <div class="cookie-banner" id="cookieBanner">
        <p>We use cookies to improve your experience and to analyze our traffic. Please accept or decline the use of cookies.</p>
        <div class="cookie-actions">
            <form action="<%= request.getContextPath() %>/cookieConsent" method="post" onsubmit="hideCookieBanner()">
                <input type="hidden" name="consentValue" value="declined" />
                <button type="submit" class="cookie-btn btn-decline">Decline</button>
            </form>
            <form action="<%= request.getContextPath() %>/cookieConsent" method="post" onsubmit="hideCookieBanner()">
                <input type="hidden" name="consentValue" value="accepted" />
                <button type="submit" class="cookie-btn btn-accept">Accept All</button>
            </form>
        </div>
    </div>
    <script>
        function hideCookieBanner() {
            const banner = document.getElementById('cookieBanner');
            if (banner) {
                banner.style.animation = 'slideDown 0.3s ease-out forwards';
            }
        }
        
        const style = document.createElement('style');
        style.textContent = `
            @keyframes slideDown {
                from {
                    opacity: 1;
                    transform: translateX(-50%) translateY(0);
                }
                to {
                    opacity: 0;
                    transform: translateX(-50%) translateY(20px);
                }
            }
        `;
        document.head.appendChild(style);
    </script>
<% } %>

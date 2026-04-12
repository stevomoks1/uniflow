package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieConsentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String consentValue = request.getParameter("consentValue");
        
        if (consentValue != null && !consentValue.trim().isEmpty()) {
            Cookie consentCookie = new Cookie("cookie_consent", consentValue);
            consentCookie.setMaxAge(5 * 60); // 5 minutes
            consentCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
            response.addCookie(consentCookie);
        }
        
        String referer = request.getHeader("referer");
        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/");
        }
    }
}

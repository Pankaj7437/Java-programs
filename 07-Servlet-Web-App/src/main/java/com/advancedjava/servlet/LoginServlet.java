package com.advancedjava.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Authentication Servlet.
 * Authenticates user credentials, creates an HttpSession, stores session attributes,
 * and issues a redirect to the protected /home dashboard.
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // Basic authentication logic for lab demo
        if (username != null && !username.trim().isEmpty() && "secret123".equals(password)) {
            // Invalidate any existing session to prevent fixation
            HttpSession existingSession = req.getSession(false);
            if (existingSession != null) {
                existingSession.invalidate();
            }

            // Create new fresh session
            HttpSession session = req.getSession(true);
            session.setAttribute("user", username.trim());
            session.setAttribute("loginTime", System.currentTimeMillis());
            session.setMaxInactiveInterval(30 * 60); // 30 minutes

            // Redirect to protected dashboard
            resp.sendRedirect(req.getContextPath() + "/home");
        } else {
            // Authentication failed
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().println("<!DOCTYPE html><html><body style='font-family:sans-serif;background:#0f172a;color:#f8fafc;padding:3rem;text-align:center;'>");
            resp.getWriter().println("<h2 style='color:#f87171;'>Authentication Failed</h2>");
            resp.getWriter().println("<p>Invalid username or password. Password must be <code>secret123</code>.</p>");
            resp.getWriter().println("<a href='index.html' style='color:#60a5fa;'>&larr; Try Again</a>");
            resp.getWriter().println("</body></html>");
        }
    }
}

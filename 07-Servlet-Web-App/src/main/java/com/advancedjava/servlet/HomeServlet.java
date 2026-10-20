package com.advancedjava.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

/**
 * Protected User Dashboard.
 * Access is guarded by AuthFilter; renders session details for the logged-in user.
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("user") : "Guest";
        Long loginTime = (session != null) ? (Long) session.getAttribute("loginTime") : null;
        String formattedDate = (loginTime != null) ? new Date(loginTime).toString() : "Unknown";

        resp.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = resp.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang='en'>");
            out.println("<head>");
            out.println("  <meta charset='UTF-8'>");
            out.println("  <title>User Dashboard (Protected)</title>");
            out.println("  <style>");
            out.println("    body { font-family: sans-serif; background: #0f172a; color: #f8fafc; padding: 3rem; text-align: center; }");
            out.println("    .card { background: #1e293b; border-radius: 12px; max-width: 600px; margin: 0 auto; padding: 2rem; border: 1px solid #334155; }");
            out.println("    h1 { color: #38bdf8; margin-bottom: 0.5rem; }");
            out.println("    .badge { display: inline-block; background: #065f46; color: #34d399; padding: 0.35rem 0.75rem; border-radius: 999px; font-size: 0.85rem; font-weight: bold; margin-bottom: 1.5rem; }");
            out.println("    p { margin: 0.5rem 0; font-size: 1.05rem; color: #cbd5e1; }");
            out.println("    .logout-btn { display: inline-block; margin-top: 1.5rem; padding: 0.65rem 1.5rem; background: #ef4444; color: #fff; text-decoration: none; border-radius: 6px; font-weight: bold; }");
            out.println("    .logout-btn:hover { background: #dc2626; }");
            out.println("  </style>");
            out.println("</head>");
            out.println("<body>");
            out.println("  <div class='card'>");
            out.println("    <span class='badge'>SESSION ACTIVE (AUTHENTICATED)</span>");
            out.println("    <h1>Welcome, " + username + "!</h1>");
            out.println("    <p>This is a protected resource accessible only through an authenticated <code>HttpSession</code>.</p>");
            out.println("    <p>Session ID: <code>" + (session != null ? session.getId() : "N/A") + "</code></p>");
            out.println("    <p>Session Created At: " + formattedDate + "</p>");
            out.println("    <p>Timeout Window: " + (session != null ? session.getMaxInactiveInterval() / 60 : 0) + " minutes</p>");
            out.println("    <a class='logout-btn' href='logout'>Logout &amp; Invalidate Session</a>");
            out.println("  </div>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}

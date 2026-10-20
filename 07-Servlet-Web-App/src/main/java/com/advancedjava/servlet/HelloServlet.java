package com.advancedjava.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Basic HTTP Servlet demonstrating request parameter processing and dynamic HTML response generation.
 */
@WebServlet(name = "HelloServlet", urlPatterns = {"/hello"})
public class HelloServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String name = req.getParameter("name");
        String department = req.getParameter("department");

        if (name == null || name.trim().isEmpty()) {
            name = "Guest Student";
        }
        if (department == null || department.trim().isEmpty()) {
            department = "General Engineering";
        }

        String currentTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        try (PrintWriter out = resp.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang='en'>");
            out.println("<head>");
            out.println("  <meta charset='UTF-8'>");
            out.println("  <title>Hello Servlet Response</title>");
            out.println("  <style>");
            out.println("    body { font-family: sans-serif; background: #0f172a; color: #f8fafc; padding: 3rem; text-align: center; }");
            out.println("    .card { background: #1e293b; border-radius: 12px; max-width: 600px; margin: 0 auto; padding: 2rem; border: 1px solid #334155; }");
            out.println("    h1 { color: #38bdf8; margin-bottom: 1rem; }");
            out.println("    p { font-size: 1.1rem; margin: 0.75rem 0; color: #cbd5e1; }");
            out.println("    .highlight { color: #4ade80; font-weight: bold; }");
            out.println("    a { display: inline-block; margin-top: 1.5rem; color: #60a5fa; text-decoration: none; font-weight: bold; }");
            out.println("    a:hover { text-decoration: underline; }");
            out.println("  </style>");
            out.println("</head>");
            out.println("<body>");
            out.println("  <div class='card'>");
            out.println("    <h1>Server-Side Servlet Response</h1>");
            out.println("    <p>Welcome, <span class='highlight'>" + escapeHtml(name) + "</span>!</p>");
            out.println("    <p>Department: <strong>" + escapeHtml(department) + "</strong></p>");
            out.println("    <p>Processed At: <em>" + currentTime + "</em></p>");
            out.println("    <p>Protocol: <code>" + req.getProtocol() + "</code> &bull; Method: <code>" + req.getMethod() + "</code></p>");
            out.println("    <a href='index.html'>&larr; Return to Home Page</a>");
            out.println("  </div>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private String escapeHtml(String input) {
        return input.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
}

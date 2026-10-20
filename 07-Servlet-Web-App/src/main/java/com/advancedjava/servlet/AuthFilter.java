package com.advancedjava.servlet;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Security Authentication Filter.
 * Intercepts requests destined for protected URIs (e.g. /home) and verifies
 * that a valid session exists. Redirects unauthorized users back to index.html.
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = {"/home"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("[AuthFilter] Initialized security filter for protected paths.");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("user") != null);

        if (loggedIn) {
            // User is authenticated, proceed along filter chain
            chain.doFilter(request, response);
        } else {
            // Unauthorized request: redirect to login landing page
            System.out.println("[AuthFilter] Access denied for unauthenticated request to: " + req.getRequestURI());
            resp.sendRedirect(req.getContextPath() + "/index.html");
        }
    }

    @Override
    public void destroy() {
        System.out.println("[AuthFilter] Destroyed.");
    }
}

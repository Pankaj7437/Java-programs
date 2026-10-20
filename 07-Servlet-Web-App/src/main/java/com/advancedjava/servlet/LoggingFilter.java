package com.advancedjava.servlet;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * Request Logging Filter.
 * Intercepts all incoming requests to log URI, HTTP method, client IP,
 * and tracks execution latency in milliseconds.
 */
@WebFilter(filterName = "LoggingFilter", urlPatterns = {"/*"})
public class LoggingFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("[LoggingFilter] Global request logging filter initialized.");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        long startTime = System.currentTimeMillis();

        String uri = req.getRequestURI();
        String method = req.getMethod();
        String remoteAddr = req.getRemoteAddr();

        System.out.printf("[REQUEST] %s %s from %s%n", method, uri, remoteAddr);

        // Continue request processing
        chain.doFilter(request, response);

        long duration = System.currentTimeMillis() - startTime;
        System.out.printf("[RESPONSE] %s %s finished in %d ms%n", method, uri, duration);
    }

    @Override
    public void destroy() {
        System.out.println("[LoggingFilter] Destroyed.");
    }
}

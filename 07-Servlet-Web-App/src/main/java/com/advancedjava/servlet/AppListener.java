package com.advancedjava.servlet;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 * Application Lifecycle Listener.
 * Receives notification events about ServletContext lifecycle changes.
 */
@WebListener
public class AppListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        String appName = sce.getServletContext().getServletContextName();
        System.out.println("==================================================");
        System.out.println("[AppListener] Application initialized: " + appName);
        System.out.println("[AppListener] Context Path: " + sce.getServletContext().getContextPath());
        System.out.println("==================================================");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("[AppListener] Application context destroyed. Resources released.");
    }
}

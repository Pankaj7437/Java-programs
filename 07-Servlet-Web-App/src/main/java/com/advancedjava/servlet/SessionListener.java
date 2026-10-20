package com.advancedjava.servlet;

import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Session Lifecycle Listener.
 * Tracks creation and destruction of user sessions and maintains active count.
 */
@WebListener
public class SessionListener implements HttpSessionListener {

    private static final AtomicInteger ACTIVE_SESSIONS = new AtomicInteger(0);

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        int count = ACTIVE_SESSIONS.incrementAndGet();
        System.out.printf("[SessionListener] New HttpSession created: ID=%s (Active Count: %d)%n",
                se.getSession().getId(), count);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        int count = ACTIVE_SESSIONS.decrementAndGet();
        System.out.printf("[SessionListener] HttpSession destroyed: ID=%s (Active Count: %d)%n",
                se.getSession().getId(), count);
    }

    public static int getActiveSessionCount() {
        return ACTIVE_SESSIONS.get();
    }
}

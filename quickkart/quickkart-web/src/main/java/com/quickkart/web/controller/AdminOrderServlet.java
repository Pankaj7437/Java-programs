package com.quickkart.web.controller;

import com.quickkart.common.model.Order;
import com.quickkart.service.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminOrderServlet", urlPatterns = {"/admin/orders", "/admin/orders/update-status"})
public class AdminOrderServlet extends HttpServlet {
    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Order> orders = orderService.getAllOrders();
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String newStatus = request.getParameter("orderStatus");

            orderService.updateStatus(orderId, newStatus);
            session.setAttribute("flashSuccess", "Order #" + orderId + " status updated to " + newStatus);
        } catch (Exception e) {
            session.setAttribute("flashError", "Failed to update order status: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}

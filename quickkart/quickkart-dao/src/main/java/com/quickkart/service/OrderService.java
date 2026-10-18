package com.quickkart.service;

import com.quickkart.common.model.Order;
import com.quickkart.dao.OrderDAO;

import java.util.List;

public class OrderService {
    private final OrderDAO orderDAO = new OrderDAO();

    public List<Order> getOrdersForUser(int userId) {
        return orderDAO.findByUserId(userId);
    }

    public Order getOrderDetails(int orderId) {
        return orderDAO.findById(orderId);
    }

    public List<Order> getAllOrders() {
        return orderDAO.findAll();
    }

    public boolean updateStatus(int orderId, String newStatus) {
        return orderDAO.updateOrderStatus(orderId, newStatus);
    }

    public int getTotalOrderCount() {
        return orderDAO.countOrders();
    }

    public double getTotalRevenue() {
        return orderDAO.getTotalRevenue();
    }
}

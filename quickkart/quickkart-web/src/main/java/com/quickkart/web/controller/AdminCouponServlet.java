package com.quickkart.web.controller;

import com.quickkart.common.model.Coupon;
import com.quickkart.dao.CouponDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet(name = "AdminCouponServlet", urlPatterns = {
        "/admin/coupons", "/admin/coupons/add", "/admin/coupons/toggle", "/admin/coupons/delete"
})
public class AdminCouponServlet extends HttpServlet {
    private final CouponDAO couponDAO = new CouponDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Coupon> coupons = couponDAO.findAll();
        request.setAttribute("coupons", coupons);
        request.getRequestDispatcher("/admin/coupons.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String servletPath = request.getServletPath();

        if ("/admin/coupons/toggle".equals(servletPath)) {
            try {
                int id = Integer.parseInt(request.getParameter("couponId"));
                boolean current = Boolean.parseBoolean(request.getParameter("status"));
                couponDAO.updateStatus(id, !current);
                session.setAttribute("flashSuccess", "Coupon status updated.");
            } catch (Exception ignored) {}
        } else if ("/admin/coupons/delete".equals(servletPath)) {
            try {
                int id = Integer.parseInt(request.getParameter("couponId"));
                couponDAO.delete(id);
                session.setAttribute("flashSuccess", "Coupon deleted.");
            } catch (Exception ignored) {}
        } else {
            try {
                String code = request.getParameter("code");
                String type = request.getParameter("discountType");
                double val = Double.parseDouble(request.getParameter("discountValue"));
                double minOrder = Double.parseDouble(request.getParameter("minimumOrder"));
                String maxDiscStr = request.getParameter("maximumDiscount");
                Double maxDisc = (maxDiscStr != null && !maxDiscStr.trim().isEmpty()) ? Double.parseDouble(maxDiscStr.trim()) : null;

                Coupon c = new Coupon();
                c.setCode(code);
                c.setDiscountType(type);
                c.setDiscountValue(val);
                c.setMinimumOrder(minOrder);
                c.setMaximumDiscount(maxDisc);
                c.setExpiryDate(Timestamp.valueOf(LocalDateTime.now().plusMonths(6)));
                c.setStatus(true);

                couponDAO.create(c);
                session.setAttribute("flashSuccess", "Coupon created successfully.");
            } catch (Exception e) {
                session.setAttribute("flashError", "Failed to create coupon: " + e.getMessage());
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/coupons");
    }
}

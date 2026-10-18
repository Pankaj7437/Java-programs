package com.quickkart.web.controller;

import com.quickkart.common.model.Category;
import com.quickkart.common.model.Product;
import com.quickkart.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminProductServlet", urlPatterns = {
        "/admin/products", "/admin/products/add", "/admin/products/edit", "/admin/products/delete"
})
public class AdminProductServlet extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> products = productService.getAllProducts();
        List<Category> categories = productService.getAllCategories();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String servletPath = request.getServletPath();

        if ("/admin/products/delete".equals(servletPath)) {
            try {
                int id = Integer.parseInt(request.getParameter("productId"));
                productService.deleteProduct(id);
                session.setAttribute("flashSuccess", "Product successfully removed.");
            } catch (Exception e) {
                session.setAttribute("flashError", "Failed to remove product: " + e.getMessage());
            }
        } else if ("/admin/products/edit".equals(servletPath)) {
            try {
                int id = Integer.parseInt(request.getParameter("productId"));
                Product p = productService.getProductById(id);
                if (p != null) {
                    p.setName(request.getParameter("name"));
                    p.setBrand(request.getParameter("brand"));
                    p.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
                    p.setDescription(request.getParameter("description"));
                    p.setPrice(Double.parseDouble(request.getParameter("price")));
                    p.setDiscount(Double.parseDouble(request.getParameter("discount")));
                    p.setStock(Integer.parseInt(request.getParameter("stock")));
                    p.setImageUrl(request.getParameter("imageUrl"));
                    p.setStatus(request.getParameter("status") != null);

                    productService.updateProduct(p);
                    session.setAttribute("flashSuccess", "Product updated successfully.");
                }
            } catch (Exception e) {
                session.setAttribute("flashError", "Error updating product: " + e.getMessage());
            }
        } else {
            // Add new product
            try {
                Product p = new Product();
                p.setName(request.getParameter("name"));
                p.setBrand(request.getParameter("brand"));
                p.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
                p.setDescription(request.getParameter("description"));
                p.setPrice(Double.parseDouble(request.getParameter("price")));
                p.setDiscount(Double.parseDouble(request.getParameter("discount")));
                p.setStock(Integer.parseInt(request.getParameter("stock")));
                p.setImageUrl(request.getParameter("imageUrl"));
                p.setStatus(true);

                productService.createProduct(p);
                session.setAttribute("flashSuccess", "Product created successfully.");
            } catch (Exception e) {
                session.setAttribute("flashError", "Error creating product: " + e.getMessage());
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}

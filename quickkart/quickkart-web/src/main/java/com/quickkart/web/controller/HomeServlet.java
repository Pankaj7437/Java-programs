package com.quickkart.web.controller;

import com.quickkart.common.model.Category;
import com.quickkart.common.model.Product;
import com.quickkart.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"", "/home", "/index"})
public class HomeServlet extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> categories = productService.getActiveCategories();
        List<Product> allProducts = productService.getAllActiveProducts();

        // 1. Flash Deals: Products with highest discounts
        List<Product> flashDeals = allProducts.stream()
                .filter(p -> p.getDiscount() >= 10.0)
                .sorted((p1, p2) -> Double.compare(p2.getDiscount(), p1.getDiscount()))
                .limit(4)
                .toList();

        // 2. Tech & Gadgets Spotlight (Categories 1, 9, 10, 11)
        List<Product> techProducts = allProducts.stream()
                .filter(p -> p.getCategoryId() == 1 || p.getCategoryId() == 9 || p.getCategoryId() == 10 || p.getCategoryId() == 11)
                .limit(4)
                .toList();

        // 3. Fashion & Lifestyle Spotlight (Categories 2, 6, 7, 8)
        List<Product> fashionProducts = allProducts.stream()
                .filter(p -> p.getCategoryId() == 2 || p.getCategoryId() == 6 || p.getCategoryId() == 7 || p.getCategoryId() == 8)
                .limit(4)
                .toList();

        // 4. New Arrivals (latest products)
        List<Product> newArrivals = allProducts.stream()
                .sorted((p1, p2) -> Integer.compare(p2.getProductId(), p1.getProductId()))
                .limit(4)
                .toList();

        // 5. Featured Essentials
        List<Product> featuredProducts = allProducts.stream().limit(8).toList();

        request.setAttribute("categories", categories);
        request.setAttribute("flashDeals", flashDeals);
        request.setAttribute("techProducts", techProducts);
        request.setAttribute("fashionProducts", fashionProducts);
        request.setAttribute("newArrivals", newArrivals);
        request.setAttribute("featuredProducts", featuredProducts);
        request.setAttribute("totalProductCount", allProducts.size());

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}

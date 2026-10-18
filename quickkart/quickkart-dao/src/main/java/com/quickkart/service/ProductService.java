package com.quickkart.service;

import com.quickkart.common.model.Category;
import com.quickkart.common.model.Product;
import com.quickkart.dao.CategoryDAO;
import com.quickkart.dao.ProductDAO;

import java.util.List;

public class ProductService {
    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    public List<Product> getAllActiveProducts() {
        return productDAO.findAll(true);
    }

    public List<Product> getAllProducts() {
        return productDAO.findAll(false);
    }

    public Product getProductById(int productId) {
        return productDAO.findById(productId);
    }

    public List<Product> getProductsByCategory(int categoryId) {
        return productDAO.findByCategory(categoryId);
    }

    public List<Product> searchProducts(String query, Integer categoryId, Double minPrice, Double maxPrice, String sortBy) {
        return productDAO.searchAndFilter(query, categoryId, minPrice, maxPrice, sortBy);
    }

    public List<Category> getActiveCategories() {
        return categoryDAO.findAll();
    }

    public List<Category> getAllCategories() {
        return categoryDAO.findAllIncludingInactive();
    }

    public boolean createProduct(Product p) {
        return productDAO.create(p);
    }

    public boolean updateProduct(Product p) {
        return productDAO.update(p);
    }

    public boolean deleteProduct(int productId) {
        return productDAO.delete(productId);
    }

    public List<Product> getLowStockAlerts(int threshold) {
        return productDAO.getLowStockProducts(threshold);
    }

    public int getTotalProductCount() {
        return productDAO.countProducts();
    }
}

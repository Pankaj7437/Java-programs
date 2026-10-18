package com.quickkart.web.controller;

import com.quickkart.common.model.Category;
import com.quickkart.dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminCategoryServlet", urlPatterns = {
        "/admin/categories", "/admin/categories/add", "/admin/categories/delete"
})
public class AdminCategoryServlet extends HttpServlet {
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> categories = categoryDAO.findAllIncludingInactive();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/categories.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String servletPath = request.getServletPath();

        if ("/admin/categories/delete".equals(servletPath)) {
            try {
                int id = Integer.parseInt(request.getParameter("categoryId"));
                categoryDAO.delete(id);
                session.setAttribute("flashSuccess", "Category deleted.");
            } catch (Exception e) {
                session.setAttribute("flashError", "Cannot delete category linked to existing products.");
            }
        } else {
            String name = request.getParameter("name");
            String slug = request.getParameter("slug");
            String description = request.getParameter("description");
            String imageUrl = request.getParameter("imageUrl");

            if (slug == null || slug.trim().isEmpty()) {
                slug = name.toLowerCase().replaceAll("[^a-z0-9]+", "-");
            }

            Category cat = new Category();
            cat.setName(name);
            cat.setSlug(slug);
            cat.setDescription(description);
            cat.setImageUrl(imageUrl);
            cat.setStatus(true);

            categoryDAO.create(cat);
            session.setAttribute("flashSuccess", "Category created successfully.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/categories");
    }
}

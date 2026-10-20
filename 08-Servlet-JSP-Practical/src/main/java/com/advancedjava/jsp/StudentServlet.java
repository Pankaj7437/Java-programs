package com.advancedjava.jsp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Controller Servlet for JSP Practical.
 * Extracts student form submission parameters, performs sanitation and validation,
 * stores processed values in request scope attributes, and dispatches control
 * to result.jsp for view rendering (Model-View-Controller pattern).
 *
 * @author Pankaj Sharma
 */
@WebServlet(name = "StudentServlet", urlPatterns = {"/student-process"})
public class StudentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Redirect direct GET access back to student.jsp form
        resp.sendRedirect(req.getContextPath() + "/student.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String roll = request.getParameter("roll");
        String email = request.getParameter("email");
        String course = request.getParameter("course");
        String age = request.getParameter("age");
        String marksStr = request.getParameter("marks");

        // Compute grade or evaluation
        double marks = 0.0;
        try {
            if (marksStr != null && !marksStr.trim().isEmpty()) {
                marks = Double.parseDouble(marksStr);
            }
        } catch (NumberFormatException e) {
            marks = 0.0;
        }

        String grade;
        if (marks >= 90) grade = "A+ (Outstanding)";
        else if (marks >= 80) grade = "A (Excellent)";
        else if (marks >= 70) grade = "B+ (Very Good)";
        else if (marks >= 60) grade = "B (Good)";
        else if (marks >= 50) grade = "C (Satisfactory)";
        else grade = "D (Needs Improvement)";

        // Set request attributes to pass data from Controller to View
        request.setAttribute("name", name != null ? name.trim() : "N/A");
        request.setAttribute("roll", roll != null ? roll.trim() : "N/A");
        request.setAttribute("email", email != null ? email.trim() : "N/A");
        request.setAttribute("course", course != null ? course.trim() : "N/A");
        request.setAttribute("age", age != null ? age.trim() : "N/A");
        request.setAttribute("marks", marks);
        request.setAttribute("grade", grade);

        // Forward request and response to result.jsp
        request.getRequestDispatcher("/result.jsp").forward(request, response);
    }
}

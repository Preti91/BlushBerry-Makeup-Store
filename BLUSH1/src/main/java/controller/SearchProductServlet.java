package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.ProductDAO;
import model.Product;

@WebServlet("/searchProduct")
public class SearchProductServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        ProductDAO dao = new ProductDAO();

        List<Product> list;

        if (keyword == null || keyword.trim().isEmpty()) {
            list = dao.getAllProducts();
        } else {
            list = dao.searchProducts(keyword.trim());
        }

        request.setAttribute("productList", list);

        request.getRequestDispatcher("/jsp/products.jsp")
               .forward(request, response);
    }
}
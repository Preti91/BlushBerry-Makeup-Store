package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.CartDAO;
import dao.DBConnection;
import dao.OrderDAO;
import model.Product;
import model.User;
import model.Order;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    // =========================
    // SHOW ORDER PAGE + HISTORY
    // =========================
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // 🔐 Check login
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {
            OrderDAO dao = new OrderDAO();
            List<Order> orderList = dao.getOrdersByUser(user.getId());

            request.setAttribute("orderList", orderList);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load orders");
        }

        request.getRequestDispatcher("/jsp/order.jsp").forward(request, response);
    }

    // =========================
    // PLACE ORDER (NO QUANTITY)
    // =========================
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // 🔐 Check login
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        CartDAO cartDAO = new CartDAO();
        List<Product> cartList = cartDAO.getCartProducts(user.getId());

        // 🛒 If cart empty
        if (cartList == null || cartList.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/order");
            return;
        }

        // =========================
        // CALCULATE TOTAL (NO QUANTITY)
        // =========================
        double total = 0;

        for (Product p : cartList) {
            total += p.getPrice();   // ✅ ONLY PRICE
        }

        // =========================
        // INSERT ORDER
        // =========================
        try (Connection conn = DBConnection.getConnection()) {

            String sql = "INSERT INTO orders(user_id, total, status) VALUES(?,?,?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, user.getId());
            ps.setDouble(2, total);
            ps.setString(3, "pending");  // default status

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // =========================
        // CLEAR CART
        // =========================
        cartDAO.clearCart(user.getId());
        session.setAttribute("cartCount", 0);

        // =========================
        // REDIRECT
        // =========================
        response.sendRedirect(request.getContextPath() + "/order");
    }
}
package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.CartDAO;
import dao.WishlistDAO;   // ✅ IMPORT ADDED
import model.User;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    // =========================
    // LOAD CART PAGE
    // =========================
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("jsp/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        CartDAO dao = new CartDAO();

        request.setAttribute("cartList", dao.getCartProducts(user.getId()));

        request.getRequestDispatcher("jsp/cart.jsp").forward(request, response);
    }

    // =========================
    // ADD TO CART
    // =========================
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("jsp/login.jsp");
            return;
        }

        try {

            User user = (User) session.getAttribute("user");

            String pid = request.getParameter("productId");
            String qtyStr = request.getParameter("qty");

            System.out.println("RAW productId = " + pid);
            System.out.println("RAW qty = " + qtyStr);
            System.out.println("USER ID = " + user.getId());

            if (pid == null || pid.trim().isEmpty()) {
                System.out.println("❌ PRODUCT ID NULL");
                return;
            }

            int productId = Integer.parseInt(pid);
            int qty = (qtyStr == null || qtyStr.isEmpty()) ? 1 : Integer.parseInt(qtyStr);

            CartDAO dao = new CartDAO();
            dao.addToCart(user.getId(), productId, qty);

            // =========================
            // ✅ REMOVE FROM WISHLIST (NEW LOGIC)
            // =========================
            String fromWishlist = request.getParameter("fromWishlist");

            if (fromWishlist != null) {
                WishlistDAO wdao = new WishlistDAO();
                wdao.remove(user.getId(), productId);
            }

            // =========================
            // REDIRECT
            // =========================
            response.sendRedirect(request.getContextPath() + "/cart");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
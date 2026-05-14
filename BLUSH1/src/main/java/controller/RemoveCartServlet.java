package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.CartDAO;
import model.User;

@WebServlet("/removeCart")
public class RemoveCartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Get product ID from URL
            int productId = Integer.parseInt(request.getParameter("pid"));

            // 2. Get session user
            HttpSession session = request.getSession(false);

            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect("jsp/login.jsp");
                return;
            }

            User user = (User) session.getAttribute("user");

            // 3. Call DAO to remove item
            CartDAO dao = new CartDAO();
            dao.removeFromCart(user.getId(), productId);

            // 4. Redirect back to cart
            response.sendRedirect("cart");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cart"); // fallback
        }
    }
}
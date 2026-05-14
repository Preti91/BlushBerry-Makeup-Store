package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.CartDAO;
import model.User;

@WebServlet("/updateCart")
public class UpdateCartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("pid"));

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("jsp/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        CartDAO dao = new CartDAO();

        if ("increase".equals(action)) {
            dao.increaseQty(user.getId(), productId);
        } 
        else if ("decrease".equals(action)) {
            dao.decreaseQty(user.getId(), productId);
        }

        response.sendRedirect("cart");
    }
}
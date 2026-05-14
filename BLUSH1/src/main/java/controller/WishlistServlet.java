

package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.WishlistDAO;
import model.User;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    // ✅ ADD / REMOVE
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("user");

        // 🔴 Check login
        if(user == null){
            res.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
            return;
        }

        int userId = user.getId();

        int productId = Integer.parseInt(req.getParameter("productId"));
        String action = req.getParameter("action");

        // ✅ NEW (to know from where request came)
        String source = req.getParameter("source");

        WishlistDAO dao = new WishlistDAO();

        if("add".equals(action)){
            if(!dao.exists(userId, productId)){
                dao.add(userId, productId);
            }
        }
        else if("remove".equals(action)){
            dao.remove(userId, productId);
        }

        // ✅ FIXED REDIRECTION
        if("wishlist".equals(source)){
            res.sendRedirect(req.getContextPath() + "/wishlist");
        } else {
            res.sendRedirect(req.getContextPath() + "/products");
        }
    }

    // ✅ LOAD WISHLIST PAGE
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("user");

        if(user == null){
            res.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
            return;
        }

        WishlistDAO dao = new WishlistDAO();

        req.setAttribute("wishlist", dao.getWishlist(user.getId()));

        RequestDispatcher rd = req.getRequestDispatcher("/jsp/wishlist.jsp");
        rd.forward(req, res);
    }
}
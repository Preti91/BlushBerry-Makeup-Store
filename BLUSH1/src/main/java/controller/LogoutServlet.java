package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get session if exists
        HttpSession session = request.getSession(false);

        if (session != null) {
            session.invalidate(); // destroy session
        }

        // redirect after logout (HOME PAGE)
        response.sendRedirect(request.getContextPath() + "/jsp/home.jsp");
    }
}
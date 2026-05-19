package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.UserDAO;
import model.User;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // NEW
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // UPDATED CONSTRUCTOR
        User user = new User(name, email, password, phone, address);

        UserDAO dao = new UserDAO();
        boolean status = dao.register(user);

        if (status) {

            // SUCCESS
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");

        } else {

            // FAILED
            response.sendRedirect(request.getContextPath() + "/jsp/signup.jsp?error=1");
        }
    }
}

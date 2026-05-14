package controller;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.DBConnection;

@WebServlet("/admin")
@MultipartConfig
public class AdminServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if (action == null) {
            res.getWriter().println("ERROR: action missing");
            return;
        }

        try (Connection con = DBConnection.getConnection()) {

            // =====================
            // ADD PRODUCT
            // =====================
            if ("add".equals(action)) {

                String name = req.getParameter("name");
                double price = Double.parseDouble(req.getParameter("price"));
                Date deliveryDate = Date.valueOf(req.getParameter("delivery_date"));

                Part filePart = req.getPart("image");
                String fileName = filePart.getSubmittedFileName();
                String imageName = "";

                if (fileName != null && !fileName.isEmpty()) {

                    String path = getServletContext().getRealPath("/images");
                    File dir = new File(path);
                    if (!dir.exists()) dir.mkdirs();

                    filePart.write(path + File.separator + fileName);
                    imageName = fileName;
                }

                PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO products(name, price, delivery_date, image) VALUES(?,?,?,?)"
                );

                ps.setString(1, name);
                ps.setDouble(2, price);
                ps.setDate(3, deliveryDate);
                ps.setString(4, imageName);

                ps.executeUpdate();

                // ✅ FIXED REDIRECT
                res.sendRedirect(req.getContextPath() + "/jsp/admin.jsp");
            }

            // =====================
            // UPDATE PRODUCT
            // =====================
            else if ("update".equals(action)) {

                int id = Integer.parseInt(req.getParameter("id"));
                String name = req.getParameter("name");
                double price = Double.parseDouble(req.getParameter("price"));
                Date deliveryDate = Date.valueOf(req.getParameter("delivery_date"));

                Part filePart = req.getPart("image");
                String fileName = filePart.getSubmittedFileName();

                if (fileName != null && !fileName.isEmpty()) {

                    String path = getServletContext().getRealPath("/images");
                    File dir = new File(path);
                    if (!dir.exists()) dir.mkdirs();

                    filePart.write(path + File.separator + fileName);

                    PreparedStatement ps = con.prepareStatement(
                            "UPDATE products SET name=?, price=?, delivery_date=?, image=? WHERE id=?"
                    );

                    ps.setString(1, name);
                    ps.setDouble(2, price);
                    ps.setDate(3, deliveryDate);
                    ps.setString(4, fileName);
                    ps.setInt(5, id);

                    ps.executeUpdate();

                } else {

                    PreparedStatement ps = con.prepareStatement(
                            "UPDATE products SET name=?, price=?, delivery_date=? WHERE id=?"
                    );

                    ps.setString(1, name);
                    ps.setDouble(2, price);
                    ps.setDate(3, deliveryDate);
                    ps.setInt(4, id);

                    ps.executeUpdate();
                }

                // ✅ FIXED REDIRECT
                res.sendRedirect(req.getContextPath() + "/jsp/admin.jsp");
            }

            // =====================
            // DELETE PRODUCT
            // =====================
            else if ("delete".equals(action)) {

                int id = Integer.parseInt(req.getParameter("id"));

                PreparedStatement ps = con.prepareStatement(
                        "DELETE FROM products WHERE id=?"
                );

                ps.setInt(1, id);
                ps.executeUpdate();

                // ✅ FIXED REDIRECT
                res.sendRedirect(req.getContextPath() + "/jsp/admin.jsp");
            }

            // =====================
            // UPDATE ORDER STATUS
            // =====================
            else if ("updateStatus".equals(action)) {

                int orderId = Integer.parseInt(req.getParameter("orderId"));
                String status = req.getParameter("status");

                PreparedStatement ps = con.prepareStatement(
                        "UPDATE orders SET status=? WHERE id=?"
                );

                ps.setString(1, status.toLowerCase());
                ps.setInt(2, orderId);

                ps.executeUpdate();

                res.sendRedirect(req.getContextPath() + "/jsp/admin.jsp");
            }

            // =====================
            // LOGOUT ADMIN
            // =====================
            else if ("logout".equals(action)) {

                HttpSession session = req.getSession(false);

                if (session != null) {
                    session.invalidate();
                }

                res.sendRedirect(req.getContextPath() + "/jsp/home.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().println("ERROR: " + e.getMessage());
        }
    }
}
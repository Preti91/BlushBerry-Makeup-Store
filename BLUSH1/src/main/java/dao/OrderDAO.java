package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Order;

public class OrderDAO {

    // ==============================
    // GET ORDERS BY USER
    // ==============================
    public List<Order> getOrdersByUser(int userId) {

        List<Order> list = new ArrayList<>();

        String sql = "SELECT id, user_id, total, order_date, status FROM orders WHERE user_id=? ORDER BY id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Order o = new Order();

                    o.setId(rs.getInt("id"));
                    o.setUserId(rs.getInt("user_id"));
                    o.setTotalAmount(rs.getDouble("total"));

                    // ✅ safer handling of date
                    Timestamp ts = rs.getTimestamp("order_date");
                    if (ts != null) {
                        o.setOrderDate(ts.toString());
                    }

                    o.setStatus(rs.getString("status"));

                    list.add(o);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ==============================
    // PLACE ORDER (NO QUANTITY)
    // ==============================
    public boolean placeOrder(int userId, double total) {

        String sql = "INSERT INTO orders(user_id, total, status) VALUES(?,?,?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setDouble(2, total);
            ps.setString(3, "pending");

            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
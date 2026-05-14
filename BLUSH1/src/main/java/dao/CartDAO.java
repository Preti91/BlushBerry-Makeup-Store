package dao;

import java.sql.*;
import java.util.*;
import model.Product;

public class CartDAO {

    // =========================
    // ADD TO CART
    // =========================
    public void addToCart(int userId, int productId, int qty) {

        try (Connection conn = DBConnection.getConnection()) {

            String check = "SELECT quantity FROM cart WHERE user_id=? AND product_id=?";
            PreparedStatement ps = conn.prepareStatement(check);

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String update = "UPDATE cart SET quantity = quantity + ? WHERE user_id=? AND product_id=?";
                PreparedStatement ps2 = conn.prepareStatement(update);

                ps2.setInt(1, qty);
                ps2.setInt(2, userId);
                ps2.setInt(3, productId);

                ps2.executeUpdate();

            } else {

                String insert = "INSERT INTO cart(user_id, product_id, quantity) VALUES(?,?,?)";
                PreparedStatement ps3 = conn.prepareStatement(insert);

                ps3.setInt(1, userId);
                ps3.setInt(2, productId);
                ps3.setInt(3, qty);

                ps3.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =========================
    // GET CART PRODUCTS
    // =========================
    public List<Product> getCartProducts(int userId) {

        List<Product> list = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT p.id, p.name, p.price, p.image, p.delivery_date, c.quantity " +
                         "FROM products p " +
                         "JOIN cart c ON p.id = c.product_id " +
                         "WHERE c.user_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Product p = new Product();

                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setImage(rs.getString("image"));
                p.setDeliveryDate(rs.getDate("delivery_date"));
                p.setQuantity(rs.getInt("quantity"));

                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =========================
    // CLEAR CART
    // =========================
    public void clearCart(int userId) {

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "DELETE FROM cart WHERE user_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =========================
    // REMOVE ITEM
    // =========================
    public void removeFromCart(int userId, int productId) {

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "DELETE FROM cart WHERE user_id=? AND product_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =========================
    // INCREASE QTY
    // =========================
    public void increaseQty(int userId, int productId) {

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "UPDATE cart SET quantity = quantity + 1 WHERE user_id=? AND product_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =========================
    // DECREASE QTY (SAFE)
    // =========================
    public void decreaseQty(int userId, int productId) {

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "UPDATE cart SET quantity = quantity - 1 " +
                         "WHERE user_id=? AND product_id=? AND quantity > 1";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =========================
    // 🔥 FIXED CART COUNT (MAIN ISSUE)
    // =========================
    public int getCartCount(int userId) {

        int count = 0;

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT COALESCE(SUM(quantity), 0) FROM cart WHERE user_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
}
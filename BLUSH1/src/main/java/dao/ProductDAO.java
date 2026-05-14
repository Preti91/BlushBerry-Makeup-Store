package dao;

import java.sql.*;
import java.util.*;
import model.Product;

public class ProductDAO {

    Connection conn = DBConnection.getConnection();

    // =========================
    // GET ALL PRODUCTS
    // =========================
    public List<Product> getAllProducts() {

        List<Product> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM products";
            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Product p = new Product();

                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setImage(rs.getString("image"));
                p.setDeliveryDate(rs.getDate("delivery_date"));

                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =========================
    // SEARCH PRODUCTS (FIXED)
    // =========================
    public List<Product> searchProducts(String keyword) {

        List<Product> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM products WHERE name LIKE ?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Product p = new Product();

                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setImage(rs.getString("image"));
                p.setDeliveryDate(rs.getDate("delivery_date"));

                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
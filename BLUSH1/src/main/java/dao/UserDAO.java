package dao;

import java.sql.*;
import model.User;

public class UserDAO {

    // 🔹 REGISTER
    public boolean register(User u) {

        boolean f = false;

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "INSERT INTO users(name,email,password,phone,address,role) VALUES(?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, u.getName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());

            // NEW
            ps.setString(4, u.getPhone());
            ps.setString(5, u.getAddress());

            // default role
            ps.setString(6, "USER");

            int i = ps.executeUpdate();

            f = i == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

    // 🔹 LOGIN
    public User login(String email, String password) {

        User user = null;

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                user = new User();

                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));

                // NEW
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));

                // ROLE
                user.setRole(rs.getString("role"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}

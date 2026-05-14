package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {

        Connection con = null;

        try {
            System.out.println("🔍 Loading Driver...");

            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("🔍 Connecting to Database...");

            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/makeup_store?useSSL=false&serverTimezone=UTC",
                "root",
                "preti@9123040662@"   // ✔ your password
            );

            System.out.println("✅ Database Connected Successfully");

        } catch (Exception e) {
            System.out.println("❌ Database Connection Failed");
            e.printStackTrace();   // 🔥 VERY IMPORTANT
        }

        return con;
    }
}
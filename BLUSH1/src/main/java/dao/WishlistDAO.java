

package dao;

import java.sql.*;
import java.util.*;
import model.Product;

public class WishlistDAO {

    Connection conn = DBConnection.getConnection();

    public boolean exists(int userId, int productId){
        try{
            String sql="SELECT * FROM wishlist WHERE user_id=? AND product_id=?";
            PreparedStatement ps=conn.prepareStatement(sql);
            ps.setInt(1,userId);
            ps.setInt(2,productId);
            ResultSet rs=ps.executeQuery();
            return rs.next();
        }catch(Exception e){ e.printStackTrace(); }
        return false;
    }

    public void add(int userId, int productId){
        try{
            String sql="INSERT INTO wishlist(user_id,product_id) VALUES(?,?)";
            PreparedStatement ps=conn.prepareStatement(sql);
            ps.setInt(1,userId);
            ps.setInt(2,productId);
            ps.executeUpdate();
        }catch(Exception e){ e.printStackTrace(); }
    }

    public void remove(int userId, int productId){
        try{
            String sql="DELETE FROM wishlist WHERE user_id=? AND product_id=?";
            PreparedStatement ps=conn.prepareStatement(sql);
            ps.setInt(1,userId);
            ps.setInt(2,productId);
            ps.executeUpdate();
        }catch(Exception e){ e.printStackTrace(); }
    }

    public List<Product> getWishlist(int userId){
        List<Product> list = new ArrayList<>();
        try{
            String sql = "SELECT p.* FROM products p JOIN wishlist w ON p.id=w.product_id WHERE w.user_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1,userId);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setImage(rs.getString("image"));
                list.add(p);
            }

        }catch(Exception e){ e.printStackTrace(); }
        return list;
    }

    // ✅ IMPORTANT FOR ❤️ TOGGLE
    public Set<Integer> getWishlistIds(int userId){

        Set<Integer> set = new HashSet<>();

        try{
            String sql = "SELECT product_id FROM wishlist WHERE user_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                set.add(rs.getInt("product_id"));
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return set;
    }
}
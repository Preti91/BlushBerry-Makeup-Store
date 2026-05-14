import java.sql.Connection;
import dao.DBConnection;

public class TestDB {
    public static void main(String[] args) {
        Connection con = DBConnection.getConnection();

        if(con != null) {
            System.out.println("Connection Successful ✅");
        } else {
            System.out.println("Connection Failed ❌");
        }
    }
}
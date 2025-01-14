/*
package DDBB;


import java.sql.*;
import javax.sql.DataSource;
import org.apache.commons.dbcp.BasicDataSource;

public class Conexion {
    private static final String JDBC_URL = "jdbc:postgresql://localhost:5432/barberhr";
    private static final String JDBC_USER = "postgres";
    private static final String JDBC_PASSWORD = "123456";
    
    public static DataSource getDataSource(){
        BasicDataSource ds = new BasicDataSource();
        ds.setUrl(JDBC_URL);
        ds.setUsername(JDBC_USER);
        ds.setPassword(JDBC_PASSWORD);
        return ds;
    }
    public static Connection getConnection() throws SQLException{
        return getDataSource().getConnection();
    }
    
    public static void close(ResultSet rs){
        try {
            rs.close();
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        }
    }
    
    public static void close(PreparedStatement stmt){
        try {
            stmt.close();
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        }
    }
    
    public static void close(Connection conn){
        try {
            conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        }
    }
}
*/
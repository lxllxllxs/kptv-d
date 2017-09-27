package com.xly.ess.util;
  
import java.sql.*;    
import javax.sql.*;    
  
/** 
 * 连接mysql数据库的工具类，用来作为DownloadPicture进行数据库连接的辅助类 
 * @author Administrator 
 * 
 */  
public final class JdbcUtil {    
    //下列配置换成相应内容即可  
    private static String url = "jdbc:mysql://59.110.143.46:3306/xly";  
    private static String user = "root";  
    private static String password = "root";    
        
    private JdbcUtil() { }    
        
    static {    
        try {    
            Class.forName("com.mysql.jdbc.Driver");    
        } catch (ClassNotFoundException e) {    
            throw new ExceptionInInitializerError(e);    
        }    
    }    
    
    public static Connection getConnection() throws SQLException{    
        return DriverManager.getConnection(url, user, password);    
    }    
        
    public static void free(ResultSet rs, Statement st, Connection conn) {    
        try {    
            if (rs != null) {    
                rs.close();    
            }    
        } catch (SQLException e) {    
            e.printStackTrace();    
        } finally {    
            try {    
                if (st != null) {    
                    st.close();    
                }    
            } catch (SQLException e) {    
                e.printStackTrace();    
            } finally {    
                if (conn != null) {    
                    try {    
                        conn.close();    
                    } catch (SQLException e) {    
                        e.printStackTrace();    
                    }    
                }    
            }    
        }    
    }    
}    
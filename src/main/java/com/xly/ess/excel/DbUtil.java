package com.xly.ess.excel;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.xly.ess.util.Log4jUtil;

public class DbUtil {

	
	public static void main(String[] a){
	}
	
	//这里改为服务器地址
////final static String db="59.110.143.46:3306/xly?useUnicode=true&characterEncoding=utf-8";
//final static String db="127.0.0.1:3306/xly?useUnicode=true&characterEncoding=utf-8";
final static String db="192.168.10.190:3306/xly?useUnicode=true&characterEncoding=utf-8";
final static String userName="root";
//final static String password="root";
final static String password="xly123";
	public static int batchImportCtm(List<Map<String,Object>> list, int salesMgrId){
		try {
			Class.forName("com.mysql.jdbc.Driver");
        Connection con = (Connection)DriverManager.getConnection("jdbc:mysql://" +  
        		db,userName, password);  
        // 关闭事务自动提交  
        con.setAutoCommit(false);  

        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss:SS");  
        TimeZone t = sdf.getTimeZone();  
        t.setRawOffset(0);  
        sdf.setTimeZone(t);  
        Long startTime =System.currentTimeMillis();  
        //默认客户选择为 2：普通
        PreparedStatement pst =(PreparedStatement) con
        		.prepareStatement("insert into xly_customer (CTM_NAME,TYPE_ID,ADDRESS,SHOP_NAME,SALES_MGR_ID,GRT_MONEY,IMPORT_MONEY) values (?,2,?,?,?,?,?)");  
        double grtMoney=0;
        double importMoney=0;
        for (int i = 0; i < list.size(); i++){  
        	Map<String,Object> map=list.get(i);
        	grtMoney=Double.valueOf(map.get("GRT_MONEY").toString());
        	importMoney=Double.valueOf(map.get("IMPORT_MONEY").toString());
        	
        	 pst.setString(1, map.get("CTM_NAME").toString());  
            pst.setString(2, map.get("ADDRESS").toString());  
            pst.setString(3, map.get("SHOP_NAME").toString());  //备注即店名
            pst.setInt(4, salesMgrId);  //备注即店名
            pst.setInt(5,(int)grtMoney);
            //系统要入的余额等于 导表的余额+押金
            pst.setDouble(6,importMoney+grtMoney);
            // 把一个SQL命令加入命令列表  
            pst.addBatch();  
        }  
        // 执行批量更新  
        pst.executeBatch();  
        // 语句执行完毕，提交本事务  
        con.commit();  

        Long endTime =System.currentTimeMillis();  
        System.out.println("用时：" + sdf.format(new Date(endTime - startTime)));  

        pst.close();  
        con.close();  
        return 1;
		} catch (ClassNotFoundException|SQLException e) {
			e.printStackTrace();
			Log4jUtil.error(e);
		}  
		  return 0;
	}
}

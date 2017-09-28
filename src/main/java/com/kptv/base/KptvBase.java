package com.kptv.base;

import java.sql.SQLException;
import java.sql.Statement;

import com.xly.ess.util.JdbcUtil;

public class KptvBase {
	
	public void print(Object obj){
		System.out.println(obj.toString());
	}
	
   public void updateBySQL(String sql) throws SQLException{
    	Statement stm = JdbcUtil.getConnection().createStatement(); //访问数据库
    	stm.execute(sql);
    }
	    
}

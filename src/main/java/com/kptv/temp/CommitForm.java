package com.kptv.temp;

import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.Headers;
import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

import com.kptv.base.KptvBase;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;
import com.xly.ess.util.CCRDFile;
import com.xly.ess.util.JdbcUtil;

public class CommitForm extends KptvBase{
	private OkHttpClient mClient=new OkHttpClient();
	
	public static void main(String[] a) throws IOException{
		new CommitForm().readNewAndCommit();
		
	}
	 public void   readNewAndCommit() {  
	        try {  
	            Connection connection = (Connection) JdbcUtil.getConnection();  
	            Statement statement = (Statement) connection.createStatement();  
	            String sql = "select * from kptv_temp"; //查询语句换位相应select语句  
	            ResultSet resultSet = statement.executeQuery(sql);  
	            while (resultSet.next()) {  
	                String id = resultSet.getString("ID");  
	                String childName = resultSet.getString("childName");  
	                String kindergarten = resultSet.getString("kindergarten");  
	                String phone = resultSet.getString("phone");  
	                String parentName = resultSet.getString("parentName");  
	                String urlS = resultSet.getString("urlS");  //注意这里获取的是最新的
	                
	                //切割链接 获得链接集合
	                urlS=urlS.replaceAll("@@", "#");
	                commitVoteForm(Integer.valueOf(id),childName,urlS);
	            }  
	            JdbcUtil.free(resultSet, statement, connection);  
	        } catch (SQLException e) {  
	            e.printStackTrace();  
	        }  
	    }  
	 
	 /**
	  * 投票表单 暂时只有宝贝姓名最重要
	  * @param childName
	  * @param urlString
	  */
	 private void commitVoteForm(final int id,String childName,String urlString) {
	    	MultipartBody.Builder bulider=   new MultipartBody.Builder().setType(MultipartBody.FORM);
	    	String[] imgUrls=urlString.split("#");
	    	for(String url:imgUrls){
	    		bulider.addPart(  
	                    Headers.of("Content-Disposition", "form-data; name=\"vote_img_show[]\""),  
	                    RequestBody.create(MediaType.parse("application/x-www-form-urlencoded"), url)) ; 
	    	}
	    	bulider
             .addPart(  
                    Headers.of("Content-Disposition", "form-data; name=\"vote_img\""),  
                    RequestBody.create(MediaType.parse("application/x-www-form-urlencoded"), ""+imgUrls[0]))
                    .addFormDataPart("vote_id","1450" )//投票Id 不是投票项id
                    .addFormDataPart("token", "mxhnai1470103415")
                    .addFormDataPart("vote_title", childName) 
                    .addFormDataPart("username",  childName)
                    .addFormDataPart("manifesto", "宣言无")
                    .addFormDataPart("introduction", "介绍无")
                    .addFormDataPart("contacts", "")      
                    .addFormDataPart( "vote_img", imgUrls[0]);
                     
	    	RequestBody requestBody =bulider.build();
	        //采用post方式提交
	        Request request = new Request.Builder()
	        .url(Constant.addVoteItem)
	        .post(requestBody)
	        .addHeader("Cookie", Constant.cookie)
	        .addHeader("Referer","http://weixin.121mai.com/index.php?g=Ucenter&m=Vote2&a=add_item&token=mxhnai1470103415&vote_id=1450")
	        .build();
	        mClient.newCall(request).enqueue(new Callback() {
				@Override
				public void onFailure(Call call, IOException e) {
					print(e.getMessage());
					String sql="UPDATE `kptv_temp` SET add_state=2  WHERE ID="+id;
					try {
						updateBySQL(sql);
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				}
				@Override
				public void onResponse(Call call, Response response)
						throws IOException {
					print(response.message());
					try {
						String sql="UPDATE `kptv_temp` SET add_state=1  WHERE ID="+id;
						updateBySQL(sql);
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				}
	        });
	    }
}

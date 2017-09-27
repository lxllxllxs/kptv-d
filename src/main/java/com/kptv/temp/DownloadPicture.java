package com.kptv.temp;
  
import java.io.DataInputStream;  
import java.io.File;  
import java.io.FileOutputStream;  
import java.io.IOException;  
import java.net.MalformedURLException;  
import java.net.URL;  
import java.sql.ResultSet;  
import java.sql.SQLException;  
import java.util.ArrayList;  
import java.util.Arrays;

import org.apache.commons.lang3.ArrayUtils;
  
import com.mysql.jdbc.Connection;  
import com.mysql.jdbc.Statement;  
import com.xly.ess.util.CCRDFile;
import com.xly.ess.util.JdbcUtil;
  
public class DownloadPicture {  
	private static final String FILE_PATH="D:/kpbtv/lxl/";
  
    public static void main(String[] args) {  
    	DownloadPicture downloadPicture = new DownloadPicture();  
    	downloadPicture.readUrlList();
    	  	
    }  
  
     /** 
     * 传入要下载的图片的url列表，将url所对应的图片下载到本地 
     * 1.获取所有数据集
     * 2.读取数据行
     * 3.一行数据包括：1.宝贝姓名2.宝贝幼儿园3.家长手机号4家长姓名5.图片链接字符串
     * 4.每行数据以 宝贝姓名+家长姓名+手机号+幼儿园建立文件夹
     * 5.分割图片链接字符串，逐个下载保存
     * @param urlList 
     */  
    private void downloadPicture(ArrayList<String> urlList,String filePath) {  
        URL url = null;  
        int imageNumber = 0;  
        for (String urlString : urlList) {  
            try {  
                url = new URL(urlString);  
                DataInputStream dataInputStream = new DataInputStream(url.openStream());  
                String imageName = FILE_PATH+filePath+"/"+imageNumber + ".jpg";  //实际保存路径
                FileOutputStream fileOutputStream = new FileOutputStream(new File(imageName));  
                byte[] buffer = new byte[1024];  
                int length;  
                while ((length = dataInputStream.read(buffer)) > 0) {  
                    fileOutputStream.write(buffer, 0, length);  
                }  
                dataInputStream.close();  
                fileOutputStream.close();  
                imageNumber++;  
            } catch (MalformedURLException e) {  
                e.printStackTrace();  
            } catch (IOException e) {  
                e.printStackTrace();  
            }  
        }  
    }  
  
    /** 
     * 连接mysql数据库，通过查询数据库读取要下载的图片的url列表 
     * 一行数据包括：
     * 1.宝贝姓名 childName
     * 2.宝贝幼儿园   kindergarten
     * 3.家长手机号  phone
     * 4家长姓名    parentName
     * 5.图片链接字符串  urlString
     * @return 
     */  
    public void   readUrlList() {  
        ArrayList<String> urlList =null;  
        try {  
            Connection connection = (Connection) JdbcUtil.getConnection();  
            Statement statement = (Statement) connection.createStatement();  
            String sql = "select * from kptv_temp"; //查询语句换位相应select语句  
            ResultSet resultSet = statement.executeQuery(sql);  
            resultSet.next();
            while (resultSet.next()) {  
                String id = resultSet.getString("ID");  
                String childName = resultSet.getString("childName");  
                String kindergarten = resultSet.getString("kindergarten");  
                String phone = resultSet.getString("phone");  
                String parentName = resultSet.getString("parentName");  
                String urlString = resultSet.getString("urlString");  
                //创建文件夹
                String dirsName=childName+" "+kindergarten+" "+parentName+" "+phone;//暂时不用
                CCRDFile.createDir(FILE_PATH+id);
                //切割链接 获得链接集合
                urlString=urlString.replaceAll("@@", "#");
                urlList= new ArrayList<String>(Arrays.asList(urlString.split("#")));
                downloadPicture(urlList,dirsName);
            }  
            JdbcUtil.free(resultSet, statement, connection);  
        } catch (SQLException e) {  
            e.printStackTrace();  
        }  
  
    }  
  
    
    
    
    
    
    
    
    
    
    
}  
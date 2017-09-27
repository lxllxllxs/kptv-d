package com.kptv.temp;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.FormBody;
import okhttp3.FormBody.Builder;
import okhttp3.Headers;
import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.junit.Test;

import com.kptv.base.KptvBase;
import com.xly.ess.util.Log4jUtil;


public class Upload extends KptvBase{
	
	private OkHttpClient mClient=new OkHttpClient();
	public static void main(String[] a) throws IOException{
		Upload upload=new Upload();
		File file =new File("D:/kpbtv/lxl/");
		File [] lists=file.listFiles();
		for(File folder:lists){
			if(folder.isDirectory()) { 
				upload.step2(file);
			}
		}
	}
	
	
	/**
     * 模拟表单提交
     *传进来的必是一个目录 目录名即为数据库里的id　用作更新
     */
    public void step2(File file) {
    	final int id= Integer.valueOf(file.getName());
    	MultipartBody.Builder bulider=   new MultipartBody.Builder().setType(MultipartBody.FORM);
    	File [] lists=null;
    	if(file.isDirectory()) {  //判断file是否是目录 
    		print("这是目录");
    		lists=file.listFiles();
    	}else{
    		print("这不是目录！");
    	}
    	final int count =lists.length;//该文件夹下有多少图片
    	for(int i =0;i<lists.length;i++){
    		bulider.addPart(
                    Headers.of("Content-Disposition", "form-data; name=\"upload_file"+i+"\"; filename=\"" + lists[i].getName() + "\""),  
                    RequestBody.create(MediaType.parse("image/jpeg"), lists[i]));
    	}
    	RequestBody requestBody =bulider.build();  
        //采用post方式提交
        Request request = new Request.Builder().url(Constant.uploadUrl).post(requestBody).build();
        mClient.newCall(request).enqueue(new Callback() {
			@Override
			public void onFailure(Call call, IOException e) {
				print(e.getMessage());
			}
			@Override
			public void onResponse(Call call, Response response)
					throws IOException {
				System.out.print(response.message());
				try {
					getLastImgs(id,count);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
        });
    }
    
    /**
     * 根据图片数获取对应数量的图片链接（依据 ：按最新的排序）
     * 拼接再更新数据库
     * @throws SQLException 
     * */
    public void getLastImgs(int  id,int  count) throws IOException, SQLException{
		Document doc = Jsoup.connect(Constant.url)
				.header("Accept", "*/*")
				.header("Cookie", Constant.cookie)
				.header("Accept-Encoding", "gzip, deflate,sdch")
				.header("Accept-Language", "zh-CN,zh;q=0.8,en-US;q=0.5,en;q=0.3")
				.header("Referer", Constant.referer)
				.header("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:48.0) Gecko/20100101 Firefox/48.0")
				.timeout(5000)
				.get();
		Elements imgs = doc.select("img[src$=.jpg_600x]");
		StringBuilder sb=new StringBuilder();
		if(imgs.size()<count){
			print("获取最新图片错误！");
			return;
		}
		//解析拼接
		for(int i=0;i<count;i++){
			String linkHref = imgs.get(i).attr("src");
			sb.append(linkHref).append("#");
			print(linkHref);
		}
		if(sb.length()<1){
			print("解析失败！");
			String sql="UPDATE `kptv_temp` SET upload_state=2 WHERE ID="+id;
			updateBySQL(sql);
			return;
		}
		//写入数据库
		String sql="UPDATE `kptv_temp` SET upload_state=1,urlS= '"+sb.toString()+"' WHERE ID="+id;
		updateBySQL(sql);
	}
    
    @Test
    public void test() throws SQLException{
    	String sql="UPDATE `kptv_temp` SET urlS= "+"'asdasdasdasd'"+" WHERE ID="+1;
		updateBySQL(sql);
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}

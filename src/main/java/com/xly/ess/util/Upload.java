package com.xly.ess.util;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import okhttp3.Call;
import okhttp3.Callback;
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


public class Upload {
	String url="http://weixin.121mai.com/index.php?g=Ucenter&m=Fileupload&a=source_material&token=mxhnai1470103415&width=600&style=600x";
	String cookie="Hm_lvt_5a82e19eca56d4f6a9392d9f4aa63e9c=1504575354; _pk_id.256.b426=3c559477d2726382.1504575354.1.1504575503.1504575354.; jump_token=mxhnai1470103415; PHPSESSID=jutvhr28b0qvebpma07hbsgd62";
	String referer="http://weixin.121mai.com/index.php?g=Ucenter&m=Vote2&a=add_item&token=mxhnai1470103415&vote_id=1450";
	
	String uploadUrl="http://weixin.121mai.com/index.php?g=Ucenter&m=Fileupload&a=upload_images&token=mxhnai1470103415&style=600x&group_id=52";//52为测试组
	
	private OkHttpClient mClient=new OkHttpClient();
	public static void main(String[] a) throws IOException{
//		new Upload().getLast6Imgs();
//		File file=new File("C:/1.jpg");
		File file =new File("C:/kpbtv/lxl/测试幼儿园/");
		new Upload().sendComplexForm(file);
	}
	
	/**
     * 模拟表单提交
     *传进来的必是一个目录
     */
    public void sendComplexForm(File file) {
//    	RequestBody fileBody = RequestBody.create(MediaType.parse("image/jpeg"), file);  
    	MultipartBody.Builder bulider=   new MultipartBody.Builder().setType(MultipartBody.FORM);
    	File [] lists=null;
    	if(file.isDirectory()) {  //判断file是否是目录 
    		System.out.print("这是目录");
    		lists=file.listFiles();
    	}else{
    		System.out.print("这不是目录！");
    	}
    	for(int i =0;i<lists.length;i++){
    		bulider.addPart(
                    Headers.of("Content-Disposition", "form-data; name=\"upload_file"+i+"\"; filename=\"" + file.getName() + "\""),  
                    RequestBody.create(MediaType.parse("image/jpeg"), file));
    	}
    	RequestBody requestBody =bulider
                
//                .addPart(  
//                        Headers.of("Content-Disposition", "form-data; name=\"imagetype\""),  
//                        RequestBody.create(null, imageType))  
           /*     .addPart(  
                        Headers.of("Content-Disposition", "form-data; name=\"upload_file0\""),  
                        RequestBody.create(null, "asdasd"))*/
//                .addFormDataPart("file", "head_image", fileBody)  
                .build();  
        //采用post方式提交
        Request request = new Request.Builder().url(uploadUrl).post(requestBody).build();
        mClient.newCall(request).enqueue(new Callback() {
			@Override
			public void onFailure(Call call, IOException e) {
				System.out.print(e.getMessage());
			}
			@Override
			public void onResponse(Call call, Response response)
					throws IOException {
				System.out.print(response.message());
			}
        });
    }
	
	public void getLast6Imgs() throws IOException{
		Document doc = Jsoup.connect(url)
				.header("Accept", "*/*")
				.header("Cookie", cookie)
				.header("Accept-Encoding", "gzip, deflate,sdch")
				.header("Accept-Language", "zh-CN,zh;q=0.8,en-US;q=0.5,en;q=0.3")
				.header("Referer", referer)
				.header("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:48.0) Gecko/20100101 Firefox/48.0")
				.timeout(5000)
				.get();
		
		Elements imgs = doc.select("img[src$=.jpg_600x]");
		for(Element img:imgs){
			String linkHref = img.attr("src");
			System.out.print(linkHref);
		}
	}
	
	/**
	 * 遍历父目录下所有文件夹，每个子文件夹都是一个item,包含报名信息和图片
	 * 
	 * @param file
	 */
	 public static void list(File file){  
	    if(file.isDirectory()) {  //判断file是否是目录 
	        File [] lists = file.listFiles();  
	        if(lists!=null){  
	            for(int i=0;i<lists.length;i++)  {
	                    list(lists[i]);//是目录就递归进入目录内再进行判断  
	                }  
	        }  
	      }  
	        System.out.println(file);//file不是目录，就输出它的路径名，这是递归的出口  
	    }  
}

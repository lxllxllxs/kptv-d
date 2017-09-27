package com.xly.ess.util;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.stereotype.Component;

import com.bstek.bdf2.core.context.ContextHolder;
import com.bstek.dorado.web.DoradoContext;
import com.xly.ess.base.base.framework.exception.MyLoginException;
@Component
public class BaseUtil {
	//检查必须的其他配置 如日志目录等
	static{
		checkFloder();
	}
	
	public static void main(String[] a){
	}
	 // 判断文件夹是否存在
    public static void checkFloder() {
    	String[] files={"D:/logs/xly/"
    			};
    	for(String filePath:files){
    		File file=new File(filePath);
    		check(file);
    	}
    	
        
    }
    
    private static void check(File file){
    	if (file.exists()) {
            if (file.isDirectory()) {
                System.out.println("日志文件夹存在");
            } else {
                System.out.println("同名文件已经存在, 无法创建目录");
            }
        } else {
            System.out.println("文件夹不存在，正在创建"+file.getAbsolutePath());
            //需要连带创建父目录
            file.mkdirs();
        }
    }
	
	/**
	 * 获取uuid 去掉中间-
	 * @return
	 */
	public String getUuid(){
		 String uuid = UUID.randomUUID().toString(); 
		 String s = uuid.toString().replace("-", "");
		 return s;
	}
	/**
	 * 获取32位UUID root 2015-05-28
	 * 
	 * @return
	 */
	public String getUUid() {
		UUID uuid = UUID.randomUUID();
		String s = uuid.toString().replace("-", "");
		return s;
	}

	/**
	 * 获取公司代码 root 2015-05-28
	 * @return
	 */
	public String getCompanyCode() {
		return  (String) DoradoContext.getCurrent().getAttribute("ORG_CODE");
	}

	/**
	 * 获取员工编码 root 2015-05-28
	 * 
	 * @return
	 */
	public String getUserCode() {
		return (String) DoradoContext.getCurrent().getAttribute("ACCOUNT_NAME");
	}

	/**
	 * 获取员工ID root 2015-05-28
	 * @return
	 */
	public String getUserId() {
		return (String) DoradoContext.getCurrent().getAttribute("USER_ID");
	}
	
	/**
	 * 获取员工名称 root 这里获得的是空的
	 * 这里返回中文名 作为真实姓名
	 * @return
	 */
	public String getUserName() {
//		return ContextHolder.getLoginUser()==null?"":ContextHolder.getLoginUser().getUsername();
		/*if(ContextHolder.getLoginUser()==null){
			String ip=(String) DoradoContext.getCurrent().getRequest().getRemoteAddr();
			Log4jUtil.error("登录失效 获取客户机IP："+ip);
			return ip;
			
		}*/
		return ContextHolder.getLoginUser().getCname();
//		return (String) DoradoContext.getCurrent().getAttribute("USER_NAME");
	}

	/**
	 * 日期转字符串 root 2015-05-28
	 * @param date
	 * @param string
	 * @return
	 */
	public String formatDateToString(Date date, String format) {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		String s = sdf.format(date);
		return s;
	}

	/**
	 * 字符串转日期 root 2015-05-28
	 * @param string
	 * @param format
	 * @return
	 */
	public Date formatStringToDate(String string, String format) {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		Date date = null;
		try {
			date = sdf.parse(string);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}
	
}

package com.xly.ess.util;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.Array;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;  
import org.apache.logging.log4j.Logger;  




/**
 * 记录日志的类 主要输出字符串
 * 这里的打印集合用info
 * @author Administrator
 * 
 */
public class Log4jUtil {
    private static Log4jUtil log4jUtil;
    private static final Logger logger =  LogManager.getLogger(Log4jUtil.class);
    public static void main(String[] args) {
    	    logger.debug("debug level");  
    	    logger.info("info level");  
    	    logger.warn("warn level");  
    	    logger.error("error level");  
    	    logger.fatal("fatal level");  
    }
    public static Log4jUtil getLog4jUtil() {
        if (log4jUtil == null) {
            log4jUtil = new Log4jUtil();
        }
        return log4jUtil;
    }

    public static void debug(String str) {
        logger.debug(str);
    }

    public static void info(String str) {
        logger.info(str);
    }
    public static void info(Object object) {
    	if(object==null){
    		logger.info("空对象！！");
    		return;
    	}
        logger.info(object.toString());
    }
    public static void warn(String str) {
        logger.warn(str);
    }

    public static void error(Exception e) {
    	  StringWriter sw = new StringWriter();  
          PrintWriter pw = new PrintWriter(sw);  
          e.printStackTrace(pw);  
        logger.error(sw.toString());
    }

    public static void error(String str) {
        logger.error(str);
    }

    public static void fatal(String str) {
        logger.fatal(str);
    }
    public static void testArray(Object[] array) {
        int length = array.length;
        for (int i = 0; i < length; i++) {
            // System.out.println("第"+i+"号元素的值："+Array.get(array, i));
            debug("第" + i + "号元素的值：" + Array.get(array, i));
        }
    }

    public static <V, K> void testListMap(List<Map<K,V>> list){
    	 debug("========打印Map集合========");
    	for(Map<K, V> map:list){
			Log4jUtil.testMap(map);
		}
    	debug("========打印Map集合END========");
    }
    
    public static <T> void testList(List<T> list) {
    	testList("打印集合：",list);
    }
    
    
    public static <T> void testList(String msg,List<T> list) {
        if (list == null) {
        	info("list=null");
        } else if (list.size() == 0) {
        	info("list.size()为0");
        } else {
            StringBuffer sb = new StringBuffer();
            String s = new String("list中数据个数：" + list.size());
            sb.append("\r\n" + s + "\r\nstart:----------------------\r\n");
            for (T t : list) {
                sb.append(t.toString() + "\r\n");// 这里List包含的类要有自定义的toString方法
            }
            sb.append("end----------------------\r\n");
            info(msg+sb.toString());
           
        }
    }

    /**
     * 用info是为了不干扰
     * @param map
     */
    public static <T> void testCollection(Collection<T> collection) {
        if (collection == null) {
        	info("collection=null");
        } else if (collection.size() == 0) {
        	info("collection.size()为0");
        } else {
            StringBuffer sb = new StringBuffer();
            String s = new String("collection中数据个数：" + collection.size());
            sb.append("\r\n" + s + "\r\nstart:----------------------\r\n");
            for (T t : collection) {
                sb.append(t.toString() + "\r\n");// 这里List包含的类要有自定义的toString方法
            }
            sb.append("end----------------------\r\n");
            info(sb.toString());
           
        }
    }
    
    
    /**
     * 用info是为了不干扰
     * @param map
     */
    public static <V, K> void testMap(Map<K, V> map) {
        if (map == null) {
            info("map=null");
        } else if (map.size() == 0) {
        	info("map.size()为0");
        } else {
            StringBuffer sb = new StringBuffer();
            String s = new String("map中数据个数：" + map.size());
            sb.append("\r\n" + s + "\r\nstart:----------------------\r\n");
            for (K k : map.keySet()) {
                sb.append("key[");
                sb.append(k.toString());
                sb.append("]所对应的value:[");	
                if(map.get(k)==null){
                	  sb.append("null");
                }else{
                	 sb.append(map.get(k).toString());
                }
                sb.append( "]\r\n");
            }
            sb.append("end----------------------\r\n");
            info(sb.toString());
        }
    }

}
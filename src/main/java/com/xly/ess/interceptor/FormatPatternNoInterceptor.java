package com.xly.ess.interceptor;
import org.springframework.stereotype.Service;

import com.bstek.bdf2.importexcel.interceptor.impl.RequiredInterceptor;
@Service("bdf2.formatPatternNoInterceptor")
public class FormatPatternNoInterceptor extends RequiredInterceptor {
    public Object execute(Object cellValue) throws Exception {
        super.execute(cellValue);
        try{
        	System.out.println("这里是拦截信息："+cellValue.toString());
        String  patternNo=cellValue.toString();
	  //注意这里不能用double转换方式 含有其他英文字符
		int index=patternNo.indexOf(".");
		if(index>0){
			patternNo=patternNo.substring(0,index);
		}
		return patternNo;
        }catch(Exception e){
        	e.printStackTrace();
        }
        return "error";
    }
    public String getName() {
        return "格式化编号（带数字 字符 英文）";
    }
}
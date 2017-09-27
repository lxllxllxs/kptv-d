package com.xly.ess.interceptor;
 
import java.util.Objects;  
  
import org.apache.log4j.AppenderSkeleton;  
import org.apache.log4j.spi.ErrorCode;  
import org.apache.log4j.spi.LoggingEvent;  
  
public class CountingConsoleAppender extends AppenderSkeleton  
{  
    /** 
     * 关闭资源 
     */  
    @Override  
    public void close()  
    {  
        if (this.closed)  
        {  
            return;  
        }  
        this.closed = true;  
    }  
  
    /** 
     * 这里需要使用格式化器 
     */  
    @Override  
    public boolean requiresLayout()  
    {  
        return true;  
    }  
  
    @Override  
    protected void append(LoggingEvent event)  
    {  
    }  
  
  
}  
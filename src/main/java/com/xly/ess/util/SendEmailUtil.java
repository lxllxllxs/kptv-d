package com.xly.ess.util;
import java.util.Properties; 
 
import javax.mail.Address; 
import javax.mail.Message; 
import javax.mail.MessagingException; 
import javax.mail.Session; 
import javax.mail.Transport; 
import javax.mail.internet.InternetAddress; 
import javax.mail.internet.MimeMessage; 

import org.junit.Test;
 
/** 
 * 
 * QQ(mail.qq.com):POP3服务器（端口995）SMTP服务器（端口465或587）。 
 * 
 */ 
public class SendEmailUtil { 
 
  /** 
   * @param args 
   * @throws MessagingException 
   */ 
	@Test
  public static void sendEmail(String content) throws MessagingException { 
     
    String sendUserName = "wyulife@163.com"; 
    String sendPassword = "lxl150198"; //这里要用授权码
     
    Properties properties = new Properties(); 
    properties.setProperty("mail.smtp.auth", "true");//服务器需要认证 
    properties.setProperty("mail.transport.protocol", "smtp");//声明发送邮件使用的端口 
     
    Session session = Session.getInstance(properties); 
    session.setDebug(true);//同意在当前线程的控制台打印与服务器对话信息 
     
    Message message = new MimeMessage(session);//构建发送的信息 
    message.setSubject("来自190服务器的检查结果通知");//这里应该是主题
    message.setText(content);//信息内容 
    message.setFrom(new InternetAddress("wyulife@163.com"));//发件人 
     
    Transport transport = session.getTransport(); 
    transport.connect("smtp.163.com", 25, sendUserName, sendPassword);//连接发件人使用发件的服务器 
    transport.sendMessage(message, new Address[]{new InternetAddress("774785161@qq.com")
//    		,new InternetAddress("1062486808@qq.com")
    });//接受邮件 
    transport.close(); 
  } 
 
} 
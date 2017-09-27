package com.xly.ess.base.base.framework.dao;
 public class BaseException extends RuntimeException
 {
   private static final long serialVersionUID = 7201718211772302895L;
 
   public BaseException()
   {
   }
 
   public BaseException(String message)
   {
     super(message);
   }
 
   public BaseException(String message, Throwable newNested)
   {
     super(message, newNested);
   }
 
   public BaseException(Throwable newNested)
   {
     super(newNested);
   }
 }
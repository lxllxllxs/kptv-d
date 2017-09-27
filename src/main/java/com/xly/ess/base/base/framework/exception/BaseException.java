/*    */ package com.xly.ess.base.base.framework.exception;
/*    */ 
/*    */ public class BaseException extends RuntimeException
/*    */ {
/*    */   private static final long serialVersionUID = 7201718211772302895L;
/*    */ 
/*    */   public BaseException()
/*    */   {
/*    */   }
/*    */ 
/*    */   public BaseException(String message)
/*    */   {
/* 31 */     super(message);
/*    */   }
/*    */ 
/*    */   public BaseException(String message, Throwable newNested)
/*    */   {
/* 40 */     super(message, newNested);
/*    */   }
/*    */ 
/*    */   public BaseException(Throwable newNested)
/*    */   {
/* 48 */     super(newNested);
/*    */   }
/*    */ }

/* Location:           D:\MyWork\code\code\java\eclipse\workspace_stagegrid\portal_kernel\
 * Qualified Name:     com.sgcc.framework.exception.BaseException
 * JD-Core Version:    0.6.0
 */
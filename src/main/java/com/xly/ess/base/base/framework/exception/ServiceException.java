/*    */ package com.xly.ess.base.base.framework.exception;
/*    */ 
/*    */ public class ServiceException extends BaseException
/*    */ {
/*    */   private static final long serialVersionUID = -749237327043675455L;
/*    */ 
/*    */   public ServiceException()
/*    */   {
/*    */   }
/*    */ 
/*    */   public ServiceException(String message)
/*    */   {
/* 37 */     super(message);
/*    */   }
/*    */ 
/*    */   public ServiceException(String message, Throwable newNested)
/*    */   {
/* 46 */     super(message, newNested);
/*    */   }
/*    */ 
/*    */   public ServiceException(Throwable newNested)
/*    */   {
/* 54 */     super(newNested);
/*    */   }
/*    */ }

/* Location:           D:\MyWork\code\code\java\eclipse\workspace_stagegrid\portal_kernel\
 * Qualified Name:     com.sgcc.framework.exception.ServiceException
 * JD-Core Version:    0.6.0
 */
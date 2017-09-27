/*    */ package com.xly.ess.base.base.framework.exception;
/*    */ 
/*    */ public class DaoException extends BaseException
/*    */ {
/*    */   private static final long serialVersionUID = -29596712713180690L;
/*    */ 
/*    */   public DaoException()
/*    */   {
/*    */   }
/*    */ 
/*    */   public DaoException(String message)
/*    */   {
/* 31 */     super(message);
/*    */   }
/*    */ 
/*    */   public DaoException(String message, Throwable newNested)
/*    */   {
/* 40 */     super(message, newNested);
/*    */   }
/*    */ 
/*    */   public DaoException(Throwable newNested)
/*    */   {
/* 48 */     super(newNested); 
/*    */   }
/*    */ }

/* Location:           D:\MyWork\code\code\java\eclipse\workspace_stagegrid\portal_kernel\
 * Qualified Name:     com.sgcc.framework.exception.DaoException
 * JD-Core Version:    0.6.0
 */
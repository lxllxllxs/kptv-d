package com.xly.ess.base.base.framework.dao;



public class BaseDaoException  extends BaseException{

   private static final long serialVersionUID = -29596712713180690L;
 
   public BaseDaoException()
   {
   }
 
   public BaseDaoException(String message)
   {
     super(message);
   }
 
   public BaseDaoException(String message, Throwable newNested)
   {
     super(message, newNested);
   }
 
   public BaseDaoException(Throwable newNested)
   {
     super(newNested);
   }
}

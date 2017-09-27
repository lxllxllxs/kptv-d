package com.xly.ess.base.base.framework.dao;



import com.bstek.bdf2.core.orm.hibernate.HibernateDao;

import com.bstek.dorado.data.entity.EntityState;
import com.bstek.dorado.data.entity.EntityUtils;
import com.bstek.dorado.data.entity.FilterType;
import com.bstek.dorado.data.provider.Page;
import com.bstek.dorado.util.Assert;
import com.bstek.dorado.util.proxy.ProxyBeanUtils;
import com.xly.ess.util.Log4jUtil;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.CacheMode;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.metadata.ClassMetadata;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.hibernate.transform.ResultTransformer;
import org.hibernate.transform.Transformers;
import org.springframework.stereotype.Component;


@Component
public class BaseDao<T, PK extends Serializable> extends HibernateDao
{
  private static final Log logger = LogFactory.getLog(BaseDao.class);
  
  //是否打开缓存
  protected boolean cacheable = false;
  
  private static final List EMPTY_UNMUTABLE_LIST = Collections.EMPTY_LIST;
  protected Class<T> entityType = getEntityType();

 
  /**
   * 所需参数统统放一个map
   * 变成sql语句
   * @param paramMap
   * @param queryString
   * @throws Exception
   */
  public void executeBatchSQL(LinkedHashMap<String,Object> paramMap,String... queryString) throws Exception{
		Session session = null;
		session = getSession();//获取currentSession
		try{
		for(String sql:queryString){
			Query query=session.createSQLQuery(sql);
		  if (paramMap != null) {
			  query.setProperties(paramMap);
		  }
		  query.executeUpdate();
		}
		}catch(Exception e){
			Log4jUtil.error(e);
			e.printStackTrace();
			Log4jUtil.error("executeBatchSQL执行sql语句块失败");
			throw new Exception("执行sql语句块失败");
			
		}
	}

  protected Class<T> getEntityType(){
	    Class<? extends BaseDao> cl = getClass();
	    Class resultType = null;
	    Type superType = cl.getGenericSuperclass();
	
	    if ((superType instanceof ParameterizedType)) {
	      Type[] paramTypes = ((ParameterizedType)superType).getActualTypeArguments();
	
	      if (paramTypes.length > 0)
	        resultType = (Class)paramTypes[0];
	      else
	        logger.warn("Can not determine EntityType for class [" + cl.getSimpleName() + "].");
	    }
	    else
	    {
	      logger.warn("[" + cl.getSimpleName() + "] is not a parameterized type.");
	    }
	
	    return resultType;
  }

  protected String getIdPropertyName() {
    ClassMetadata meta = getSessionFactory().getClassMetadata(this.entityType);
    return meta.getIdentifierPropertyName();
  }

  /**
   * 不需要返回id 直接抛出异常
   * @param entity
   */
  public void save(T entity)throws  Exception{
    String entityName = getEntityName(entity);
     getSession().saveOrUpdate(entityName, entity);
  }

  public int update(T entity) {
	try{
    String entityName = getEntityName(entity);
     Object obj=getSession().merge(entityName, entity);
     return obj==null?0:1;
	}catch(Exception e){
		e.printStackTrace();
		return 0;
	}
  }
  /**
   * 这里返回的本质就是新建记录的id
   * @param entity
   * @return
   */
  public int saveNew(T entity){
	try{
    String entityName = getEntityName(entity);
    return  Integer.valueOf(getSession().save(entityName, entity).toString());
	}catch(Exception e){
		e.printStackTrace();
		return 0;
	}
  }
  
  public void delete(T entity) throws Exception{
    String entityName = getEntityName(entity);
    getSession().delete(entityName, entity);
  }

  public void delete(PK id)throws Exception {
    delete(get(id));
  }

  public EntityState persistEntity(T entity) throws Exception{
    EntityState state = EntityUtils.getState(entity);
    if (EntityState.DELETED.equals(state))
      delete(entity);
    else if ((EntityState.MODIFIED.equals(state)) || (EntityState.NEW.equals(state)) || (EntityState.MOVED.equals(state)))
    {
      save(entity);
    }
    return state;
  }

  public int persistEntities(Collection<T> entities)
  {
    int i = 0;
    if (entities == null)
    	return i;
    
    Session session = this.getSessionFactory().openSession();
	try{
	    for (Iterator<T> i$ = EntityUtils.getIterable(entities, FilterType.DELETED).iterator(); i$.hasNext(); ) { Object entity = i$.next();
	
	      session.delete(entity);
	      i++;
	    }
	    for (Iterator<T> i$ = EntityUtils.getIterable(entities, FilterType.MODIFIED).iterator(); i$.hasNext(); ) { Object entity = i$.next();
	
	      session.update(entity);
	      i++;
	    }
	    for (Iterator<T> i$ = EntityUtils.getIterable(entities, FilterType.MOVED).iterator(); i$.hasNext(); ) { Object entity = i$.next();
	
	      session.save(entity);
	      i++;
	    }
	    for (Iterator<T> i$ = EntityUtils.getIterable(entities, FilterType.NEW).iterator(); i$.hasNext(); ) { Object entity = i$.next();
	      session.save(entity);
	      i++;
	    }
    }finally{
    	 session.flush();
    	 session.close();
    }
    return i;
  }

  public T get(PK id)
  {
    return (T) getSession().load(this.entityType, id);
  }

  public Criteria createCriteria() {
    return getSession().createCriteria(this.entityType);
  }

  public Criteria createCriteria(Criterion[] criterions) {
    Criteria criteria = createCriteria();
    for (Criterion c : criterions) {
      criteria.add(c);
    }
    return criteria;
  }

  public Query createQuery(String hql, Object[] parameters) {
    Query q = getSession().createQuery(hql);
    if (parameters != null) {
      for (int i = 0; i < parameters.length; i++) {
        q.setParameter(i, parameters[i]);
      }
    }
    return q;
  }



  
  public Query createQuery(String queryString, Map<String, ?> parameters) {
    Query query = getSession().createQuery(queryString);
    if (parameters != null) {
      query.setProperties(parameters);
    }
    return query;
  }


  
  
  public List<T> find(Criteria criteria)
  {
    return criteria.list();
  }

  public Page<T> find(Page<T> page, Criteria criteria)
  {
	try{
    notNull(page, "page");
    long totalCount = countCriteriaResult(criteria);
    page.setEntityCount((int)totalCount);
    setPageParameterToCriteria(criteria, page);
    page.setEntities(criteria.list());
    return page;
	}catch(Exception e){
		e.printStackTrace();
	}
	return null;
  }

  public List<T> find(Criterion[] criterions) {
    return find(createCriteria(criterions));
  }

  public List<T> find(DetachedCriteria detachedCriteria) {
    Criteria criteria = detachedCriteria.getExecutableCriteria(getSession());

    return find(criteria);
  }

  public Page<T> find(Page<T> page, DetachedCriteria detachedCriteria) {
    Criteria criteria = detachedCriteria.getExecutableCriteria(getSession());

    return find(page, criteria);
  }

  public Page<T> find(Page<T> page, Criterion[] criterions) {
    notNull(page, "page");
    return find(page, createCriteria(criterions));
  }

  protected long countCriteriaResult(Criteria criteria)
  {
    CriteriaImplHelper implHelper = new CriteriaImplHelper(criteria);
    long count = 0L;
    List orderEntries = null;
    try
    {
      orderEntries = implHelper.getOrderEntries();
      implHelper.setOrderEntries(EMPTY_UNMUTABLE_LIST);

      Projection projection = implHelper.getProjection();
      ResultTransformer transformer = implHelper.getResultTransformer();

      count = ((Number)criteria.setProjection(Projections.rowCount()).uniqueResult()).longValue();

      criteria.setProjection(projection);
      if (projection == null) {
        criteria.setResultTransformer(CriteriaSpecification.ROOT_ENTITY);
      }
      if (transformer != null)
        criteria.setResultTransformer(transformer);
    }
    catch (Exception e) {
      throw new RuntimeException(e);
    } finally {
      try {
        implHelper.setOrderEntries(orderEntries);
      } catch (Exception e) {
        logger.warn(e, e);
      }
    }
    return count;
  }

  protected long countHqlResult(String hql, Object[] parameters) {
    String countHql = generateCountHql(hql);
    return ((Number)findUnique(countHql, parameters)).longValue();
  }

  protected long countHqlResult(String hql, Map<String, ?> parameters) {
    String countHql = generateCountHql(hql);
    return ((Number)findUnique(countHql, parameters)).longValue();
  }


  
  
  private String generateCountHql(String hql) {
    hql = "from " + StringUtils.substringAfter(hql, "from");
    hql = StringUtils.substringBefore(hql, "order by");
    String countHql = "select count(*) " + hql;
    return countHql;
  }

  
  
  protected Criteria setPageParameterToCriteria(Criteria c, Page<T> page) {
    c.setFirstResult(page.getFirstEntityIndex());
    c.setMaxResults(page.getPageSize());
    return c;
  }

  protected Query setPageParameterToQuery(Query q, Page page) {
    q.setFirstResult(page.getFirstEntityIndex());
    q.setMaxResults(page.getPageSize());
    return q;
  }

  
  public List<T> get(Collection<PK> ids) {
    return find(new Criterion[] { Restrictions.in(getIdPropertyName(), ids) });
  }

  public List<T> getAll()
  {
	try{
    return createCriteria().list();
	}catch(Exception e){
		e.printStackTrace();
		return null;
	}
  }

  public Page<T> getAll(Page<T> page) {
    return find(page, new Criterion[0]);
  }

  public <X> X findUnique(String hql, Object[] parameters)
  {
    return (X) createQuery(hql, parameters).uniqueResult();
  }

  public <X> X findUnique(String hql, Map<String, ?> parameters)
  {
    return (X) createQuery(hql, parameters).uniqueResult();
  }

  public <X> List<X> find(String hql, Object[] parameters)
  {
    return createQuery(hql, parameters).list();
  }

  public <X> List<X> find(String hql, Map<String, ?> parameters) 
  {
    return createQuery(hql, parameters).list();
  }

  public Page<T> find(Page<T> page, String hql, Object[] parameters)
  {
    notNull(page, "page");

    Query q = createQuery(hql, parameters);
    long totalCount = countHqlResult(hql, parameters);
    page.setEntityCount((int)totalCount);
    setPageParameterToQuery(q, page);
    page.setEntities(q.list());
    return page;
  }

  public Page<T> find(Page<T> page, String hql, Map<String, ?> parameters)
  {
    notNull(page, "page");

    Query q = createQuery(hql, parameters);
    long totalCount = countHqlResult(hql, parameters);
    page.setEntityCount((int)totalCount);
    setPageParameterToQuery(q, page);
    page.setEntities(q.list());
    return page;
  }

  protected String getEntityName(Object object) {
	try{
    if (object != null) {
      Class<?> cl = ProxyBeanUtils.getProxyTargetType(object);
      return cl.getName();
    }
	}catch(Exception e){
		e.printStackTrace();
		return null;
	}
    return null;
  }

  protected void notNull(Object obj, String name)
  {
    Assert.notNull(obj, "[" + name + "] must not be null.");
  }
  


  
  /**
   * ----------------------------by SQL ----------------------------
   */
  
  
  public Page<Map> findPageListBySQL(Page<Map> page, String sql, Map<String, ?> parameters)
  {
		return findPageListBySQL(page,sql,parameters, Transformers.ALIAS_TO_ENTITY_MAP);
 }
  
  public Page<Map> findPageListBySQL(Page<Map> page, String sql, Map<String, ?> parameters,AliasToEntityMapResultTransformer transformer)
  {
	  try{
    notNull(page, "page");
    SQLQuery query= getSession().createSQLQuery(sql);
    
    long totalCount = countSqlResult(sql, parameters);
    page.setEntityCount((int)totalCount);
    if (parameters != null) {
        query.setProperties(parameters);
      }
    if (transformer != null) {
          query.setResultTransformer(transformer);
    }
    setPageParameterToQuery(query, page);
    List list = query.list();
    Log4jUtil.testList(list);
    page.setEntities(list);
    	return page;
  }catch(Exception e){
		  Log4jUtil.error(e);
		  e.printStackTrace();
  }
	  return null;
 }
  

/**
 * 返回生成 记录数的 SQL    
 * @param sql 查询的ＳＱＬ
 * @return 记录数 SQL 
 * @author liliang
 */
  private String generateCountSql(String sql) {
	   //初始化 默认 为 0条记录 
	    String countSql = "select 0 from dual ";  
	  
	    //截取SQL 修改为 记录条数 sql
	    if(sql != null){
		    sql = this.removeSelect(sql);
		    sql = BaseDao.removeOrders(sql);
		    countSql = "select count(*) " + sql;
	    }
	    
	    return countSql;
	  }

/**
 *  根据输入的sql 返回记录条数 
 * @param sql
 * @param parameters
 * @return 记录条数 
 * @author liliang
 */
protected long countSqlResult(String sql, Map<String, ?> parameters) {
	    String countSql = generateCountSql(sql);
	    return ((Number)findUniqueBySql(countSql, parameters)).longValue();
	  }

/**
 * 创建查询的SQL的query
 * @param queryString 查询的sql
 * @param parameters  查询的参数 
 * @return Query 查询的 对象
 */
public Query createSQLQuery(String queryString, Map<String, ?> parameters) {
    Query query = getSession().createSQLQuery(queryString);
    if (parameters != null) {
      query.setProperties(parameters);
    }
    return query;
  }

/**
 * 创建 查询 SQL的 Query 
 * @param sql        查询语句
 * @param parameters 查询参数 
 * @return 查询的 Query
 */
public Query createSQLQuery(String sql, Object[] parameters) {
    Query q = getSession().createSQLQuery(sql);
    if (parameters != null) {
      for (int i = 0; i < parameters.length; i++) {
        q.setParameter(i, parameters[i]);
      }
    }
    return q;
  }

/**
 * 返回SQL查询的结果 
 * @param sql
 * @param parameters 参数对象列表
 * @return 返回SQL 总数量 
 */
public <X> X findUniqueBySql(String sql, Object[] parameters)
{
  return (X) createSQLQuery(sql, parameters).uniqueResult();
}

/**
 * 返回SQL查询的结果 
 * @param sql
 * @param parameters 参数MAP对象
 * @return 返回SQL 总数量 
 */
public <X> X findUniqueBySql(String sql, Map<String, ?> parameters)
{
  return (X) createSQLQuery(sql, parameters).uniqueResult();
}

/**
 * 返回SQL查询的结果 
 * @param sql
 * @param parameters 参数对象数组
 * @return 返回SQL 总数量 
 */
public <X> List<X> findBySql(String sql, Object[] parameters)
{
  return createSQLQuery(sql, parameters).list();
}

/**
 * 返回SQL查询的结果 
 * @param sql
 * @param parameters 参数MAP对象
 * @return 返回SQL 总数量 
 */
public <X> List<X> findBySql(String sql, Map<String, ?> parameters)
{
  return createSQLQuery(sql, parameters).list(); 
}


public List<Map> findListBySQL(String sql, Map<?, ?> paramMap) throws BaseDaoException{
		  return findListBySQL(sql,paramMap,Transformers.ALIAS_TO_ENTITY_MAP);
}


public List<Map> findListBySQL(String sql, Map<?, ?> paramMap, AliasToEntityMapResultTransformer transformer)
  throws BaseDaoException
{
  Query query = getSession().createSQLQuery(sql);
  query.setCacheable(this.cacheable);
  query.setCacheMode(CacheMode.IGNORE);
  query.setCacheRegion("SQL_Query");
  if (paramMap != null) {
    query.setProperties(paramMap);
  }
  if (transformer != null) {
    query.setResultTransformer(transformer);
  }
  return query.list();
}
/*
 * 执行SQL语句
 * @param SQL 需要执行的 SQL
 * @param paramMap 需要执行的SQL的参数
 */
public int executeUpdateBySQL(String sql, Map<?, ?> paramMap)
  throws BaseException
{
  Query query = getSession().createSQLQuery(sql);
/*  query.setCacheable(this.cacheable);
  query.setCacheMode(CacheMode.IGNORE);
  query.setCacheRegion("SQL_Query");*/
  if (paramMap != null) {
    query.setProperties(paramMap);
  }
  return query.executeUpdate();
}


/**
 * 删除sql 中的 select语句 
 * @param sql 
 * @return
 */
protected String removeSelect(String sql)
{
  int beginPos = sql.toLowerCase().indexOf("from");
  return sql.substring(beginPos);
}

/**
 * 删除SQL中的 order by 语句
 * @param sql
 * @return
 */
public static String removeOrders(String sql)
{
  if (sql != null) {
    String tmp = sql.toLowerCase().trim();
    int right = tmp.lastIndexOf(")");
    int order = tmp.lastIndexOf(" order");
    int by = tmp.lastIndexOf(" by");
    if ((order == -1) || (by == -1) || (order > by))
      return sql;
    if (right == -1) {
      Pattern pattern = Pattern.compile("order\\s*by[\\w|\\W|\\s|\\S]*", 2);
      Matcher matcher = pattern.matcher(sql);
      StringBuffer buf = new StringBuffer();
      while (matcher.find()) {
        matcher.appendReplacement(buf, "");
      }
      matcher.appendTail(buf);
      return buf.toString();
    }if (right < order) {
      return sql.substring(0, sql.toLowerCase().lastIndexOf(" order"));
    }
  }
  return sql;
}

public String testProcedurePrint() throws Exception{
	LinkedHashMap<String,Object> returnParams=new LinkedHashMap<String, Object>();
	returnParams.put("p_out", null);
	executeProcedure("xly.testPrint", returnParams);
	return returnParams.get("p_out").toString();
}

/**2017-08-08 改为获取线程相关的session
 * 执行存储过程
 * 注意这里出入的参数顺序要和存储过程的入参顺序一致
 * @param SQL 需要执行的 SQL
 * @param paramMap 需要执行的SQL的参数
 * 20170915 修改BaseException 为 Exception
 */
public LinkedHashMap<String,Object> executeProcedure(String procName, LinkedHashMap<String,Object> procParam)throws Exception
{

	//初始化变量
	Session session = null;
	Connection conn = null;
	ResultSet rs =null;
	CallableStatement call =null;
	try{
		//创建连接 
//		session = getSessionFactory().openSession();
		session = getSession();//获取currentSession
		conn = session.connection();
		//组装 入参
		call=assembleParam(conn,procName,procParam);
		//执行存储过程
		rs = call.executeQuery();
		//读取返回值
		Iterator<String> procParamIterator = procParam.keySet().iterator();
		while(procParamIterator.hasNext()){	
			String   paramName = procParamIterator.next();
			Object   paramValue = null;
			if(paramName.indexOf("out") > 0){
				paramValue = call.getObject(paramName);
				procParam.put(paramName, paramValue);
				logger.debug("读取返回值 " + paramName + " = " + paramValue);
			}
		}
		}catch(SQLException e){
			//sql异常不管 ，mysql5.5版本的问题 游标
		}catch(Exception e){
			Log4jUtil.error(e);
			e.printStackTrace();
		}finally{
			/*//关闭连接
			try{
			if(rs != null && !rs.isClosed())
			try{ rs.close(); }catch(Exception e){ 
				Log4jUtil.error(e);
				e.printStackTrace();}
			
			if(session != null )
			try{ session.close(); }catch(Exception e){
				Log4jUtil.error(e);
				e.printStackTrace();}
			}catch(Exception e){
				Log4jUtil.error(e);
				logger.error(e.getLocalizedMessage());
			}*/
		}
		return procParam;
	
}

/**20170811
 * 定时任务不能从线程相关的session中取
 * @param procName
 * @param procParam
 * @return
 * @throws BaseDaoException
 */
public LinkedHashMap<String,Object> executeScheduleProcedure(String procName, LinkedHashMap<String,Object> procParam)
		  throws BaseDaoException
		{

			//初始化变量
			Session session = null;
			Connection conn = null;
			ResultSet rs =null;
			CallableStatement call =null;
			try{
				//创建连接 
				session = getSessionFactory().openSession();
				conn = session.connection();
				//组装 入参
				call=assembleParam(conn,procName,procParam);
				//执行存储过程
				rs = call.executeQuery();
				int count=0;
				while(rs.next()){
					count+=1;
				}
				procParam.put("resultCount", count);
				//读取返回值
				Iterator<String> procParamIterator = procParam.keySet().iterator();
				while(procParamIterator.hasNext()){	
					String   paramName = procParamIterator.next();
					Object   paramValue = null;
					if(paramName.indexOf("out") > 0){
						paramValue = call.getObject(paramName);
						procParam.put(paramName, paramValue);
						logger.debug("读取返回值 " + paramName + " = " + paramValue);
					}
				}
				}catch(Exception e){
					Log4jUtil.error(e);
					e.printStackTrace();
				}finally{
					try{
					if(rs != null && !rs.isClosed())
					try{ rs.close(); }catch(Exception e){ 
						Log4jUtil.error(e);
						e.printStackTrace();}
					
					if(session != null )
					try{ session.close(); }catch(Exception e){
						Log4jUtil.error(e);
						e.printStackTrace();}
					}catch(Exception e){
						Log4jUtil.error(e);
						logger.error(e.getLocalizedMessage());
					}
				}
				return procParam;
			
		}
/**
 * 
 * @param call 
 * @param procName
 * @param procParam
 * @throws SQLException 
 */
private CallableStatement assembleParam(Connection conn,String procName,LinkedHashMap<String,Object> procParam) throws SQLException{
	//生成拼接字符串(?,?,?)
			String temp = "";
			if(procParam != null && !procParam.isEmpty())
			for(int i = 0 ; i < procParam.size() ; i++){
				temp = temp.length() == 0 ? "?" : temp + ",?"; 
			}
			temp = temp.length() == 0 ? temp : "(" + temp + ")"; 
			//执行存储过程
			String callProc = "{Call " + procName  + temp + "}";
			logger.debug("执行存储过程:" + callProc);
			CallableStatement call = conn.prepareCall(callProc);
			if(procParam != null && !procParam.isEmpty()){
				Iterator<String> procParamIterator = procParam.keySet().iterator();
				int i = 1;
				while(procParamIterator.hasNext()){	
					String   paramName = procParamIterator.next();
					Object  paramValue = procParam.get(paramName);
					//使用带 out的作为 输出标记
					if(paramName.indexOf("out") <= 0){
					   call.setObject(i ,procParam.get(paramName));
						logger.debug("设置参数 " + i + " : " + procParam.get(paramName));
					}else{
						call.registerOutParameter(paramName,java.sql.Types.VARCHAR);
						logger.debug("设置参数 " + i + " : " + paramName);
					}
					i ++;
				}
			}
			return call;
}



}
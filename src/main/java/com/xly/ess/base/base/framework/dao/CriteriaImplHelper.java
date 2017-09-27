package com.xly.ess.base.base.framework.dao;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.ResultTransformer;

public class CriteriaImplHelper
{
  private static Field Field_DetachedCriteria_impl = null;

  private static Field Field_maxResults = null;
  private static Field Field_firstResult = null;
  private static Field Field_subcriteriaList = null;
  private static Field Field_orderEntries = null;
  private static Field Field_Order_propertyName = null;
  private static Field Field_Order_ignoreCase = null;

  private static Method Method_iterateSubcriteria = null;
  private static Method Method_iterateOrderings = null;
  private static Method Method_getProjection = null;
  private static Method Method_setProjection = null;
  private static Method Method_getResultTransformer = null;
  private static Method Method_Subcriteria_getAlias;
  private static Method Method_Subcriteria_getPath;
  private static Method Method_Subcriteria_getParent;
  private static Method Mehtod_OrderEntry_getCriteria;
  private static Method Method_OrderEntry_getOrder;
  private Criteria criteriaImpl;
  private Map<String, String> aliasMap;

  public CriteriaImplHelper(DetachedCriteria detachedCriteria)
  {
    try
    {
      this.criteriaImpl = getCriteriaImpl(detachedCriteria);
    } catch (Exception e) {
      throw new RuntimeException(e);
    }
  }

  public CriteriaImplHelper(Criteria criteria) {
    this.criteriaImpl = criteria;
  }

  public Criteria getCriteria() {
    return this.criteriaImpl;
  }

  public void makeCount() throws Exception
  {
    Criteria countCriteria = this.criteriaImpl;
    if (Method_iterateOrderings == null) {
      Method_iterateOrderings = countCriteria.getClass().getMethod("iterateOrderings", new Class[0]);
    }
    Iterator orderItr = (Iterator)Method_iterateOrderings.invoke(countCriteria, new Object[0]);
    if (orderItr != null) {
      while (orderItr.hasNext()) {
        orderItr.next();
        orderItr.remove();
      }
    }

    countCriteria.setProjection(Projections.rowCount());
    countCriteria.setResultTransformer(CriteriaSpecification.ROOT_ENTITY);

    clearMaxResults(countCriteria);
    clearFirstResult(countCriteria);
  }

  public String getCriteriaPath(String propertyPath)
    throws Exception
  {
    Iterator i$;
    if (this.aliasMap == null) {
      this.aliasMap = new HashMap();
      if (Method_iterateSubcriteria == null) {
        Method_iterateSubcriteria = this.criteriaImpl.getClass().getMethod("iterateSubcriteria", new Class[0]);
      }

      if (Field_subcriteriaList == null) {
        Field f = this.criteriaImpl.getClass().getDeclaredField("subcriteriaList");
        f.setAccessible(true);
        Field_subcriteriaList = f;
      }

      List subcriteriaList = (List)Field_subcriteriaList.get(this.criteriaImpl);
      for (i$ = subcriteriaList.iterator(); i$.hasNext(); ) { Object subcriteria = i$.next();
        if (Method_Subcriteria_getAlias == null) {
          Method_Subcriteria_getAlias = subcriteria.getClass().getMethod("getAlias", new Class[0]);
        }

        String subAlias = (String)Method_Subcriteria_getAlias.invoke(subcriteria, new Object[0]);
        if (StringUtils.isNotEmpty(subAlias)) {
          String fullPath = getFullPath(subcriteria);
          this.aliasMap.put(fullPath, subAlias);
        }
      }
    }

    if (propertyPath.indexOf('.') < 0) {
      if (this.aliasMap.containsKey(propertyPath)) {
        return this.aliasMap.get(propertyPath);
      }
      return propertyPath;
    }

    int splitIndex = propertyPath.lastIndexOf('.');
    String parentPath = propertyPath.substring(0, splitIndex);
    String parentAlias = this.aliasMap.get(parentPath);
    if (StringUtils.isEmpty(parentAlias)) {
      return propertyPath;
    }
    return parentAlias + "." + propertyPath.substring(splitIndex + 1);
  }

  private String getFullPath(Object subcriteria)
    throws Exception
  {
    if (Method_Subcriteria_getPath == null) {
      Method_Subcriteria_getPath = subcriteria.getClass().getDeclaredMethod("getPath", new Class[0]);
    }
    String subPath = (String)Method_Subcriteria_getPath.invoke(subcriteria, new Object[0]);

    if (Method_Subcriteria_getParent == null) {
      Method_Subcriteria_getParent = subcriteria.getClass().getDeclaredMethod("getParent", new Class[0]);
    }
    Criteria parentCriteria = (Criteria)Method_Subcriteria_getParent.invoke(subcriteria, new Object[0]);
    if (parentCriteria.getClass().getSimpleName().equals("Subcriteria")) {
      return getFullPath(parentCriteria) + "." + subPath;
    }
    return subPath;
  }

  public List getOrderEntries()
    throws Exception
  {
    if (Field_orderEntries == null) {
      Field f = this.criteriaImpl.getClass().getDeclaredField("orderEntries");
      f.setAccessible(true);
      Field_orderEntries = f;
    }

    return (List)Field_orderEntries.get(this.criteriaImpl);
  }

  public void setOrderEntries(List orderEntries) throws Exception
  {
    if (Field_orderEntries == null) {
      Field f = this.criteriaImpl.getClass().getDeclaredField("orderEntries");
      f.setAccessible(true);
      Field_orderEntries = f;
    }

    Field_orderEntries.set(this.criteriaImpl, orderEntries);
  }

  public void setProjection(Projection projection) throws Exception {
    if (Method_setProjection == null) {
      Method_setProjection = this.criteriaImpl.getClass().getMethod("setProjection", new Class[] { Projection.class });
    }

    Method_setProjection.invoke(this.criteriaImpl, new Object[] { projection });
  }

  public Projection getProjection() throws Exception {
    if (Method_getProjection == null) {
      Method_getProjection = this.criteriaImpl.getClass().getMethod("getProjection", new Class[0]);
    }

    return (Projection)Method_getProjection.invoke(this.criteriaImpl, new Object[0]);
  }

  public ResultTransformer getResultTransformer()
    throws Exception
  {
    if (Method_getResultTransformer == null) {
      Method_getResultTransformer = this.criteriaImpl.getClass().getMethod("getResultTransformer", new Class[0]);
    }

    return (ResultTransformer)Method_getResultTransformer.invoke(this.criteriaImpl, new Object[0]);
  }

  public void setResultTransformer(ResultTransformer resultTransformer) {
    this.criteriaImpl.setResultTransformer(resultTransformer);
  }

  public void mergeOrders(List<Order> hOrders)
    throws Exception
  {
    Map oldOrderMap = new LinkedHashMap();
    Iterator oldOrderEntryItr = getOrderEntries().iterator();
    while (oldOrderEntryItr.hasNext()) {
      Object orderEntry = oldOrderEntryItr.next();
      if (Mehtod_OrderEntry_getCriteria == null) {
        Mehtod_OrderEntry_getCriteria = orderEntry.getClass().getMethod("getCriteria", new Class[0]);
      }

      Criteria orderCriteria = (Criteria)Mehtod_OrderEntry_getCriteria.invoke(orderEntry, new Object[0]);
      if ((this.criteriaImpl.equals(orderCriteria)) && 
        (Method_OrderEntry_getOrder == null)) {
        Method_OrderEntry_getOrder = orderEntry.getClass().getDeclaredMethod("getOrder", new Class[0]);
        Order order = (Order)Method_OrderEntry_getOrder.invoke(orderEntry, new Object[0]);
        oldOrderMap.put(getPropertyName(order), order);
        oldOrderEntryItr.remove();
      }

    }

    Set newOrderNames = new HashSet();
    for (Order newOrder : hOrders) {
      this.criteriaImpl.addOrder(newOrder);
      String propertyName = getPropertyName(newOrder);

      if (oldOrderMap.containsKey(propertyName)) {
        Order oldOrder = (Order)oldOrderMap.get(propertyName);
        if (isIgnoreCase(oldOrder)) {
          newOrder.ignoreCase();
        }
      }
      newOrderNames.add(getPropertyName(newOrder));
    }

    Set<String> oldOrderNames = oldOrderMap.keySet();
    for (String oldOrderName : oldOrderNames)
      if (!newOrderNames.contains(oldOrderName))
        this.criteriaImpl.addOrder((Order)oldOrderMap.get(oldOrderName));
  }

  private boolean isIgnoreCase(Order order)
    throws Exception
  {
    if (Field_Order_ignoreCase == null) {
      Field f = Order.class.getDeclaredField("ignoreCase");
      f.setAccessible(true);
      Field_Order_ignoreCase = f;
    }

    return Field_Order_ignoreCase.getBoolean(order);
  }

  private void clearMaxResults(Object entityCriteria) throws Exception {
    if (Field_maxResults == null) {
      Field f = entityCriteria.getClass().getDeclaredField("maxResults");
      f.setAccessible(true);
      Field_maxResults = f;
    }
    Field_maxResults.set(entityCriteria, null);
  }

  private void clearFirstResult(Object entityCriteria) throws Exception {
    if (Field_firstResult == null) {
      Field f = entityCriteria.getClass().getDeclaredField("firstResult");
      f.setAccessible(true);
      Field_firstResult = f;
    }
    Field_firstResult.set(entityCriteria, null);
  }

  private String getPropertyName(Order order) throws Exception {
    if (Field_Order_propertyName == null) {
      Field f = Order.class.getDeclaredField("propertyName");
      f.setAccessible(true);
      Field_Order_propertyName = f;
    }

    return (String)Field_Order_propertyName.get(order);
  }

  private Criteria getCriteriaImpl(DetachedCriteria detachedCriteria) throws Exception {
    if (Field_DetachedCriteria_impl == null) {
      Field f = DetachedCriteria.class.getDeclaredField("impl");
      f.setAccessible(true);
      Field_DetachedCriteria_impl = f;
    }

    return (Criteria)Field_DetachedCriteria_impl.get(detachedCriteria);
  }
}
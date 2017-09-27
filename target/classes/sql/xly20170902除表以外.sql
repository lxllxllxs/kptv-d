/*
SQLyog  v12.2.6 (64 bit)
MySQL - 5.5.32 : Database - xly
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`xly` /*!40100 DEFAULT CHARACTER SET utf8 */;

/* Trigger structure for table `bdf2_user` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `del-user-position` */$$

/*!50003 CREATE */ /*!50003 TRIGGER `del-user-position` BEFORE DELETE ON `bdf2_user` FOR EACH ROW BEGIN
	DELETE FROM bdf2_user_position WHERE SALES_MGR_NAME=old.CNAME_;
    END */$$


DELIMITER ;

/* Trigger structure for table `bdf2_user_position` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `updateMgrName` */$$

/*!50003 CREATE */ /*!50003 TRIGGER `updateMgrName` BEFORE INSERT ON `bdf2_user_position` FOR EACH ROW BEGIN
	set NEW.SALES_MGR_NAME=getMgrName(NEW.USERNAME_);
    END */$$


DELIMITER ;

/* Trigger structure for table `xly_ctm_bal` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `ctm-bal-createdate` */$$

/*!50003 CREATE */ /*!50003 TRIGGER `ctm-bal-createdate` BEFORE INSERT ON `xly_ctm_bal` FOR EACH ROW BEGIN
	SET NEW.CREATE_DATE=NOW();
    END */$$


DELIMITER ;

/* Trigger structure for table `xly_customer` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `setCtmMoney` */$$

/*!50003 CREATE */ /*!50003 TRIGGER `setCtmMoney` BEFORE INSERT ON `xly_customer` FOR EACH ROW BEGIN
	IF NEW.MONEY IS NULL OR LENGTH(NEW.MONEY)<1 THEN
	SET  NEW.MONEY=ENCODE(NEW.IMPORT_MONEY,'xly');
	END IF;
    END */$$


DELIMITER ;

/* Trigger structure for table `xly_sale_pattern` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `sale-pattern-createdate` */$$

/*!50003 CREATE */ /*!50003 TRIGGER `sale-pattern-createdate` BEFORE INSERT ON `xly_sale_pattern` FOR EACH ROW BEGIN
    SET NEW.CREATE_DATE=NOW();
    END */$$


DELIMITER ;

/* Function  structure for function  `ACheckBillStock` */

/*!50003 DROP FUNCTION IF EXISTS `ACheckBillStock` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `ACheckBillStock`(stockId INT) RETURNS int(11)
BEGIN
    DECLARE v_sum INT DEFAULT 0;
    DECLARE v_reduce_sum INT DEFAULT 0;
    
	SELECT SUM(br.count) INTO v_sum FROM  `v_billrecord` br WHERE br.`stockId` =stockId AND br.`bState`=1;
	RETURN v_sum;
    END */$$
DELIMITER ;

/* Function  structure for function  `AcheckCtm` */

/*!50003 DROP FUNCTION IF EXISTS `AcheckCtm` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `AcheckCtm`() RETURNS tinyint(1)
BEGIN
    DECLARE ctmA INT  DEFAULT 0;
    DECLARE ctmB INT  DEFAULT 0;
    select count(*) into ctmA from xly_customer;
    SELECT COUNT(*) INTO ctmB FROM v_customer;
    return ctmA=ctmB ;
    END */$$
DELIMITER ;

/* Function  structure for function  `ACheckWareRecord` */

/*!50003 DROP FUNCTION IF EXISTS `ACheckWareRecord` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `ACheckWareRecord`(pId int,warehouse varchar(10)) RETURNS int(11)
BEGIN
    declare v_sum int default 0;
    DECLARE v_reduce_sum INT DEFAULT 0;
    
	SELECT SUM(vw.`STOCK`) into v_sum FROM v_warerecord vw WHERE vw.`PRODUCT_ID` =pId AND vw.`WAREHOUSE`=warehouse;
	-- 3和4是减库存 需要减去两倍
	SELECT SUM(vw.`STOCK`) INTO v_reduce_sum FROM v_warerecord vw WHERE vw.`PRODUCT_ID` =pId AND vw.`WAREHOUSE`=warehouse  AND (vw.`OPT_ID`=3 OR vw.`OPT_ID`=4); 
	if v_reduce_sum is null then set v_reduce_sum=0;
	end if;
	IF v_sum IS NULL THEN SET v_sum=0;
	END IF;
	return v_sum-2*v_reduce_sum;
    END */$$
DELIMITER ;

/* Function  structure for function  `ACheckWareStock` */

/*!50003 DROP FUNCTION IF EXISTS `ACheckWareStock` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `ACheckWareStock`(stockId INT) RETURNS int(11)
BEGIN
    DECLARE v_sum INT DEFAULT 0;
    DECLARE v_pId INT DEFAULT 0;
    DECLARE v_warehouse varchar(10) ;
    DECLARE v_reduce_sum INT DEFAULT 0;
	SELECT ps.WAREHOUSE,ps.PRODUCT_ID INTO v_warehouse,v_pId FROM xly_pdt_stock ps WHERE ps.ID=stockId;
	
	SELECT SUM(vw.`STOCK`) INTO v_sum FROM v_warerecord vw WHERE vw.`PRODUCT_ID` =v_pId AND vw.`WAREHOUSE`=v_warehouse;
	-- 3和4是减库存 需要减去两倍
	SELECT SUM(vw.`STOCK`) INTO v_reduce_sum FROM v_warerecord vw WHERE vw.`PRODUCT_ID` =v_pId AND vw.`WAREHOUSE`=v_warehouse  AND (vw.`OPT_ID`=3 OR vw.`OPT_ID`=4); 
	IF v_reduce_sum IS NULL THEN SET v_reduce_sum=0;
	END IF;
	IF v_sum IS NULL THEN SET v_sum=0;
	END IF;
	RETURN v_sum-2*v_reduce_sum;
    END */$$
DELIMITER ;

/* Function  structure for function  `AFormatPatterno` */

/*!50003 DROP FUNCTION IF EXISTS `AFormatPatterno` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `AFormatPatterno`(patt varchar(10)) RETURNS varchar(10) CHARSET utf8
BEGIN
    declare v_patternno varchar(10);
    SELECT SUBSTRING_INDEX(patt, '.', 1) into v_patternno;
    return v_patternno;
    END */$$
DELIMITER ;

/* Function  structure for function  `checkBillRecord` */

/*!50003 DROP FUNCTION IF EXISTS `checkBillRecord` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `checkBillRecord`() RETURNS tinyint(1)
BEGIN
    DECLARE x_br INT  DEFAULT 0;
    DECLARE v_br INT  DEFAULT 0;
    select count(*) into x_br from xly_bill_record;
    SELECT COUNT(*) INTO v_br FROM v_billrecord;
    return x_br=v_br ;
    END */$$
DELIMITER ;

/* Function  structure for function  `checkCtmConsumption` */

/*!50003 DROP FUNCTION IF EXISTS `checkCtmConsumption` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `checkCtmConsumption`(ctmId int) RETURNS double
BEGIN
    declare totalConsumption double default 0;
	SELECT SUM(b.`TOTAL_AMOUNT`) into totalConsumption FROM xly_bill b WHERE b.`CTM_ID`=ctmId and b.`STATE`=1;
	RETURN totalConsumption;
    END */$$
DELIMITER ;

/* Function  structure for function  `countTotalAmount` */

/*!50003 DROP FUNCTION IF EXISTS `countTotalAmount` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `countTotalAmount`(V_billNo int) RETURNS double
BEGIN
    DECLARE TOTAL_AMOUNT double DEFAULT 0;
	SELECT SUM(subTotal)+freight into TOTAL_AMOUNT FROM v_billrecord WHERE billNo=V_billNo;
	return TOTAL_AMOUNT;
    END */$$
DELIMITER ;

/* Function  structure for function  `dcoM` */

/*!50003 DROP FUNCTION IF EXISTS `dcoM` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `dcoM`(ctmId int) RETURNS double
BEGIN
    declare V_MONEY double default 0;
    SELECT DECODE(money,'xly') INTO V_MONEY FROM xly_customer WHERE CTM_ID=ctmId;
	return V_MONEY;
    END */$$
DELIMITER ;

/* Function  structure for function  `getAdjustment` */

/*!50003 DROP FUNCTION IF EXISTS `getAdjustment` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getAdjustment`(typeId INT,gradesId INT,v_month VARCHAR(7)) RETURNS double
BEGIN
-- 根据 种类 等级 获得调账 减少库存-增加库存（只管数值） 
    DECLARE totalAdd INT DEFAULT 0;
    DECLARE totalReduce INT DEFAULT 0;
	SELECT SUM(vw.`STOCK`) INTO totalReduce FROM v_warerecord vw WHERE vw.`GRADES_ID`=gradesId AND vw.`TYPE_ID`=typeId AND vw.`OPT_ID`=3 AND LEFT(vw.PRODUCED_DATE,7)=v_month;
	SELECT SUM(vw.`STOCK`) INTO totalAdd FROM v_warerecord vw WHERE vw.`GRADES_ID`=gradesId AND vw.`TYPE_ID`=typeId AND vw.`OPT_ID`=2 AND LEFT(vw.PRODUCED_DATE,7)=v_month;
	
	RETURN IFNULL(totalReduce,0)-IFNULL(totalAdd,0);
    END */$$
DELIMITER ;

/* Function  structure for function  `getBenchmarkByPId` */

/*!50003 DROP FUNCTION IF EXISTS `getBenchmarkByPId` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getBenchmarkByPId`(pId int) RETURNS double
BEGIN
    declare V_benchmark double default 0;
    SELECT BENCHMARK into V_benchmark FROM v_product WHERE ID=pId;
    return V_benchmark;
	
    END */$$
DELIMITER ;

/* Function  structure for function  `getBenchmarkByStockId` */

/*!50003 DROP FUNCTION IF EXISTS `getBenchmarkByStockId` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getBenchmarkByStockId`(stockId int) RETURNS double
BEGIN
    declare V_benchmark double default 0;
    SELECT BENCHMARK into V_benchmark FROM v_product WHERE ID= getPIdByStockId(stockId);
    return V_benchmark;
	
    END */$$
DELIMITER ;

/* Function  structure for function  `getBillSample` */

/*!50003 DROP FUNCTION IF EXISTS `getBillSample` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getBillSample`(typeId INT,gradesId INT,v_month VARCHAR(30)) RETURNS double
BEGIN
-- 根据 种类 等级 月份获取 月出的样品量(片)
    DECLARE totalBillSampleVolume DOUBLE DEFAULT 0;
	SELECT SUM(b.`count`) INTO totalBillSampleVolume FROM v_billrecord b 
	WHERE b.`typeId`=typeId 
	AND b.`gradesId`=gradesId 
	AND b.`bState`=1 
	AND b.billType='样品'
	AND LEFT(b.`billTime`,7)=LEFT(v_month,7);
	
	IF totalBillSampleVolume IS NULL 
	THEN SET totalBillSampleVolume=0;
	END IF;
	RETURN totalBillSampleVolume;
    END */$$
DELIMITER ;

/* Function  structure for function  `getBillStockByStockId` */

/*!50003 DROP FUNCTION IF EXISTS `getBillStockByStockId` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getBillStockByStockId`(v_stockId INT) RETURNS int(11)
BEGIN
    DECLARE v_bill_stock INT DEFAULT 0;
         SELECT SUM(br.`count`) INTO v_bill_stock FROM v_billrecord br WHERE br.`bState`=1 AND br.`stockId`=v_stockId ;
         if v_bill_stock is  null then set v_bill_stock=0;
         end if;
         RETURN v_bill_stock;
    END */$$
DELIMITER ;

/* Function  structure for function  `getCtmBalMonth` */

/*!50003 DROP FUNCTION IF EXISTS `getCtmBalMonth` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getCtmBalMonth`(ctmId INT,v_month VARCHAR(30)) RETURNS double
BEGIN
    DECLARE totalBal DOUBLE DEFAULT 0;
	SELECT SUM(b.`AMOUNT`) INTO totalBal FROM xly_bal_record b 
	WHERE b.`CTM_ID`=ctmId 
	AND LEFT(b.`CREATE_TIME`,7)=LEFT(v_month,7);
	RETURN totalBal;
    END */$$
DELIMITER ;

/* Function  structure for function  `getCtmConsumptionMonth` */

/*!50003 DROP FUNCTION IF EXISTS `getCtmConsumptionMonth` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getCtmConsumptionMonth`(ctmId INT,v_month VARCHAR(30)) RETURNS double
BEGIN
    DECLARE totalConsumption DOUBLE DEFAULT 0;
	SELECT SUM(b.`TOTAL_AMOUNT`) INTO totalConsumption FROM xly_bill b 
	WHERE b.`CTM_ID`=ctmId 
	AND b.`STATE`=1 
	AND b.BILL_TYPE!='样品'
	AND LEFT(b.`BILL_TIME`,7)=LEFT(v_month,7);
	RETURN totalConsumption;
    END */$$
DELIMITER ;

/* Function  structure for function  `getCurrentTotalStock` */

/*!50003 DROP FUNCTION IF EXISTS `getCurrentTotalStock` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getCurrentTotalStock`(typeId INT,gradesId INT) RETURNS double
BEGIN
-- 统一返回的是件 （箱）
     DECLARE totalStock INT DEFAULT 0;
	SELECT SUM(vs.`STOCK`) INTO totalStock FROM v_stock vs WHERE vs.`TYPE_ID`=typeId AND vs.`GRADES_ID`=gradesId ;
	
	IF totalStock IS NULL THEN 
	SET totalStock=0;
	END IF;
	RETURN totalStock;
    END */$$
DELIMITER ;

/* Function  structure for function  `getFreezeStock` */

/*!50003 DROP FUNCTION IF EXISTS `getFreezeStock` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getFreezeStock`(stockId INT) RETURNS int(11)
BEGIN
    DECLARE v_sum INT DEFAULT 0;
	SELECT SUM(wf.`COUNT`) INTO v_sum FROM xly_wh_freeze wf WHERE wf.`STOCK_ID`=stockId AND wf.`STATE`=1;
	RETURN v_sum;
    END */$$
DELIMITER ;

/* Function  structure for function  `getInventoryAdjust` */

/*!50003 DROP FUNCTION IF EXISTS `getInventoryAdjust` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getInventoryAdjust`(v_typeId INT,v_gradesId INT,v_month VARCHAR(7)) RETURNS int(11)
BEGIN
	-- 种类  等级 月份唯一
	RETURN IFNULL((SELECT SUM(ir.`modification`) FROM v_inventory_record ir WHERE ir.`gradesId`=v_gradesId AND ir.`typeId`=v_typeId AND LEFT(ir.`createDate`,7)=v_month),0);
    END */$$
DELIMITER ;

/* Function  structure for function  `getLastMonthBalance` */

/*!50003 DROP FUNCTION IF EXISTS `getLastMonthBalance` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getLastMonthBalance`(ctmId INT,v_month VARCHAR(30)) RETURNS double
BEGIN
-- 这个方法是用于 客户余额汇总表 由于 hibernate不支持selectfrom子查询
    DECLARE lastMonthBalance DOUBLE DEFAULT 0;
	SELECT cb.BALANCE INTO  lastMonthBalance FROM xly_ctm_bal cb 
	WHERE cb.`CTM_ID`=ctmId AND cb.`END_MONTH`= LEFT(DATE_SUB(STR_TO_DATE(v_month,'%Y-%m-%d'), INTERVAL 1 MONTH),7);
	IF lastMonthBalance IS NULL THEN SET lastMonthBalance=0;
	END IF;
	RETURN lastMonthBalance;
    END */$$
DELIMITER ;

/* Function  structure for function  `getMgrName` */

/*!50003 DROP FUNCTION IF EXISTS `getMgrName` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getMgrName`(userName varchar(10) ) RETURNS varchar(10) CHARSET utf8
BEGIN
    declare  realName varchar(10);
	SELECT  u.`CNAME_` into realName FROM bdf2_user u WHERE u.`USERNAME_`=userName;
	RETURN realName;
    END */$$
DELIMITER ;

/* Function  structure for function  `getNowCtmBal` */

/*!50003 DROP FUNCTION IF EXISTS `getNowCtmBal` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getNowCtmBal`(ctmId INT) RETURNS double
BEGIN
    DECLARE totalBal DOUBLE DEFAULT 0;
	SELECT SUM(b.`AMOUNT`) INTO totalBal FROM xly_bal_record b 
	WHERE b.`CTM_ID`=ctmId 
	AND LEFT(b.`CREATE_TIME`,7)=DATE_FORMAT(NOW(),'%Y-%m');
	RETURN totalBal;
    END */$$
DELIMITER ;

/* Function  structure for function  `getNowCtmConsumption` */

/*!50003 DROP FUNCTION IF EXISTS `getNowCtmConsumption` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getNowCtmConsumption`(ctmId INT) RETURNS double
BEGIN
    DECLARE totalConsumption DOUBLE DEFAULT 0;
	SELECT SUM(b.`TOTAL_AMOUNT`) INTO totalConsumption FROM xly_bill b 
	WHERE b.`CTM_ID`=ctmId 
	AND b.`STATE`=1 
	AND b.BILL_TYPE!='样品'
	AND LEFT(b.`BILL_TIME`,7)=DATE_FORMAT(NOW(),'%Y-%m');
	RETURN totalConsumption;
    END */$$
DELIMITER ;

/* Function  structure for function  `getNowMonth` */

/*!50003 DROP FUNCTION IF EXISTS `getNowMonth` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getNowMonth`() RETURNS varchar(7) CHARSET utf8
BEGIN
	RETURN (SELECT DATE_FORMAT(NOW(),'%Y-%m'));
    END */$$
DELIMITER ;

/* Function  structure for function  `getOutPut` */

/*!50003 DROP FUNCTION IF EXISTS `getOutPut` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getOutPut`(typeId INT,gradesId INT,v_month VARCHAR(30)) RETURNS double
BEGIN
-- 根据 种类 等级 月份获取总产量(片) 只算1正常入库 
    DECLARE totalAdd INT DEFAULT 0;
	SELECT SUM(vw.`STOCK`) INTO totalAdd FROM v_warerecord vw 
	WHERE vw.`TYPE_ID`=typeId 
	AND vw.`GRADES_ID`=gradesId 
	AND vw.OPT_ID=1
	AND LEFT(vw.`PRODUCED_DATE`,7)=LEFT(v_month,7);
	
	IF totalAdd IS NULL THEN 
	SET totalAdd=0;
	END IF;
	RETURN totalAdd;
    END */$$
DELIMITER ;

/* Function  structure for function  `getPIdByStockId` */

/*!50003 DROP FUNCTION IF EXISTS `getPIdByStockId` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getPIdByStockId`(stockId int) RETURNS int(11)
BEGIN
    declare  pId int default 0;
	 SELECT PRODUCT_ID into pId FROM xly_pdt_stock WHERE ID = stockId;
	 RETURN pId;
    END */$$
DELIMITER ;

/* Function  structure for function  `getSaleVolume` */

/*!50003 DROP FUNCTION IF EXISTS `getSaleVolume` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getSaleVolume`(typeId INT,gradesId INT,v_month VARCHAR(30)) RETURNS double
BEGIN
-- 根据 种类 等级 月份获取总销量(片)
    DECLARE totalSaleVolume DOUBLE DEFAULT 0;
	SELECT SUM(b.count) INTO totalSaleVolume FROM v_billrecord b 
	WHERE b.`typeId`=typeId 
	AND b.`gradesId`=gradesId 
	AND b.`bState`=1 
	AND b.billType!='样品'
	AND LEFT(b.`billTime`,7)=LEFT(v_month,7);
	
	IF totalSaleVolume IS NULL THEN 
	SET totalSaleVolume=0;
	END IF;
	RETURN totalSaleVolume;
    END */$$
DELIMITER ;

/* Function  structure for function  `getStockDamaged` */

/*!50003 DROP FUNCTION IF EXISTS `getStockDamaged` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getStockDamaged`(typeId INT,gradesId INT,v_month VARCHAR(30)) RETURNS double
BEGIN
     DECLARE totalReduce INT DEFAULT 0;
	SELECT SUM(vw.STOCK) INTO totalReduce FROM v_warerecord vw 
	WHERE vw.`TYPE_ID`=typeId 
	AND vw.`GRADES_ID`=gradesId 
	AND vw.OPT_ID=4
	AND LEFT(vw.`PRODUCED_DATE`,7)=LEFT(v_month,7);
	
	IF totalReduce IS NULL THEN 
	SET totalReduce=0;
	END IF;
	RETURN totalReduce;
    END */$$
DELIMITER ;

/* Function  structure for function  `getStockMove` */

/*!50003 DROP FUNCTION IF EXISTS `getStockMove` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getStockMove`(stockId INT) RETURNS double
BEGIN
-- 根据 种类 等级 获得调账 减少库存-增加库存（只管数值） 
    DECLARE totalAdd INT DEFAULT 0;
    DECLARE totalReduce INT DEFAULT 0;
	SELECT SUM(ms.`STOCK`) INTO totalReduce FROM `xly_move_stock` ms WHERE ms.`OUT_STOCKID`=stockId;
	SELECT SUM(ms.`STOCK`) INTO totalAdd FROM xly_move_stock ms WHERE ms.`IN_STOCKID`=stockId;
	
	RETURN IFNULL(totalReduce,0)-IFNULL(totalAdd,0);
    END */$$
DELIMITER ;

/* Function  structure for function  `getThisMonthBalance` */

/*!50003 DROP FUNCTION IF EXISTS `getThisMonthBalance` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getThisMonthBalance`(ctmId INT,v_month VARCHAR(30)) RETURNS double
BEGIN
-- 这个方法是用于 客户余额汇总表 如果是当前月，返回当前余额，否则返回本月底余额
    DECLARE thisMonthBalance DOUBLE DEFAULT 0;
	if(left(now(),7)=LEFT(v_month,7)) then 
	select vc.money into thisMonthBalance from v_customer vc where vc.ctmId=ctmId;
	else
	SELECT cb.BALANCE INTO  thisMonthBalance FROM xly_ctm_bal cb 
	WHERE cb.`CTM_ID`=ctmId AND cb.`END_MONTH`= LEFT(v_month,7);
	END IF;
	IF thisMonthBalance IS NULL THEN SET thisMonthBalance=0;
	end if;
	RETURN thisMonthBalance;
    END */$$
DELIMITER ;

/* Function  structure for function  `sortCtmBuyInsertCheck` */

/*!50003 DROP FUNCTION IF EXISTS `sortCtmBuyInsertCheck` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `sortCtmBuyInsertCheck`(V_CTM_ID INT,V_SALE_MGR_ID INT,V_MONTH VARCHAR(30)) RETURNS int(11)
BEGIN
    DECLARE V_RECORD_COUNT INT DEFAULT 0;
	SELECT COUNT(*) INTO V_RECORD_COUNT FROM xly_ctm_buy cb WHERE  cb.`CTM_ID`=V_CTM_ID AND SALE_MGR_ID=V_SALE_MGR_ID AND END_MONTH=V_MONTH;
	IF V_RECORD_COUNT IS NULL 
	THEN SET V_RECORD_COUNT=0;
	END IF ;
	RETURN V_RECORD_COUNT;
    END */$$
DELIMITER ;

/* Function  structure for function  `sp_cn` */

/*!50003 DROP FUNCTION IF EXISTS `sp_cn` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `sp_cn`(n_LowerMoney  decimal(15,2)) RETURNS varchar(200) CHARSET utf8
begin
Declare v_LowerStr  NVARCHAR(200) ;
Declare v_UpperPart NVARCHAR(200) ;
Declare v_UpperStr NVARCHAR(200) ;
Declare i_I int ;
set v_LowerStr = LTRIM(RTRIM(ROUND(n_LowerMoney,2 ) ) ) ;
set i_I = 1 ;
set v_UpperStr = '' ;
while ( i_I <=char_length(v_LowerStr ) )  do
set v_UpperPart = CONCAT( case substring(v_LowerStr,char_length(v_LowerStr) - i_I + 1,1 )
WHEN '.' THEN '元'
WHEN '0' THEN '零'
WHEN '1' THEN '壹'
WHEN '2' THEN '贰'
WHEN '3' THEN '叁'
WHEN '4' THEN '肆'
WHEN '5' THEN '伍'
WHEN '6' THEN '陆'
WHEN '7' THEN '柒'
WHEN '8' THEN '捌'
WHEN '9' THEN '玖'
END,
case i_I
WHEN 1 THEN '分'
WHEN 2 THEN '角'
WHEN 3 THEN ''
WHEN 4 THEN ''
WHEN 5 THEN '拾'
WHEN 6 THEN '佰'
WHEN 7 THEN '仟'
WHEN 8 THEN '万'
WHEN 9 THEN '拾'
WHEN 10 THEN '佰'
WHEN 11 THEN '仟'
WHEN 12 THEN '亿'
WHEN 13 THEN '拾'
WHEN 14 THEN '佰'
WHEN 15 THEN '仟'
WHEN 16 THEN '万'
ELSE ''
END );
set v_UpperStr =CONCAT( v_UpperPart , v_UpperStr) ;
set i_I = i_I + 1 ;
end while;
set v_UpperStr = REPLACE(v_UpperStr,'零拾','零') ;
set v_UpperStr = REPLACE(v_UpperStr,'零佰','零') ;
set v_UpperStr = REPLACE(v_UpperStr,'零仟','零') ;
set v_UpperStr = REPLACE(v_UpperStr,'零零零','零') ;
set v_UpperStr = REPLACE(v_UpperStr,'零零','零') ;
set v_UpperStr = REPLACE(v_UpperStr,'零角零分','整') ;
set v_UpperStr = REPLACE(v_UpperStr,'零分','整') ;
set v_UpperStr = REPLACE(v_UpperStr,'零角','零') ;
set v_UpperStr = REPLACE(v_UpperStr,'零亿零万零元','亿元') ;
set v_UpperStr = REPLACE(v_UpperStr,'亿零万零元','亿元') ;
set v_UpperStr = REPLACE(v_UpperStr,'零亿零万','亿') ;
set v_UpperStr = REPLACE(v_UpperStr,'零万零元','万元') ;
set v_UpperStr = REPLACE(v_UpperStr,'万零元','万元') ;
set v_UpperStr = REPLACE(v_UpperStr,'零亿','亿') ;
set v_UpperStr = REPLACE(v_UpperStr,'零万','万') ;
set v_UpperStr = REPLACE(v_UpperStr,'零元','元') ;
set v_UpperStr = REPLACE(v_UpperStr,'零零','零') ;
if ( '元' = substring(v_UpperStr,1,1))  then
set v_UpperStr = substring(v_UpperStr,2,(char_length(v_UpperStr) - 1));
end if;
if ( '零' = substring(v_UpperStr,1,1)) then
set v_UpperStr = substring(v_UpperStr,2,(char_length(v_UpperStr) - 1)) ;
end if;
if ( '角' = substring(v_UpperStr,1,1)) then
set v_UpperStr = substring(v_UpperStr,2,(char_length(v_UpperStr) - 1)) ;
end if;
if ( '分' = substring(v_UpperStr,1,1)) then
set v_UpperStr = substring(v_UpperStr,2,(char_length(v_UpperStr) - 1)) ;
end if;
if ('整' = substring(v_UpperStr,1,1)) then
set v_UpperStr = '零元整' ;
end if;
return  v_UpperStr;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ACheckCtmStatement` */

/*!50003 DROP PROCEDURE IF EXISTS  `ACheckCtmStatement` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `ACheckCtmStatement`()
BEGIN
  DECLARE V_CTM_ID INT DEFAULT 0;
    DECLARE V_CTM_NAME VARCHAR(20);
    DECLARE LAST_BAL double default 0;
    DECLARE CURR_BAL DOUBLE DEFAULT 0;
    DECLARE THIS_MONTH_CUP DOUBLE DEFAULT 0;
    DECLARE THIS_MONTH_BAL DOUBLE DEFAULT 0;
    
    DECLARE done BOOLEAN DEFAULT FALSE;  
    DECLARE cur CURSOR FOR 
    SELECT 
	vc.`ctmName`,
	cb.`BALANCE`,
	vc.`money` ,
	ifnull((SELECT getNowCtmConsumption(cb.`CTM_ID`)),0),
	IFNULL((SELECT getNowCtmBal(cb.`CTM_ID`)),0)
	 FROM xly_ctm_bal cb,v_customer vc
	WHERE cb.`CTM_ID`=vc.`ctmId` AND cb.`END_MONTH`=LEFT(DATE_SUB(NOW(),INTERVAL 1 MONTH),7);
    OPEN cur;
    SET @a=0;
    truncate temp_incorrect_ctm_bal;
  -- 开始循环
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur INTO V_CTM_NAME,LAST_BAL,CURR_BAL,THIS_MONTH_CUP,THIS_MONTH_BAL;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
    -- 当前余额+销售额-入账 得出上月余额
    insert into temp_incorrect_ctm_bal(ctmName,lastMonthCtmBal,currBal,thisMonCup,thisMonBal,calLastMonthBal)
    values(V_CTM_NAME,LAST_BAL,CURR_BAL,THIS_MONTH_CUP,THIS_MONTH_BAL,currBal+thisMonCup-thisMonBal);
  END LOOP;
  CLOSE cur;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `ACheckLocalStock` */

/*!50003 DROP PROCEDURE IF EXISTS  `ACheckLocalStock` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `ACheckLocalStock`()
BEGIN
	DROP TEMPORARY TABLE IF EXISTS tmp_check_local_stock;
    CREATE TEMPORARY TABLE tmp_check_local_stock
    SELECT
  `ps`.`ID`          AS `ID`,
  `ps`.`PRODUCT_ID`  AS `PRODUCT_ID`,
  `ps`.`WAREHOUSE`   AS `WAREHOUSE`,
  `ps`.`MODIFY_DATE` AS `MODIFY_DATE`,
  `ps`.`STOCK`       AS `STOCK`,
  `getStockMove`(
`ps`.`ID`)  AS `moveStock`,
  `ACheckWareStock`(
`ps`.`ID`)  AS `wareStock`,
  `getFreezeStock`(
`ps`.`ID`)  AS `freezeStock`,
  IFNULL(`bs`.`billStock`,0) AS `billStock`,
  IFNULL((SELECT  SUM(ir.`MODIFICATION`) FROM `xly_inventory_record` ir WHERE ir.`STOCK_ID`=`ps`.`ID`),0) AS modification
FROM (`xly_pdt_stock` `ps` LEFT JOIN `v_billstock` `bs` ON ((`bs`.`stockId` = `ps`.`ID`)));
SELECT * FROM tmp_check_local_stock als WHERE `als`.`STOCK`!= -IFNULL(`als`.`freezeStock`,0)-IFNULL(`als`.`billStock`,0)+ `als`.`wareStock`  - IFNULL(`als`.`moveStock`,0)+modification;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `ACtmStatement` */

/*!50003 DROP PROCEDURE IF EXISTS  `ACtmStatement` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `ACtmStatement`()
BEGIN
       DECLARE V_CTM_ID INT DEFAULT 0;
    DECLARE V_CTM_NAME VARCHAR(20);
    DECLARE V_MONEY VARCHAR(30);
    DECLARE done BOOLEAN DEFAULT FALSE;     
    DECLARE cur CURSOR FOR 
    SELECT CTM_ID,IMPORT_MONEY FROM `xly_ctm_hedui`;
    OPEN cur;
    SET @a=0;
  -- 开始循环
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur INTO V_CTM_ID,V_MONEY;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
    insert into xly_ctm_bal(CTM_ID,BALANCE,END_MONTH) values(V_CTM_ID,V_MONEY,'2017-06');
  END LOOP;
  CLOSE cur;  
    END */$$
DELIMITER ;

/* Procedure structure for procedure `addBatchBillRecord` */

/*!50003 DROP PROCEDURE IF EXISTS  `addBatchBillRecord` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `addBatchBillRecord`(
    V_CTMID int ,
    S_ID1 INT ,
    v_count INT ,
    PRICE double 
    )
BEGIN
     
    DECLARE V_SALE_MGR_ID INT DEFAULT 0;
    DECLARE i INT DEFAULT 1;
	
    DECLARE LAST_ID INT DEFAULT 0;
    DECLARE pId INT DEFAULT 0;
    INSERT INTO xly_bill (BILL_TIME,CTM_ID,FREIGHT,DRIVER_PHONE,CAR_NO,CREATER,REMARK,BILL_TYPE)
    VALUES(NOW(),V_CTMID,200,'15019861460','JMMM23','System','批量','普通');
    SELECT LAST_INSERT_ID() INTO LAST_ID;
    
    repeat 
    select getPIdByStockId(S_ID1) into pId;
    INSERT INTO xly_bill_record (BILL_NO,STOCK_ID,COUNT,PRICE,BENCHMARK)
    VALUES(LAST_ID,S_ID1,v_count*i,30,getBenchmarkByPId(pId));
    set i = i + 1;  
    until i >= 5 
    end repeat;  
    update xly_bill set TOTAL_AMOUNT=countTotalAmount(LAST_ID) where BILL_NO=LAST_ID;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AExcelStock` */

/*!50003 DROP PROCEDURE IF EXISTS  `AExcelStock` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AExcelStock`(IN V_MD VARCHAR(10))
BEGIN
    DECLARE V_P_ID INT DEFAULT 0;
    DECLARE V_IMPORT_ID INT DEFAULT 0;
    DECLARE V_TYPEBRAND_ID INT DEFAULT 0;
    DECLARE V_TAR_STOCK INT DEFAULT 0;
    DECLARE V_TAR_STOCKID INT DEFAULT 0;
    DECLARE V_FREZEE_STOCK INT DEFAULT 0;
    DECLARE V_BILL_STOCK INT DEFAULT 0;
    
    DECLARE V_CTM_NAME VARCHAR(20);
    
    DECLARE v_typeBrand VARCHAR(20);
    DECLARE v_category VARCHAR(20);
    DECLARE v_patternno VARCHAR(10);
    DECLARE v_grades VARCHAR(10);
    DECLARE v_color VARCHAR(10);
    DECLARE v_warehouse VARCHAR(10);
    
    DECLARE done BOOLEAN DEFAULT FALSE;     
    DECLARE cur CURSOR FOR 
    SELECT id,typeBrand,category,patternno ,grades,color,warehouse FROM `import_stock`;
    OPEN cur;
    SET @a=0;
    UPDATE import_stock SET currentStock =0,pId=0,stockId=0,freezeStock=0,todayBillStock=0,wareStock=0;
  -- 开始循环
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur INTO V_IMPORT_ID,v_typeBrand,v_category,v_patternno,v_grades,v_color,v_warehouse;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
	
    IF v_typeBrand='曼宜森' THEN  SET V_TYPEBRAND_ID=1;
    ELSEIF v_typeBrand='曼宜森(金)' or v_typeBrand='曼宜森（金）' THEN  SET V_TYPEBRAND_ID=4;
     ELSEIF v_typeBrand='布达米亚' OR v_typeBrand='布达米亚(新)' OR v_typeBrand='布达米亚（新）' THEN  SET V_TYPEBRAND_ID=2;
     ELSEIF v_typeBrand='布达米亚(金)' OR v_typeBrand='布达米亚（金）'THEN  SET V_TYPEBRAND_ID=5;
     
     ELSEIF v_typeBrand='新圣悦' THEN  SET V_TYPEBRAND_ID=3;
     ELSEIF v_typeBrand='新圣悦(金)' OR v_typeBrand='新圣悦（金）' THEN SET V_TYPEBRAND_ID=6;
   ELSEIF v_typeBrand='牧梵' THEN SET V_TYPEBRAND_ID=7;
    END IF;
    -- 要先归零 否则没有结果还会继续用
    SET V_P_ID=0,V_TAR_STOCKID=0,V_TAR_STOCK=0,V_FREZEE_STOCK=0,V_BILL_STOCK=0;
     SELECT vp.`ID` INTO  V_P_ID FROM v_productall vp WHERE vp.`TYPE_BRAND_ID`=V_TYPEBRAND_ID AND vp.`CATEGORT`= v_category
    AND vp.`COLOR`=v_color AND vp.`GRADES_NAME`=v_grades AND vp.`PATTERN_NO`=v_patternno LIMIT 1;
    IF V_P_ID > 0 THEN 
	    SELECT ps.`STOCK` ,ps.`ID` INTO V_TAR_STOCK,V_TAR_STOCKID FROM xly_pdt_stock ps WHERE ps.`PRODUCT_ID`=V_P_ID AND ps.`WAREHOUSE`=v_warehouse;
	     SELECT SUM(br.`count`) INTO V_BILL_STOCK FROM v_billrecord br WHERE br.`bState`=1 AND br.`stockId`=V_TAR_STOCKID AND LEFT(br.`billTime`,10)=V_MD;
	    IF V_TAR_STOCKID >0 THEN 
	    UPDATE import_stock SET currentStock =V_TAR_STOCK,pId=V_P_ID,stockId=V_TAR_STOCKID,freezeStock=`ACheckFreezeStock`(V_TAR_STOCKID),todayBillStock= V_BILL_STOCK,wareStock=`ACheckWareStock`(V_TAR_STOCKID)  WHERE id = V_IMPORT_ID;
	    END IF;
     END IF;
    
   
   
   
  END LOOP;
  CLOSE cur;  
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AFormatPattAndColor` */

/*!50003 DROP PROCEDURE IF EXISTS  `AFormatPattAndColor` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AFormatPattAndColor`()
BEGIN 
    UPDATE import_stock SET patternno =`AFormatPatterno`(patternno),color =`AFormatPatterno`(color),category=`AFormatPatterno`(category);
    
    END */$$
DELIMITER ;

/* Procedure structure for procedure `ALocalStock` */

/*!50003 DROP PROCEDURE IF EXISTS  `ALocalStock` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `ALocalStock`(in V_MD varchar(10))
BEGIN
    DECLARE V_P_ID INT DEFAULT 0;
    DECLARE v_stockId INT DEFAULT 0;
    DECLARE v_stock INT DEFAULT 0;
    DECLARE v_productId INT DEFAULT 0;
    DECLARE v_ INT DEFAULT 0;
    DECLARE V_FREZEE_STOCK INT DEFAULT 0;
    DECLARE V_BILL_STOCK INT DEFAULT 0;
    
    DECLARE v_warehouse VARCHAR(10);
    
    DECLARE done BOOLEAN DEFAULT FALSE;     
    DECLARE cur CURSOR FOR 
    SELECT id,PRODUCT_ID,stock,warehouse FROM `xly_pdt_stock`;
    OPEN cur;
    SET @a=0;
      -- first clean all date；
      truncate local_stock;
  -- 开始循环
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur INTO v_stockId,v_productId,v_stock,v_warehouse;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
    -- 这里还要根据 冻结库存来更新库存 
    select sum(wf.COUNT) into V_FREZEE_STOCK from `xly_wh_freeze` wf where wf.state=1 and wf.STOCK_ID= v_stockId;
    SELECT SUM(br.`count`) INTO V_BILL_STOCK FROM v_billrecord br WHERE br.`bState`=1 AND br.`stockId`=v_stockId ;
    insert local_stock (pId,currentStock,stockId,warehouse,freezeStock,billStock,wareStock)
    values(v_productId,v_stock,v_stockId,v_warehouse,V_FREZEE_STOCK,V_BILL_STOCK,`ACheckWareRecord`(v_productId,v_warehouse));
     -- 要先归零 否则没有结果还会继续用
    SET v_productId=0,v_stockId=0,v_stock=0,V_FREZEE_STOCK=0,V_BILL_STOCK=0;
    
   
   
   
  END LOOP;
  CLOSE cur;  
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AMappingCtm` */

/*!50003 DROP PROCEDURE IF EXISTS  `AMappingCtm` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AMappingCtm`()
BEGIN
     DECLARE V_CTM_ID INT DEFAULT 0;
    DECLARE V_CTM_NAME varchar(20);
    DECLARE V_ADDRESS VARCHAR(30);
    DECLARE done BOOLEAN DEFAULT FALSE;     
    DECLARE cur CURSOR FOR 
    SELECT ctmId,ctmName,address from v_customer;
    OPEN cur;
    SET @a=0;
  -- 开始循环
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur INTO V_CTM_ID,V_CTM_NAME,V_ADDRESS;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
    UPDATE xly_ctm_hedui SET CTM_ID=V_CTM_ID WHERE CTM_NAME=V_CTM_NAME AND ADDRESS=V_ADDRESS;
  END LOOP;
  CLOSE cur;  
 END */$$
DELIMITER ;

/* Procedure structure for procedure `AMappingFreezeStock` */

/*!50003 DROP PROCEDURE IF EXISTS  `AMappingFreezeStock` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AMappingFreezeStock`()
BEGIN
     DECLARE V_STOCK_ID INT DEFAULT 0;
     DECLARE V_COUNT INT DEFAULT 0;
    DECLARE V_CTM_NAME varchar(20);
    DECLARE V_ADDRESS VARCHAR(30);
    DECLARE done BOOLEAN DEFAULT FALSE;     
    DECLARE cur CURSOR FOR 
    SELECT wf.`STOCK_ID`,wf.`COUNT` FROM xly_wh_freeze wf WHERE wf.STATE=1;
    OPEN cur;
    SET @a=0;
  -- 开始循环
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur INTO V_STOCK_ID,V_COUNT;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
    UPDATE import_stock SET freezeStock=freezeStock+V_COUNT where stockId=V_STOCK_ID;
  END LOOP;
  CLOSE cur;  
 END */$$
DELIMITER ;

/* Procedure structure for procedure `AModifyStock` */

/*!50003 DROP PROCEDURE IF EXISTS  `AModifyStock` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AModifyStock`(v_stockId INT,v_modifyCount INT, v_targetStock INT,v_remark VARCHAR(200))
BEGIN
   
    INSERT a_modifty_stock_record (stockId,modifyStock,targetStock,modifyDate,remark)
    VALUES(v_stockId,v_modifyCount,v_targetStock,NOW(),v_remark);
    
    CALL setStock(v_stockId,v_modifyCount);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `ASetAllJournalCount` */

/*!50003 DROP PROCEDURE IF EXISTS  `ASetAllJournalCount` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `ASetAllJournalCount`()
BEGIN
     DECLARE v_ctm_id INT DEFAULT 0; 
     DECLARE done BOOLEAN DEFAULT FALSE;
    
     DECLARE cur CURSOR FOR SELECT CTM_ID FROM xly_customer;
     DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  SET @a=0;
  read_loop: LOOP
    -- 提取游标里的数据， 第一行没有update 第二行开始  （入账有无正确的正负？）
    FETCH cur INTO v_ctm_id;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
	CALL ASetJournalCount(v_ctm_id);
  END LOOP;
  CLOSE cur;
	SELECT @a;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `ASetJournalCount` */

/*!50003 DROP PROCEDURE IF EXISTS  `ASetJournalCount` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `ASetJournalCount`(v_ctmId INT )
BEGIN
	DECLARE V_RECORD_ID INT DEFAULT 0; 
   
    DECLARE v_first BOOLEAN DEFAULT TRUE;   
    DECLARE V_TYPE VARCHAR(10) ;  
    DECLARE V_BAL_BEFORE DOUBLE DEFAULT 0;
    DECLARE V_BAL_AFTER DOUBLE DEFAULT 0;
    DECLARE V_IN DOUBLE DEFAULT 0;
    DECLARE V_OUT DOUBLE DEFAULT 0;
    -- 记录后一条的before即可 作为前一条的after（这里的后一条是按时间的倒序排的）
    DECLARE v_pre_bal_before DOUBLE DEFAULT 0;
       
     DECLARE done BOOLEAN DEFAULT FALSE;
    
     DECLARE cur CURSOR FOR 
SELECT a.recordId,a.optType,a.balBefore,a.balAfter,a.amountIn,a.amountOut
FROM(
SELECT  vb.`ctmId`,vb.`balId` recordID,CONCAT('入账','')optType ,vb.balBefore ,vb.balAfter ,vb.`amount` amountIn,0 amountOut,vb.`createTime`
FROM v_balrecord vb UNION ALL
SELECT b.CTM_ID ctmId,b.`BILL_NO` recordId,CONCAT('开票','') optType,b.`BAL_BEFORE` balBefore,b.`BAL_AFTER` balAfter,CONCAT('0','') amountIn,b.`TOTAL_AMOUNT` amountOut,b.`BILL_TIME` createTime
FROM xly_bill b WHERE  b.`STATE`=1 AND b.`BILL_TYPE`!='样品' ) a,v_customer vc WHERE vc.`ctmId`=v_ctmId AND vc.`ctmId`=a.ctmId 
ORDER BY a.createTime DESC;
     DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  -- 以当前余额为起点
  SET v_pre_bal_before=dcoM(v_ctmId);
  read_loop: LOOP
    -- 提取游标里的数据， 第一行没有update 第二行开始  （入账有无正确的正负？）
    FETCH cur INTO V_RECORD_ID,V_TYPE,V_BAL_BEFORE,V_BAL_AFTER,V_IN,V_OUT;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
    -- 前=后+out-in
    IF V_TYPE='开票' THEN UPDATE xly_bill SET BAL_BEFORE=v_pre_bal_before+V_OUT-V_IN,BAL_AFTER=v_pre_bal_before WHERE BILL_NO=V_RECORD_ID;
    ELSE 
    UPDATE `xly_bal_record` SET BAL_BEFORE=v_pre_bal_before+V_OUT-V_IN,BAL_AFTER=v_pre_bal_before WHERE BAL_ID=V_RECORD_ID;
    END IF;
      -- 将最近的转存
    SET v_pre_bal_before=v_pre_bal_before+V_OUT-V_IN;
    SET @a=@a+1;
  END LOOP;
  CLOSE cur;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AUpdateProdcutTypeBrandId` */

/*!50003 DROP PROCEDURE IF EXISTS  `AUpdateProdcutTypeBrandId` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AUpdateProdcutTypeBrandId`()
BEGIN
UPDATE `xly_product` SET TYPE_ID=1,BRAND_ID=1 WHERE TYPE_BRAND_ID=1;
UPDATE `xly_product` SET TYPE_ID=1,BRAND_ID=2 WHERE TYPE_BRAND_ID=2;
UPDATE `xly_product` SET TYPE_ID=1,BRAND_ID=3 WHERE TYPE_BRAND_ID=3;
UPDATE `xly_product` SET TYPE_ID=2,BRAND_ID=1 WHERE TYPE_BRAND_ID=4;
UPDATE `xly_product` SET TYPE_ID=2,BRAND_ID=2 WHERE TYPE_BRAND_ID=5;
UPDATE `xly_product` SET TYPE_ID=2,BRAND_ID=3 WHERE TYPE_BRAND_ID=6;
UPDATE `xly_product` SET TYPE_ID=3,BRAND_ID=4 WHERE TYPE_BRAND_ID=7;
UPDATE `xly_product` SET TYPE_ID=3,BRAND_ID=1 WHERE TYPE_BRAND_ID=8;
UPDATE `xly_product` SET TYPE_ID=4,BRAND_ID=1 WHERE TYPE_BRAND_ID=9;
END */$$
DELIMITER ;

/* Procedure structure for procedure `batchUpdateBillTotal` */

/*!50003 DROP PROCEDURE IF EXISTS  `batchUpdateBillTotal` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `batchUpdateBillTotal`()
BEGIN
       
    DECLARE V_BILL_NO INT DEFAULT 0;
    DECLARE done BOOLEAN DEFAULT FALSE;     
    DECLARE cur CURSOR FOR 
    SELECT b.BILL_NO
    FROM  xly_bill b;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  
  OPEN cur;
    SET @a=0;
  -- 开始循环
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur INTO V_BILL_NO;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;  
      UPDATE xly_bill SET TOTAL_AMOUNT=countTotalAmount(V_BILL_NO) where BILL_NO=V_BILL_NO;
	
   
  END LOOP;
  CLOSE cur;  
    END */$$
DELIMITER ;

/* Procedure structure for procedure `chartCtmBrand` */

/*!50003 DROP PROCEDURE IF EXISTS  `chartCtmBrand` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `chartCtmBrand`(v_ctmId INT )
BEGIN
	DECLARE V_RECORD_ID INT DEFAULT 0; 
    DECLARE V_BRAND_A INT DEFAULT 0;
    DECLARE V_BRAND_B INT DEFAULT 0;
    DECLARE V_BRAND_C INT DEFAULT 0; 
    DECLARE V_BRAND_D INT DEFAULT 0; 
   
     DECLARE V_ID INT DEFAULT 0;   
    DECLARE V_YM VARCHAR(10) ;  
    
     DECLARE done BOOLEAN DEFAULT FALSE;
    
     DECLARE cur CURSOR FOR 
     SELECT ym FROM `xly_year_month`  WHERE STR_TO_DATE(`ym`,'%Y-%m-%d') BETWEEN (NOW() - INTERVAL 1 YEAR)  AND NOW();
       DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
     -- 不捕捉错误 否则会跳过
  OPEN cur;
    SET @a=0;
    -- 先根据ctmId 都全删了 以后就直接出入即可
    DELETE FROM xly_char_ctmbrand  WHERE ctmId=v_ctmId;
  -- 开始循环 以时间为主导
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur INTO V_YM;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
    
    SET V_BRAND_A=0,V_BRAND_B=0,V_BRAND_C=0,V_BRAND_D=0,V_RECORD_ID=0;
 
    SELECT SUM(vb.`qtyCount`) INTO V_BRAND_A FROM v_billrecord vb WHERE vb.`billType`!='样品' AND vb.`bState`=1 AND vb.`brandId`=1 AND LEFT(vb.`billTime`,7)=V_YM AND vb.ctmId=v_ctmId;
    SELECT SUM(vb.`qtyCount`) INTO V_BRAND_B FROM v_billrecord vb WHERE vb.`billType`!='样品' AND vb.`bState`=1 AND vb.`brandId`=2 AND LEFT(vb.`billTime`,7)=V_YM AND vb.ctmId=v_ctmId;
    SELECT SUM(vb.`qtyCount`) INTO V_BRAND_C FROM v_billrecord vb WHERE vb.`billType`!='样品' AND vb.`bState`=1 AND vb.`brandId`=3 AND LEFT(vb.`billTime`,7)=V_YM AND vb.ctmId=v_ctmId;
    SELECT SUM(vb.`qtyCount`) INTO V_BRAND_D FROM v_billrecord vb WHERE vb.`billType`!='样品' AND vb.`bState`=1 AND vb.`brandId`=4 AND LEFT(vb.`billTime`,7)=V_YM AND vb.ctmId=v_ctmId;
    
    INSERT INTO  xly_char_ctmbrand(billTime,ctmId,brandA,brandB,brandC,brandD) VALUES (V_YM,v_ctmId,IFNULL(V_BRAND_A,0),IFNULL(V_BRAND_B,0),IFNULL(V_BRAND_C,0),IFNULL(V_BRAND_D,0));
  END LOOP;
  CLOSE cur;
  SELECT @a;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `chartCtmPdtType` */

/*!50003 DROP PROCEDURE IF EXISTS  `chartCtmPdtType` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `chartCtmPdtType`(v_ctmId INT )
BEGIN
	DECLARE V_RECORD_ID INT DEFAULT 0; 
    DECLARE V_TYPE_A INT DEFAULT 0;
    DECLARE V_TYPE_B INT DEFAULT 0;
    DECLARE V_TYPE_C INT DEFAULT 0;
    DECLARE V_TYPE_D INT DEFAULT 0;  
   
     DECLARE V_ID INT DEFAULT 0;   
    DECLARE V_YM VARCHAR(10) ;  
    
     DECLARE done BOOLEAN DEFAULT FALSE;
    
     DECLARE cur CURSOR FOR 
     SELECT ym FROM `xly_year_month`  WHERE STR_TO_DATE(`ym`,'%Y-%m-%d') BETWEEN (NOW() - INTERVAL 1 YEAR)  AND NOW();
       DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
     -- 不捕捉错误 否则会跳过
  OPEN cur;
    SET @a=0;
    -- 先根据ctmId 都全删了 以后就直接出入即可
    DELETE FROM xly_char_ctm_pdt_type  WHERE ctmId=v_ctmId;
  -- 开始循环 以时间为主导
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur INTO V_YM;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
    
    SET V_TYPE_A=0,V_TYPE_B=0,V_TYPE_C=0;
 
    SELECT SUM(vb.`qtyCount`) INTO V_TYPE_A FROM v_billrecord vb WHERE vb.`billType`!='样品' AND vb.`bState`=1 AND vb.`typeId`=1 AND LEFT(vb.`billTime`,7)=V_YM AND vb.ctmId=v_ctmId;
    SELECT SUM(vb.`qtyCount`) INTO V_TYPE_B FROM v_billrecord vb WHERE vb.`billType`!='样品' AND vb.`bState`=1 AND vb.`typeId`=2 AND LEFT(vb.`billTime`,7)=V_YM AND vb.ctmId=v_ctmId;
    SELECT SUM(vb.`qtyCount`) INTO V_TYPE_C FROM v_billrecord vb WHERE vb.`billType`!='样品' AND vb.`bState`=1 AND vb.`typeId`=3 AND LEFT(vb.`billTime`,7)=V_YM AND vb.ctmId=v_ctmId;
    SELECT SUM(vb.`qtyCount`) INTO V_TYPE_D FROM v_billrecord vb WHERE vb.`billType`!='样品' AND vb.`bState`=1 AND vb.`typeId`=4 AND LEFT(vb.`billTime`,7)=V_YM AND vb.ctmId=v_ctmId;
    
    INSERT INTO  xly_char_ctm_pdt_type(billTime,ctmId,typeA,typeB,typeC,typeD) VALUES (V_YM,v_ctmId,IFNULL(V_TYPE_A,0),IFNULL(V_TYPE_B,0),IFNULL(V_TYPE_C,0),IFNULL(V_TYPE_D,0));
  END LOOP;
  CLOSE cur;
  SELECT @a;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `chartProductType` */

/*!50003 DROP PROCEDURE IF EXISTS  `chartProductType` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `chartProductType`()
BEGIN
    DECLARE V_TYPE_A INT DEFAULT 0;
    DECLARE V_TYPE_B INT DEFAULT 0;
    DECLARE V_TYPE_C INT DEFAULT 0;
    DECLARE V_TYPE_D INT DEFAULT 0;  
   
     DECLARE V_ID INT DEFAULT 0;   
    DECLARE V_YM VARCHAR(10) ;  
    
     DECLARE done BOOLEAN DEFAULT FALSE;
     DECLARE cur CURSOR FOR 
     SELECT id,billTime FROM `xly_char_pdttype`  WHERE STR_TO_DATE(`billTime`,'%Y-%m-%d') BETWEEN (NOW() - INTERVAL 1 YEAR)  AND NOW();
  OPEN cur;
    SET @a=0;
  -- 开始循环 以时间为主导
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur INTO V_ID,V_YM;
    -- 声明结束的时候
     SET V_TYPE_A=0,V_TYPE_B=0,V_TYPE_C=0;
    SELECT SUM(vb.`qtyCount`) INTO V_TYPE_A FROM v_billrecord vb WHERE vb.`billType`!='样品' AND vb.`bState`=1 AND vb.`typeId`=1 AND LEFT(vb.`billTime`,7)=V_YM;
    SELECT SUM(vb.`qtyCount`) INTO V_TYPE_B FROM v_billrecord vb WHERE vb.`billType`!='样品' AND vb.`bState`=1 AND vb.`typeId`=2 AND LEFT(vb.`billTime`,7)=V_YM;
    SELECT SUM(vb.`qtyCount`) INTO V_TYPE_C FROM v_billrecord vb WHERE vb.`billType`!='样品' AND vb.`bState`=1 AND vb.`typeId`=3 AND LEFT(vb.`billTime`,7)=V_YM;
    SELECT SUM(vb.`qtyCount`) INTO V_TYPE_D FROM v_billrecord vb WHERE vb.`billType`!='样品' AND vb.`bState`=1 AND vb.`typeId`=4 AND LEFT(vb.`billTime`,7)=V_YM;
    UPDATE xly_char_pdttype SET typeA=IFNULL(V_TYPE_A,0),typeB=IFNULL(V_TYPE_B,0),typeC=IFNULL(V_TYPE_C,0),typeD=IFNULL(V_TYPE_D,0) WHERE id=V_ID;
  END LOOP;
  CLOSE cur;
   
    END */$$
DELIMITER ;

/* Procedure structure for procedure `creatMonth` */

/*!50003 DROP PROCEDURE IF EXISTS  `creatMonth` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `creatMonth`()
BEGIN
  DECLARE num INT ;
  SET num = 1 ;
  WHILE
    num < 13 DO 
    INSERT INTO xly_year_month (ym) 
    VALUES
      (concat('2016-',LPAD(num,2,0))) ;
    SET num = num + 1 ;
  END WHILE ;
END */$$
DELIMITER ;

/* Procedure structure for procedure `dcoMoney` */

/*!50003 DROP PROCEDURE IF EXISTS  `dcoMoney` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `dcoMoney`(IN ctmId INT,OUT p_out DOUBLE)
BEGIN
	 SELECT DECODE(money,'xly') money INTO p_out FROM xly_customer WHERE CTM_ID=ctmId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `delAndRevert` */

/*!50003 DROP PROCEDURE IF EXISTS  `delAndRevert` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `delAndRevert`(
IN recordId int,
out result boolean
)
BEGIN
declare  num int default 0;
DECLARE OPT_TYPE INT DEFAULT 0;
select  STOCK,TYPE_ID into num,OPT_TYPE from xly_wh_record whr where whr.ID=recordId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `delBalByCtmId` */

/*!50003 DROP PROCEDURE IF EXISTS  `delBalByCtmId` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `delBalByCtmId`(ctmId int)
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE; 
    
    DELETE FROM xly_bal_record  WHERE CTM_ID=ctmId ;
 
    END */$$
DELIMITER ;

/* Procedure structure for procedure `delBrByBillNo` */

/*!50003 DROP PROCEDURE IF EXISTS  `delBrByBillNo` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `delBrByBillNo`(billNo int)
BEGIN
    DELETE FROM xly_bill  WHERE BILL_NO=billNo;
    DELETE FROM xly_bill_record WHERE BILL_NO=billNo;
    
    END */$$
DELIMITER ;

/* Procedure structure for procedure `delBrByCtmId` */

/*!50003 DROP PROCEDURE IF EXISTS  `delBrByCtmId` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `delBrByCtmId`(ctmId int)
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;   
    declare V_BILL_NO int;  
    -- 已对数据有效性进行筛选
    DECLARE cur CURSOR FOR 
    SELECT b.BILL_NO
    FROM  xly_bill b
    WHERE b.CTM_ID=ctmId;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  
  OPEN cur;
    SET @a=0;
  -- 开始循环
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur INTO V_BILL_NO;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
    call delBrByBillNo(V_BILL_NO);
    
  END LOOP;
  CLOSE cur;  
    END */$$
DELIMITER ;

/* Procedure structure for procedure `IMPORT_MATERIAL` */

/*!50003 DROP PROCEDURE IF EXISTS  `IMPORT_MATERIAL` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `IMPORT_MATERIAL`()
BEGIN
    DECLARE V_LOCATION VARCHAR(30);
    DECLARE V_THIRD_MAT VARCHAR(30);
    DECLARE V_SUB_MAT VARCHAR(30);
     DECLARE V_MAT VARCHAR(30);
    DECLARE V_UNIT VARCHAR(30);
    DECLARE V_UNIT_PRICE decimal default  0;
    DECLARE V_TOTAL_STOCK INT DEFAULT 0;
    DECLARE V_THIRD_MAT_ID INT DEFAULT 0;
    DECLARE V_SUB_MAT_ID INT DEFAULT 0;
    DECLARE V_MAT_ID INT DEFAULT 0;
    DECLARE V_STOCK INT DEFAULT 0;
    DECLARE done BOOLEAN DEFAULT FALSE;     
    DECLARE cur CURSOR FOR 
    SELECT LOCATION,SUB_MAT,THIRD_MAT,UNIT,STOCK,UNIT_PRICE,TOTAL_STOCK FROM `import_materials`;
      DECLARE cur2 CURSOR FOR 
    SELECT LOCATION,SUB_MAT,THIRD_MAT,UNIT,STOCK,UNIT_PRICE,TOTAL_STOCK FROM `import_materials`;
     DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    -- 去掉 ‘新厂’字符
   -- update `import_materials` set SUB_MAT=replace(SUB_MAT,'新厂','');
    truncate mat_third_mat;
    OPEN cur;
    SET @a=0;
  -- 开始循环
  read_loop: LOOP
    -- 先插入三级种类 单位 单价 名称相同才插入，同时从二级分类表中获取 一级id和二级id
    FETCH cur INTO V_LOCATION,V_SUB_MAT,V_THIRD_MAT,V_UNIT,V_STOCK,V_UNIT_PRICE,V_TOTAL_STOCK;
	IF done THEN
      LEAVE read_loop;
    END IF;   
    if((select count(1) from `mat_third_mat` tm where tm.THIRD_MAT_NAME=V_THIRD_MAT and tm.UNIT=V_UNIT and tm.UNIT_PRICE=V_UNIT_PRICE)=0)then 
    select SUB_MAT_ID,MAT_ID into V_SUB_MAT_ID,V_MAT_ID  from mat_sub_mat where SUB_MAT_NAME=V_SUB_MAT;
    insert into mat_third_mat(THIRD_MAT_NAME,UNIT,UNIT_PRICE,SUB_MAT_ID,MAT_ID) 
    values(V_THIRD_MAT,V_UNIT,V_UNIT_PRICE,ifnull(V_SUB_MAT_ID,0),ifnull(V_MAT_ID,0));
    end if;
    -- 声明结束的时候
    set V_SUB_MAT_ID=0,V_MAT_ID=0;
  END LOOP;
  CLOSE cur;  
  
     OPEN cur2;
    SET done=false;
  -- 开始循环
  read_loop2: LOOP
    -- 还有 一个V_TOATAL_STOCK没有用
    FETCH cur2   INTO V_LOCATION,V_SUB_MAT,V_THIRD_MAT,V_UNIT,V_STOCK,V_UNIT_PRICE,V_TOTAL_STOCK;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop2;
    END IF;
    -- 这里必定有对应的id
     SET @a=@a+1;
    SELECT tm.THIRD_MAT_ID,tm.SUB_MAT_ID,tm.MAT_ID into V_THIRD_MAT_ID,V_SUB_MAT_ID,V_MAT_ID
     FROM `mat_third_mat` tm WHERE tm.THIRD_MAT_NAME=V_THIRD_MAT AND tm.UNIT=V_UNIT AND tm.UNIT_PRICE=V_UNIT_PRICE;
     
    INSERT INTO `mat_stock`(MAT_ID,SUB_MAT_ID,THIRD_MAT_ID,STOCK,INIT_STOCK,LOCATION) 
    VALUES(V_MAT_ID,V_SUB_MAT_ID,V_THIRD_MAT_ID,V_STOCK,V_STOCK,V_LOCATION);
  END LOOP;
  CLOSE cur2;  
    END */$$
DELIMITER ;

/* Procedure structure for procedure `lastMonthCtmBal` */

/*!50003 DROP PROCEDURE IF EXISTS  `lastMonthCtmBal` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `lastMonthCtmBal`()
BEGIN
    DECLARE lastMonth VARCHAR(7);
    DECLARE V_MONEY DOUBLE DEFAULT 0;
    DECLARE V_CTMID INT DEFAULT 0;
    
    DECLARE done BOOLEAN DEFAULT FALSE;
     -- 因为实在1号的凌晨执行 所以凌晨时的数据还是当做是上一个月的余额
    DECLARE cur CURSOR FOR 
    SELECT ctm.`CTM_ID`,(SELECT dcoM(ctm.`CTM_ID`)) MONEY FROM xly_customer ctm;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
    SET @a=0;
  -- 开始循环
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur INTO V_CTMID,V_MONEY;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
    -- 这里 取取上前月份 表示月初余额 即为上月月底余额
    INSERT INTO xly_ctm_bal (CTM_ID,BALANCE,END_MONTH)VALUES (V_CTMID,V_MONEY,LEFT(Date_sub(NOW(),INTERVAL 1 month),7));
  END LOOP;
  CLOSE cur;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `recoveryFrezee` */

/*!50003 DROP PROCEDURE IF EXISTS  `recoveryFrezee` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `recoveryFrezee`(v_modifier VARCHAR(20),freezeId INT ,v_opt_type VARCHAR(10),OUT p_out INT)
BEGIN
-- 用于恢复冻结记录接口
	DECLARE updateResult INT DEFAULT 1 ;
	DECLARE v_stockId INT DEFAULT 0 ;
	DECLARE v_amount INT DEFAULT 0 ;
	-- 这里加层保险 只有状态为0 的才可以改成1
	DECLARE cur CURSOR FOR 
	SELECT wf.`COUNT`,wf.`STOCK_ID` FROM xly_wh_freeze wf WHERE wf.`FREEZE_ID`=freezeId AND wf.`STATE`=0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND SET p_out=0; 
	SET p_out=1;
	OPEN cur;
	-- 提取游标里的数据，这里只有一个，多个的话也一样；
	FETCH cur INTO v_amount,v_stockId;
	-- z注意这里都是取反的
	CALL updateStock(-v_amount,v_stockId,updateResult);
	IF updateResult>0 THEN 
	UPDATE `xly_wh_freeze` SET STATE = 1,MODIFY_DATE=NOW(),FINAL_MODIFIER=v_modifier,OPT_TYPE=v_opt_type WHERE FREEZE_ID=freezeId;
	ELSE SET p_out=0;
	END IF;
  CLOSE cur;  
    END */$$
DELIMITER ;

/* Procedure structure for procedure `resetAllXly` */

/*!50003 DROP PROCEDURE IF EXISTS  `resetAllXly` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `resetAllXly`(V_NEED int)
BEGIN
    -- 入账记录
    TRUNCATE `xly_bal_record`;
    -- 开票记录
    TRUNCATE `xly_bill`;
    -- 开票子记录
    TRUNCATE `xly_bill_record`;
    -- 产品生产班次
    TRUNCATE `xly_classes`;
    -- 客户入账记录
    TRUNCATE `xly_ctm_bal`;
    -- 客户采购记录
    TRUNCATE `xly_ctm_buy`;
    -- 客户类型（准备废弃）
    TRUNCATE `xly_ctm_type`;
    -- 客户表
    TRUNCATE `xly_customer`;
    -- 失效开票记录
    TRUNCATE `xly_drop_bill`;
    -- 产品 品牌表
    TRUNCATE `xly_pdt_bra`;
    -- 产品 等级表
    TRUNCATE `xly_pdt_gd`;
    -- 产品 规格表
    TRUNCATE `xly_pdt_spec`;
    -- 库存 表 
    TRUNCATE `xly_pdt_stock`;
    -- 产品 种类表
    TRUNCATE `xly_pdt_typ`;
    -- 产品 种类--品牌表
    TRUNCATE `xly_pdt_typ_bra`;
    -- 产品 基价表
    TRUNCATE `xly_pdt_typ_gd_bm`;
    -- 产品 表
    TRUNCATE `xly_product`;
    -- 销售 花型--等级统计表
    TRUNCATE `xly_sale_pattern`;
    -- 销售 种类统计表
    TRUNCATE `xly_sp_pdt_type`;
    -- 库存 冻结表
    TRUNCATE `xly_wh_freeze`;
    -- 库存 入库记录表
    TRUNCATE `xly_wh_record`;
    -- 库存 入库操作类型表
    TRUNCATE `xly_wh_type`;
    -- 年月表
    TRUNCATE `xly_year_month`;
    
    -- 清除完结 重新插入数据
    /**
        种类
1--全抛釉 3
2--金刚石 2
2--超白坯 2
品牌
1--曼宜森
2--布达米亚
3--新圣锐
4--牧梵
等级
1--优级
2--优B
3--一级
4--合格
5--次品
规格
1--800*800(mm)
    **/
    -- 产品 种类
    insert into `xly_pdt_typ` (TYPE_NAME,QTY)values('全抛釉',3); 
    INSERT INTO `xly_pdt_typ` (TYPE_NAME,QTY)VALUES('金刚石',2); 
    INSERT INTO `xly_pdt_typ` (TYPE_NAME,QTY)VALUES('超白坯',2); 
    -- 产品 品牌
    INSERT INTO `xly_pdt_bra` (BRAND_NAME)VALUES('曼宜森'); 
    INSERT INTO `xly_pdt_bra` (BRAND_NAME)VALUES('布达米亚'); 
    INSERT INTO `xly_pdt_bra` (BRAND_NAME)VALUES('新圣悦'); 
    INSERT INTO `xly_pdt_bra` (BRAND_NAME)VALUES('牧梵'); 
    -- 规格
    INSERT INTO `xly_pdt_spec` (SPEC_NAME)VALUES('800*800'); 
    -- 产品 等级
    INSERT INTO `xly_pdt_gd` (GRADES_NAME)VALUES('优级');    
    INSERT INTO `xly_pdt_gd` (GRADES_NAME)VALUES('优B'); 
    INSERT INTO `xly_pdt_gd` (GRADES_NAME)VALUES('一级'); 
    INSERT INTO `xly_pdt_gd` (GRADES_NAME)VALUES('合格'); 
    INSERT INTO `xly_pdt_gd` (GRADES_NAME)VALUES('次品_打包'); 
    INSERT INTO `xly_pdt_gd` (GRADES_NAME)VALUES('次品_未打包'); 
    -- 产品 种类--品牌
    INSERT INTO `xly_pdt_typ_bra` (TYPE_ID,BRAND_ID)VALUES(1,1); 
    INSERT INTO `xly_pdt_typ_bra` (TYPE_ID,BRAND_ID)VALUES(1,2); 
    INSERT INTO `xly_pdt_typ_bra` (TYPE_ID,BRAND_ID)VALUES(1,3); 
    INSERT INTO `xly_pdt_typ_bra` (TYPE_ID,BRAND_ID)VALUES(2,1); 
    INSERT INTO `xly_pdt_typ_bra` (TYPE_ID,BRAND_ID)VALUES(2,2); 
    INSERT INTO `xly_pdt_typ_bra` (TYPE_ID,BRAND_ID)VALUES(2,3); 
    INSERT INTO `xly_pdt_typ_bra` (TYPE_ID,BRAND_ID)VALUES(3,4); 
    -- 产品基价
    INSERT INTO `xly_pdt_typ_gd_bm` (TYPE_ID,GRADES_ID,BENCH_MARK)VALUES(1,1,21);
    INSERT INTO `xly_pdt_typ_gd_bm` (TYPE_ID,GRADES_ID,BENCH_MARK)VALUES(1,2,19); 
    INSERT INTO `xly_pdt_typ_gd_bm` (TYPE_ID,GRADES_ID,BENCH_MARK)VALUES(1,3,16); 
    INSERT INTO `xly_pdt_typ_gd_bm` (TYPE_ID,GRADES_ID,BENCH_MARK)VALUES(1,4,14); 
    INSERT INTO `xly_pdt_typ_gd_bm` (TYPE_ID,GRADES_ID,BENCH_MARK)VALUES(1,5,8); 
    INSERT INTO `xly_pdt_typ_gd_bm` (TYPE_ID,GRADES_ID,BENCH_MARK)VALUES(1,6,8); 
    INSERT INTO `xly_pdt_typ_gd_bm` (TYPE_ID,GRADES_ID,BENCH_MARK)VALUES(2,1,24);
    INSERT INTO `xly_pdt_typ_gd_bm` (TYPE_ID,GRADES_ID,BENCH_MARK)VALUES(2,2,20); 
    INSERT INTO `xly_pdt_typ_gd_bm` (TYPE_ID,GRADES_ID,BENCH_MARK)VALUES(2,3,19); 
    INSERT INTO `xly_pdt_typ_gd_bm` (TYPE_ID,GRADES_ID,BENCH_MARK)VALUES(2,4,14);
    INSERT INTO `xly_pdt_typ_gd_bm` (TYPE_ID,GRADES_ID,BENCH_MARK)VALUES(2,5,8); 
    INSERT INTO `xly_pdt_typ_gd_bm` (TYPE_ID,GRADES_ID,BENCH_MARK)VALUES(2,6,8); 
    
    INSERT INTO `xly_pdt_typ_gd_bm` (TYPE_ID,GRADES_ID,BENCH_MARK)VALUES(3,1,30);
    INSERT INTO `xly_pdt_typ_gd_bm` (TYPE_ID,GRADES_ID,BENCH_MARK)VALUES(3,3,24); 
    INSERT INTO `xly_pdt_typ_gd_bm` (TYPE_ID,GRADES_ID,BENCH_MARK)VALUES(3,4,18);
    INSERT INTO `xly_pdt_typ_gd_bm` (TYPE_ID,GRADES_ID,BENCH_MARK)VALUES(3,5,8); 
    INSERT INTO `xly_pdt_typ_gd_bm` (TYPE_ID,GRADES_ID,BENCH_MARK)VALUES(3,6,8); 
     
    -- 产品 批次
    INSERT INTO `xly_classes` (CLASSES_NAME)VALUES('一线一班'); 
    INSERT INTO `xly_classes` (CLASSES_NAME)VALUES('一线二班'); 
    INSERT INTO `xly_classes` (CLASSES_NAME)VALUES('一线三班'); 
    INSERT INTO `xly_classes` (CLASSES_NAME)VALUES('导表（无）'); 
    
    -- 入库 操作类型
    INSERT INTO `xly_wh_type` (TYPE_NAME)VALUES('正常'); 
    INSERT INTO `xly_wh_type` (TYPE_NAME)VALUES('增加库存'); 
    INSERT INTO `xly_wh_type` (TYPE_NAME)VALUES('减少库存'); 
    INSERT INTO `xly_wh_type` (TYPE_NAME)VALUES('破损处理'); 
    INSERT INTO `xly_wh_type` (TYPE_NAME)VALUES('导表入库'); 
    
    -- 创建月份 用于折线图 条形图
    call creatMonth();
    
    
    
    
    
    
    
    
    
    
    
    
    END */$$
DELIMITER ;

/* Procedure structure for procedure `setMoney` */

/*!50003 DROP PROCEDURE IF EXISTS  `setMoney` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `setMoney`(IN ctmId INT,IN money double)
BEGIN
	 update xly_customer set  money=encode(money,'xly')  where CTM_ID=ctmId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `setSaleMgrCtmCount` */

/*!50003 DROP PROCEDURE IF EXISTS  `setSaleMgrCtmCount` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `setSaleMgrCtmCount`(IN V_MONTH VARCHAR(7))
BEGIN
    
    DECLARE V_SALE_MGR_ID INT DEFAULT 0;
	
    DECLARE V_COUNT INT DEFAULT 0;
    DECLARE done BOOLEAN DEFAULT FALSE;     
    DECLARE cur CURSOR FOR 
    SELECT  vm.salesMgrId FROM v_mgr vm;
    OPEN cur;
    SET @a=0;
  -- 开始循环
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur INTO V_SALE_MGR_ID;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
    SET @a=@a+1;
    SELECT COUNT(1) into V_COUNT FROM (SELECT DISTINCT b.ctmId FROM v_simple_bill  b WHERE LEFT(b.`billTime`,7)=V_MONTH AND b.salesMgrId=V_SALE_MGR_ID) a;
    -- 销售经理Id和月份确定唯一行
    IF V_COUNT > 0 THEN
    update xly_mgr_sale set CTM_COUNT=V_COUNT where SALE_MGR_ID=V_SALE_MGR_ID and END_MONTH=V_MONTH;
    END IF;
	
  END LOOP;
  CLOSE cur;  
	SELECT @a;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `setStock` */

/*!50003 DROP PROCEDURE IF EXISTS  `setStock` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `setStock`(IN stockId INT,IN number int)
BEGIN
	 UPDATE xly_pdt_stock SET stock = stock + number WHERE ID = stockId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sortCtmBuy` */

/*!50003 DROP PROCEDURE IF EXISTS  `sortCtmBuy` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sortCtmBuy`(IN V_MONTH VARCHAR(7))
BEGIN
    DECLARE V_SALE_MGR_ID INT DEFAULT 0;
    DECLARE V_CTM_ID INT DEFAULT 0;
    DECLARE V_CTM_NAME VARCHAR(10);
    DECLARE V_SALE_MGR_NAME VARCHAR(10);
	
    DECLARE V_BRAND_ID INT DEFAULT 0;
    DECLARE V_TYPE_ID INT DEFAULT 0;
    DECLARE V_AMOUNT DOUBLE DEFAULT 0;
     
    DECLARE V_RECORD_COUNT INT DEFAULT 0;
    DECLARE done BOOLEAN DEFAULT FALSE;     
    -- 已对数据有效性进行筛选 注意排除库房 经理的数据
    DECLARE cur CURSOR FOR 
    SELECT vbr.ctmId,vbr.ctmName,vbr.`brandId`,vbr.`typeId`,vbr.`salesMgrId`,salesMgrName,vbr.`subTotal`
    FROM  v_buy_record vbr 
    WHERE LEFT(vbr.`billTime`,7)=V_MONTH AND vbr.salesMgrId!=64;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  
  OPEN cur;
  -- 惯例 先清除旧数据 依据：年月份
  DELETE FROM xly_ctm_buy WHERE END_MONTH=V_MONTH;
  
    SET @a=0,@b=0;
  -- 开始循环 
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur INTO V_CTM_ID,V_CTM_NAME,V_BRAND_ID,V_TYPE_ID,V_SALE_MGR_ID,V_SALE_MGR_NAME,V_AMOUNT;
    SET V_RECORD_COUNT=0;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
    -- 注意 ctmID、月份、mgrID确定唯一行
	
    -- 这里做你想做的循环的事件
	IF sortCtmBuyInsertCheck(V_CTM_ID,V_SALE_MGR_ID,V_MONTH)<1 THEN
	INSERT INTO xly_ctm_buy(SALE_MGR_ID,SALE_MGR_NAME,CTM_ID,CTM_NAME,CREATE_DATE,END_MONTH) 
	VALUES(V_SALE_MGR_ID,V_SALE_MGR_NAME,V_CTM_ID,V_CTM_NAME,NOW(),V_MONTH);
	SET @b=@b+1;
	END IF;
	-- 11是曼宜森--全抛釉
	IF V_BRAND_ID=1 AND V_TYPE_ID=1 THEN
	UPDATE xly_ctm_buy SET MYS_Q=MYS_Q+V_AMOUNT WHERE  CTM_ID=V_CTM_ID AND END_MONTH=V_MONTH AND SALE_MGR_ID=V_SALE_MGR_ID;
	-- 12是曼宜森--金刚石
	ELSEIF V_BRAND_ID=1 AND V_TYPE_ID=2 THEN
	UPDATE xly_ctm_buy SET MYS_J=MYS_J+V_AMOUNT WHERE  CTM_ID=V_CTM_ID  AND END_MONTH=V_MONTH AND SALE_MGR_ID=V_SALE_MGR_ID;
	-- 13是曼宜森--超白坯（新增）
	ELSEIF V_BRAND_ID=1 AND V_TYPE_ID=3 THEN
	UPDATE xly_ctm_buy SET MYS_C=MYS_C+V_AMOUNT WHERE  CTM_ID=V_CTM_ID  AND END_MONTH=V_MONTH AND SALE_MGR_ID=V_SALE_MGR_ID;
	-- 14是曼宜森--大理石（新增）
	ELSEIF V_BRAND_ID=1 AND V_TYPE_ID=4 THEN
	UPDATE xly_ctm_buy SET MYS_D=MYS_D+V_AMOUNT WHERE  CTM_ID=V_CTM_ID  AND END_MONTH=V_MONTH AND SALE_MGR_ID=V_SALE_MGR_ID;
	-- 21是布达米亚--全抛釉
	ELSEIF V_BRAND_ID=2 AND V_TYPE_ID=1 THEN
	UPDATE xly_ctm_buy SET BDMY_Q=BDMY_Q+V_AMOUNT WHERE  CTM_ID=V_CTM_ID  AND END_MONTH=V_MONTH AND SALE_MGR_ID=V_SALE_MGR_ID;
	-- 22是布达米亚--金刚石
	ELSEIF V_BRAND_ID=2 AND V_TYPE_ID=2 THEN
	UPDATE xly_ctm_buy SET BDMY_J=BDMY_J+V_AMOUNT WHERE  CTM_ID=V_CTM_ID AND END_MONTH=V_MONTH AND SALE_MGR_ID=V_SALE_MGR_ID;
	-- 31是新圣悦--全抛釉
	ELSEIF V_BRAND_ID=3 AND V_TYPE_ID=1 THEN
	UPDATE xly_ctm_buy SET XSY_Q=XSY_Q+V_AMOUNT WHERE  CTM_ID=V_CTM_ID AND END_MONTH=V_MONTH AND SALE_MGR_ID=V_SALE_MGR_ID;
	-- 32是新圣悦--金刚石
	ELSEIF V_BRAND_ID=3 AND V_TYPE_ID=2 THEN
	UPDATE xly_ctm_buy SET XSY_J=XSY_J+V_AMOUNT WHERE  CTM_ID=V_CTM_ID AND END_MONTH=V_MONTH AND SALE_MGR_ID=V_SALE_MGR_ID;
	-- 43是牧梵--超白坯
	ELSEIF V_BRAND_ID=4 AND V_TYPE_ID=3 THEN
	UPDATE xly_ctm_buy SET MF_C=MF_C+V_AMOUNT WHERE  CTM_ID=V_CTM_ID AND END_MONTH=V_MONTH AND SALE_MGR_ID=V_SALE_MGR_ID;
	END IF;
	SET @a=@a+1;
  END LOOP;
  CLOSE cur;  
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sortSalesAndOutput` */

/*!50003 DROP PROCEDURE IF EXISTS  `sortSalesAndOutput` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sortSalesAndOutput`(
IN V_MONTH VARCHAR(7)
)
BEGIN
    DECLARE V_GRADES_A INT DEFAULT 0;
    DECLARE V_GRADES_B INT DEFAULT 0;
    DECLARE V_GRADES_C INT DEFAULT 0; 
    DECLARE V_GRADES_D INT DEFAULT 0;
    DECLARE V_GRADES_E INT DEFAULT 0; 
    DECLARE V_GRADES_F INT DEFAULT 0;     
    DECLARE V_TYPE_ID INT DEFAULT 0;
     DECLARE V_QTY INT DEFAULT 0;   
     
    DECLARE V_MONTH_P DOUBLE DEFAULT 0;  
     DECLARE V_MONTH_S DOUBLE DEFAULT 0;  
    DECLARE V_TOTAL_AREA DOUBLE DEFAULT 0;  
    DECLARE V_TOTAL_PACK INT DEFAULT 0;    
     DECLARE done BOOLEAN DEFAULT FALSE;
       -- 产量 注意 都只取正常入库的
         -- 总面积 单位平方米 砖统一是800mm*800mm 即0.64m2 另外入库是按箱 需要换成片计算总面积 除了全抛釉3片 其余2片
     DECLARE cur_output CURSOR FOR 
     SELECT vw.TYPE_ID,vw.QTY,
	SUM(CASE vw.`GRADES_ID` WHEN 1 THEN vw.`STOCK`  END ) gradesA,
	SUM(CASE vw.`GRADES_ID` WHEN 2 THEN vw.`STOCK`  END ) gradesB,
	SUM(CASE vw.`GRADES_ID` WHEN 3 THEN vw.`STOCK`  END ) gradesC,
	SUM(CASE vw.`GRADES_ID` WHEN 4 THEN vw.`STOCK`  END ) gradesD,
	SUM(CASE vw.`GRADES_ID` WHEN 5 THEN vw.`STOCK`  END ) gradesE,
	SUM(CASE vw.`GRADES_ID` WHEN 6 THEN vw.`STOCK`  END ) gradesF,
	SUM(vw.`STOCK`) totalPack,
	SUM(vw.`STOCK`)*0.64*vw.`QTY` totalArea
	 FROM v_warerecord vw 
	WHERE LEFT(vw.PRODUCED_DATE,7)=V_MONTH AND vw.`OPT_ID`=1
	GROUP BY vw.`TYPE_ID` ORDER BY vw.TYPE_ID;
	-- 销量 不算样品
	DECLARE cur_sales CURSOR FOR 
	SELECT bsp.typeId,bsp.qty,
	SUM(CASE bsp.`gradesId` WHEN 1 THEN bsp.count  END ) gradesA,
	SUM(CASE bsp.`gradesId` WHEN 2 THEN bsp.count  END ) gradesB,
	SUM(CASE bsp.`gradesId` WHEN 3 THEN bsp.count  END ) gradesC,
	SUM(CASE bsp.`gradesId` WHEN 4 THEN bsp.count  END ) gradesD,
	SUM(CASE bsp.`gradesId` WHEN 5 THEN bsp.count  END ) gradesE,
	SUM(CASE bsp.`gradesId` WHEN 6 THEN bsp.count  END ) gradesF,
	SUM(bsp.`count`) totalPack,
	SUM(bsp.`count`)*0.64*bsp.`qty` totalArea
	FROM v_billrecord_sp bsp WHERE LEFT(bsp.billTime,7)=V_MONTH AND bsp.billType!='样品'
	GROUP BY bsp.typeId
	ORDER BY bsp.typeId; 
   
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur_output;
    -- 必须是先执行生产统计 再销售统计 先删除同月份的数据
    DELETE FROM `xly_sp_pdt_type` WHERE END_MONTH=V_MONTH;
  -- 开始循环
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur_output INTO V_TYPE_ID,V_QTY,V_GRADES_A,V_GRADES_B,V_GRADES_C,V_GRADES_D,V_GRADES_E,V_GRADES_F,V_TOTAL_PACK,V_TOTAL_AREA;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
    INSERT INTO xly_sp_pdt_type 
    (PRODUCT_TYPE,END_MONTH,GRADES_A,GRADES_B,GRADES_C,GRADES_D,GRADES_E,GRADES_F,TOTAL_AREA,TOTAL_PACK,SP_TYPE,CREATE_DATE,QTY)
    VALUES(V_TYPE_ID,V_MONTH,IFNULL(V_GRADES_A,0),IFNULL(V_GRADES_B,0),IFNULL(V_GRADES_C,0),IFNULL(V_GRADES_D,0),
    IFNULL(V_GRADES_E,0),IFNULL(V_GRADES_F,0),V_TOTAL_AREA,V_TOTAL_PACK,'生产',NOW(),V_QTY);
END LOOP;
  CLOSE cur_output;
     
SET done=FALSE,V_GRADES_A=0,V_GRADES_B=0,V_GRADES_C=0,V_GRADES_D=0,V_GRADES_E=0,V_GRADES_F=0,V_TOTAL_PACK=0,V_TOTAL_AREA=0;
    OPEN cur_sales;
  -- 开始循环
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur_sales INTO V_TYPE_ID,V_QTY,V_GRADES_A,V_GRADES_B,V_GRADES_C,V_GRADES_D,V_GRADES_E,V_GRADES_F,V_TOTAL_PACK,V_TOTAL_AREA;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
    INSERT INTO xly_sp_pdt_type 
    (PRODUCT_TYPE,END_MONTH,GRADES_A,GRADES_B,GRADES_C,GRADES_D,GRADES_E,GRADES_F,TOTAL_AREA,TOTAL_PACK,SP_TYPE,CREATE_DATE,QTY)
    VALUES(V_TYPE_ID,V_MONTH,IFNULL(V_GRADES_A,0),IFNULL(V_GRADES_B,0),IFNULL(V_GRADES_C,0),IFNULL(V_GRADES_D,0),
    IFNULL(V_GRADES_E,0),IFNULL(V_GRADES_F,0),V_TOTAL_AREA,V_TOTAL_PACK,'销售',NOW(),V_QTY);
END LOOP;
  CLOSE cur_sales;
     -- 统计3个种类的本月所有销量
	SELECT SUM(spt.TOTAL_AREA) INTO  V_MONTH_S FROM xly_sp_pdt_type spt WHERE END_MONTH=V_MONTH AND SP_TYPE='销售' ;
	UPDATE xly_sp_pdt_type SET MONTH_TOTAL_S=V_MONTH_S WHERE END_MONTH=V_MONTH;
	 -- 统计3个种类的本月所有产量
	SELECT SUM(spt.TOTAL_AREA) INTO  V_MONTH_P FROM xly_sp_pdt_type spt WHERE END_MONTH=V_MONTH AND SP_TYPE='生产';
	UPDATE xly_sp_pdt_type SET MONTH_TOTAL_P=V_MONTH_P WHERE END_MONTH=V_MONTH ; 
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SStatisticTypeGrades` */

/*!50003 DROP PROCEDURE IF EXISTS  `SStatisticTypeGrades` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `SStatisticTypeGrades`(v_month VARCHAR(20))
BEGIN
-- 用于统计种类 等级的库存
DECLARE typeId INT ;
DECLARE gradesId INT ;
DECLARE recordId INT ;
DECLARE typeCount INT default 0;
select count(*) into typeCount from `xly_pdt_typ`;
  SET typeId = 1 ;  
        WHILE typeId <= typeCount DO  
        SET gradesId = 1; 
             -- 插入固定条数的记录 6 6 4（超白坯）以等级和种类 月份作为唯一标识 YM--月末库存直取当前库存量 单位 箱
             WHILE gradesId <= 6 DO  
     -- 判断 如果存在 则更新 销售量，产量，破损量，样品量，和调账  月份 等级 种类决定唯一行
    SELECT ss.`ID` INTO recordId FROM xly_statistics_stock  ss WHERE ss.`STATISTIC_MONTH`=v_month AND ss.`GRADES_ID`=gradesId AND ss.`TYPE_ID`=typeId;
    IF recordId IS NULL OR recordId<1 THEN 
    INSERT INTO `xly_statistics_stock`
    (TYPE_ID,GRADES_ID,YM_STOCK,SALES_VOLUME,OUT_PUT,DAMAGED,SAMPLE,ADJUSTMENT,STATISTIC_MONTH,CREATE_DATE)VALUES
    (typeId,gradesId,getCurrentTotalStock(typeId,gradesId),
    getSaleVolume(typeId,gradesId,v_month),
    getOutPut(typeId,gradesId,v_month),
    `getStockDamaged`(typeId,gradesId,v_month),
    getBillSample(typeId,gradesId,v_month),getAdjustment(typeId,gradesId,v_month),v_month,NOW());
    ELSE 
    UPDATE xly_statistics_stock  
    SET SALES_VOLUME=getSaleVolume(typeId,gradesId,v_month),
    OUT_PUT=getOutPut(typeId,gradesId,v_month),
    DAMAGED=`getStockDamaged`(typeId,gradesId,v_month),
    SAMPLE=getBillSample(typeId,gradesId,v_month),ADJUSTMENT=getAdjustment(typeId,gradesId,v_month) WHERE ID=recordId;
    END IF;
    -- 重置
    SET recordId=0;
    SET gradesId = gradesId + 1;  
	END WHILE; 
            SET typeId = typeId + 1;  
        END WHILE;  
   
    
     
    END */$$
DELIMITER ;

/* Procedure structure for procedure `unFreezeStock` */

/*!50003 DROP PROCEDURE IF EXISTS  `unFreezeStock` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `unFreezeStock`(OUT p_out VARCHAR (100))
BEGIN
DECLARE F_ID INT (11) ;
DECLARE STOCK_ID INT (11) ;
DECLARE STOCK_COUNT INT (11) ;
 DECLARE done BOOLEAN DEFAULT FALSE;    
DECLARE CUR_RECORD CURSOR FOR 
SELECT whf.FREEZE_ID,whf.STOCK_ID ,whf.COUNT FROM  xly_wh_freeze whf 
  WHERE STR_TO_DATE(whf.END_DATE,'%Y-%m-%d')<NOW() AND whf.STATE=1;
  DECLARE EXIT HANDLER FOR NOT FOUND CLOSE CUR_RECORD;  
  SET p_out="";
  OPEN CUR_RECORD;
   -- 开始循环
  read_loop: LOOP
  FETCH CUR_RECORD INTO F_ID,STOCK_ID,STOCK_COUNT;  
/**	
 select F_ID,STOCK_ID,STOCK_COUNT;
 **/
  IF done THEN
      LEAVE read_loop;
    END IF;
UPDATE `xly_wh_freeze` SET STATE = 0,MODIFY_DATE=NOW(),FINAL_MODIFIER='系统到期释放' WHERE FREEZE_ID=F_ID;
UPDATE xly_pdt_stock SET stock = stock+STOCK_COUNT,MODIFY_DATE = NOW() WHERE ID = STOCK_ID;
    END LOOP;
  CLOSE CUR_RECORD;  
  SET p_out=p_out+":"+F_ID;    
  CLOSE CUR_RECORD;  
  END */$$
DELIMITER ;

/* Procedure structure for procedure `updataMoney` */

/*!50003 DROP PROCEDURE IF EXISTS  `updataMoney` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `updataMoney`(v_ctmId INT,v_amount DOUBLE,OUT p_out INT)
BEGIN
DECLARE current_money DOUBLE DEFAULT 0;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND SET p_out=0; 
SET p_out=1;
SELECT  money INTO current_money FROM v_customer WHERE ctmId=v_ctmId;
	 UPDATE xly_customer SET  money=ENCODE(v_amount+current_money,'xly')  WHERE CTM_ID=v_ctmId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `updateCheckState` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateCheckState` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `updateCheckState`(subId int ,recordId int,state int, OUT p_out int)
BEGIN
-- state 是子记录的状态 0未审核1通过2驳回
 -- 0等待验收 1验收通过 2验收驳回 3等待填入价格 4等待审核 5通过 6驳回
DECLARE checkCount INT DEFAULT 0 ;
DECLARE passCount INT default 0 ;
DECLARE dealCount INT DEFAULT 0 ;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND SET p_out=0; 
  SET p_out=1;
  UPDATE `mat_stock_subrecord` SET CHECK_STATE=state WHERE  SUB_ID=subId;
SELECT sr.CHECK_COUNT INTO checkCount FROM mat_stock_record sr WHERE sr.RECORD_ID=recordId;
-- 统计已经处理的子记录 
SELECT COUNT(1) INTO dealCount FROM mat_stock_subrecord  WHERE  RECORD_ID=recordId AND  CHECK_STATE!=0;
-- 处理条数等于总数（子记录中的煤类型CHECK_STATE默认值为1通过）则处理完成
IF checkCount=dealCount THEN 
SELECT COUNT(1) INTO passCount FROM mat_stock_subrecord  WHERE  RECORD_ID=recordId AND  CHECK_STATE=1;
UPDATE mat_stock_record SET STATE=if(passCount=checkCount,1,2) WHERE RECORD_ID=recordId;
END IF;
 
  END */$$
DELIMITER ;

/* Procedure structure for procedure `updateMatStock` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateMatStock` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `updateMatStock`(number INT,stockId INT ,OUT p_out INT)
BEGIN 
	DECLARE v_currentStock INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND SET p_out=0; 
	
	SET p_out=1;
	SELECT STOCK INTO v_currentStock FROM `mat_stock`  WHERE STOCK_ID = stockId;
	IF number+v_currentStock<0 THEN 
	SET p_out=0;
	ELSE	
	UPDATE mat_stock SET STOCK = STOCK+number,MODIFY_DATE = NOW() WHERE STOCK_ID = stockId;
	END IF;
    
    END */$$
DELIMITER ;

/* Procedure structure for procedure `updateReviewState` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateReviewState` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `updateReviewState`(subId int ,recordId int,state int, OUT p_out int)
BEGIN
-- state 是子记录的状态 0未审核1通过2驳回
 -- 0等待验收 1验收通过 2验收驳回 3等待填入价格 4等待审核 5通过 6驳回
DECLARE checkCount INT DEFAULT 0 ;
DECLARE passCount INT default 0 ;
DECLARE dealCount INT DEFAULT 0 ;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND SET p_out=0; 
  SET p_out=1;
  UPDATE `mat_stock_subrecord` SET REVIEW_STATE=state WHERE  SUB_ID=subId;
-- 统计已经处理的子记录 
SELECT COUNT(1) INTO dealCount FROM mat_stock_subrecord  WHERE  RECORD_ID=recordId AND  REVIEW_STATE!=0;
-- 处理条数等于总数（子记录中的煤类型CHECK_STATE默认值为1通过）则处理完成
IF checkCount=dealCount THEN 
SELECT COUNT(1) INTO passCount FROM mat_stock_subrecord  WHERE  RECORD_ID=recordId AND  REVIEW_STATE=1;
UPDATE mat_stock_record SET STATE=if(passCount=checkCount,1,2) WHERE RECORD_ID=recordId;
END IF;
 
  END */$$
DELIMITER ;

/* Procedure structure for procedure `updateStock` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateStock` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `updateStock`(number INT,stockId INT ,OUT p_out INT)
BEGIN 
	DECLARE v_currentStock INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND SET p_out=0; 
	
	SET p_out=1;
	SELECT stock INTO v_currentStock FROM xly_pdt_stock  WHERE ID = stockId;
	IF number+v_currentStock<0 THEN 
	SET p_out=0;
	ELSE	
	UPDATE xly_pdt_stock SET stock = stock+number,MODIFY_DATE = NOW() WHERE ID = stockId;
	END IF;
    
    END */$$
DELIMITER ;

/* Procedure structure for procedure `updateSubRecordPrice` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateSubRecordPrice` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `updateSubRecordPrice`(subId int ,recordId int, OUT p_out int)
BEGIN
DECLARE subcount INT DEFAULT 0 ;
DECLARE havePriceCount INT default 0 ;
DECLARE totalPrice double default 0;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND SET p_out=0; 
  SET p_out=1;
  -- 判断 父记录进入审核状态依据：含价格的子记录数=父记录字段里的子记录数 （材料类型排除）
  -- 该查询必不为空
  SELECT sr.SUB_COUNT INTO subcount from mat_stock_record sr where sr.RECORD_ID=recordId;
  select count(1),sum(ss.SUBTOTAL) into havePriceCount, totalPrice from mat_stock_subrecord ss where ss.RECORD_ID=recordId and ss.PRICE>0;
  if subcount=subcount then 
  -- 0等待验收 1验收通过 2验收驳回 3等待填入价格 4等待审核 5通过 6驳回
  update mat_stock_record set STATE=4,TOTAL_PRICE=totalPrice where sr.RECORD_ID=recordId;
  end if;
  END */$$
DELIMITER ;

/*Table structure for table `v_a_checkimportstock` */

DROP TABLE IF EXISTS `v_a_checkimportstock`;

/*!50001 DROP VIEW IF EXISTS `v_a_checkimportstock` */;
/*!50001 DROP TABLE IF EXISTS `v_a_checkimportstock` */;

/*!50001 CREATE TABLE  `v_a_checkimportstock`(
 `id` int(10) ,
 `typeBrand` varchar(10) ,
 `category` varchar(20) ,
 `patternno` varchar(20) ,
 `grades` varchar(10) ,
 `color` varchar(10) ,
 `warehouse` varchar(10) ,
 `stock` varchar(10) ,
 `currentStock` int(10) ,
 `freezeStock` int(10) ,
 `todayBillStock` int(10) ,
 `wareStock` int(10) ,
 `stockId` int(10) ,
 `pId` int(10) ,
 `allBillStock` bigint(11) ,
 `D` double 
)*/;

/*Table structure for table `v_balrecord` */

DROP TABLE IF EXISTS `v_balrecord`;

/*!50001 DROP VIEW IF EXISTS `v_balrecord` */;
/*!50001 DROP TABLE IF EXISTS `v_balrecord` */;

/*!50001 CREATE TABLE  `v_balrecord`(
 `balId` int(10) ,
 `creater` varchar(10) ,
 `createTime` varchar(30) ,
 `optType` varchar(10) ,
 `collectionType` varchar(10) ,
 `balBefore` decimal(10,2) ,
 `balAfter` decimal(10,2) ,
 `ctmName` varchar(20) ,
 `ctmId` int(10) ,
 `salesMgrName` varchar(10) ,
 `amount` double ,
 `remark` varchar(100) ,
 `address` varchar(30) 
)*/;

/*Table structure for table `v_billrecord` */

DROP TABLE IF EXISTS `v_billrecord`;

/*!50001 DROP VIEW IF EXISTS `v_billrecord` */;
/*!50001 DROP TABLE IF EXISTS `v_billrecord` */;

/*!50001 CREATE TABLE  `v_billrecord`(
 `billNo` int(10) ,
 `billNoStr` varchar(7) ,
 `billTime` varchar(20) ,
 `billType` varchar(35) ,
 `carNo` varchar(50) ,
 `creater` varchar(50) ,
 `driverPhone` varchar(11) ,
 `freight` int(20) ,
 `remark` varchar(50) ,
 `bState` smallint(1) ,
 `balBefore` decimal(10,2) ,
 `balAfter` decimal(10,2) ,
 `salesMgrId` int(10) ,
 `count` int(10) ,
 `price` double ,
 `totalAmount` double ,
 `subTotal` double ,
 `benchmark` double ,
 `recordId` int(10) ,
 `ctmName` varchar(20) ,
 `ctmId` int(10) ,
 `address` varchar(30) ,
 `stockId` int(10) ,
 `warehouse` varchar(10) ,
 `stock` int(10) ,
 `id` int(11) ,
 `categort` varchar(10) ,
 `color` varchar(10) ,
 `patternNo` varchar(10) ,
 `brandName` varchar(10) ,
 `brandId` int(10) ,
 `gradesName` varchar(10) ,
 `specId` int(5) ,
 `specName` varchar(10) ,
 `typeName` varchar(10) ,
 `qty` int(2) ,
 `qtyCount` bigint(21) ,
 `gradesId` int(10) ,
 `typeId` int(10) ,
 `mgrName` varchar(10) 
)*/;

/*Table structure for table `v_billrecord_fake` */

DROP TABLE IF EXISTS `v_billrecord_fake`;

/*!50001 DROP VIEW IF EXISTS `v_billrecord_fake` */;
/*!50001 DROP TABLE IF EXISTS `v_billrecord_fake` */;

/*!50001 CREATE TABLE  `v_billrecord_fake`(
 `billNo` int(10) ,
 `billNoStr` varchar(7) ,
 `billTime` varchar(20) ,
 `billType` varchar(35) ,
 `carNo` varchar(10) ,
 `creater` varchar(10) ,
 `driverPhone` varchar(12) ,
 `freight` int(20) ,
 `remark` varchar(35) ,
 `bState` smallint(1) ,
 `count` int(10) ,
 `price` double ,
 `totalAmount` double ,
 `subTotal` double ,
 `recordId` int(10) ,
 `ctmName` varchar(20) ,
 `ctmId` int(10) ,
 `address` varchar(30) ,
 `salesMgrId` int(10) ,
 `stockId` int(10) ,
 `warehouse` varchar(10) ,
 `stock` int(10) ,
 `id` int(11) ,
 `categort` varchar(10) ,
 `color` varchar(10) ,
 `patternNo` varchar(10) ,
 `brandName` varchar(10) ,
 `brandId` int(10) ,
 `gradesName` varchar(10) ,
 `specId` int(5) ,
 `specName` varchar(10) ,
 `typeName` varchar(10) ,
 `qty` int(2) ,
 `qtyCount` bigint(21) ,
 `gradesId` int(10) ,
 `typeId` int(10) ,
 `mgrName` varchar(10) 
)*/;

/*Table structure for table `v_billrecord_simple` */

DROP TABLE IF EXISTS `v_billrecord_simple`;

/*!50001 DROP VIEW IF EXISTS `v_billrecord_simple` */;
/*!50001 DROP TABLE IF EXISTS `v_billrecord_simple` */;

/*!50001 CREATE TABLE  `v_billrecord_simple`(
 `billNo` int(10) ,
 `billTime` varchar(20) ,
 `billType` varchar(35) ,
 `bState` smallint(1) ,
 `balBefore` decimal(10,2) ,
 `balAfter` decimal(10,2) ,
 `count` int(10) ,
 `price` double ,
 `benchmark` double ,
 `salesMgrId` int(10) ,
 `totalAmount` double ,
 `subTotal` double ,
 `ctmName` varchar(20) ,
 `ctmId` int(10) ,
 `address` varchar(30) ,
 `brandName` varchar(10) ,
 `brandId` int(10) ,
 `gradesName` varchar(10) ,
 `typeName` varchar(10) ,
 `qty` int(2) ,
 `qtyCount` bigint(21) ,
 `gradesId` int(10) ,
 `typeId` int(10) ,
 `mgrName` varchar(10) 
)*/;

/*Table structure for table `v_billrecord_sp` */

DROP TABLE IF EXISTS `v_billrecord_sp`;

/*!50001 DROP VIEW IF EXISTS `v_billrecord_sp` */;
/*!50001 DROP TABLE IF EXISTS `v_billrecord_sp` */;

/*!50001 CREATE TABLE  `v_billrecord_sp`(
 `billNo` int(10) ,
 `billNoStr` varchar(7) ,
 `billTime` varchar(20) ,
 `billType` varchar(35) ,
 `carNo` varchar(50) ,
 `creater` varchar(50) ,
 `driverPhone` varchar(11) ,
 `freight` int(20) ,
 `remark` varchar(50) ,
 `bState` smallint(1) ,
 `count` int(10) ,
 `price` double ,
 `totalAmount` double ,
 `subTotal` double ,
 `recordId` int(10) ,
 `stockId` int(10) ,
 `warehouse` varchar(10) ,
 `stock` int(10) ,
 `id` int(11) ,
 `categort` varchar(10) ,
 `color` varchar(10) ,
 `patternNo` varchar(10) ,
 `brandName` varchar(10) ,
 `brandId` int(10) ,
 `gradesName` varchar(10) ,
 `specId` int(5) ,
 `specName` varchar(10) ,
 `typeName` varchar(10) ,
 `qty` int(2) ,
 `qtyCount` bigint(21) ,
 `gradesId` int(10) ,
 `typeId` int(10) 
)*/;

/*Table structure for table `v_billstock` */

DROP TABLE IF EXISTS `v_billstock`;

/*!50001 DROP VIEW IF EXISTS `v_billstock` */;
/*!50001 DROP TABLE IF EXISTS `v_billstock` */;

/*!50001 CREATE TABLE  `v_billstock`(
 `stockId` int(10) ,
 `billStock` decimal(32,0) 
)*/;

/*Table structure for table `v_buy_record` */

DROP TABLE IF EXISTS `v_buy_record`;

/*!50001 DROP VIEW IF EXISTS `v_buy_record` */;
/*!50001 DROP TABLE IF EXISTS `v_buy_record` */;

/*!50001 CREATE TABLE  `v_buy_record`(
 `billNo` int(10) ,
 `billTime` varchar(20) ,
 `billType` varchar(35) ,
 `freight` int(20) ,
 `remark` varchar(50) ,
 `bState` smallint(1) ,
 `count` int(10) ,
 `price` double ,
 `totalAmount` double ,
 `subTotal` double ,
 `recordId` int(10) ,
 `ctmName` varchar(20) ,
 `ctmId` int(10) ,
 `salesMgrId` int(10) ,
 `stockId` int(10) ,
 `warehouse` varchar(10) ,
 `stock` int(10) ,
 `brandName` varchar(10) ,
 `brandId` int(10) ,
 `gradesName` varchar(10) ,
 `typeName` varchar(10) ,
 `qty` int(2) ,
 `qtyCount` bigint(21) ,
 `gradesId` int(10) ,
 `typeId` int(10) ,
 `salesMgrName` varchar(10) 
)*/;

/*Table structure for table `v_customer` */

DROP TABLE IF EXISTS `v_customer`;

/*!50001 DROP VIEW IF EXISTS `v_customer` */;
/*!50001 DROP TABLE IF EXISTS `v_customer` */;

/*!50001 CREATE TABLE  `v_customer`(
 `ctmId` int(10) ,
 `ctmName` varchar(20) ,
 `typeId` smallint(6) ,
 `address` varchar(30) ,
 `shopName` varchar(30) ,
 `salesMgrId` int(10) ,
 `initMoney` double ,
 `ca` varchar(52) ,
 `money` text ,
 `avlMoney` double ,
 `grtMoney` int(11) ,
 `debt` int(11) ,
 `salesMgrName` varchar(10) 
)*/;

/*Table structure for table `v_customer_money` */

DROP TABLE IF EXISTS `v_customer_money`;

/*!50001 DROP VIEW IF EXISTS `v_customer_money` */;
/*!50001 DROP TABLE IF EXISTS `v_customer_money` */;

/*!50001 CREATE TABLE  `v_customer_money`(
 `ctmId` int(10) ,
 `ctmName` varchar(20) ,
 `initMoney` double ,
 `grtMoney` int(11) ,
 `debt` int(11) ,
 `money` text ,
 `totalCtmBal` double ,
 `totalConsumption` double 
)*/;

/*Table structure for table `v_drop_record` */

DROP TABLE IF EXISTS `v_drop_record`;

/*!50001 DROP VIEW IF EXISTS `v_drop_record` */;
/*!50001 DROP TABLE IF EXISTS `v_drop_record` */;

/*!50001 CREATE TABLE  `v_drop_record`(
 `BILL_NO` int(10) ,
 `dropCreater` varchar(20) ,
 `dropDate` varchar(20) ,
 `reason` varchar(255) ,
 `billNo` int(10) ,
 `billNoStr` varchar(7) ,
 `billTime` varchar(20) ,
 `billType` varchar(35) ,
 `carNo` varchar(50) ,
 `creater` varchar(50) ,
 `driverPhone` varchar(11) ,
 `freight` int(20) ,
 `remark` varchar(50) ,
 `bState` smallint(1) ,
 `count` int(10) ,
 `price` double ,
 `subTotal` double ,
 `recordId` int(10) ,
 `ctmName` varchar(20) ,
 `ctmId` int(10) ,
 `address` varchar(30) ,
 `salesMgrId` int(10) ,
 `stockId` int(10) ,
 `warehouse` varchar(10) ,
 `stock` int(10) ,
 `id` int(11) ,
 `categort` varchar(10) ,
 `color` varchar(10) ,
 `patternNo` varchar(10) ,
 `brandName` varchar(10) ,
 `brandId` int(10) ,
 `gradesName` varchar(10) ,
 `specId` int(5) ,
 `specName` varchar(10) ,
 `typeName` varchar(10) ,
 `qty` int(2) ,
 `gradesId` int(10) ,
 `typeId` int(10) ,
 `mgrName` varchar(10) 
)*/;

/*Table structure for table `v_freeze` */

DROP TABLE IF EXISTS `v_freeze`;

/*!50001 DROP VIEW IF EXISTS `v_freeze` */;
/*!50001 DROP TABLE IF EXISTS `v_freeze` */;

/*!50001 CREATE TABLE  `v_freeze`(
 `freezeId` int(10) ,
 `stockId` int(10) ,
 `warehouse` varchar(10) ,
 `ctmName` varchar(20) ,
 `address` varchar(30) ,
 `ctmId` int(10) ,
 `count` int(10) ,
 `createTime` varchar(35) ,
 `creater` varchar(35) ,
 `endDate` varchar(35) ,
 `remark` varchar(100) ,
 `state` smallint(1) ,
 `modifyDate` datetime ,
 `optType` varchar(5) ,
 `finalModifier` varchar(10) ,
 `brandName` varchar(10) ,
 `typeName` varchar(10) ,
 `categort` varchar(10) ,
 `color` varchar(10) ,
 `qty` int(2) ,
 `gradesName` varchar(10) ,
 `patternNo` varchar(10) ,
 `specName` varchar(10) 
)*/;

/*Table structure for table `v_inventory_record` */

DROP TABLE IF EXISTS `v_inventory_record`;

/*!50001 DROP VIEW IF EXISTS `v_inventory_record` */;
/*!50001 DROP TABLE IF EXISTS `v_inventory_record` */;

/*!50001 CREATE TABLE  `v_inventory_record`(
 `recorId` int(9) ,
 `pId` int(9) ,
 `stockId` int(9) ,
 `warehouse` varchar(20) ,
 `remark` varchar(50) ,
 `modification` int(9) ,
 `creater` varchar(20) ,
 `createDate` datetime ,
 `typeId` int(9) ,
 `brandId` int(9) ,
 `categort` varchar(10) ,
 `patternNo` varchar(10) ,
 `color` varchar(10) ,
 `gradesId` int(10) ,
 `specId` int(5) 
)*/;

/*Table structure for table `v_mat3` */

DROP TABLE IF EXISTS `v_mat3`;

/*!50001 DROP VIEW IF EXISTS `v_mat3` */;
/*!50001 DROP TABLE IF EXISTS `v_mat3` */;

/*!50001 CREATE TABLE  `v_mat3`(
 `matName` varchar(50) ,
 `mat2Name` varchar(20) ,
 `matId` int(9) ,
 `mat2Id` int(9) ,
 `mat3Id` int(9) ,
 `mat3Name` varchar(50) ,
 `hidden` tinyint(1) ,
 `unit` varchar(20) 
)*/;

/*Table structure for table `v_mgr` */

DROP TABLE IF EXISTS `v_mgr`;

/*!50001 DROP VIEW IF EXISTS `v_mgr` */;
/*!50001 DROP TABLE IF EXISTS `v_mgr` */;

/*!50001 CREATE TABLE  `v_mgr`(
 `positionId` varchar(60) ,
 `salesMgrId` int(10) ,
 `salesMgrName` varchar(10) 
)*/;

/*Table structure for table `v_parent_stock_record` */

DROP TABLE IF EXISTS `v_parent_stock_record`;

/*!50001 DROP VIEW IF EXISTS `v_parent_stock_record` */;
/*!50001 DROP TABLE IF EXISTS `v_parent_stock_record` */;

/*!50001 CREATE TABLE  `v_parent_stock_record`(
 `recordId` int(7) unsigned ,
 `supplierId` int(10) ,
 `createDate` datetime ,
 `isPring` tinyint(1) ,
 `state` int(1) ,
 `subcount` int(9) ,
 `checkCount` int(11) ,
 `valid` tinyint(1) ,
 `totalPrice` decimal(10,2) ,
 `supplierName` varchar(20) 
)*/;

/*Table structure for table `v_patternno_grade` */

DROP TABLE IF EXISTS `v_patternno_grade`;

/*!50001 DROP VIEW IF EXISTS `v_patternno_grade` */;
/*!50001 DROP TABLE IF EXISTS `v_patternno_grade` */;

/*!50001 CREATE TABLE  `v_patternno_grade`(
 `sum` decimal(32,0) ,
 `billTime` varchar(20) ,
 `typeId` int(10) ,
 `typeName` varchar(10) ,
 `brandId` int(10) ,
 `brandName` varchar(10) ,
 `patternNo` varchar(10) ,
 `gradesId` int(10) ,
 `gradesName` varchar(10) 
)*/;

/*Table structure for table `v_productall` */

DROP TABLE IF EXISTS `v_productall`;

/*!50001 DROP VIEW IF EXISTS `v_productall` */;
/*!50001 DROP TABLE IF EXISTS `v_productall` */;

/*!50001 CREATE TABLE  `v_productall`(
 `ID` int(11) ,
 `TYPE_NAME` varchar(10) ,
 `BRAND_NAME` varchar(10) ,
 `CATEGORT` varchar(10) ,
 `TYPE_BRAND_ID` int(10) ,
 `COLOR` varchar(10) ,
 `BENCHMARK` double ,
 `PATTERN_NO` varchar(10) ,
 `BRAND_ID` int(10) ,
 `GRADES_ID` int(10) ,
 `GRADES_NAME` varchar(10) ,
 `SPEC_NAME` varchar(10) ,
 `QTY` int(2) ,
 `TYPE_ID` int(10) ,
 `SPEC_ID` int(5) 
)*/;

/*Table structure for table `v_simple_bill` */

DROP TABLE IF EXISTS `v_simple_bill`;

/*!50001 DROP VIEW IF EXISTS `v_simple_bill` */;
/*!50001 DROP TABLE IF EXISTS `v_simple_bill` */;

/*!50001 CREATE TABLE  `v_simple_bill`(
 `billNo` int(10) ,
 `billNoStr` varchar(7) ,
 `billTime` varchar(20) ,
 `billType` varchar(35) ,
 `carNo` varchar(50) ,
 `creater` varchar(50) ,
 `driverPhone` varchar(11) ,
 `freight` int(20) ,
 `totalAmount` double ,
 `ctmId` int(10) ,
 `salesMgrId` int(10) ,
 `remark` varchar(50) 
)*/;

/*Table structure for table `v_simple_bill_fake` */

DROP TABLE IF EXISTS `v_simple_bill_fake`;

/*!50001 DROP VIEW IF EXISTS `v_simple_bill_fake` */;
/*!50001 DROP TABLE IF EXISTS `v_simple_bill_fake` */;

/*!50001 CREATE TABLE  `v_simple_bill_fake`(
 `billNo` int(10) ,
 `billNoStr` varchar(7) ,
 `billTime` varchar(20) ,
 `billType` varchar(35) ,
 `carNo` varchar(10) ,
 `creater` varchar(10) ,
 `driverPhone` varchar(12) ,
 `freight` int(20) ,
 `totalAmount` double ,
 `ctmId` int(10) ,
 `remark` varchar(35) 
)*/;

/*Table structure for table `v_sp_pdt_type` */

DROP TABLE IF EXISTS `v_sp_pdt_type`;

/*!50001 DROP VIEW IF EXISTS `v_sp_pdt_type` */;
/*!50001 DROP TABLE IF EXISTS `v_sp_pdt_type` */;

/*!50001 CREATE TABLE  `v_sp_pdt_type`(
 `SP_ID` int(10) ,
 `PRODUCT_TYPE` int(1) ,
 `END_MONTH` varchar(7) ,
 `GRADES_A` int(10) ,
 `GRADES_B` int(10) ,
 `GRADES_C` int(10) ,
 `GRADES_D` int(10) ,
 `GRADES_E` int(10) ,
 `TOTAL_PACK` int(11) ,
 `CREATE_DATE` datetime ,
 `TOTAL_AREA` double ,
 `SP_TYPE` char(2) ,
 `SALE_PERCENT` double ,
 `REMARK` varchar(20) ,
 `TYPE_ID` int(10) ,
 `TYPE_NAME` varchar(10) ,
 `QTY` int(2) 
)*/;

/*Table structure for table `v_stock` */

DROP TABLE IF EXISTS `v_stock`;

/*!50001 DROP VIEW IF EXISTS `v_stock` */;
/*!50001 DROP TABLE IF EXISTS `v_stock` */;

/*!50001 CREATE TABLE  `v_stock`(
 `STOCK_ID` int(10) ,
 `WAREHOUSE` varchar(10) ,
 `STOCK` int(10) ,
 `ID` int(11) ,
 `CATEGORT` varchar(10) ,
 `COLOR` varchar(10) ,
 `PATTERN_NO` varchar(10) ,
 `BRAND_NAME` varchar(10) ,
 `BRAND_ID` int(10) ,
 `GRADES_NAME` varchar(10) ,
 `SPEC_ID` int(5) ,
 `SPEC_NAME` varchar(10) ,
 `BENCHMARK` double ,
 `TYPE_NAME` varchar(10) ,
 `QTY` int(2) ,
 `GRADES_ID` int(10) ,
 `TYPE_ID` int(10) 
)*/;

/*Table structure for table `v_stock_inventory` */

DROP TABLE IF EXISTS `v_stock_inventory`;

/*!50001 DROP VIEW IF EXISTS `v_stock_inventory` */;
/*!50001 DROP TABLE IF EXISTS `v_stock_inventory` */;

/*!50001 CREATE TABLE  `v_stock_inventory`(
 `STOCK_ID` int(10) ,
 `WAREHOUSE` varchar(10) ,
 `STOCK` bigint(12) ,
 `CATEGORT` varchar(10) ,
 `COLOR` varchar(10) ,
 `PATTERN_NO` varchar(10) ,
 `PRODUCT_ID` int(11) ,
 `BRAND_NAME` varchar(10) ,
 `BRAND_ID` int(10) ,
 `TYPE_ID` int(10) ,
 `TYPE_NAME` varchar(10) ,
 `GRADES_ID` int(10) ,
 `GRADES_NAME` varchar(10) ,
 `SPEC_NAME` varchar(10) ,
 `QTY` int(2) 
)*/;

/*Table structure for table `v_stock_record` */

DROP TABLE IF EXISTS `v_stock_record`;

/*!50001 DROP VIEW IF EXISTS `v_stock_record` */;
/*!50001 DROP TABLE IF EXISTS `v_stock_record` */;

/*!50001 CREATE TABLE  `v_stock_record`(
 `recordId` int(7) unsigned ,
 `recordIdStr` varchar(7) ,
 `subId` int(10) ,
 `stockId` int(9) ,
 `matId` int(9) ,
 `matName` varchar(50) ,
 `mat2Id` int(9) ,
 `mat2Name` varchar(20) ,
 `mat3Id` int(9) ,
 `mat3Name` varchar(50) ,
 `unit` varchar(20) ,
 `count` int(9) ,
 `price` decimal(10,2) ,
 `subtotal` decimal(10,2) ,
 `applicant` varchar(50) ,
 `reviewState` int(11) ,
 `checkState` int(11) ,
 `supplierId` int(10) ,
 `supplierName` varchar(20) ,
 `isPrint` tinyint(1) ,
 `state` int(1) ,
 `totalPrice` decimal(10,2) ,
 `creater` varchar(50) ,
 `createDate` datetime 
)*/;

/*Table structure for table `v_type_bra` */

DROP TABLE IF EXISTS `v_type_bra`;

/*!50001 DROP VIEW IF EXISTS `v_type_bra` */;
/*!50001 DROP TABLE IF EXISTS `v_type_bra` */;

/*!50001 CREATE TABLE  `v_type_bra`(
 `ID` int(10) ,
 `BRAND_ID` int(10) ,
 `BRAND_NAME` varchar(10) ,
 `TYPE_ID` int(10) ,
 `TYPE_NAME` varchar(10) ,
 `QTY` int(2) 
)*/;

/*Table structure for table `v_warerecord` */

DROP TABLE IF EXISTS `v_warerecord`;

/*!50001 DROP VIEW IF EXISTS `v_warerecord` */;
/*!50001 DROP TABLE IF EXISTS `v_warerecord` */;

/*!50001 CREATE TABLE  `v_warerecord`(
 `PRODUCT_ID` int(11) ,
 `TYPE_NAME` varchar(10) ,
 `TYPE_ID` int(10) ,
 `BRAND_NAME` varchar(10) ,
 `BRAND_ID` int(10) ,
 `CATEGORT` varchar(10) ,
 `COLOR` varchar(10) ,
 `GRADES_NAME` varchar(10) ,
 `GRADES_ID` int(10) ,
 `PATTERN_NO` varchar(10) ,
 `QTY` int(2) ,
 `SPEC_NAME` varchar(10) ,
 `SPEC_ID` int(5) ,
 `RECORD_ID` int(10) ,
 `WAREHOUSE` varchar(10) ,
 `STOCK` int(10) ,
 `CREATE_DATE` varchar(35) ,
 `CREATER` varchar(20) ,
 `PRODUCED_DATE` varchar(35) ,
 `REMARK` varchar(35) ,
 `CLASSES_ID` int(10) ,
 `CLASSES_NAME` varchar(10) ,
 `OPT_ID` int(10) ,
 `OPT_TYPE` varchar(10) 
)*/;

/*View structure for view v_a_checkimportstock */

/*!50001 DROP TABLE IF EXISTS `v_a_checkimportstock` */;
/*!50001 DROP VIEW IF EXISTS `v_a_checkimportstock` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_a_checkimportstock` AS select `s`.`id` AS `id`,`s`.`typeBrand` AS `typeBrand`,`s`.`category` AS `category`,`s`.`patternno` AS `patternno`,`s`.`grades` AS `grades`,`s`.`color` AS `color`,`s`.`warehouse` AS `warehouse`,`s`.`stock` AS `stock`,`s`.`currentStock` AS `currentStock`,`s`.`freezeStock` AS `freezeStock`,`s`.`todayBillStock` AS `todayBillStock`,`s`.`wareStock` AS `wareStock`,`s`.`stockId` AS `stockId`,`s`.`pId` AS `pId`,(select `getBillStockByStockId`(`s`.`stockId`)) AS `allBillStock`,(`s`.`stock` - ((`s`.`currentStock` + if(isnull(`s`.`todayBillStock`),0,`s`.`todayBillStock`)) + if(isnull(`s`.`freezeStock`),0,`s`.`freezeStock`))) AS `D` from `import_stock` `s` where ((`s`.`stock` <> ((`s`.`currentStock` + if(isnull(`s`.`todayBillStock`),0,`s`.`todayBillStock`)) + if(isnull(`s`.`freezeStock`),0,`s`.`freezeStock`))) and (`s`.`stockId` > 0)) */;

/*View structure for view v_balrecord */

/*!50001 DROP TABLE IF EXISTS `v_balrecord` */;
/*!50001 DROP VIEW IF EXISTS `v_balrecord` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_balrecord` AS select `br`.`BAL_ID` AS `balId`,`br`.`CREATER` AS `creater`,`br`.`CREATE_TIME` AS `createTime`,`br`.`OPT_TYPE` AS `optType`,`br`.`COLLECTION_TYPE` AS `collectionType`,`br`.`BAL_BEFORE` AS `balBefore`,`br`.`BAL_AFTER` AS `balAfter`,`ctm`.`CTM_NAME` AS `ctmName`,`ctm`.`CTM_ID` AS `ctmId`,`vm`.`salesMgrName` AS `salesMgrName`,`br`.`AMOUNT` AS `amount`,`br`.`REMARK` AS `remark`,`ctm`.`ADDRESS` AS `address` from ((`xly_bal_record` `br` join `xly_customer` `ctm`) join `v_mgr` `vm`) where ((`ctm`.`CTM_ID` = `br`.`CTM_ID`) and (`vm`.`salesMgrId` = `ctm`.`SALES_MGR_ID`)) order by `br`.`BAL_ID` desc */;

/*View structure for view v_billrecord */

/*!50001 DROP TABLE IF EXISTS `v_billrecord` */;
/*!50001 DROP VIEW IF EXISTS `v_billrecord` */;

/*!50001 CREATE ALGORITHM=TEMPTABLE SQL SECURITY DEFINER VIEW `v_billrecord` AS select `b`.`BILL_NO` AS `billNo`,lpad(`b`.`BILL_NO`,7,0) AS `billNoStr`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`CAR_NO` AS `carNo`,`b`.`CREATER` AS `creater`,`b`.`DRIVER_PHONE` AS `driverPhone`,`b`.`FREIGHT` AS `freight`,`b`.`REMARK` AS `remark`,`b`.`STATE` AS `bState`,`b`.`BAL_BEFORE` AS `balBefore`,`b`.`BAL_AFTER` AS `balAfter`,`b`.`SALES_MGR_ID` AS `salesMgrId`,`br`.`COUNT` AS `count`,`br`.`PRICE` AS `price`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,((`br`.`COUNT` * `br`.`PRICE`) * `vs`.`QTY`) AS `subTotal`,`br`.`BENCHMARK` AS `benchmark`,`br`.`RECORD_ID` AS `recordId`,`ctm`.`CTM_NAME` AS `ctmName`,`ctm`.`CTM_ID` AS `ctmId`,`ctm`.`ADDRESS` AS `address`,`vs`.`STOCK_ID` AS `stockId`,`vs`.`WAREHOUSE` AS `warehouse`,`vs`.`STOCK` AS `stock`,`vs`.`ID` AS `id`,`vs`.`CATEGORT` AS `categort`,`vs`.`COLOR` AS `color`,`vs`.`PATTERN_NO` AS `patternNo`,`vs`.`BRAND_NAME` AS `brandName`,`vs`.`BRAND_ID` AS `brandId`,`vs`.`GRADES_NAME` AS `gradesName`,`vs`.`SPEC_ID` AS `specId`,`vs`.`SPEC_NAME` AS `specName`,`vs`.`TYPE_NAME` AS `typeName`,`vs`.`QTY` AS `qty`,(`br`.`COUNT` * `vs`.`QTY`) AS `qtyCount`,`vs`.`GRADES_ID` AS `gradesId`,`vs`.`TYPE_ID` AS `typeId`,`mgr`.`salesMgrName` AS `mgrName` from ((((`xly_bill` `b` join `xly_bill_record` `br`) join `xly_customer` `ctm`) join `v_mgr` `mgr`) join `v_stock` `vs`) where ((`b`.`BILL_NO` = `br`.`BILL_NO`) and (`b`.`CTM_ID` = `ctm`.`CTM_ID`) and (`mgr`.`salesMgrId` = `b`.`SALES_MGR_ID`) and (`br`.`STOCK_ID` = `vs`.`STOCK_ID`)) order by `b`.`BILL_NO` desc */;

/*View structure for view v_billrecord_fake */

/*!50001 DROP TABLE IF EXISTS `v_billrecord_fake` */;
/*!50001 DROP VIEW IF EXISTS `v_billrecord_fake` */;

/*!50001 CREATE ALGORITHM=TEMPTABLE SQL SECURITY DEFINER VIEW `v_billrecord_fake` AS select `b`.`BILL_NO` AS `billNo`,lpad(`b`.`BILL_NO`,7,0) AS `billNoStr`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`CAR_NO` AS `carNo`,`b`.`CREATER` AS `creater`,`b`.`DRIVER_PHONE` AS `driverPhone`,`b`.`FREIGHT` AS `freight`,`b`.`REMARK` AS `remark`,`b`.`STATE` AS `bState`,`br`.`COUNT` AS `count`,`br`.`PRICE` AS `price`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,((`br`.`COUNT` * `br`.`PRICE`) * `vs`.`QTY`) AS `subTotal`,`br`.`RECORD_ID` AS `recordId`,`ctm`.`CTM_NAME` AS `ctmName`,`ctm`.`CTM_ID` AS `ctmId`,`ctm`.`ADDRESS` AS `address`,`ctm`.`SALES_MGR_ID` AS `salesMgrId`,`vs`.`STOCK_ID` AS `stockId`,`vs`.`WAREHOUSE` AS `warehouse`,`vs`.`STOCK` AS `stock`,`vs`.`ID` AS `id`,`vs`.`CATEGORT` AS `categort`,`vs`.`COLOR` AS `color`,`vs`.`PATTERN_NO` AS `patternNo`,`vs`.`BRAND_NAME` AS `brandName`,`vs`.`BRAND_ID` AS `brandId`,`vs`.`GRADES_NAME` AS `gradesName`,`vs`.`SPEC_ID` AS `specId`,`vs`.`SPEC_NAME` AS `specName`,`vs`.`TYPE_NAME` AS `typeName`,`vs`.`QTY` AS `qty`,(`br`.`COUNT` * `vs`.`QTY`) AS `qtyCount`,`vs`.`GRADES_ID` AS `gradesId`,`vs`.`TYPE_ID` AS `typeId`,`mgr`.`salesMgrName` AS `mgrName` from ((((`xly_bill_fake` `b` join `xly_bill_record_fake` `br`) join `xly_customer` `ctm`) join `v_mgr` `mgr`) join `v_stock` `vs`) where ((`b`.`BILL_NO` = `br`.`BILL_NO`) and (`b`.`CTM_ID` = `ctm`.`CTM_ID`) and (`mgr`.`salesMgrId` = `ctm`.`SALES_MGR_ID`) and (`br`.`STOCK_ID` = `vs`.`STOCK_ID`)) order by `b`.`BILL_NO` desc */;

/*View structure for view v_billrecord_simple */

/*!50001 DROP TABLE IF EXISTS `v_billrecord_simple` */;
/*!50001 DROP VIEW IF EXISTS `v_billrecord_simple` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_billrecord_simple` AS select `b`.`BILL_NO` AS `billNo`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`STATE` AS `bState`,`b`.`BAL_BEFORE` AS `balBefore`,`b`.`BAL_AFTER` AS `balAfter`,`br`.`COUNT` AS `count`,`br`.`PRICE` AS `price`,`br`.`BENCHMARK` AS `benchmark`,`b`.`SALES_MGR_ID` AS `salesMgrId`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,((`br`.`COUNT` * `br`.`PRICE`) * `vs`.`QTY`) AS `subTotal`,`ctm`.`CTM_NAME` AS `ctmName`,`ctm`.`CTM_ID` AS `ctmId`,`ctm`.`ADDRESS` AS `address`,`vs`.`BRAND_NAME` AS `brandName`,`vs`.`BRAND_ID` AS `brandId`,`vs`.`GRADES_NAME` AS `gradesName`,`vs`.`TYPE_NAME` AS `typeName`,`vs`.`QTY` AS `qty`,(`br`.`COUNT` * `vs`.`QTY`) AS `qtyCount`,`vs`.`GRADES_ID` AS `gradesId`,`vs`.`TYPE_ID` AS `typeId`,`mgr`.`salesMgrName` AS `mgrName` from ((((`xly_bill` `b` join `xly_bill_record` `br`) join `xly_customer` `ctm`) join `v_mgr` `mgr`) join `v_stock` `vs`) where ((`b`.`BILL_NO` = `br`.`BILL_NO`) and (`b`.`STATE` = 1) and (`b`.`CTM_ID` = `ctm`.`CTM_ID`) and (`mgr`.`salesMgrId` = `ctm`.`SALES_MGR_ID`) and (`br`.`STOCK_ID` = `vs`.`STOCK_ID`)) order by `b`.`BILL_NO` desc */;

/*View structure for view v_billrecord_sp */

/*!50001 DROP TABLE IF EXISTS `v_billrecord_sp` */;
/*!50001 DROP VIEW IF EXISTS `v_billrecord_sp` */;

/*!50001 CREATE ALGORITHM=TEMPTABLE SQL SECURITY DEFINER VIEW `v_billrecord_sp` AS select `b`.`BILL_NO` AS `billNo`,lpad(`b`.`BILL_NO`,7,0) AS `billNoStr`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`CAR_NO` AS `carNo`,`b`.`CREATER` AS `creater`,`b`.`DRIVER_PHONE` AS `driverPhone`,`b`.`FREIGHT` AS `freight`,`b`.`REMARK` AS `remark`,`b`.`STATE` AS `bState`,`br`.`COUNT` AS `count`,`br`.`PRICE` AS `price`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,((`br`.`COUNT` * `br`.`PRICE`) * `vs`.`QTY`) AS `subTotal`,`br`.`RECORD_ID` AS `recordId`,`vs`.`STOCK_ID` AS `stockId`,`vs`.`WAREHOUSE` AS `warehouse`,`vs`.`STOCK` AS `stock`,`vs`.`ID` AS `id`,`vs`.`CATEGORT` AS `categort`,`vs`.`COLOR` AS `color`,`vs`.`PATTERN_NO` AS `patternNo`,`vs`.`BRAND_NAME` AS `brandName`,`vs`.`BRAND_ID` AS `brandId`,`vs`.`GRADES_NAME` AS `gradesName`,`vs`.`SPEC_ID` AS `specId`,`vs`.`SPEC_NAME` AS `specName`,`vs`.`TYPE_NAME` AS `typeName`,`vs`.`QTY` AS `qty`,(`br`.`COUNT` * `vs`.`QTY`) AS `qtyCount`,`vs`.`GRADES_ID` AS `gradesId`,`vs`.`TYPE_ID` AS `typeId` from ((`xly_bill` `b` join `xly_bill_record` `br`) join `v_stock` `vs`) where ((`b`.`BILL_NO` = `br`.`BILL_NO`) and (`br`.`STOCK_ID` = `vs`.`STOCK_ID`) and (`b`.`STATE` = 1)) order by `b`.`BILL_NO` desc */;

/*View structure for view v_billstock */

/*!50001 DROP TABLE IF EXISTS `v_billstock` */;
/*!50001 DROP VIEW IF EXISTS `v_billstock` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_billstock` AS select `br`.`stockId` AS `stockId`,sum(`br`.`count`) AS `billStock` from `v_billrecord` `br` where (`br`.`bState` = 1) group by `br`.`stockId` */;

/*View structure for view v_buy_record */

/*!50001 DROP TABLE IF EXISTS `v_buy_record` */;
/*!50001 DROP VIEW IF EXISTS `v_buy_record` */;

/*!50001 CREATE ALGORITHM=TEMPTABLE SQL SECURITY DEFINER VIEW `v_buy_record` AS select `b`.`BILL_NO` AS `billNo`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`FREIGHT` AS `freight`,`b`.`REMARK` AS `remark`,`b`.`STATE` AS `bState`,`br`.`COUNT` AS `count`,`br`.`PRICE` AS `price`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,((`br`.`COUNT` * `br`.`PRICE`) * `vs`.`QTY`) AS `subTotal`,`br`.`RECORD_ID` AS `recordId`,`ctm`.`CTM_NAME` AS `ctmName`,`ctm`.`CTM_ID` AS `ctmId`,`b`.`SALES_MGR_ID` AS `salesMgrId`,`vs`.`STOCK_ID` AS `stockId`,`vs`.`WAREHOUSE` AS `warehouse`,`vs`.`STOCK` AS `stock`,`vs`.`BRAND_NAME` AS `brandName`,`vs`.`BRAND_ID` AS `brandId`,`vs`.`GRADES_NAME` AS `gradesName`,`vs`.`TYPE_NAME` AS `typeName`,`vs`.`QTY` AS `qty`,(`br`.`COUNT` * `vs`.`QTY`) AS `qtyCount`,`vs`.`GRADES_ID` AS `gradesId`,`vs`.`TYPE_ID` AS `typeId`,`mgr`.`salesMgrName` AS `salesMgrName` from ((((`xly_bill` `b` join `xly_bill_record` `br`) join `xly_customer` `ctm`) join `v_mgr` `mgr`) join `v_stock` `vs`) where ((`b`.`BILL_NO` = `br`.`BILL_NO`) and (`b`.`CTM_ID` = `ctm`.`CTM_ID`) and (`b`.`STATE` = 1) and (`b`.`BILL_TYPE` <> '样品') and (`mgr`.`salesMgrId` = `b`.`SALES_MGR_ID`) and (`br`.`STOCK_ID` = `vs`.`STOCK_ID`)) */;

/*View structure for view v_customer */

/*!50001 DROP TABLE IF EXISTS `v_customer` */;
/*!50001 DROP VIEW IF EXISTS `v_customer` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_customer` AS select `cmt`.`CTM_ID` AS `ctmId`,`cmt`.`CTM_NAME` AS `ctmName`,`cmt`.`TYPE_ID` AS `typeId`,`cmt`.`ADDRESS` AS `address`,`cmt`.`SHOP_NAME` AS `shopName`,`cmt`.`SALES_MGR_ID` AS `salesMgrId`,`cmt`.`IMPORT_MONEY` AS `initMoney`,concat(`cmt`.`CTM_NAME`,'--',`cmt`.`ADDRESS`) AS `ca`,convert(decode(`cmt`.`MONEY`,'xly') using utf8) AS `money`,((decode(`cmt`.`MONEY`,'xly') - `cmt`.`GRT_MONEY`) + `cmt`.`DEBT`) AS `avlMoney`,`cmt`.`GRT_MONEY` AS `grtMoney`,`cmt`.`DEBT` AS `debt`,`mgr`.`SALES_MGR_NAME` AS `salesMgrName` from (`xly_customer` `cmt` join `bdf2_user_position` `mgr`) where (`mgr`.`SALES_MGR_ID` = `cmt`.`SALES_MGR_ID`) order by `cmt`.`CTM_ID` desc */;

/*View structure for view v_customer_money */

/*!50001 DROP TABLE IF EXISTS `v_customer_money` */;
/*!50001 DROP VIEW IF EXISTS `v_customer_money` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_customer_money` AS select `vc`.`ctmId` AS `ctmId`,`vc`.`ctmName` AS `ctmName`,`vc`.`initMoney` AS `initMoney`,`vc`.`grtMoney` AS `grtMoney`,`vc`.`debt` AS `debt`,`vc`.`money` AS `money`,(select sum(`b`.`AMOUNT`) from `xly_bal_record` `b` where (`b`.`CTM_ID` = `vc`.`ctmId`)) AS `totalCtmBal`,(select sum(`b`.`TOTAL_AMOUNT`) from `xly_bill` `b` where ((`b`.`CTM_ID` = `vc`.`ctmId`) and (`b`.`STATE` = 1) and (`b`.`BILL_TYPE` = '普通'))) AS `totalConsumption` from `v_customer` `vc` */;

/*View structure for view v_drop_record */

/*!50001 DROP TABLE IF EXISTS `v_drop_record` */;
/*!50001 DROP VIEW IF EXISTS `v_drop_record` */;

/*!50001 CREATE ALGORITHM=TEMPTABLE SQL SECURITY DEFINER VIEW `v_drop_record` AS select `db`.`BILL_NO` AS `BILL_NO`,`db`.`CREATER` AS `dropCreater`,`db`.`CREATE_DATE` AS `dropDate`,`db`.`REASON` AS `reason`,`vb`.`billNo` AS `billNo`,`vb`.`billNoStr` AS `billNoStr`,`vb`.`billTime` AS `billTime`,`vb`.`billType` AS `billType`,`vb`.`carNo` AS `carNo`,`vb`.`creater` AS `creater`,`vb`.`driverPhone` AS `driverPhone`,`vb`.`freight` AS `freight`,`vb`.`remark` AS `remark`,`vb`.`bState` AS `bState`,`vb`.`count` AS `count`,`vb`.`price` AS `price`,`vb`.`subTotal` AS `subTotal`,`vb`.`recordId` AS `recordId`,`vb`.`ctmName` AS `ctmName`,`vb`.`ctmId` AS `ctmId`,`vb`.`address` AS `address`,`vb`.`salesMgrId` AS `salesMgrId`,`vb`.`stockId` AS `stockId`,`vb`.`warehouse` AS `warehouse`,`vb`.`stock` AS `stock`,`vb`.`id` AS `id`,`vb`.`categort` AS `categort`,`vb`.`color` AS `color`,`vb`.`patternNo` AS `patternNo`,`vb`.`brandName` AS `brandName`,`vb`.`brandId` AS `brandId`,`vb`.`gradesName` AS `gradesName`,`vb`.`specId` AS `specId`,`vb`.`specName` AS `specName`,`vb`.`typeName` AS `typeName`,`vb`.`qty` AS `qty`,`vb`.`gradesId` AS `gradesId`,`vb`.`typeId` AS `typeId`,`vb`.`mgrName` AS `mgrName` from (`xly_drop_bill` `db` join `v_billrecord` `vb`) where (`db`.`BILL_NO` = `vb`.`billNo`) */;

/*View structure for view v_freeze */

/*!50001 DROP TABLE IF EXISTS `v_freeze` */;
/*!50001 DROP VIEW IF EXISTS `v_freeze` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_freeze` AS select `whf`.`FREEZE_ID` AS `freezeId`,`whf`.`STOCK_ID` AS `stockId`,`whf`.`WAREHOUSE` AS `warehouse`,`ctm`.`CTM_NAME` AS `ctmName`,`ctm`.`ADDRESS` AS `address`,`whf`.`CTM_ID` AS `ctmId`,`whf`.`COUNT` AS `count`,`whf`.`CREATE_TIME` AS `createTime`,`whf`.`CREATER` AS `creater`,`whf`.`END_DATE` AS `endDate`,`whf`.`REMARK` AS `remark`,`whf`.`STATE` AS `state`,`whf`.`MODIFY_DATE` AS `modifyDate`,`whf`.`OPT_TYPE` AS `optType`,`whf`.`FINAL_MODIFIER` AS `finalModifier`,`vp`.`BRAND_NAME` AS `brandName`,`vp`.`TYPE_NAME` AS `typeName`,`vp`.`CATEGORT` AS `categort`,`vp`.`COLOR` AS `color`,`vp`.`QTY` AS `qty`,`vp`.`GRADES_NAME` AS `gradesName`,`vp`.`PATTERN_NO` AS `patternNo`,`vp`.`SPEC_NAME` AS `specName` from (((`xly_customer` `ctm` join `xly_wh_freeze` `whf`) join `xly_pdt_stock` `pdts`) join `v_productall` `vp`) where ((`ctm`.`CTM_ID` = `whf`.`CTM_ID`) and (`whf`.`STOCK_ID` = `pdts`.`ID`) and (`pdts`.`PRODUCT_ID` = `vp`.`ID`)) order by `whf`.`FREEZE_ID` desc */;

/*View structure for view v_inventory_record */

/*!50001 DROP TABLE IF EXISTS `v_inventory_record` */;
/*!50001 DROP VIEW IF EXISTS `v_inventory_record` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_inventory_record` AS select `ir`.`ID` AS `recorId`,`ir`.`PRODUCT_ID` AS `pId`,`ir`.`STOCK_ID` AS `stockId`,`ir`.`WAREHOUSE` AS `warehouse`,`ir`.`REMARK` AS `remark`,`ir`.`MODIFICATION` AS `modification`,`ir`.`CREATER` AS `creater`,`ir`.`CREATE_DATE` AS `createDate`,`p`.`TYPE_ID` AS `typeId`,`p`.`BRAND_ID` AS `brandId`,`p`.`CATEGORT` AS `categort`,`p`.`PATTERN_NO` AS `patternNo`,`p`.`COLOR` AS `color`,`p`.`GRADES_ID` AS `gradesId`,`p`.`SPEC_ID` AS `specId` from (`xly_inventory_record` `ir` join `xly_product` `p`) where (`ir`.`PRODUCT_ID` = `p`.`ID`) */;

/*View structure for view v_mat3 */

/*!50001 DROP TABLE IF EXISTS `v_mat3` */;
/*!50001 DROP VIEW IF EXISTS `v_mat3` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_mat3` AS select `m2`.`MAT_NAME` AS `matName`,`m2`.`MAT2_NAME` AS `mat2Name`,`m3`.`MAT_ID` AS `matId`,`m3`.`MAT2_ID` AS `mat2Id`,`m3`.`MAT3_ID` AS `mat3Id`,`m3`.`MAT3_NAME` AS `mat3Name`,`m3`.`HIDDEN` AS `hidden`,`m3`.`UNIT` AS `unit` from (`mat_3` `m3` join `mat_2` `m2`) where (`m2`.`MAT2_ID` = `m3`.`MAT2_ID`) */;

/*View structure for view v_mgr */

/*!50001 DROP TABLE IF EXISTS `v_mgr` */;
/*!50001 DROP VIEW IF EXISTS `v_mgr` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_mgr` AS select `up`.`POSITION_ID_` AS `positionId`,`up`.`SALES_MGR_ID` AS `salesMgrId`,`up`.`SALES_MGR_NAME` AS `salesMgrName` from (`bdf2_user` `u` join `bdf2_user_position` `up`) where ((`u`.`USERNAME_` = `up`.`USERNAME_`) and (`up`.`POSITION_ID_` = '1')) */;

/*View structure for view v_parent_stock_record */

/*!50001 DROP TABLE IF EXISTS `v_parent_stock_record` */;
/*!50001 DROP VIEW IF EXISTS `v_parent_stock_record` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_parent_stock_record` AS select `sr`.`RECORD_ID` AS `recordId`,`sr`.`SUPPLIER_ID` AS `supplierId`,`sr`.`CREATE_DATE` AS `createDate`,`sr`.`IS_PRINT` AS `isPring`,`sr`.`STATE` AS `state`,`sr`.`SUB_COUNT` AS `subcount`,`sr`.`CHECK_COUNT` AS `checkCount`,`sr`.`VALID` AS `valid`,`sr`.`TOTAL_PRICE` AS `totalPrice`,`ms`.`SUPPLIER_NAME` AS `supplierName` from (`mat_stock_record` `sr` join `mat_supplier` `ms`) where (`sr`.`SUPPLIER_ID` = `ms`.`ID`) */;

/*View structure for view v_patternno_grade */

/*!50001 DROP TABLE IF EXISTS `v_patternno_grade` */;
/*!50001 DROP VIEW IF EXISTS `v_patternno_grade` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_patternno_grade` AS select sum(`vb`.`count`) AS `sum`,`vb`.`billTime` AS `billTime`,`vb`.`typeId` AS `typeId`,`vb`.`typeName` AS `typeName`,`vb`.`brandId` AS `brandId`,`vb`.`brandName` AS `brandName`,`vb`.`patternNo` AS `patternNo`,`vb`.`gradesId` AS `gradesId`,`vb`.`gradesName` AS `gradesName` from `v_billrecord` `vb` where ((`vb`.`bState` = 1) and (`vb`.`gradesId` < 5)) group by `vb`.`typeId`,`vb`.`patternNo`,`vb`.`gradesId` order by `vb`.`typeId`,`vb`.`brandId`,`vb`.`patternNo`,`vb`.`gradesId` */;

/*View structure for view v_productall */

/*!50001 DROP TABLE IF EXISTS `v_productall` */;
/*!50001 DROP VIEW IF EXISTS `v_productall` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_productall` AS select `vp`.`ID` AS `ID`,`pt`.`TYPE_NAME` AS `TYPE_NAME`,`pb`.`BRAND_NAME` AS `BRAND_NAME`,`vp`.`CATEGORT` AS `CATEGORT`,`vp`.`TYPE_BRAND_ID` AS `TYPE_BRAND_ID`,`vp`.`COLOR` AS `COLOR`,`ptgb`.`BENCH_MARK` AS `BENCHMARK`,`vp`.`PATTERN_NO` AS `PATTERN_NO`,`pb`.`BRAND_ID` AS `BRAND_ID`,`pg`.`GRADES_ID` AS `GRADES_ID`,`pg`.`GRADES_NAME` AS `GRADES_NAME`,`ps`.`SPEC_NAME` AS `SPEC_NAME`,`pt`.`QTY` AS `QTY`,`pt`.`TYPE_ID` AS `TYPE_ID`,`ps`.`SPEC_ID` AS `SPEC_ID` from (((((`xly_product` `vp` join `xly_pdt_bra` `pb`) join `xly_pdt_gd` `pg`) join `xly_pdt_spec` `ps`) join `xly_pdt_typ` `pt`) join `xly_pdt_typ_gd_bm` `ptgb`) where ((`vp`.`BRAND_ID` = `pb`.`BRAND_ID`) and (`vp`.`GRADES_ID` = `pg`.`GRADES_ID`) and (`vp`.`SPEC_ID` = `ps`.`SPEC_ID`) and (`vp`.`TYPE_ID` = `pt`.`TYPE_ID`) and (`ptgb`.`GRADES_ID` = `vp`.`GRADES_ID`) and (`ptgb`.`TYPE_ID` = `vp`.`TYPE_ID`)) */;

/*View structure for view v_simple_bill */

/*!50001 DROP TABLE IF EXISTS `v_simple_bill` */;
/*!50001 DROP VIEW IF EXISTS `v_simple_bill` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_simple_bill` AS select `b`.`BILL_NO` AS `billNo`,lpad(`b`.`BILL_NO`,7,0) AS `billNoStr`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`CAR_NO` AS `carNo`,`b`.`CREATER` AS `creater`,`b`.`DRIVER_PHONE` AS `driverPhone`,`b`.`FREIGHT` AS `freight`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,`b`.`CTM_ID` AS `ctmId`,`b`.`SALES_MGR_ID` AS `salesMgrId`,`b`.`REMARK` AS `remark` from (`xly_bill` `b` join `xly_customer` `ctm`) where ((`b`.`CTM_ID` = `ctm`.`CTM_ID`) and (`b`.`STATE` = 1)) order by `b`.`BILL_NO` desc */;

/*View structure for view v_simple_bill_fake */

/*!50001 DROP TABLE IF EXISTS `v_simple_bill_fake` */;
/*!50001 DROP VIEW IF EXISTS `v_simple_bill_fake` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_simple_bill_fake` AS select `b`.`BILL_NO` AS `billNo`,lpad(`b`.`BILL_NO`,7,0) AS `billNoStr`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`CAR_NO` AS `carNo`,`b`.`CREATER` AS `creater`,`b`.`DRIVER_PHONE` AS `driverPhone`,`b`.`FREIGHT` AS `freight`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,`b`.`CTM_ID` AS `ctmId`,`b`.`REMARK` AS `remark` from `xly_bill_fake` `b` */;

/*View structure for view v_sp_pdt_type */

/*!50001 DROP TABLE IF EXISTS `v_sp_pdt_type` */;
/*!50001 DROP VIEW IF EXISTS `v_sp_pdt_type` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_sp_pdt_type` AS select `xspt`.`SP_ID` AS `SP_ID`,`xspt`.`PRODUCT_TYPE` AS `PRODUCT_TYPE`,`xspt`.`END_MONTH` AS `END_MONTH`,`xspt`.`GRADES_A` AS `GRADES_A`,`xspt`.`GRADES_B` AS `GRADES_B`,`xspt`.`GRADES_C` AS `GRADES_C`,`xspt`.`GRADES_D` AS `GRADES_D`,`xspt`.`GRADES_E` AS `GRADES_E`,`xspt`.`TOTAL_PACK` AS `TOTAL_PACK`,`xspt`.`CREATE_DATE` AS `CREATE_DATE`,`xspt`.`TOTAL_AREA` AS `TOTAL_AREA`,`xspt`.`SP_TYPE` AS `SP_TYPE`,`xspt`.`SALE_PERCENT` AS `SALE_PERCENT`,`xspt`.`REMARK` AS `REMARK`,`xpt`.`TYPE_ID` AS `TYPE_ID`,`xpt`.`TYPE_NAME` AS `TYPE_NAME`,`xpt`.`QTY` AS `QTY` from (`xly_sp_pdt_type` `xspt` join `xly_pdt_typ` `xpt`) where (`xspt`.`PRODUCT_TYPE` = `xpt`.`TYPE_ID`) */;

/*View structure for view v_stock */

/*!50001 DROP TABLE IF EXISTS `v_stock` */;
/*!50001 DROP VIEW IF EXISTS `v_stock` */;

/*!50001 CREATE ALGORITHM=TEMPTABLE SQL SECURITY DEFINER VIEW `v_stock` AS select `ps`.`ID` AS `STOCK_ID`,`ps`.`WAREHOUSE` AS `WAREHOUSE`,`ps`.`STOCK` AS `STOCK`,`vp`.`ID` AS `ID`,`vp`.`CATEGORT` AS `CATEGORT`,`vp`.`COLOR` AS `COLOR`,`vp`.`PATTERN_NO` AS `PATTERN_NO`,`vp`.`BRAND_NAME` AS `BRAND_NAME`,`vp`.`BRAND_ID` AS `BRAND_ID`,`vp`.`GRADES_NAME` AS `GRADES_NAME`,`vp`.`SPEC_ID` AS `SPEC_ID`,`vp`.`SPEC_NAME` AS `SPEC_NAME`,`vp`.`BENCHMARK` AS `BENCHMARK`,`vp`.`TYPE_NAME` AS `TYPE_NAME`,`vp`.`QTY` AS `QTY`,`vp`.`GRADES_ID` AS `GRADES_ID`,`vp`.`TYPE_ID` AS `TYPE_ID` from (`xly_pdt_stock` `ps` join `v_productall` `vp`) where (`ps`.`PRODUCT_ID` = `vp`.`ID`) */;

/*View structure for view v_stock_inventory */

/*!50001 DROP TABLE IF EXISTS `v_stock_inventory` */;
/*!50001 DROP VIEW IF EXISTS `v_stock_inventory` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_stock_inventory` AS select `vs`.`STOCK_ID` AS `STOCK_ID`,`vs`.`WAREHOUSE` AS `WAREHOUSE`,(`vs`.`STOCK` + ifnull(`getFreezeStock`(`vs`.`STOCK_ID`),0)) AS `STOCK`,`vs`.`CATEGORT` AS `CATEGORT`,`vs`.`COLOR` AS `COLOR`,`vs`.`PATTERN_NO` AS `PATTERN_NO`,`vs`.`ID` AS `PRODUCT_ID`,`vs`.`BRAND_NAME` AS `BRAND_NAME`,`vs`.`BRAND_ID` AS `BRAND_ID`,`vs`.`TYPE_ID` AS `TYPE_ID`,`vs`.`TYPE_NAME` AS `TYPE_NAME`,`vs`.`GRADES_ID` AS `GRADES_ID`,`vs`.`GRADES_NAME` AS `GRADES_NAME`,`vs`.`SPEC_NAME` AS `SPEC_NAME`,`vs`.`QTY` AS `QTY` from `v_stock` `vs` order by left(`vs`.`WAREHOUSE`,1),(substr(`vs`.`WAREHOUSE`,3) + 0) */;

/*View structure for view v_stock_record */

/*!50001 DROP TABLE IF EXISTS `v_stock_record` */;
/*!50001 DROP VIEW IF EXISTS `v_stock_record` */;

/*!50001 CREATE ALGORITHM=TEMPTABLE SQL SECURITY DEFINER VIEW `v_stock_record` AS select `sr`.`RECORD_ID` AS `recordId`,lpad(`sr`.`RECORD_ID`,7,0) AS `recordIdStr`,`ss`.`SUB_ID` AS `subId`,`ss`.`STOCK_ID` AS `stockId`,`vm`.`matId` AS `matId`,`vm`.`matName` AS `matName`,`vm`.`mat2Id` AS `mat2Id`,`vm`.`mat2Name` AS `mat2Name`,`vm`.`mat3Id` AS `mat3Id`,`vm`.`mat3Name` AS `mat3Name`,`vm`.`unit` AS `unit`,`ss`.`COUNT` AS `count`,`ss`.`PRICE` AS `price`,`ss`.`SUBTOTAL` AS `subtotal`,`ss`.`APPLICANT` AS `applicant`,`ss`.`REVIEW_STATE` AS `reviewState`,`ss`.`CHECK_STATE` AS `checkState`,`sr`.`SUPPLIER_ID` AS `supplierId`,`ms`.`SUPPLIER_NAME` AS `supplierName`,`sr`.`IS_PRINT` AS `isPrint`,`sr`.`STATE` AS `state`,`sr`.`TOTAL_PRICE` AS `totalPrice`,`sr`.`CREATER` AS `creater`,`sr`.`CREATE_DATE` AS `createDate` from (((`mat_stock_subrecord` `ss` join `mat_stock_record` `sr`) join `v_mat3` `vm`) join `mat_supplier` `ms`) where ((`sr`.`VALID` = 1) and (`sr`.`RECORD_ID` = `ss`.`RECORD_ID`) and (`sr`.`SUPPLIER_ID` = `ms`.`ID`) and (`ss`.`MAT3_ID` = `vm`.`mat3Id`)) */;

/*View structure for view v_type_bra */

/*!50001 DROP TABLE IF EXISTS `v_type_bra` */;
/*!50001 DROP VIEW IF EXISTS `v_type_bra` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_type_bra` AS select `ptb`.`ID` AS `ID`,`pb`.`BRAND_ID` AS `BRAND_ID`,`pb`.`BRAND_NAME` AS `BRAND_NAME`,`pt`.`TYPE_ID` AS `TYPE_ID`,`pt`.`TYPE_NAME` AS `TYPE_NAME`,`pt`.`QTY` AS `QTY` from ((`xly_pdt_typ_bra` `ptb` join `xly_pdt_typ` `pt`) join `xly_pdt_bra` `pb`) where ((`ptb`.`BRAND_ID` = `pb`.`BRAND_ID`) and (`ptb`.`TYPE_ID` = `pt`.`TYPE_ID`)) */;

/*View structure for view v_warerecord */

/*!50001 DROP TABLE IF EXISTS `v_warerecord` */;
/*!50001 DROP VIEW IF EXISTS `v_warerecord` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_warerecord` AS select `vp`.`ID` AS `PRODUCT_ID`,`vp`.`TYPE_NAME` AS `TYPE_NAME`,`vp`.`TYPE_ID` AS `TYPE_ID`,`vp`.`BRAND_NAME` AS `BRAND_NAME`,`vp`.`BRAND_ID` AS `BRAND_ID`,`vp`.`CATEGORT` AS `CATEGORT`,`vp`.`COLOR` AS `COLOR`,`vp`.`GRADES_NAME` AS `GRADES_NAME`,`vp`.`GRADES_ID` AS `GRADES_ID`,`vp`.`PATTERN_NO` AS `PATTERN_NO`,`vp`.`QTY` AS `QTY`,`vp`.`SPEC_NAME` AS `SPEC_NAME`,`vp`.`SPEC_ID` AS `SPEC_ID`,`whr`.`ID` AS `RECORD_ID`,`whr`.`WAREHOUSE` AS `WAREHOUSE`,`whr`.`STOCK` AS `STOCK`,`whr`.`CREATE_DATE` AS `CREATE_DATE`,`whr`.`CREATER` AS `CREATER`,`whr`.`PRODUCED_DATE` AS `PRODUCED_DATE`,`whr`.`REMARK` AS `REMARK`,`cla`.`CLASSES_ID` AS `CLASSES_ID`,`cla`.`CLASSES_NAME` AS `CLASSES_NAME`,`wht`.`TYPE_ID` AS `OPT_ID`,`wht`.`TYPE_NAME` AS `OPT_TYPE` from (((`xly_wh_record` `whr` join `v_productall` `vp`) join `xly_classes` `cla`) join `xly_wh_type` `wht`) where ((`whr`.`PRODUCT_ID` = `vp`.`ID`) and (`whr`.`CLASSES_ID` = `cla`.`CLASSES_ID`) and (`whr`.`TYPE_ID` = `wht`.`TYPE_ID`)) order by `whr`.`ID` desc */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

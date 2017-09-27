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

/* Procedure structure for procedure `clearData` */

/*!50003 DROP PROCEDURE IF EXISTS  `clearData` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `clearData`(V_NEED int)
BEGIN
    -- 入账记录
    TRUNCATE `xly_bal_record`;
    -- 开票记录
    TRUNCATE `xly_bill`;
       -- 开票记录
    TRUNCATE `xly_bill_fake`;
    -- 开票子记录
    TRUNCATE `xly_bill_record`;
        -- 开票子记录
    TRUNCATE `xly_bill_record_fake`;
    -- 客户入账记录
    TRUNCATE `xly_ctm_bal`;
    -- 客户采购记录
    TRUNCATE `xly_ctm_buy`;
    -- 客户表
    TRUNCATE `xly_customer`;
    -- 失效开票记录
    TRUNCATE `xly_drop_bill`;
    -- 库存 表 
    TRUNCATE `xly_pdt_stock`;
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
    
    END */$$
DELIMITER ;

/* Procedure structure for procedure `creatCtm` */

/*!50003 DROP PROCEDURE IF EXISTS  `creatCtm` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `creatCtm`(ctmCount int ,mgrId int )
BEGIN
  DECLARE num INT  ;
  DECLARE mgrName varchar(12) ;
  SELECT vm.`salesMgrName` INTO mgrName FROM v_mgr vm WHERE vm.`salesMgrId`=mgrId;
  SET num = 1 ;
  WHILE
    num < ctmCount DO 
    INSERT INTO xly_customer (CTM_NAME,SALES_MGR_ID,ADDRESS)VALUES(concat('客户',num,'-',mgrName),mgrId,concat(mgrId,'地址',num));
    SET num = num + 1 ;
  END WHILE ;
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

/*!50003 CREATE PROCEDURE `dcoMoney`(in ctmId int)
BEGIN
	 SELECT DECODE(money,'xly') money from xly_customer where CTM_ID=ctmId;
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

/* Procedure structure for procedure `deleteImportStock` */

/*!50003 DROP PROCEDURE IF EXISTS  `deleteImportStock` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `deleteImportStock`()
BEGIN
    DELETE FROM xly_product WHERE COLOR='cs';
    DELETE FROM xly_wh_record WHERE TYPE_ID=5;
    delete From xly_pdt_stock where WAREHOUSE='M-1' or WAREHOUSE='M-2' OR WAREHOUSE='B-1' OR WAREHOUSE='B-2' OR WAREHOUSE='X-1' 
    OR WAREHOUSE='X-2' OR  WAREHOUSE='MF-3';
    END */$$
DELIMITER ;

/* Procedure structure for procedure `lastMonthCtmBal` */

/*!50003 DROP PROCEDURE IF EXISTS  `lastMonthCtmBal` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `lastMonthCtmBal`()
BEGIN
    DECLARE lastMonth varchar(7);
    DECLARE V_MONEY double default 0;
    DECLARE V_CTMID int DEFAULT 0;
    
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
    INSERT INTO xly_ctm_bal (CTM_ID,BALANCE,END_MONTH)VALUES (V_CTMID,V_MONEY,left(DATE_SUB(NOW(),INTERVAL 1 MONTH),7));
  END LOOP;
  CLOSE cur;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `recoveryFrezee` */

/*!50003 DROP PROCEDURE IF EXISTS  `recoveryFrezee` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `recoveryFrezee`()
BEGIN
	DECLARE F_ID INT (11) ;
	DECLARE STOCK_ID INT (11) ;
	DECLARE STOCK_COUNT INT (11) ;
	DECLARE V_END_DATE varchar (20) ;
	DECLARE CUR_RECORD CURSOR FOR 
	SELECT whf.FREEZE_ID,whf.STOCK_ID ,whf.COUNT,whf.END_DATE FROM  xly_wh_freeze whf 
  WHERE whf.END_DATE='2017-07-05' AND whf.STATE=0 and whf.WAREHOUSE!='E-28';
  DECLARE EXIT HANDLER FOR NOT FOUND CLOSE CUR_RECORD;  
  OPEN CUR_RECORD;
  REPEAT  
  FETCH CUR_RECORD INTO F_ID,STOCK_ID,STOCK_COUNT,V_END_DATE;
  	IF V_END_DATE='2017-07-05' THEN 
	set STOCK_COUNT=STOCK_COUNT*2;
	UPDATE xly_pdt_stock SET STOCK = STOCK-STOCK_COUNT WHERE ID=STOCK_ID;
	END IF;
  UNTIL 0 END REPEAT;
  CLOSE CUR_RECORD;  
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
    declare V_SALE_MGR_ID int default 0;
    DECLARE V_CTM_ID INT DEFAULT 0;
    DECLARE V_CTM_NAME varchar(10);
    DECLARE V_SALE_MGR_NAME varchar(10);
	
    DECLARE V_BRAND_ID INT DEFAULT 0;
    DECLARE V_TYPE_ID INT DEFAULT 0;
    DECLARE V_AMOUNT double DEFAULT 0;
     
    DECLARE V_RECORD_COUNT INT DEFAULT 0;
    DECLARE done BOOLEAN DEFAULT FALSE;     
    -- 已对数据有效性进行筛选
    DECLARE cur CURSOR FOR 
    SELECT vbr.ctmId,vbr.ctmName,vbr.`brandId`,vbr.`typeId`,vbr.`salesMgrId`,salesMgrName,vbr.`subTotal`
    FROM  v_buy_record vbr 
    WHERE LEFT(vbr.`billTime`,7)=V_MONTH;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  
  OPEN cur;
    SET @a=0;
  -- 开始循环 
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur INTO V_CTM_ID,V_CTM_NAME,V_BRAND_ID,V_TYPE_ID,V_SALE_MGR_ID,V_SALE_MGR_NAME,V_AMOUNT;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
    -- 注意 ctmID、月份、mgrID确定唯一行
	select count(*) into V_RECORD_COUNT from xly_ctm_buy cb where  cb.`CTM_ID`=V_CTM_ID AND SALE_MGR_ID=V_SALE_MGR_ID AND END_MONTH=V_MONTH;
    -- 这里做你想做的循环的事件
	IF V_RECORD_COUNT = 0 THEN
	insert into xly_ctm_buy(SALE_MGR_ID,SALE_MGR_NAME,CTM_ID,CTM_NAME,CREATE_DATE,END_MONTH) 
	values(V_SALE_MGR_ID,V_SALE_MGR_NAME,V_CTM_ID,V_CTM_NAME,now(),V_MONTH);
	end IF;
	-- 11是曼宜森--全抛釉
	if V_BRAND_ID=1 and V_TYPE_ID=1 then
	update xly_ctm_buy set MYS_Q=MYS_Q+V_AMOUNT WHERE  CTM_ID=V_CTM_ID AND END_MONTH=V_MONTH AND SALE_MGR_ID=V_SALE_MGR_ID;
	-- 12是曼宜森--金刚石
	ELSEIF V_BRAND_ID=1 AND V_TYPE_ID=2 THEN
	UPDATE xly_ctm_buy SET MYS_J=MYS_J+V_AMOUNT WHERE  CTM_ID=V_CTM_ID  AND END_MONTH=V_MONTH AND SALE_MGR_ID=V_SALE_MGR_ID;
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
	ELSE 
	UPDATE xly_ctm_buy SET MF_C=MF_C+V_AMOUNT WHERE  CTM_ID=V_CTM_ID AND END_MONTH=V_MONTH AND SALE_MGR_ID=V_SALE_MGR_ID;
	SET @a=@a+1;
    END IF;
  END LOOP;
  CLOSE cur;  
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sortProduceByType` */

/*!50003 DROP PROCEDURE IF EXISTS  `sortProduceByType` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sortProduceByType`(
IN V_MONTH VARCHAR(7)
)
BEGIN
    DECLARE V_GRADES_A INT DEFAULT 0;
    DECLARE V_GRADES_B INT DEFAULT 0;
    DECLARE V_GRADES_C INT DEFAULT 0; 
    DECLARE V_GRADES_D INT DEFAULT 0;
    DECLARE V_GRADES_E INT DEFAULT 0;    
    
     DECLARE V_QTY INT DEFAULT 0;   
     
    DECLARE V_MONTH_P DOUBLE DEFAULT 0;  
    DECLARE V_TOTAL_AREA DOUBLE DEFAULT 0;  
    DECLARE V_TOTAL_PACK int DEFAULT 0;     
    DECLARE V_OPT_ID INT;
    DECLARE V_STOCK INT DEFAULT 0;
    DECLARE V_GRADES_ID INT;
     DECLARE done BOOLEAN DEFAULT FALSE;
     DECLARE cur CURSOR FOR 
     SELECT vw.GRADES_ID,vw.OPT_ID,vw.STOCK,vw.QTY FROM v_warerecord vw WHERE LEFT(vw.PRODUCED_DATE,7)=V_MONTH 
     AND vw.TYPE_ID=1;
     
  DECLARE cur2 CURSOR FOR 
     SELECT vw.GRADES_ID,vw.OPT_ID,vw.STOCK,vw.QTY FROM v_warerecord vw WHERE LEFT(vw.PRODUCED_DATE,7)=V_MONTH 
     AND vw.TYPE_ID=2;   
     
       DECLARE cur3 CURSOR FOR 
     SELECT vw.GRADES_ID,vw.OPT_ID,vw.STOCK,vw.QTY FROM v_warerecord vw WHERE LEFT(vw.PRODUCED_DATE,7)=V_MONTH 
     AND vw.TYPE_ID=3;    
     
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
    SET @a=0;
  -- 开始循环
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur INTO V_GRADES_ID,V_OPT_ID,V_STOCK,V_QTY;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
	
    -- 这里做你想做的循环的事件
	IF V_OPT_ID=3 OR V_OPT_ID=4 THEN
	SET V_STOCK=-V_STOCK;
    END IF;
    SET @a=@a+1;
	CASE V_GRADES_ID
	WHEN 1 THEN   SET V_GRADES_A=V_GRADES_A+V_STOCK;
	WHEN 2 THEN   SET V_GRADES_B=V_GRADES_B+V_STOCK;
	WHEN 3 THEN   SET V_GRADES_C=V_GRADES_C+V_STOCK;
	WHEN 4 THEN   SET V_GRADES_D=V_GRADES_D+V_STOCK;
	WHEN 5 THEN   SET V_GRADES_E=V_GRADES_E+V_STOCK;
	WHEN 6 THEN   SET V_GRADES_E=V_GRADES_E+V_STOCK;
	END CASE;
  END LOOP;
  -- 总面积 单位平方米 砖统一是800mm*800mm 即0.64m2 另外入库是按箱 需要换成片计算总面积 除了全抛釉3片 其余2片
	SET V_TOTAL_PACK=V_GRADES_A+V_GRADES_B+V_GRADES_C+V_GRADES_D+V_GRADES_E;
	SET V_TOTAL_AREA=V_TOTAL_PACK*V_QTY*0.64;
	INSERT INTO xly_sp_pdt_type 
	(PRODUCT_TYPE,END_MONTH,GRADES_A,GRADES_B,GRADES_C,GRADES_D,GRADES_E,TOTAL_AREA,TOTAL_PACK,SP_TYPE,CREATE_DATE,QTY)
	VALUES(1,V_MONTH,V_GRADES_A,V_GRADES_B,V_GRADES_C,V_GRADES_D,V_GRADES_E,V_TOTAL_AREA,V_TOTAL_PACK,'生产',now(),V_QTY);-- 这里全是生产
	SELECT @a,V_GRADES_A,V_GRADES_B,V_GRADES_C,V_GRADES_D,V_GRADES_E,V_TOTAL_PACK,V_TOTAL_AREA;
	
  CLOSE cur;
    -- 结束种类1
    
    set done=false,V_GRADES_A=0,V_GRADES_B=0,V_GRADES_C=0,V_GRADES_D=0,V_GRADES_E=0,V_TOTAL_PACK=0,V_TOTAL_AREA=0;
  OPEN cur2;
    SET @a=0;
  -- 开始循环
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur2 INTO V_GRADES_ID,V_OPT_ID,V_STOCK,V_QTY;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
	
    -- 这里做你想做的循环的事件
	IF V_OPT_ID=3 OR V_OPT_ID=4 THEN
	SET V_STOCK=-V_STOCK;
    END IF;
    SET @a=@a+1;
	CASE V_GRADES_ID
	WHEN 1 THEN   SET V_GRADES_A=V_GRADES_A+V_STOCK;
	WHEN 2 THEN   SET V_GRADES_B=V_GRADES_B+V_STOCK;
	WHEN 3 THEN   SET V_GRADES_C=V_GRADES_C+V_STOCK;
	WHEN 4 THEN   SET V_GRADES_D=V_GRADES_D+V_STOCK;
	WHEN 5 THEN   SET V_GRADES_E=V_GRADES_E+V_STOCK;
	WHEN 6 THEN   SET V_GRADES_E=V_GRADES_E+V_STOCK;
	END CASE;
  END LOOP;
  -- 总面积 单位平方米 砖统一是800mm*800mm 即0.64m2 另外入库是按箱 需要换成片计算总面积 除了全抛釉3片 其余2片
	SET V_TOTAL_PACK=V_GRADES_A+V_GRADES_B+V_GRADES_C+V_GRADES_D+V_GRADES_E;
	SET V_TOTAL_AREA=V_TOTAL_PACK*V_QTY*0.64;
	INSERT INTO xly_sp_pdt_type 
	(PRODUCT_TYPE,END_MONTH,GRADES_A,GRADES_B,GRADES_C,GRADES_D,GRADES_E,TOTAL_AREA,TOTAL_PACK,SP_TYPE,CREATE_DATE,QTY)
	VALUES(2,V_MONTH,V_GRADES_A,V_GRADES_B,V_GRADES_C,V_GRADES_D,V_GRADES_E,V_TOTAL_AREA,V_TOTAL_PACK,'生产',NOW(),V_QTY);-- 这里全是生产
	SELECT @a,V_GRADES_A,V_GRADES_B,V_GRADES_C,V_GRADES_D,V_GRADES_E,V_TOTAL_PACK,V_TOTAL_AREA;
  CLOSE cur2;
    -- 结束种类2    
  -- 这里忘记清除 导致数据不正常
  SET done=FALSE,V_GRADES_A=0,V_GRADES_B=0,V_GRADES_C=0,V_GRADES_D=0,V_GRADES_E=0,V_TOTAL_PACK=0,V_TOTAL_AREA=0;
  OPEN cur3;
    SET @a=0;
  -- 开始循环
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur3 INTO V_GRADES_ID,V_OPT_ID,V_STOCK,V_QTY;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
	
    -- 这里做你想做的循环的事件
	IF V_OPT_ID=3 OR V_OPT_ID=4 THEN
	SET V_STOCK=-V_STOCK;
    END IF;
    SET @a=@a+1;
	CASE V_GRADES_ID
	WHEN 1 THEN   SET V_GRADES_A=V_GRADES_A+V_STOCK;
	WHEN 2 THEN   SET V_GRADES_B=V_GRADES_B+V_STOCK;
	WHEN 3 THEN   SET V_GRADES_C=V_GRADES_C+V_STOCK;
	WHEN 4 THEN   SET V_GRADES_D=V_GRADES_D+V_STOCK;
	WHEN 5 THEN   SET V_GRADES_E=V_GRADES_E+V_STOCK;
	WHEN 6 THEN   SET V_GRADES_E=V_GRADES_E+V_STOCK;
	END CASE;
  END LOOP;
  -- 总面积 单位平方米 砖统一是800mm*800mm 即0.64m2 另外入库是按箱 需要换成片计算总面积 除了全抛釉3片 其余2片
	SET V_TOTAL_PACK=V_GRADES_A+V_GRADES_B+V_GRADES_C+V_GRADES_D+V_GRADES_E;
	SET V_TOTAL_AREA=V_TOTAL_PACK*V_QTY*0.64;
	INSERT INTO xly_sp_pdt_type 
	(PRODUCT_TYPE,END_MONTH,GRADES_A,GRADES_B,GRADES_C,GRADES_D,GRADES_E,TOTAL_AREA,TOTAL_PACK,SP_TYPE,CREATE_DATE,QTY)
	VALUES(3,V_MONTH,V_GRADES_A,V_GRADES_B,V_GRADES_C,V_GRADES_D,V_GRADES_E,V_TOTAL_AREA,V_TOTAL_PACK,'生产',NOW(),V_QTY);-- 这里全是生产
	SELECT @a,V_GRADES_A,V_GRADES_B,V_GRADES_C,V_GRADES_D,V_GRADES_E,V_TOTAL_PACK,V_TOTAL_AREA;
  CLOSE cur3;
    -- 结束种类3   
   
    
     
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sortSaleByType` */

/*!50003 DROP PROCEDURE IF EXISTS  `sortSaleByType` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sortSaleByType`(
IN V_MONTH VARCHAR(7)
)
BEGIN
    DECLARE V_GRADES_A INT DEFAULT 0;
    DECLARE V_GRADES_B INT DEFAULT 0;
    DECLARE V_GRADES_C INT DEFAULT 0; 
    DECLARE V_GRADES_D INT DEFAULT 0;
    -- 次品 打包和未打包的 5 6
    DECLARE V_GRADES_E INT DEFAULT 0;    
    
    
     DECLARE V_MONTH_S DOUBLE DEFAULT 0;
      DECLARE V_MONTH_P DOUBLE DEFAULT 0;
     DECLARE V_QTY INT DEFAULT 0;   
    DECLARE V_TOTAL_AREA DOUBLE DEFAULT 0;  
    DECLARE V_TOTAL_PACK int DEFAULT 0;     
    DECLARE V_OPT_ID INT;
    DECLARE V_COUNT INT DEFAULT 0;
    DECLARE V_GRADES_ID INT;
    DECLARE done BOOLEAN DEFAULT FALSE;
    -- v_billrecord_sp 已经筛选有效数据
    DECLARE cur CURSOR FOR 
    SELECT bsp.gradesId,bsp.count,bsp.qty FROM v_billrecord_sp bsp WHERE LEFT(bsp.billTime,7)=V_MONTH AND bsp.typeId=1;  
     
   DECLARE cur2 CURSOR FOR 
   SELECT bsp.gradesId,bsp.count,bsp.qty FROM v_billrecord_sp bsp WHERE LEFT(bsp.billTime,7)=V_MONTH AND bsp.typeId=2;  
     
    DECLARE cur3 CURSOR FOR 
   SELECT bsp.gradesId,bsp.count,bsp.qty FROM v_billrecord_sp bsp WHERE LEFT(bsp.billTime,7)=V_MONTH AND bsp.typeId=3;  
     
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
    SET @a=0;
  -- 开始循环
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur INTO V_GRADES_ID,V_COUNT,V_QTY;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
	
    SET @a=@a+1;
	CASE V_GRADES_ID
	WHEN 1 THEN   SET V_GRADES_A=V_GRADES_A+V_COUNT;
	WHEN 2 THEN   SET V_GRADES_B=V_GRADES_B+V_COUNT;
	WHEN 3 THEN   SET V_GRADES_C=V_GRADES_C+V_COUNT;
	WHEN 4 THEN   SET V_GRADES_D=V_GRADES_D+V_COUNT;
	WHEN 5 THEN   SET V_GRADES_E=V_GRADES_E+V_COUNT;
	WHEN 6 THEN   SET V_GRADES_E=V_GRADES_E+V_COUNT;
	END CASE;
  END LOOP;
  -- 总面积 单位平方米 砖统一是800mm*800mm 即0.64m2 另外入库是按箱 需要换成片计算总面积 除了全抛釉3片 其余2片
	SET V_TOTAL_PACK=V_GRADES_A+V_GRADES_B+V_GRADES_C+V_GRADES_D+V_GRADES_E;
	SET V_TOTAL_AREA=V_TOTAL_PACK*V_QTY*0.64;
	INSERT INTO xly_sp_pdt_type 
	(PRODUCT_TYPE,END_MONTH,GRADES_A,GRADES_B,GRADES_C,GRADES_D,GRADES_E,TOTAL_AREA,TOTAL_PACK,SP_TYPE,CREATE_DATE,QTY)
	VALUES(1,V_MONTH,V_GRADES_A,V_GRADES_B,V_GRADES_C,V_GRADES_D,V_GRADES_E,V_TOTAL_AREA,V_TOTAL_PACK,'销售',now(),V_QTY);-- 这里全是销售
	SELECT @a,V_GRADES_A,V_GRADES_B,V_GRADES_C,V_GRADES_D,V_GRADES_E,V_TOTAL_PACK,V_TOTAL_AREA;
  CLOSE cur;
    -- 结束种类1
    
    set done=false,V_GRADES_A=0,V_GRADES_B=0,V_GRADES_C=0,V_GRADES_D=0,V_GRADES_E=0,V_TOTAL_PACK=0,V_TOTAL_AREA=0;
  OPEN cur2;
    SET @a=0;
  -- 开始循环
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur2 INTO V_GRADES_ID,V_COUNT,V_QTY;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
	
    SET @a=@a+1;
	CASE V_GRADES_ID
	WHEN 1 THEN   SET V_GRADES_A=V_GRADES_A+V_COUNT;
	WHEN 2 THEN   SET V_GRADES_B=V_GRADES_B+V_COUNT;
	WHEN 3 THEN   SET V_GRADES_C=V_GRADES_C+V_COUNT;
	WHEN 4 THEN   SET V_GRADES_D=V_GRADES_D+V_COUNT;
	WHEN 5 THEN   SET V_GRADES_E=V_GRADES_E+V_COUNT;
	WHEN 6 THEN   SET V_GRADES_E=V_GRADES_E+V_COUNT;
	END CASE;
  END LOOP;
  -- 总面积 单位平方米 砖统一是800mm*800mm 即0.64m2 另外入库是按箱 需要换成片计算总面积 除了全抛釉3片 其余2片
	SET V_TOTAL_PACK=V_GRADES_A+V_GRADES_B+V_GRADES_C+V_GRADES_D+V_GRADES_E;
	SET V_TOTAL_AREA=V_TOTAL_PACK*V_QTY*0.64;
	INSERT INTO xly_sp_pdt_type 
	(PRODUCT_TYPE,END_MONTH,GRADES_A,GRADES_B,GRADES_C,GRADES_D,GRADES_E,TOTAL_AREA,TOTAL_PACK,SP_TYPE,CREATE_DATE,QTY)
	VALUES(2,V_MONTH,V_GRADES_A,V_GRADES_B,V_GRADES_C,V_GRADES_D,V_GRADES_E,V_TOTAL_AREA,V_TOTAL_PACK,'销售',NOW(),V_QTY);-- 这里全是销售
	SELECT @a,V_GRADES_A,V_GRADES_B,V_GRADES_C,V_GRADES_D,V_GRADES_E,V_TOTAL_PACK,V_TOTAL_AREA;
  CLOSE cur2;
    -- 结束种类2    
  
    -- 这里忘记清除 导致数据不正常
  SET done=FALSE,V_GRADES_A=0,V_GRADES_B=0,V_GRADES_C=0,V_GRADES_D=0,V_GRADES_E=0,V_TOTAL_PACK=0,V_TOTAL_AREA=0;
  OPEN cur3;
    SET @a=0;
  -- 开始循环
  read_loop: LOOP
    -- 提取游标里的数据，这里只有一个，多个的话也一样；
    FETCH cur3 INTO V_GRADES_ID,V_COUNT,V_QTY;
    -- 声明结束的时候
    IF done THEN
      LEAVE read_loop;
    END IF;
	
    SET @a=@a+1;
	CASE V_GRADES_ID
	WHEN 1 THEN   SET V_GRADES_A=V_GRADES_A+V_COUNT;
	WHEN 2 THEN   SET V_GRADES_B=V_GRADES_B+V_COUNT;
	WHEN 3 THEN   SET V_GRADES_C=V_GRADES_C+V_COUNT;
	WHEN 4 THEN   SET V_GRADES_D=V_GRADES_D+V_COUNT;
	WHEN 5 THEN   SET V_GRADES_E=V_GRADES_E+V_COUNT;
	WHEN 6 THEN   SET V_GRADES_E=V_GRADES_E+V_COUNT;
	END CASE;
  END LOOP;
  -- 总面积 单位平方米 砖统一是800mm*800mm 即0.64m2 另外入库是按箱 需要换成片计算总面积 除了全抛釉3片 其余2片
	SET V_TOTAL_PACK=V_GRADES_A+V_GRADES_B+V_GRADES_C+V_GRADES_D+V_GRADES_E;
	SET V_TOTAL_AREA=V_TOTAL_PACK*V_QTY*0.64;
	INSERT INTO xly_sp_pdt_type 
	(PRODUCT_TYPE,END_MONTH,GRADES_A,GRADES_B,GRADES_C,GRADES_D,GRADES_E,TOTAL_AREA,TOTAL_PACK,SP_TYPE,CREATE_DATE,QTY)
	VALUES(3,V_MONTH,V_GRADES_A,V_GRADES_B,V_GRADES_C,V_GRADES_D,V_GRADES_E,V_TOTAL_AREA,V_TOTAL_PACK,'销售',NOW(),V_QTY);-- 这里全是销售
	SELECT @a,V_GRADES_A,V_GRADES_B,V_GRADES_C,V_GRADES_D,V_GRADES_E,V_TOTAL_PACK,V_TOTAL_AREA;
  CLOSE cur3;
    -- 结束种类3    
        -- 统计3个种类的本月所有销量
	SELECT SUM(spt.TOTAL_AREA) INTO  V_MONTH_S FROM xly_sp_pdt_type spt WHERE END_MONTH=V_MONTH AND SP_TYPE='销售' ;
	UPDATE xly_sp_pdt_type SET MONTH_TOTAL_S=V_MONTH_S WHERE END_MONTH=V_MONTH;
	 -- 统计3个种类的本月所有产量
	SELECT SUM(spt.TOTAL_AREA) INTO  V_MONTH_P FROM xly_sp_pdt_type spt WHERE END_MONTH=V_MONTH AND SP_TYPE='生产';
	UPDATE xly_sp_pdt_type SET MONTH_TOTAL_P=V_MONTH_P WHERE END_MONTH=V_MONTH ;
    
	
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `testPrint` */

/*!50003 DROP PROCEDURE IF EXISTS  `testPrint` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `testPrint`(OUT p_out varchar (100))
BEGIN
	set p_out='返回测试成功！';
    END */$$
DELIMITER ;

/* Procedure structure for procedure `unFreezeStock` */

/*!50003 DROP PROCEDURE IF EXISTS  `unFreezeStock` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `unFreezeStock`(OUT p_out VARCHAR (100))
BEGIN
DECLARE F_ID INT (11) ;
DECLARE STOCK_ID int (11) ;
DECLARE STOCK_COUNT INT (11) ;
DECLARE CUR_RECORD CURSOR FOR 
SELECT whf.FREEZE_ID,whf.STOCK_ID ,whf.COUNT FROm  xly_wh_freeze whf 
  WHERE str_to_date(whf.END_DATE,'%Y-%m-%d')<now() and whf.STATE=1;
  DECLARE EXIT HANDLER FOR NOT FOUND CLOSE CUR_RECORD;  
  SET p_out="";
  open CUR_RECORD;
  REPEAT  
  FETCH CUR_RECORD INTO F_ID,STOCK_ID,STOCK_COUNT;  
/**	
 select F_ID,STOCK_ID,STOCK_COUNT;
 **/
	UPDATE `xly_wh_freeze` SET STATE = 0 WHERE FREEZE_ID=F_ID;
    update xly_pdt_stock set STOCK = STOCK+STOCK_COUNT,MODIFY_DATE=now() where ID=STOCK_ID;
    
  SET p_out=p_out+":"+F_ID;    
  UNTIL 0 END REPEAT;
  CLOSE CUR_RECORD;  
  END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

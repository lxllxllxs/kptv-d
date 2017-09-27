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
	SELECT SUM(b.`TOTAL_AMOUNT`) into totalConsumption FROM xly_bill b WHERE b.`CTM_ID`=ctmId;
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

/* Function  structure for function  `getNowMonth` */

/*!50003 DROP FUNCTION IF EXISTS `getNowMonth` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `getNowMonth`() RETURNS varchar(7) CHARSET utf8
BEGIN
	RETURN (SELECT DATE_FORMAT(NOW(),'%Y-%m'));
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

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

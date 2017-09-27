/*
SQLyog Ultimate v11.33 (64 bit)
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

USE `xly`;

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
 `carNo` varchar(25) ,
 `creater` varchar(10) ,
 `driverPhone` varchar(11) ,
 `freight` int(20) ,
 `remark` varchar(35) ,
 `bState` smallint(1) ,
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
 `state` smallint(1) ,
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
 `state` smallint(1) ,
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
 `carNo` varchar(25) ,
 `creater` varchar(10) ,
 `driverPhone` varchar(11) ,
 `freight` int(20) ,
 `remark` varchar(35) ,
 `bState` smallint(1) ,
 `count` int(10) ,
 `price` double ,
 `totalAmount` double ,
 `subTotal` double ,
 `recordId` int(10) ,
 `stockId` int(10) ,
 `warehouse` varchar(10) ,
 `state` smallint(1) ,
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

/*Table structure for table `v_buy_record` */

DROP TABLE IF EXISTS `v_buy_record`;

/*!50001 DROP VIEW IF EXISTS `v_buy_record` */;
/*!50001 DROP TABLE IF EXISTS `v_buy_record` */;

/*!50001 CREATE TABLE  `v_buy_record`(
 `billNo` int(10) ,
 `billTime` varchar(20) ,
 `billType` varchar(35) ,
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
 `salesMgrId` int(10) ,
 `stockId` int(10) ,
 `warehouse` varchar(10) ,
 `state` smallint(1) ,
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
 `ca` varchar(52) ,
 `money` text ,
 `avlMoney` double ,
 `grtMoney` int(11) ,
 `debt` int(11) ,
 `salesMgrName` varchar(10) 
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
 `carNo` varchar(25) ,
 `creater` varchar(10) ,
 `driverPhone` varchar(11) ,
 `freight` int(20) ,
 `remark` varchar(35) ,
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
 `state` smallint(1) ,
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
 `brandName` varchar(10) ,
 `typeName` varchar(10) ,
 `categort` varchar(10) ,
 `color` varchar(10) ,
 `gradesName` varchar(10) ,
 `patternNo` varchar(10) ,
 `specName` varchar(10) 
)*/;

/*Table structure for table `v_group_pdt_type` */

DROP TABLE IF EXISTS `v_group_pdt_type`;

/*!50001 DROP VIEW IF EXISTS `v_group_pdt_type` */;
/*!50001 DROP TABLE IF EXISTS `v_group_pdt_type` */;

/*!50001 CREATE TABLE  `v_group_pdt_type`(
 `billTime` varchar(20) ,
 `pdtTypeName` varchar(10) ,
 `pdtTypeId` int(10) ,
 `buySum` decimal(32,0) 
)*/;

/*Table structure for table `v_groupbybrand` */

DROP TABLE IF EXISTS `v_groupbybrand`;

/*!50001 DROP VIEW IF EXISTS `v_groupbybrand` */;
/*!50001 DROP TABLE IF EXISTS `v_groupbybrand` */;

/*!50001 CREATE TABLE  `v_groupbybrand`(
 `billTime` varchar(20) ,
 `brandId` int(10) ,
 `brandName` varchar(10) ,
 `ctmId` int(10) ,
 `buySum` decimal(32,0) 
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

/*Table structure for table `v_product` */

DROP TABLE IF EXISTS `v_product`;

/*!50001 DROP VIEW IF EXISTS `v_product` */;
/*!50001 DROP TABLE IF EXISTS `v_product` */;

/*!50001 CREATE TABLE  `v_product`(
 `ID` int(11) ,
 `CATEGORT` varchar(10) ,
 `COLOR` varchar(10) ,
 `GRADES_ID` int(10) ,
 `PATTERN_NO` varchar(10) ,
 `SPEC_ID` int(5) ,
 `TYPE_BRAND_ID` int(10) ,
 `BRAND_ID` int(10) ,
 `BENCHMARK` double ,
 `TYPE_ID` int(10) 
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
 `carNo` varchar(25) ,
 `creater` varchar(10) ,
 `driverPhone` varchar(11) ,
 `freight` int(20) ,
 `totalAmount` double ,
 `ctmId` int(10) ,
 `salesMgrId` int(10) ,
 `remark` varchar(35) 
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
 `CREATE_DATE` date ,
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
 `STATE` smallint(1) ,
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

/*View structure for view v_balrecord */

/*!50001 DROP TABLE IF EXISTS `v_balrecord` */;
/*!50001 DROP VIEW IF EXISTS `v_balrecord` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_balrecord` AS select `br`.`BAL_ID` AS `balId`,`br`.`CREATER` AS `creater`,`br`.`CREATE_TIME` AS `createTime`,`br`.`OPT_TYPE` AS `optType`,`br`.`COLLECTION_TYPE` AS `collectionType`,`ctm`.`CTM_NAME` AS `ctmName`,`ctm`.`CTM_ID` AS `ctmId`,`vm`.`salesMgrName` AS `salesMgrName`,`br`.`AMOUNT` AS `amount`,`br`.`REMARK` AS `remark`,`ctm`.`ADDRESS` AS `address` from ((`xly_bal_record` `br` join `xly_customer` `ctm`) join `v_mgr` `vm`) where ((`ctm`.`CTM_ID` = `br`.`CTM_ID`) and (`vm`.`salesMgrId` = `ctm`.`SALES_MGR_ID`)) order by `br`.`BAL_ID` desc */;

/*View structure for view v_billrecord */

/*!50001 DROP TABLE IF EXISTS `v_billrecord` */;
/*!50001 DROP VIEW IF EXISTS `v_billrecord` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_billrecord` AS select `b`.`BILL_NO` AS `billNo`,lpad(`b`.`BILL_NO`,7,0) AS `billNoStr`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`CAR_NO` AS `carNo`,`b`.`CREATER` AS `creater`,`b`.`DRIVER_PHONE` AS `driverPhone`,`b`.`FREIGHT` AS `freight`,`b`.`REMARK` AS `remark`,`b`.`STATE` AS `bState`,`b`.`SALES_MGR_ID` AS `salesMgrId`,`br`.`COUNT` AS `count`,`br`.`PRICE` AS `price`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,((`br`.`COUNT` * `br`.`PRICE`) * `vs`.`QTY`) AS `subTotal`,`br`.`BENCHMARK` AS `benchmark`,`br`.`RECORD_ID` AS `recordId`,`ctm`.`CTM_NAME` AS `ctmName`,`ctm`.`CTM_ID` AS `ctmId`,`ctm`.`ADDRESS` AS `address`,`vs`.`STOCK_ID` AS `stockId`,`vs`.`WAREHOUSE` AS `warehouse`,`vs`.`STATE` AS `state`,`vs`.`STOCK` AS `stock`,`vs`.`ID` AS `id`,`vs`.`CATEGORT` AS `categort`,`vs`.`COLOR` AS `color`,`vs`.`PATTERN_NO` AS `patternNo`,`vs`.`BRAND_NAME` AS `brandName`,`vs`.`BRAND_ID` AS `brandId`,`vs`.`GRADES_NAME` AS `gradesName`,`vs`.`SPEC_ID` AS `specId`,`vs`.`SPEC_NAME` AS `specName`,`vs`.`TYPE_NAME` AS `typeName`,`vs`.`QTY` AS `qty`,(`br`.`COUNT` * `vs`.`QTY`) AS `qtyCount`,`vs`.`GRADES_ID` AS `gradesId`,`vs`.`TYPE_ID` AS `typeId`,`mgr`.`salesMgrName` AS `mgrName` from ((((`xly_bill` `b` join `xly_bill_record` `br`) join `xly_customer` `ctm`) join `v_mgr` `mgr`) join `v_stock` `vs`) where ((`b`.`BILL_NO` = `br`.`BILL_NO`) and (`b`.`CTM_ID` = `ctm`.`CTM_ID`) and (`mgr`.`salesMgrId` = `b`.`SALES_MGR_ID`) and (`br`.`STOCK_ID` = `vs`.`STOCK_ID`)) order by `b`.`BILL_NO` desc */;

/*View structure for view v_billrecord_fake */

/*!50001 DROP TABLE IF EXISTS `v_billrecord_fake` */;
/*!50001 DROP VIEW IF EXISTS `v_billrecord_fake` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_billrecord_fake` AS select `b`.`BILL_NO` AS `billNo`,lpad(`b`.`BILL_NO`,7,0) AS `billNoStr`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`CAR_NO` AS `carNo`,`b`.`CREATER` AS `creater`,`b`.`DRIVER_PHONE` AS `driverPhone`,`b`.`FREIGHT` AS `freight`,`b`.`REMARK` AS `remark`,`b`.`STATE` AS `bState`,`br`.`COUNT` AS `count`,`br`.`PRICE` AS `price`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,((`br`.`COUNT` * `br`.`PRICE`) * `vs`.`QTY`) AS `subTotal`,`br`.`RECORD_ID` AS `recordId`,`ctm`.`CTM_NAME` AS `ctmName`,`ctm`.`CTM_ID` AS `ctmId`,`ctm`.`ADDRESS` AS `address`,`ctm`.`SALES_MGR_ID` AS `salesMgrId`,`vs`.`STOCK_ID` AS `stockId`,`vs`.`WAREHOUSE` AS `warehouse`,`vs`.`STATE` AS `state`,`vs`.`STOCK` AS `stock`,`vs`.`ID` AS `id`,`vs`.`CATEGORT` AS `categort`,`vs`.`COLOR` AS `color`,`vs`.`PATTERN_NO` AS `patternNo`,`vs`.`BRAND_NAME` AS `brandName`,`vs`.`BRAND_ID` AS `brandId`,`vs`.`GRADES_NAME` AS `gradesName`,`vs`.`SPEC_ID` AS `specId`,`vs`.`SPEC_NAME` AS `specName`,`vs`.`TYPE_NAME` AS `typeName`,`vs`.`QTY` AS `qty`,(`br`.`COUNT` * `vs`.`QTY`) AS `qtyCount`,`vs`.`GRADES_ID` AS `gradesId`,`vs`.`TYPE_ID` AS `typeId`,`mgr`.`salesMgrName` AS `mgrName` from ((((`xly_bill_fake` `b` join `xly_bill_record_fake` `br`) join `xly_customer` `ctm`) join `v_mgr` `mgr`) join `v_stock` `vs`) where ((`b`.`BILL_NO` = `br`.`BILL_NO`) and (`b`.`CTM_ID` = `ctm`.`CTM_ID`) and (`mgr`.`salesMgrId` = `ctm`.`SALES_MGR_ID`) and (`br`.`STOCK_ID` = `vs`.`STOCK_ID`)) order by `b`.`BILL_NO` desc */;

/*View structure for view v_billrecord_simple */

/*!50001 DROP TABLE IF EXISTS `v_billrecord_simple` */;
/*!50001 DROP VIEW IF EXISTS `v_billrecord_simple` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_billrecord_simple` AS select `b`.`BILL_NO` AS `billNo`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`STATE` AS `bState`,`br`.`COUNT` AS `count`,`br`.`PRICE` AS `price`,`br`.`BENCHMARK` AS `benchmark`,`b`.`SALES_MGR_ID` AS `salesMgrId`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,((`br`.`COUNT` * `br`.`PRICE`) * `vs`.`QTY`) AS `subTotal`,`ctm`.`CTM_NAME` AS `ctmName`,`ctm`.`CTM_ID` AS `ctmId`,`ctm`.`ADDRESS` AS `address`,`vs`.`BRAND_NAME` AS `brandName`,`vs`.`BRAND_ID` AS `brandId`,`vs`.`GRADES_NAME` AS `gradesName`,`vs`.`TYPE_NAME` AS `typeName`,`vs`.`QTY` AS `qty`,(`br`.`COUNT` * `vs`.`QTY`) AS `qtyCount`,`vs`.`GRADES_ID` AS `gradesId`,`vs`.`TYPE_ID` AS `typeId`,`mgr`.`salesMgrName` AS `mgrName` from ((((`xly_bill` `b` join `xly_bill_record` `br`) join `xly_customer` `ctm`) join `v_mgr` `mgr`) join `v_stock` `vs`) where ((`b`.`BILL_NO` = `br`.`BILL_NO`) and (`b`.`STATE` = 1) and (`b`.`CTM_ID` = `ctm`.`CTM_ID`) and (`mgr`.`salesMgrId` = `ctm`.`SALES_MGR_ID`) and (`br`.`STOCK_ID` = `vs`.`STOCK_ID`)) order by `b`.`BILL_NO` desc */;

/*View structure for view v_billrecord_sp */

/*!50001 DROP TABLE IF EXISTS `v_billrecord_sp` */;
/*!50001 DROP VIEW IF EXISTS `v_billrecord_sp` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_billrecord_sp` AS select `b`.`BILL_NO` AS `billNo`,lpad(`b`.`BILL_NO`,7,0) AS `billNoStr`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`CAR_NO` AS `carNo`,`b`.`CREATER` AS `creater`,`b`.`DRIVER_PHONE` AS `driverPhone`,`b`.`FREIGHT` AS `freight`,`b`.`REMARK` AS `remark`,`b`.`STATE` AS `bState`,`br`.`COUNT` AS `count`,`br`.`PRICE` AS `price`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,((`br`.`COUNT` * `br`.`PRICE`) * `vs`.`QTY`) AS `subTotal`,`br`.`RECORD_ID` AS `recordId`,`vs`.`STOCK_ID` AS `stockId`,`vs`.`WAREHOUSE` AS `warehouse`,`vs`.`STATE` AS `state`,`vs`.`STOCK` AS `stock`,`vs`.`ID` AS `id`,`vs`.`CATEGORT` AS `categort`,`vs`.`COLOR` AS `color`,`vs`.`PATTERN_NO` AS `patternNo`,`vs`.`BRAND_NAME` AS `brandName`,`vs`.`BRAND_ID` AS `brandId`,`vs`.`GRADES_NAME` AS `gradesName`,`vs`.`SPEC_ID` AS `specId`,`vs`.`SPEC_NAME` AS `specName`,`vs`.`TYPE_NAME` AS `typeName`,`vs`.`QTY` AS `qty`,(`br`.`COUNT` * `vs`.`QTY`) AS `qtyCount`,`vs`.`GRADES_ID` AS `gradesId`,`vs`.`TYPE_ID` AS `typeId` from ((`xly_bill` `b` join `xly_bill_record` `br`) join `v_stock` `vs`) where ((`b`.`BILL_NO` = `br`.`BILL_NO`) and (`br`.`STOCK_ID` = `vs`.`STOCK_ID`) and (`b`.`STATE` = 1)) order by `b`.`BILL_NO` desc */;

/*View structure for view v_buy_record */

/*!50001 DROP TABLE IF EXISTS `v_buy_record` */;
/*!50001 DROP VIEW IF EXISTS `v_buy_record` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_buy_record` AS select `b`.`BILL_NO` AS `billNo`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`FREIGHT` AS `freight`,`b`.`REMARK` AS `remark`,`b`.`STATE` AS `bState`,`br`.`COUNT` AS `count`,`br`.`PRICE` AS `price`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,((`br`.`COUNT` * `br`.`PRICE`) * `vs`.`QTY`) AS `subTotal`,`br`.`RECORD_ID` AS `recordId`,`ctm`.`CTM_NAME` AS `ctmName`,`ctm`.`CTM_ID` AS `ctmId`,`b`.`SALES_MGR_ID` AS `salesMgrId`,`vs`.`STOCK_ID` AS `stockId`,`vs`.`WAREHOUSE` AS `warehouse`,`vs`.`STATE` AS `state`,`vs`.`STOCK` AS `stock`,`vs`.`BRAND_NAME` AS `brandName`,`vs`.`BRAND_ID` AS `brandId`,`vs`.`GRADES_NAME` AS `gradesName`,`vs`.`TYPE_NAME` AS `typeName`,`vs`.`QTY` AS `qty`,(`br`.`COUNT` * `vs`.`QTY`) AS `qtyCount`,`vs`.`GRADES_ID` AS `gradesId`,`vs`.`TYPE_ID` AS `typeId`,`mgr`.`salesMgrName` AS `salesMgrName` from ((((`xly_bill` `b` join `xly_bill_record` `br`) join `xly_customer` `ctm`) join `v_mgr` `mgr`) join `v_stock` `vs`) where ((`b`.`BILL_NO` = `br`.`BILL_NO`) and (`b`.`CTM_ID` = `ctm`.`CTM_ID`) and (`b`.`STATE` = 1) and (`mgr`.`salesMgrId` = `b`.`SALES_MGR_ID`) and (`br`.`STOCK_ID` = `vs`.`STOCK_ID`)) */;

/*View structure for view v_customer */

/*!50001 DROP TABLE IF EXISTS `v_customer` */;
/*!50001 DROP VIEW IF EXISTS `v_customer` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_customer` AS select `cmt`.`CTM_ID` AS `ctmId`,`cmt`.`CTM_NAME` AS `ctmName`,`cmt`.`TYPE_ID` AS `typeId`,`cmt`.`ADDRESS` AS `address`,`cmt`.`SHOP_NAME` AS `shopName`,`cmt`.`SALES_MGR_ID` AS `salesMgrId`,concat(`cmt`.`CTM_NAME`,'--',`cmt`.`ADDRESS`) AS `ca`,convert(decode(`cmt`.`MONEY`,'xly') using utf8) AS `money`,((decode(`cmt`.`MONEY`,'xly') - `cmt`.`GRT_MONEY`) + `cmt`.`DEBT`) AS `avlMoney`,`cmt`.`GRT_MONEY` AS `grtMoney`,`cmt`.`DEBT` AS `debt`,`mgr`.`SALES_MGR_NAME` AS `salesMgrName` from (`xly_customer` `cmt` join `bdf2_user_position` `mgr`) where (`mgr`.`SALES_MGR_ID` = `cmt`.`SALES_MGR_ID`) order by `cmt`.`CTM_ID` desc */;

/*View structure for view v_drop_record */

/*!50001 DROP TABLE IF EXISTS `v_drop_record` */;
/*!50001 DROP VIEW IF EXISTS `v_drop_record` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_drop_record` AS select `db`.`BILL_NO` AS `BILL_NO`,`db`.`CREATER` AS `dropCreater`,`db`.`CREATE_DATE` AS `dropDate`,`db`.`REASON` AS `reason`,`vb`.`billNo` AS `billNo`,`vb`.`billNoStr` AS `billNoStr`,`vb`.`billTime` AS `billTime`,`vb`.`billType` AS `billType`,`vb`.`carNo` AS `carNo`,`vb`.`creater` AS `creater`,`vb`.`driverPhone` AS `driverPhone`,`vb`.`freight` AS `freight`,`vb`.`remark` AS `remark`,`vb`.`bState` AS `bState`,`vb`.`count` AS `count`,`vb`.`price` AS `price`,`vb`.`subTotal` AS `subTotal`,`vb`.`recordId` AS `recordId`,`vb`.`ctmName` AS `ctmName`,`vb`.`ctmId` AS `ctmId`,`vb`.`address` AS `address`,`vb`.`salesMgrId` AS `salesMgrId`,`vb`.`stockId` AS `stockId`,`vb`.`warehouse` AS `warehouse`,`vb`.`state` AS `state`,`vb`.`stock` AS `stock`,`vb`.`id` AS `id`,`vb`.`categort` AS `categort`,`vb`.`color` AS `color`,`vb`.`patternNo` AS `patternNo`,`vb`.`brandName` AS `brandName`,`vb`.`brandId` AS `brandId`,`vb`.`gradesName` AS `gradesName`,`vb`.`specId` AS `specId`,`vb`.`specName` AS `specName`,`vb`.`typeName` AS `typeName`,`vb`.`qty` AS `qty`,`vb`.`gradesId` AS `gradesId`,`vb`.`typeId` AS `typeId`,`vb`.`mgrName` AS `mgrName` from (`xly_drop_bill` `db` join `v_billrecord` `vb`) where (`db`.`BILL_NO` = `vb`.`billNo`) */;

/*View structure for view v_freeze */

/*!50001 DROP TABLE IF EXISTS `v_freeze` */;
/*!50001 DROP VIEW IF EXISTS `v_freeze` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_freeze` AS select `whf`.`FREEZE_ID` AS `freezeId`,`whf`.`STOCK_ID` AS `stockId`,`whf`.`WAREHOUSE` AS `warehouse`,`ctm`.`CTM_NAME` AS `ctmName`,`ctm`.`ADDRESS` AS `address`,`whf`.`CTM_ID` AS `ctmId`,`whf`.`COUNT` AS `count`,`whf`.`CREATE_TIME` AS `createTime`,`whf`.`CREATER` AS `creater`,`whf`.`END_DATE` AS `endDate`,`whf`.`REMARK` AS `remark`,`whf`.`STATE` AS `state`,`vp`.`BRAND_NAME` AS `brandName`,`vp`.`TYPE_NAME` AS `typeName`,`vp`.`CATEGORT` AS `categort`,`vp`.`COLOR` AS `color`,`vp`.`GRADES_NAME` AS `gradesName`,`vp`.`PATTERN_NO` AS `patternNo`,`vp`.`SPEC_NAME` AS `specName` from (((`xly_customer` `ctm` join `xly_wh_freeze` `whf`) join `xly_pdt_stock` `pdts`) join `v_productall` `vp`) where ((`ctm`.`CTM_ID` = `whf`.`CTM_ID`) and (`whf`.`STOCK_ID` = `pdts`.`ID`) and (`pdts`.`PRODUCT_ID` = `vp`.`ID`) and (`whf`.`STATE` = 1)) order by `whf`.`FREEZE_ID` desc */;

/*View structure for view v_group_pdt_type */

/*!50001 DROP TABLE IF EXISTS `v_group_pdt_type` */;
/*!50001 DROP VIEW IF EXISTS `v_group_pdt_type` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_group_pdt_type` AS select `xym`.`ym` AS `billTime`,`vb`.`typeName` AS `pdtTypeName`,`vb`.`typeId` AS `pdtTypeId`,sum(`vb`.`count`) AS `buySum` from (`xly_year_month` `xym` left join `v_billrecord` `vb` on((left(`vb`.`billTime`,7) = `xym`.`ym`))) where (str_to_date(`xym`.`ym`,'%Y-%m-%d') between (now() - interval 1 year) and now()) group by `xym`.`ym` order by `xym`.`ym` */;

/*View structure for view v_groupbybrand */

/*!50001 DROP TABLE IF EXISTS `v_groupbybrand` */;
/*!50001 DROP VIEW IF EXISTS `v_groupbybrand` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_groupbybrand` AS select `xym`.`ym` AS `billTime`,`vb`.`brandId` AS `brandId`,`vb`.`brandName` AS `brandName`,`vb`.`ctmId` AS `ctmId`,sum(`vb`.`count`) AS `buySum` from (`xly_year_month` `xym` left join `v_billrecord` `vb` on((left(`vb`.`billTime`,7) = `xym`.`ym`))) where (str_to_date(`xym`.`ym`,'%Y-%m-%d') between (now() - interval 1 year) and now()) group by `xym`.`ym`,`vb`.`ctmId`,`vb`.`brandId` order by `xym`.`ym` */;

/*View structure for view v_mgr */

/*!50001 DROP TABLE IF EXISTS `v_mgr` */;
/*!50001 DROP VIEW IF EXISTS `v_mgr` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_mgr` AS select `up`.`POSITION_ID_` AS `positionId`,`up`.`SALES_MGR_ID` AS `salesMgrId`,`up`.`SALES_MGR_NAME` AS `salesMgrName` from (`bdf2_user` `u` join `bdf2_user_position` `up`) where ((`u`.`USERNAME_` = `up`.`USERNAME_`) and (`up`.`POSITION_ID_` = '1')) */;

/*View structure for view v_patternno_grade */

/*!50001 DROP TABLE IF EXISTS `v_patternno_grade` */;
/*!50001 DROP VIEW IF EXISTS `v_patternno_grade` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_patternno_grade` AS select sum(`vb`.`count`) AS `sum`,`vb`.`billTime` AS `billTime`,`vb`.`typeId` AS `typeId`,`vb`.`typeName` AS `typeName`,`vb`.`brandId` AS `brandId`,`vb`.`brandName` AS `brandName`,`vb`.`patternNo` AS `patternNo`,`vb`.`gradesId` AS `gradesId`,`vb`.`gradesName` AS `gradesName` from `v_billrecord` `vb` where ((`vb`.`bState` = 1) and (`vb`.`gradesId` < 5)) group by `vb`.`typeId`,`vb`.`patternNo`,`vb`.`gradesId` order by `vb`.`typeId`,`vb`.`brandId`,`vb`.`patternNo`,`vb`.`gradesId` */;

/*View structure for view v_product */

/*!50001 DROP TABLE IF EXISTS `v_product` */;
/*!50001 DROP VIEW IF EXISTS `v_product` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_product` AS select `p`.`ID` AS `ID`,`p`.`CATEGORT` AS `CATEGORT`,`p`.`COLOR` AS `COLOR`,`p`.`GRADES_ID` AS `GRADES_ID`,`p`.`PATTERN_NO` AS `PATTERN_NO`,`p`.`SPEC_ID` AS `SPEC_ID`,`p`.`TYPE_BRAND_ID` AS `TYPE_BRAND_ID`,`ptb`.`BRAND_ID` AS `BRAND_ID`,`tgb`.`BENCH_MARK` AS `BENCHMARK`,`ptb`.`TYPE_ID` AS `TYPE_ID` from ((`xly_product` `p` join `xly_pdt_typ_bra` `ptb`) join `xly_pdt_typ_gd_bm` `tgb`) where ((`p`.`TYPE_BRAND_ID` = `ptb`.`ID`) and (`tgb`.`TYPE_ID` = `ptb`.`TYPE_ID`) and (`tgb`.`GRADES_ID` = `p`.`GRADES_ID`)) */;

/*View structure for view v_productall */

/*!50001 DROP TABLE IF EXISTS `v_productall` */;
/*!50001 DROP VIEW IF EXISTS `v_productall` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_productall` AS select `vp`.`ID` AS `ID`,`pt`.`TYPE_NAME` AS `TYPE_NAME`,`pb`.`BRAND_NAME` AS `BRAND_NAME`,`vp`.`CATEGORT` AS `CATEGORT`,`vp`.`TYPE_BRAND_ID` AS `TYPE_BRAND_ID`,`vp`.`COLOR` AS `COLOR`,`vp`.`BENCHMARK` AS `BENCHMARK`,`vp`.`PATTERN_NO` AS `PATTERN_NO`,`vp`.`BRAND_ID` AS `BRAND_ID`,`pg`.`GRADES_ID` AS `GRADES_ID`,`pg`.`GRADES_NAME` AS `GRADES_NAME`,`ps`.`SPEC_NAME` AS `SPEC_NAME`,`pt`.`QTY` AS `QTY`,`pt`.`TYPE_ID` AS `TYPE_ID`,`ps`.`SPEC_ID` AS `SPEC_ID` from ((((`v_product` `vp` join `xly_pdt_bra` `pb`) join `xly_pdt_gd` `pg`) join `xly_pdt_spec` `ps`) join `xly_pdt_typ` `pt`) where ((`vp`.`BRAND_ID` = `pb`.`BRAND_ID`) and (`vp`.`GRADES_ID` = `pg`.`GRADES_ID`) and (`vp`.`SPEC_ID` = `ps`.`SPEC_ID`) and (`vp`.`TYPE_ID` = `pt`.`TYPE_ID`)) */;

/*View structure for view v_simple_bill */

/*!50001 DROP TABLE IF EXISTS `v_simple_bill` */;
/*!50001 DROP VIEW IF EXISTS `v_simple_bill` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_simple_bill` AS select `b`.`BILL_NO` AS `billNo`,lpad(`b`.`BILL_NO`,7,0) AS `billNoStr`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`CAR_NO` AS `carNo`,`b`.`CREATER` AS `creater`,`b`.`DRIVER_PHONE` AS `driverPhone`,`b`.`FREIGHT` AS `freight`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,`b`.`CTM_ID` AS `ctmId`,`b`.`SALES_MGR_ID` AS `salesMgrId`,`b`.`REMARK` AS `remark` from (`xly_bill` `b` join `xly_customer` `ctm`) where ((`b`.`CTM_ID` = `ctm`.`CTM_ID`) and (`b`.`STATE` = 1)) order by `b`.`BILL_NO` desc */;

/*View structure for view v_simple_bill_fake */

/*!50001 DROP TABLE IF EXISTS `v_simple_bill_fake` */;
/*!50001 DROP VIEW IF EXISTS `v_simple_bill_fake` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_simple_bill_fake` AS select `b`.`BILL_NO` AS `billNo`,lpad(`b`.`BILL_NO`,7,0) AS `billNoStr`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`CAR_NO` AS `carNo`,`b`.`CREATER` AS `creater`,`b`.`DRIVER_PHONE` AS `driverPhone`,`b`.`FREIGHT` AS `freight`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,`b`.`CTM_ID` AS `ctmId`,`b`.`REMARK` AS `remark` from `xly_bill_fake` `b` */;

/*View structure for view v_sp_pdt_type */

/*!50001 DROP TABLE IF EXISTS `v_sp_pdt_type` */;
/*!50001 DROP VIEW IF EXISTS `v_sp_pdt_type` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_sp_pdt_type` AS select `xspt`.`SP_ID` AS `SP_ID`,`xspt`.`PRODUCT_TYPE` AS `PRODUCT_TYPE`,`xspt`.`END_MONTH` AS `END_MONTH`,`xspt`.`GRADES_A` AS `GRADES_A`,`xspt`.`GRADES_B` AS `GRADES_B`,`xspt`.`GRADES_C` AS `GRADES_C`,`xspt`.`GRADES_D` AS `GRADES_D`,`xspt`.`GRADES_E` AS `GRADES_E`,`xspt`.`TOTAL_PACK` AS `TOTAL_PACK`,`xspt`.`CREATE_DATE` AS `CREATE_DATE`,`xspt`.`TOTAL_AREA` AS `TOTAL_AREA`,`xspt`.`SP_TYPE` AS `SP_TYPE`,`xspt`.`SALE_PERCENT` AS `SALE_PERCENT`,`xspt`.`REMARK` AS `REMARK`,`xpt`.`TYPE_ID` AS `TYPE_ID`,`xpt`.`TYPE_NAME` AS `TYPE_NAME`,`xpt`.`QTY` AS `QTY` from (`xly_sp_pdt_type` `xspt` join `xly_pdt_typ` `xpt`) where (`xspt`.`PRODUCT_TYPE` = `xpt`.`TYPE_ID`) */;

/*View structure for view v_stock */

/*!50001 DROP TABLE IF EXISTS `v_stock` */;
/*!50001 DROP VIEW IF EXISTS `v_stock` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_stock` AS select `ps`.`ID` AS `STOCK_ID`,`ps`.`WAREHOUSE` AS `WAREHOUSE`,`ps`.`STATE` AS `STATE`,`ps`.`STOCK` AS `STOCK`,`vp`.`ID` AS `ID`,`vp`.`CATEGORT` AS `CATEGORT`,`vp`.`COLOR` AS `COLOR`,`vp`.`PATTERN_NO` AS `PATTERN_NO`,`vp`.`BRAND_NAME` AS `BRAND_NAME`,`vp`.`BRAND_ID` AS `BRAND_ID`,`vp`.`GRADES_NAME` AS `GRADES_NAME`,`vp`.`SPEC_ID` AS `SPEC_ID`,`vp`.`SPEC_NAME` AS `SPEC_NAME`,`vp`.`BENCHMARK` AS `BENCHMARK`,`vp`.`TYPE_NAME` AS `TYPE_NAME`,`vp`.`QTY` AS `QTY`,`vp`.`GRADES_ID` AS `GRADES_ID`,`vp`.`TYPE_ID` AS `TYPE_ID` from (`xly_pdt_stock` `ps` join `v_productall` `vp`) where (`ps`.`PRODUCT_ID` = `vp`.`ID`) */;

/*View structure for view v_type_bra */

/*!50001 DROP TABLE IF EXISTS `v_type_bra` */;
/*!50001 DROP VIEW IF EXISTS `v_type_bra` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_type_bra` AS select `ptb`.`ID` AS `ID`,`pb`.`BRAND_ID` AS `BRAND_ID`,`pb`.`BRAND_NAME` AS `BRAND_NAME`,`pt`.`TYPE_ID` AS `TYPE_ID`,`pt`.`TYPE_NAME` AS `TYPE_NAME`,`pt`.`QTY` AS `QTY` from ((`xly_pdt_typ_bra` `ptb` join `xly_pdt_typ` `pt`) join `xly_pdt_bra` `pb`) where ((`ptb`.`BRAND_ID` = `pb`.`BRAND_ID`) and (`ptb`.`TYPE_ID` = `pt`.`TYPE_ID`)) */;

/*View structure for view v_warerecord */

/*!50001 DROP TABLE IF EXISTS `v_warerecord` */;
/*!50001 DROP VIEW IF EXISTS `v_warerecord` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_warerecord` AS select `vp`.`ID` AS `PRODUCT_ID`,`vp`.`TYPE_NAME` AS `TYPE_NAME`,`vp`.`TYPE_ID` AS `TYPE_ID`,`vp`.`BRAND_NAME` AS `BRAND_NAME`,`vp`.`BRAND_ID` AS `BRAND_ID`,`vp`.`CATEGORT` AS `CATEGORT`,`vp`.`COLOR` AS `COLOR`,`vp`.`GRADES_NAME` AS `GRADES_NAME`,`vp`.`GRADES_ID` AS `GRADES_ID`,`vp`.`PATTERN_NO` AS `PATTERN_NO`,`vp`.`QTY` AS `QTY`,`vp`.`SPEC_NAME` AS `SPEC_NAME`,`whr`.`ID` AS `RECORD_ID`,`whr`.`WAREHOUSE` AS `WAREHOUSE`,`whr`.`STOCK` AS `STOCK`,`whr`.`CREATE_DATE` AS `CREATE_DATE`,`whr`.`CREATER` AS `CREATER`,`whr`.`PRODUCED_DATE` AS `PRODUCED_DATE`,`whr`.`REMARK` AS `REMARK`,`cla`.`CLASSES_ID` AS `CLASSES_ID`,`cla`.`CLASSES_NAME` AS `CLASSES_NAME`,`wht`.`TYPE_ID` AS `OPT_ID`,`wht`.`TYPE_NAME` AS `OPT_TYPE` from (((`xly_wh_record` `whr` join `v_productall` `vp`) join `xly_classes` `cla`) join `xly_wh_type` `wht`) where ((`whr`.`PRODUCT_ID` = `vp`.`ID`) and (`whr`.`CLASSES_ID` = `cla`.`CLASSES_ID`) and (`whr`.`TYPE_ID` = `wht`.`TYPE_ID`)) order by `whr`.`ID` desc */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

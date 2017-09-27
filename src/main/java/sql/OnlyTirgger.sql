/*
SQLyog Enterprise v12.09 (64 bit)
MySQL - 5.5.53 : Database - xly
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

/* Trigger structure for table `bdf2_user` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `del-user-position` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `del-user-position` BEFORE DELETE ON `bdf2_user` FOR EACH ROW BEGIN
	DELETE FROM bdf2_user_position WHERE SALES_MGR_NAME=old.CNAME_;
    END */$$


DELIMITER ;

/* Trigger structure for table `bdf2_user_position` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `updateMgrName` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `updateMgrName` BEFORE INSERT ON `bdf2_user_position` FOR EACH ROW BEGIN
	set NEW.SALES_MGR_NAME=getMgrName(NEW.USERNAME_);
    END */$$


DELIMITER ;

/* Trigger structure for table `xly_ctm_bal` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `ctm-bal-createdate` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `ctm-bal-createdate` BEFORE INSERT ON `xly_ctm_bal` FOR EACH ROW BEGIN
	SET NEW.CREATE_DATE=NOW();
    END */$$


DELIMITER ;

/* Trigger structure for table `xly_customer` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `setCtmMoney` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `setCtmMoney` BEFORE INSERT ON `xly_customer` FOR EACH ROW BEGIN
	IF NEW.MONEY IS NULL OR LENGTH(NEW.MONEY)<1 THEN
	SET  NEW.MONEY=ENCODE(NEW.IMPORT_MONEY,'xly');
	END IF;
    END */$$


DELIMITER ;

/* Trigger structure for table `xly_sale_pattern` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `sale-pattern-createdate` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `sale-pattern-createdate` BEFORE INSERT ON `xly_sale_pattern` FOR EACH ROW BEGIN
    SET NEW.CREATE_DATE=NOW();
    END */$$


DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

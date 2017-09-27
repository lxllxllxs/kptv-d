/*
SQLyog v10.2 
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

/*Table structure for table `bdf2_company` */

DROP TABLE IF EXISTS `bdf2_company`;

CREATE TABLE `bdf2_company` (
  `ID_` varchar(60) NOT NULL,
  `DESC_` varchar(120) DEFAULT NULL,
  `NAME_` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_company` */

insert  into `bdf2_company`(`ID_`,`DESC_`,`NAME_`) values ('xly','','白银新乐雅陶瓷有限公司');

/*Table structure for table `bdf2_component` */

DROP TABLE IF EXISTS `bdf2_component`;

CREATE TABLE `bdf2_component` (
  `ID_` varchar(60) NOT NULL,
  `COMPONENT_ID_` varchar(60) NOT NULL,
  `DESC_` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_component` */

/*Table structure for table `bdf2_dept` */

DROP TABLE IF EXISTS `bdf2_dept`;

CREATE TABLE `bdf2_dept` (
  `ID_` varchar(60) NOT NULL,
  `COMPANY_ID_` varchar(60) DEFAULT NULL,
  `CREATE_DATE_` datetime DEFAULT NULL,
  `DESC_` varchar(120) DEFAULT NULL,
  `NAME_` varchar(60) DEFAULT NULL,
  `PARENT_ID_` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_dept` */

/*Table structure for table `bdf2_excel_model` */

DROP TABLE IF EXISTS `bdf2_excel_model`;

CREATE TABLE `bdf2_excel_model` (
  `ID_` varchar(60) NOT NULL,
  `COMMENT_` varchar(120) DEFAULT NULL,
  `COMPANYID_` varchar(60) DEFAULT NULL,
  `CREATE_DATE_` datetime DEFAULT NULL,
  `DATASOURCE_NAME_` varchar(60) DEFAULT NULL,
  `DB_TYPE_` varchar(60) DEFAULT NULL,
  `END_COLUMN_` int(11) DEFAULT NULL,
  `END_ROW_` int(11) DEFAULT NULL,
  `EXCEL_SHEET_NAME_` varchar(60) DEFAULT NULL,
  `HELP_DOC_` varchar(60) DEFAULT NULL,
  `NAME_` varchar(60) DEFAULT NULL,
  `PRIMARYKEY_` varchar(60) DEFAULT NULL,
  `PRIMARYKEY_TYPE_` varchar(60) DEFAULT NULL,
  `PROCESSOR_` varchar(120) DEFAULT NULL,
  `SEQUENCE_NAME_` varchar(120) DEFAULT NULL,
  `START_COLUMN_` int(11) DEFAULT NULL,
  `START_ROW_` int(11) DEFAULT NULL,
  `TABLE_LABEL_` varchar(120) DEFAULT NULL,
  `TABEL_NAME_` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_excel_model` */

insert  into `bdf2_excel_model`(`ID_`,`COMMENT_`,`COMPANYID_`,`CREATE_DATE_`,`DATASOURCE_NAME_`,`DB_TYPE_`,`END_COLUMN_`,`END_ROW_`,`EXCEL_SHEET_NAME_`,`HELP_DOC_`,`NAME_`,`PRIMARYKEY_`,`PRIMARYKEY_TYPE_`,`PROCESSOR_`,`SEQUENCE_NAME_`,`START_COLUMN_`,`START_ROW_`,`TABLE_LABEL_`,`TABEL_NAME_`) values ('0001','如有多个sheet 只会导入第一个','xly','2017-06-16 15:12:28',NULL,NULL,0,2,NULL,NULL,'客户资料导入',NULL,NULL,'xlyCustomerProcessor',NULL,0,1,NULL,NULL),('0002',NULL,'xly','2017-06-16 15:13:43',NULL,NULL,0,2,NULL,NULL,'库存导入',NULL,NULL,'xlyStockProcessor',NULL,0,1,NULL,NULL);

/*Table structure for table `bdf2_excel_model_detail` */

DROP TABLE IF EXISTS `bdf2_excel_model_detail`;

CREATE TABLE `bdf2_excel_model_detail` (
  `ID_` varchar(60) NOT NULL,
  `EXCEL_COLUMN_` int(11) DEFAULT NULL,
  `EXCEL_MODEL_ID_` varchar(60) DEFAULT NULL,
  `INTERCEPTOR_` varchar(120) DEFAULT NULL,
  `NAME_` varchar(60) DEFAULT NULL,
  `TABLE_COLUMN_` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_excel_model_detail` */

insert  into `bdf2_excel_model_detail`(`ID_`,`EXCEL_COLUMN_`,`EXCEL_MODEL_ID_`,`INTERCEPTOR_`,`NAME_`,`TABLE_COLUMN_`) values ('6576d27e40044bcd:-5c91546:15cafb6099e:-7fff',1,'0001',NULL,'地区',NULL),('6576d27e40044bcd:-5c91546:15cafb6099e:-7ffe',2,'0001',NULL,'姓名',NULL),('6576d27e40044bcd:-5c91546:15cafb6099e:-7ffd',3,'0001',NULL,'备注',NULL),('6576d27e40044bcd:-5c91546:15cafb6099e:-7ffc',1,'0002',NULL,'种类',NULL),('6576d27e40044bcd:-5c91546:15cafb6099e:-7ffb',2,'0002',NULL,'品牌',NULL),('6576d27e40044bcd:-5c91546:15cafb6099e:-7ffa',3,'0002',NULL,'类别',NULL),('6576d27e40044bcd:-5c91546:15cafb6099e:-7ff9',4,'0002',NULL,'编号',NULL),('6576d27e40044bcd:-5c91546:15cafb6099e:-7ff8',5,'0002',NULL,'等级',NULL),('6576d27e40044bcd:-5c91546:15cafb6099e:-7ff7',6,'0002',NULL,'色号',NULL),('6576d27e40044bcd:-5c91546:15cafb6099e:-7ff6',7,'0002',NULL,'库存',NULL),('6576d27e40044bcd:-5c91546:15cafb6099e:-7ff5',8,'0002',NULL,'储位',NULL),('6576d27e40044bcd:-5c91546:15cafb6099e:-7ff4',9,'0002',NULL,'备注',NULL);

/*Table structure for table `bdf2_group` */

DROP TABLE IF EXISTS `bdf2_group`;

CREATE TABLE `bdf2_group` (
  `ID_` varchar(60) NOT NULL,
  `COMPANY_ID_` varchar(60) DEFAULT NULL,
  `CREATE_DATE_` datetime DEFAULT NULL,
  `DESC_` varchar(120) DEFAULT NULL,
  `NAME_` varchar(60) DEFAULT NULL,
  `PARENT_ID_` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_group` */

/*Table structure for table `bdf2_group_member` */

DROP TABLE IF EXISTS `bdf2_group_member`;

CREATE TABLE `bdf2_group_member` (
  `ID_` varchar(60) NOT NULL,
  `DEPT_ID_` varchar(60) DEFAULT NULL,
  `GROUP_ID_` varchar(60) DEFAULT NULL,
  `POSITION_ID_` varchar(60) DEFAULT NULL,
  `USERNAME_` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_group_member` */

/*Table structure for table `bdf2_message` */

DROP TABLE IF EXISTS `bdf2_message`;

CREATE TABLE `bdf2_message` (
  `ID_` varchar(60) NOT NULL,
  `CONTENT_` varchar(1000) NOT NULL,
  `READ_` bit(1) NOT NULL,
  `RECEIVER_` varchar(60) NOT NULL,
  `REPLY_` bit(1) DEFAULT NULL,
  `SEND_DATE_` datetime DEFAULT NULL,
  `SENDER_` varchar(60) NOT NULL,
  `TAGS_` varchar(100) DEFAULT NULL,
  `TITLE_` varchar(60) NOT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_message` */

/*Table structure for table `bdf2_message_template` */

DROP TABLE IF EXISTS `bdf2_message_template`;

CREATE TABLE `bdf2_message_template` (
  `ID_` varchar(60) NOT NULL,
  `COMPANY_ID_` varchar(60) DEFAULT NULL,
  `CONTENT_` varchar(1000) DEFAULT NULL,
  `NAME_` varchar(60) DEFAULT NULL,
  `TYPE_` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_message_template` */

/*Table structure for table `bdf2_position` */

DROP TABLE IF EXISTS `bdf2_position`;

CREATE TABLE `bdf2_position` (
  `ID_` varchar(60) NOT NULL,
  `COMPANY_ID_` varchar(60) DEFAULT NULL,
  `CREATE_DATE_` datetime DEFAULT NULL,
  `DESC_` varchar(120) DEFAULT NULL,
  `NAME_` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_position` */

insert  into `bdf2_position`(`ID_`,`COMPANY_ID_`,`CREATE_DATE_`,`DESC_`,`NAME_`) values ('1','xly','2017-06-16 15:16:13',NULL,'销售经理'),('2','xly','2017-06-17 10:53:21',NULL,'销售总监'),('3','xly','2017-06-17 10:54:12',NULL,'开票员'),('4','xly','2017-06-17 10:54:32',NULL,'开票总监'),('5','xly','2017-06-17 10:55:01',NULL,'入库员'),('6','xly','2017-06-17 10:56:50',NULL,'财务'),('7','xly','2017-06-17 10:57:22',NULL,'财务核对'),('8','xly','2017-06-17 10:59:12',NULL,'财务总监'),('9','xly','2017-06-17 10:59:32',NULL,'总经理');

/*Table structure for table `bdf2_role` */

DROP TABLE IF EXISTS `bdf2_role`;

CREATE TABLE `bdf2_role` (
  `ID_` varchar(60) NOT NULL,
  `COMPANY_ID_` varchar(60) DEFAULT NULL,
  `CREATE_DATE_` datetime DEFAULT NULL,
  `CREATE_USER_` varchar(60) DEFAULT NULL,
  `DESC_` varchar(120) DEFAULT NULL,
  `ENABLED_` bit(1) DEFAULT NULL,
  `NAME_` varchar(60) DEFAULT NULL,
  `PARENT_ID_` varchar(60) DEFAULT NULL,
  `TYPE_` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_role` */

insert  into `bdf2_role`(`ID_`,`COMPANY_ID_`,`CREATE_DATE_`,`CREATE_USER_`,`DESC_`,`ENABLED_`,`NAME_`,`PARENT_ID_`,`TYPE_`) values ('918b622a-9919-4c3d-84d5-f623160ccced','xly','2017-06-16 15:41:18',NULL,'拥有所有界面权限','','系统管理员',NULL,'normal'),('6c6f8fad-6266-4d22-b002-9551b5df7258','xly','2017-06-16 15:42:04',NULL,'查看库存、查看提成','','销售经理',NULL,'normal');

/*Table structure for table `bdf2_role_member` */

DROP TABLE IF EXISTS `bdf2_role_member`;

CREATE TABLE `bdf2_role_member` (
  `ID_` varchar(60) NOT NULL,
  `CREATE_DATE_` datetime DEFAULT NULL,
  `DEPT_ID_` varchar(60) DEFAULT NULL,
  `GRANTED_` bit(1) DEFAULT NULL,
  `POSITION_ID_` varchar(60) DEFAULT NULL,
  `ROLE_ID_` varchar(60) DEFAULT NULL,
  `USERNAME_` varchar(60) DEFAULT NULL,
  `GROUP_ID_` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `FK79BEE4326C254D1D` (`GROUP_ID_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_role_member` */

insert  into `bdf2_role_member`(`ID_`,`CREATE_DATE_`,`DEPT_ID_`,`GRANTED_`,`POSITION_ID_`,`ROLE_ID_`,`USERNAME_`,`GROUP_ID_`) values ('caa2a529-fbe7-4ff3-a069-6a84df6cc270','2017-06-16 15:43:21',NULL,'',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','lxl123',NULL),('00449fba-2d64-43fc-a1c6-a63ee226451c','2017-06-16 15:43:21',NULL,'',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','xlyzby',NULL),('46502406-bdd9-42f7-bf03-33a09f559c9a','2017-06-16 15:44:26',NULL,'','1','6c6f8fad-6266-4d22-b002-9551b5df7258',NULL,NULL);

/*Table structure for table `bdf2_role_resource` */

DROP TABLE IF EXISTS `bdf2_role_resource`;

CREATE TABLE `bdf2_role_resource` (
  `ID_` varchar(60) NOT NULL,
  `PACKAGE_ID_` varchar(60) DEFAULT NULL,
  `ROLE_ID_` varchar(60) DEFAULT NULL,
  `URL_ID_` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_role_resource` */

insert  into `bdf2_role_resource`(`ID_`,`PACKAGE_ID_`,`ROLE_ID_`,`URL_ID_`) values ('818c857d-4b3b-4053-bbdf-5f32178406f0',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','f7787b64-e7ea-492c-8650-b7570f3a44d7'),('d2d272b5-a0e1-4198-8d2d-57a529e3ca06',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','f38900c5-d24a-4d4c-8387-3307251f4550'),('4c15518d-848c-46d2-b071-3732abb70c00',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','48a6ae98-8427-4268-9b93-554c37777517'),('9c2e0fa3-983c-490c-959e-3d490269f109',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','c155d60f-e83a-485b-9a3f-4869d18f9c20'),('e9016048-223c-4eef-b8a3-a1164ad80ef7',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','ccf2550e-2401-4aed-8d45-247a921bb546'),('01e4e8b3-8bdc-4546-b999-e828fe5201f9',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','9305dfb3-7256-4215-88a4-34057ee67b1e'),('9016108e-8759-42fd-8bf0-610378d3e699',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','6c2cb859-1996-4916-97cf-a9264baa889b'),('31a408ed-25af-4bb6-911e-94558a94f48b',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','412746a2-6bfd-4e2b-9148-056db257be29'),('2b9c0e45-6fdc-438b-a415-a769d7c93234',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','29155906-d5e2-4bd0-91f7-9914fb2ce8b2'),('4183c02f-5292-4edd-b21c-de5fde0feec6',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','7676baa4-8943-49ff-9b6c-3c8d4de08bb2'),('c33dc0cb-08d9-4205-b99f-2f438bd19c11',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','7238d5b9-a527-4471-a043-e432d9eb4db8'),('fcc5b451-9a7f-4801-b0d9-89b8084799e0',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','9c3a1992-6de0-465f-8fd6-1daa583180d8'),('69943cf3-4616-4117-b114-45112deb29d7',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','8672c912-5a07-4b59-99b6-ea8e397b0b24'),('313ec144-2e12-4e35-895f-1bc97b696321',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','66e7cc71-9522-492f-be6d-6cdab1641cc6'),('9c484e0e-8540-4e2e-a86e-8b876e1e7c59',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','c478a332-b715-43e0-8b8b-de7f12f7788b'),('011fe6eb-35e0-4788-b5b9-181db5a9865b',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','4fccbd0b-c210-42c9-9c04-65cb22bc5653'),('fb1760b4-aac2-43b3-a711-efc5ae0e4321',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','1ed9fdb3-1ee1-4ac5-a92c-b74c65ee6c24'),('45da75bd-cb40-4e74-b1ad-4101e233b54e',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','root-xly'),('38c3f29d-ecd6-478e-b7cb-32e3af5344de',NULL,'6c6f8fad-6266-4d22-b002-9551b5df7258','51b8c113-e27b-4a99-87a0-d7c144026617'),('0262a0cb-8abf-40ea-9944-322d8c72d818',NULL,'6c6f8fad-6266-4d22-b002-9551b5df7258','8acbc920-5527-4d55-b9b0-f0ba9d21ed04'),('076e1025-abb2-4d93-b3e4-7f9c1914d91d',NULL,'6c6f8fad-6266-4d22-b002-9551b5df7258','3a5c804c-6eaa-439f-a930-aee1fa26cc95'),('dd12f809-4355-4a75-8d62-a8afdb3339c7',NULL,'6c6f8fad-6266-4d22-b002-9551b5df7258','9f01ddf9-b469-472b-9c0c-357d885513e0'),('1c820eb9-b36b-4c90-a8fd-69f477b7d56a',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','51b8c113-e27b-4a99-87a0-d7c144026617'),('6eee2eae-b624-4073-9f6a-94eb1d09c41d',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','c9bed751-d7fe-4a4f-991e-4945896feabe'),('8641468d-27ec-4583-b747-79ad8af9fe1b',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','8acbc920-5527-4d55-b9b0-f0ba9d21ed04'),('08bc13a0-550d-4c3e-9771-df4da088d312',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','c8d5a6bb-0c0f-4d94-8604-ee43b1264f5b'),('8b0bf881-b7ea-4ac6-b611-570dfdd49231',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','1e8b00df-371d-481f-8491-7a5fce7d6f4a'),('5cef94ea-4cdf-4bfd-b8e5-5c09e4ea3faf',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','ebd6bc30-e4e1-4fbf-beb0-5f5d38ef1561'),('c49fd6df-79d0-4bd8-8a2e-c69b9ce51c47',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','a2150511-cd00-424a-9095-40ba97e5eb8e'),('f5d4de2b-fe6b-4321-ab73-b2ff991114e7',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','93ef222b-df49-48de-a395-b07507a98cf9'),('a0e0ed26-c472-453f-b4a2-f0a39bd91d98',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','b906fcca-4483-477a-9c90-3cdeb37eb48d'),('4ece7f62-7742-402f-ab62-0bef2d8290bb',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','01889c12-ea4a-4cb4-8029-e609dbf96072'),('6f54fed6-3aa9-44d7-8b16-e5e286838b2a',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','236a963c-4aa3-4d05-a416-53bff8306f1f'),('31b8b8bf-3993-4808-9819-38ef70890b67',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','22426042-2ed6-4993-a56d-fac6a808393e'),('8fa2a999-e68f-4e92-ab1c-ef4b367a7eee',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','eefee2bf-8b6d-4522-ab7f-b8a3bb611a4b'),('de8a56dd-9a48-465c-91c2-ab1d7ac7a739',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','a3c4fa93-3ebb-4e85-90cb-62936ea2bd1e'),('497542e6-543c-4edb-81f9-598cf3310a14',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','c920fe16-a89c-460f-9d56-6a20d222d3d8'),('4fb541f2-c9ba-42dd-8653-1e61af6aa6ab',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','b36e6e78-d3d6-482a-83e2-8684596427b6'),('8ae7fb1d-2cc9-4862-82e2-7d56b65efa35',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','3a5c804c-6eaa-439f-a930-aee1fa26cc95'),('199d8a0e-1913-41d9-b3ed-636d823b510e',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','b4569622-8859-45bf-8a7d-616190e108b3'),('b428c69b-65f9-453e-8889-74347f595f3a',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','2443fa26-bbbc-4258-8d77-ec04bb5dd282'),('5635b815-6816-4238-81f1-4301c09f70b3',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','8261239a-2e55-40ef-9074-ffd3d4d6518b'),('83d1f6fb-2588-4c93-a6af-8b969b30e952',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','68a18be2-03ef-4901-a6b5-edd581c17ed1'),('a6968960-8a78-4d01-9a16-cbcd222468f8',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','c1c04520-b2a0-4743-ab74-0f7a14838d0d'),('cb30f08c-b6a5-4048-91ce-3ab77b0355cc',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','9f01ddf9-b469-472b-9c0c-357d885513e0'),('959d60c7-50c4-447c-82dd-2e77614d048b',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','b6085683-1c50-4c23-abe8-2994af61a786'),('3449617f-0ffb-46ed-abde-d66fe0853c54',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','5fab22a3-468f-4f50-98ea-496ca1917978'),('5cc0764e-3472-4b98-a7c9-d5ee1570717a',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','2831dfcb-ae53-4893-8325-9c7bee5289fa'),('8c464d51-e9a6-44c3-92d4-f6d9e23169c2',NULL,'918b622a-9919-4c3d-84d5-f623160ccced','8afbac3a-c84b-47d0-8fb5-7edd87647e7a');

/*Table structure for table `bdf2_ureport_definition` */

DROP TABLE IF EXISTS `bdf2_ureport_definition`;

CREATE TABLE `bdf2_ureport_definition` (
  `ID_` varchar(60) NOT NULL,
  `BLOB_` longblob,
  `CREATE_DATE_` datetime NOT NULL,
  `DESC_` varchar(200) DEFAULT NULL,
  `FILE_NAME_` varchar(60) DEFAULT NULL,
  `NAME_` varchar(60) DEFAULT NULL,
  `TYPE_ID_` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_ureport_definition` */

/*Table structure for table `bdf2_ureport_parameter` */

DROP TABLE IF EXISTS `bdf2_ureport_parameter`;

CREATE TABLE `bdf2_ureport_parameter` (
  `ID_` varchar(60) NOT NULL,
  `NAME_` varchar(60) DEFAULT NULL,
  `REPORT_DEFINITION_ID_` varchar(60) NOT NULL,
  `VALUE_` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_ureport_parameter` */

/*Table structure for table `bdf2_ureport_type` */

DROP TABLE IF EXISTS `bdf2_ureport_type`;

CREATE TABLE `bdf2_ureport_type` (
  `ID_` varchar(60) NOT NULL,
  `CATEGORY_` varchar(60) DEFAULT NULL,
  `CREATE_DATE_` datetime NOT NULL,
  `DESC_` varchar(200) DEFAULT NULL,
  `NAME_` varchar(60) DEFAULT NULL,
  `PARENT_ID_` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_ureport_type` */

/*Table structure for table `bdf2_url` */

DROP TABLE IF EXISTS `bdf2_url`;

CREATE TABLE `bdf2_url` (
  `ID_` varchar(60) NOT NULL,
  `COMPANY_ID_` varchar(60) NOT NULL,
  `DESC_` varchar(120) DEFAULT NULL,
  `FOR_NAVIGATION_` bit(1) NOT NULL,
  `ICON_` varchar(120) DEFAULT NULL,
  `NAME_` varchar(60) NOT NULL,
  `ORDER_` int(11) DEFAULT NULL,
  `PARENT_ID_` varchar(60) DEFAULT NULL,
  `SYSTEM_ID_` varchar(60) DEFAULT NULL,
  `URL_` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_url` */

insert  into `bdf2_url`(`ID_`,`COMPANY_ID_`,`DESC_`,`FOR_NAVIGATION_`,`ICON_`,`NAME_`,`ORDER_`,`PARENT_ID_`,`SYSTEM_ID_`,`URL_`) values ('root-xly','xly',NULL,'','url(skin>common/icons.gif) -102px -101px','系统管理',1,NULL,NULL,NULL),('ccf2550e-2401-4aed-8d45-247a921bb546','xly',NULL,'','dorado/res/com/bstek/bdf2/importexcel/view/icons/page_excel.png','Excel导入',5,'root-xly',NULL,NULL),('c155d60f-e83a-485b-9a3f-4869d18f9c20','xly',NULL,'','url(skin>common/icons.gif) -102px -21px','导入模板定义',1,'ccf2550e-2401-4aed-8d45-247a921bb546',NULL,'bdf2.importexcel.view.ExcelMaintain.d'),('48a6ae98-8427-4268-9b93-554c37777517','xly',NULL,'','dorado/res/com/bstek/bdf2/importexcel/view/icons/page_excel.png','导入演示',2,'ccf2550e-2401-4aed-8d45-247a921bb546',NULL,'bdf2.importexcel.view.ImportExcel.d'),('1ed9fdb3-1ee1-4ac5-a92c-b74c65ee6c24','xly',NULL,'','url(skin>common/icons.gif) -100px -20px','系统默认基本信息维护',1,'root-xly',NULL,NULL),('4fccbd0b-c210-42c9-9c04-65cb22bc5653','xly',NULL,'','url(skin>common/icons.gif) -62px -141px','菜单维护',1,'1ed9fdb3-1ee1-4ac5-a92c-b74c65ee6c24',NULL,'bdf2.core.view.url.UrlMaintain.d'),('c478a332-b715-43e0-8b8b-de7f12f7788b','xly',NULL,'','url(skin>common/icons.gif) -142px -101px','用户维护',2,'1ed9fdb3-1ee1-4ac5-a92c-b74c65ee6c24',NULL,'bdf2.core.view.user.UserMaintain.d'),('66e7cc71-9522-492f-be6d-6cdab1641cc6','xly',NULL,'','url(skin>common/icons.gif) -42px -41px','部门维护',3,'1ed9fdb3-1ee1-4ac5-a92c-b74c65ee6c24',NULL,'bdf2.core.view.dept.DeptMaintain.d'),('8672c912-5a07-4b59-99b6-ea8e397b0b24','xly',NULL,'','url(skin>common/icons.gif) -262px -41px','岗位维护',4,'1ed9fdb3-1ee1-4ac5-a92c-b74c65ee6c24',NULL,'bdf2.core.view.position.PositionMaintain.d'),('9c3a1992-6de0-465f-8fd6-1daa583180d8','xly',NULL,'','url(skin>common/icons.gif) -302px -61px','消息模版维护',5,'1ed9fdb3-1ee1-4ac5-a92c-b74c65ee6c24',NULL,'bdf2.core.view.messagetemplate.MessageTemplateMaintain.d'),('7238d5b9-a527-4471-a043-e432d9eb4db8','xly',NULL,'','url(skin>common/icons.gif) -42px -41px','权限管理',2,'root-xly',NULL,NULL),('7676baa4-8943-49ff-9b6c-3c8d4de08bb2','xly',NULL,'','url(skin>common/icons.gif) -240px -80px','角色维护',1,'7238d5b9-a527-4471-a043-e432d9eb4db8',NULL,'bdf2.core.view.role.RoleMaintain.d'),('29155906-d5e2-4bd0-91f7-9914fb2ce8b2','xly',NULL,'','url(skin>common/icons.gif) -262px -100px','URL权限维护',2,'7238d5b9-a527-4471-a043-e432d9eb4db8',NULL,'bdf2.core.view.role.url.RoleUrlMaintain.d'),('412746a2-6bfd-4e2b-9148-056db257be29','xly',NULL,'','url(skin>common/icons.gif) -181px -41px','组件权限维护',3,'7238d5b9-a527-4471-a043-e432d9eb4db8',NULL,'bdf2.core.view.role.component.RoleComponentMaintain.d'),('6c2cb859-1996-4916-97cf-a9264baa889b','xly',NULL,'','url(skin>common/icons.gif) -102px -21px','角色成员维护',4,'7238d5b9-a527-4471-a043-e432d9eb4db8',NULL,'bdf2.core.view.role.member.RoleMemberMaintain.d'),('9305dfb3-7256-4215-88a4-34057ee67b1e','xly',NULL,'','url(skin>common/icons.gif) -101px -121px','群组维护',5,'7238d5b9-a527-4471-a043-e432d9eb4db8',NULL,'bdf2.core.view.group.GroupMaintain.d'),('f38900c5-d24a-4d4c-8387-3307251f4550','xly',NULL,'','url(skin>common/icons.gif) -162px -41px','UReport报表管理',10,'root-xly',NULL,NULL),('f7787b64-e7ea-492c-8650-b7570f3a44d7','xly',NULL,'','url(>skin>common/icons.gif) -240px -140px','UReport报表模版维护',1,'f38900c5-d24a-4d4c-8387-3307251f4550',NULL,'bdf2.ureport.view.ReportMaintain.d'),('8acbc920-5527-4d55-b9b0-f0ba9d21ed04','xly',NULL,'','url(>skin>common/icons.gif) -160px -140px','库存表',2,'51b8c113-e27b-4a99-87a0-d7c144026617',NULL,'com.xly.ess.view.StockList.d'),('51b8c113-e27b-4a99-87a0-d7c144026617','xly',NULL,'','url(>skin>common/icons.gif) -40px -40px','库存管理',2,NULL,NULL,NULL),('1e8b00df-371d-481f-8491-7a5fce7d6f4a','xly',NULL,'','url(skin>common/icons.gif) -142px -101px','客户管理',3,NULL,NULL,NULL),('93ef222b-df49-48de-a395-b07507a98cf9','xly',NULL,'',' url(>skin>common/icons.gif) -20px -80px','财务管理',4,NULL,NULL,NULL),('22426042-2ed6-4993-a56d-fac6a808393e','xly',NULL,'',' url(>skin>common/icons.gif) -60px -160px','开票管理',5,NULL,NULL,NULL),('3a5c804c-6eaa-439f-a930-aee1fa26cc95','xly',NULL,'',' url(>skin>common/icons.gif) -300px -20px','销售管理',6,NULL,NULL,NULL),('5fab22a3-468f-4f50-98ea-496ca1917978','xly',NULL,'',' url(>skin>common/icons.gif) -120px -60px','虚拟开票',7,NULL,NULL,NULL),('c8d5a6bb-0c0f-4d94-8604-ee43b1264f5b','xly',NULL,'',' url(>skin>common/icons.gif) -180px -20px','冻结库存',3,'51b8c113-e27b-4a99-87a0-d7c144026617',NULL,'com.xly.ess.view.WhFreeze.d'),('c9bed751-d7fe-4a4f-991e-4945896feabe','xly',NULL,'','url(>skin>common/icons.gif) -280px -100px','入库',1,'51b8c113-e27b-4a99-87a0-d7c144026617',NULL,'com.xly.ess.view.Stock.d'),('ebd6bc30-e4e1-4fbf-beb0-5f5d38ef1561','xly',NULL,'',' url(>skin>common/icons.gif) -60px -140px','客户列表',1,'1e8b00df-371d-481f-8491-7a5fce7d6f4a',NULL,'com.xly.ess.view.CustomerList.d'),('a2150511-cd00-424a-9095-40ba97e5eb8e','xly',NULL,'',' url(>skin>common/icons.gif) -100px -120px','客户详情',2,'1e8b00df-371d-481f-8491-7a5fce7d6f4a',NULL,'com.xly.ess.view.CtmDetails.d'),('b906fcca-4483-477a-9c90-3cdeb37eb48d','xly',NULL,'',' url(>skin>common/icons.gif) -20px -140px','入账',1,'93ef222b-df49-48de-a395-b07507a98cf9',NULL,'com.xly.ess.view.BalanceRecord.d'),('01889c12-ea4a-4cb4-8029-e609dbf96072','xly',NULL,'',' url(>skin>common/icons.gif) -200px -0px','修改客户余额',2,'93ef222b-df49-48de-a395-b07507a98cf9',NULL,'com.xly.ess.view.EditBalance.d'),('236a963c-4aa3-4d05-a416-53bff8306f1f','xly',NULL,'',' url(>skin>common/icons.gif) -20px -40px','查看客户余额',3,'93ef222b-df49-48de-a395-b07507a98cf9',NULL,'com.xly.ess.view.CtmBalance.d'),('eefee2bf-8b6d-4522-ab7f-b8a3bb611a4b','xly',NULL,'',' url(>skin>common/icons.gif) -120px -20px','开票',1,'22426042-2ed6-4993-a56d-fac6a808393e',NULL,'com.xly.ess.view.Bill.d'),('a3c4fa93-3ebb-4e85-90cb-62936ea2bd1e','xly',NULL,'',' url(>skin>common/icons.gif) -180px -140px','开票记录',2,'22426042-2ed6-4993-a56d-fac6a808393e',NULL,'com.xly.ess.view.BillRecord.d'),('2831dfcb-ae53-4893-8325-9c7bee5289fa','xly',NULL,'',' url(>skin>common/icons.gif) -120px -20px','虚拟开票',1,'5fab22a3-468f-4f50-98ea-496ca1917978',NULL,'com.xly.ess.view.BillF.d'),('8afbac3a-c84b-47d0-8fb5-7edd87647e7a','xly',NULL,'',' url(>skin>common/icons.gif) -180px -140px','虚拟开票记录',2,'5fab22a3-468f-4f50-98ea-496ca1917978',NULL,'com.xly.ess.view.BillRecordF.d'),('c920fe16-a89c-460f-9d56-6a20d222d3d8','xly',NULL,'',' url(>skin>common/icons.gif) -80px -140px','作废记录',3,'22426042-2ed6-4993-a56d-fac6a808393e',NULL,'com.xly.ess.view.DropBill.d'),('b4569622-8859-45bf-8a7d-616190e108b3','xly',NULL,'',' url(>skin>common/icons.gif) -100px -60px','客户对账单',1,'3a5c804c-6eaa-439f-a930-aee1fa26cc95',NULL,'com.xly.ess.view.CtmReconciliation.d'),('2443fa26-bbbc-4258-8d77-ec04bb5dd282','xly',NULL,'',' url(>skin>common/icons.gif) -100px -20px','设置保证金/欠款金额',2,'3a5c804c-6eaa-439f-a930-aee1fa26cc95',NULL,'com.xly.ess.view.SetDebt.d'),('8261239a-2e55-40ef-9074-ffd3d4d6518b','xly',NULL,'',' url(>skin>common/icons.gif) -300px -20px','客户采购分析',3,'3a5c804c-6eaa-439f-a930-aee1fa26cc95',NULL,'com.xly.ess.view.LineChart.d'),('68a18be2-03ef-4901-a6b5-edd581c17ed1','xly',NULL,'',' url(>skin>common/icons.gif) -280px -40px','种类销量分析',4,'3a5c804c-6eaa-439f-a930-aee1fa26cc95',NULL,'com.xly.ess.view.SaleChart.d'),('c1c04520-b2a0-4743-ab74-0f7a14838d0d','xly',NULL,'','url(>skin>common/icons.gif) -220px -40px','产量与销量',6,'3a5c804c-6eaa-439f-a930-aee1fa26cc95',NULL,'com.xly.ess.view.OutputSales.d'),('9f01ddf9-b469-472b-9c0c-357d885513e0','xly',NULL,'',' url(>skin>common/icons.gif) -260px -20px','月销量统计表',7,'3a5c804c-6eaa-439f-a930-aee1fa26cc95',NULL,'com.xly.ess.view.Sales.d'),('b36e6e78-d3d6-482a-83e2-8684596427b6','xly',NULL,'',' url(>skin>common/icons.gif) -60px -40px','样品开票',4,'22426042-2ed6-4993-a56d-fac6a808393e',NULL,'com.xly.ess.view.SampleBill.d'),('b6085683-1c50-4c23-abe8-2994af61a786','xly',NULL,'',' url(>skin>common/icons.gif) -260px -140px','花型销量统计',7,'3a5c804c-6eaa-439f-a930-aee1fa26cc95',NULL,'ureport?action=htmlpreview&report=classpath:PatternNo');

/*Table structure for table `bdf2_url_component` */

DROP TABLE IF EXISTS `bdf2_url_component`;

CREATE TABLE `bdf2_url_component` (
  `ID_` varchar(60) NOT NULL,
  `AUTHORITY_TYPE_` varchar(10) NOT NULL,
  `ROLE_ID_` varchar(60) DEFAULT NULL,
  `URL_ID_` varchar(60) DEFAULT NULL,
  `COMPONENT_ID_` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `FKFCFBDBDCD4C56CC` (`COMPONENT_ID_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_url_component` */

/*Table structure for table `bdf2_user` */

DROP TABLE IF EXISTS `bdf2_user`;

CREATE TABLE `bdf2_user` (
  `USERNAME_` varchar(60) NOT NULL,
  `ADDRESS_` varchar(120) DEFAULT NULL,
  `ADMINISTRATOR_` bit(1) NOT NULL,
  `BIRTHDAY_` datetime DEFAULT NULL,
  `CNAME_` varchar(60) NOT NULL,
  `COMPANY_ID_` varchar(60) NOT NULL,
  `CREATE_DATE_` datetime DEFAULT NULL,
  `EMAIL_` varchar(60) DEFAULT NULL,
  `ENABLED_` bit(1) NOT NULL,
  `ENAME_` varchar(60) DEFAULT NULL,
  `MALE_` bit(1) NOT NULL,
  `MOBILE_` varchar(20) DEFAULT NULL,
  `PASSWORD_` varchar(70) NOT NULL,
  `SALT_` varchar(10) NOT NULL,
  PRIMARY KEY (`USERNAME_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_user` */

insert  into `bdf2_user`(`USERNAME_`,`ADDRESS_`,`ADMINISTRATOR_`,`BIRTHDAY_`,`CNAME_`,`COMPANY_ID_`,`CREATE_DATE_`,`EMAIL_`,`ENABLED_`,`ENAME_`,`MALE_`,`MOBILE_`,`PASSWORD_`,`SALT_`) values ('xlyzby',NULL,'',NULL,'系统管理员','xly',NULL,'1062486808@qq.com','','administrator','','18394895298','5fbb2b72d5ee7e7b44c7dacd590cf24823676477','232'),('lxl123',NULL,'','1993-05-16 00:00:00','罗学林','xly',NULL,'774785161@qq.com','','lxl','','15019861460','df6001fb642f242da5876575363f5123f2a40094','65'),('yb','无','\0','1987-06-16 00:00:00','杨彬','xly',NULL,'12313@qq.com','','yangbin','','13855222231','134f79b1a4e1d3c946a7a0dea8cefc483d07658d','14'),('lsb',NULL,'\0','2017-06-16 00:00:00','零售部','xly',NULL,'123456@qq.com','','lingshoubu','','15019864110','88e881eead8839e5954c952533bc7230178efc7d','39'),('xsb',NULL,'\0','2017-06-16 00:00:00','销售部','xly',NULL,'123456@qq.com','','xiaoshoubu','','15213245992','33a6f548fa7d39b68a72e982078303512474b449','34'),('zl',NULL,'\0',NULL,'朱林','xly',NULL,'123465@qq.com','','zhulin','','15213234645','b6f2994ec657c50dcf283084663cb260427b94f0','68'),('zxg',NULL,'\0',NULL,'张新国','xly',NULL,'123456@qq.com','','zhangxinguo','','15284211144','e92e876ea24f177b46ddffe363a005da5b9da98a','64'),('zjj',NULL,'\0',NULL,'张建军','xly',NULL,'123465@qq.com','','zhangjianjun','','15345752325','de881c09f4f14da5f902143235ad9306c7250a9d','90'),('flj',NULL,'\0',NULL,'付丽娟','xly',NULL,'123456@qq.com','','fulijuan','\0','18817505847','5338f75ad3d3a75bec85a16e89434cde36431aa2','48'),('sfq',NULL,'\0',NULL,'石福全','xly',NULL,'123456@qq.com','','shifuquan','','15088454569','ab228332038e8f8f376e16e15ac6e0680702eee5','29'),('ysb',NULL,'\0',NULL,'尹淑兵','xly',NULL,'123465@qq.com','','yinshubing','\0','18999889988','9b69fafade822ab57e4052fc3a516166878d0860','44');

/*Table structure for table `bdf2_user_dept` */

DROP TABLE IF EXISTS `bdf2_user_dept`;

CREATE TABLE `bdf2_user_dept` (
  `ID_` varchar(60) NOT NULL,
  `DEPT_ID_` varchar(60) NOT NULL,
  `USERNAME_` varchar(60) NOT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_user_dept` */

/*Table structure for table `bdf2_user_position` */

DROP TABLE IF EXISTS `bdf2_user_position`;

CREATE TABLE `bdf2_user_position` (
  `ID_` varchar(60) NOT NULL,
  `POSITION_ID_` varchar(60) NOT NULL,
  `USERNAME_` varchar(60) NOT NULL,
  `SALES_MGR_ID` int(10) NOT NULL AUTO_INCREMENT,
  `SALES_MGR_NAME` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `SALES_MGR_ID` (`SALES_MGR_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

/*Data for the table `bdf2_user_position` */

insert  into `bdf2_user_position`(`ID_`,`POSITION_ID_`,`USERNAME_`,`SALES_MGR_ID`,`SALES_MGR_NAME`) values ('ac44b939-2c53-4d93-8cbf-731c0cacafa1','1','yb',26,'杨彬'),('374cd862-1e5b-4429-a699-f22d89f2824c','1','lsb',27,'零售部'),('bbcbb21b-0eac-4903-8bcf-2b281e2943a9','1','xsb',28,'销售部'),('57e54735-f35e-4eb2-9c06-8badec6b5980','1','zl',29,'朱林'),('db48ff39-dbe9-4a67-935e-e881bdf1d433','1','zxg',30,'张新国'),('e02a7ae5-5795-42c1-a087-ac6e2558d496','1','zjj',31,'张建军'),('1dafe922-97ce-482d-9729-5f794e1dde35','1','flj',32,'付丽娟'),('6d0b0b40-553b-4742-973f-7cfef8d88325','1','sfq',33,'石福全'),('754988f9-f1e8-4906-9505-0b36487d54a7','1','ysb',34,'尹淑兵');

/*Table structure for table `xly_bal_record` */

DROP TABLE IF EXISTS `xly_bal_record`;

CREATE TABLE `xly_bal_record` (
  `BAL_ID` int(10) NOT NULL AUTO_INCREMENT,
  `CTM_ID` int(10) DEFAULT NULL,
  `CREATER` varchar(10) DEFAULT NULL,
  `AMOUNT` double DEFAULT NULL,
  `CREATE_TIME` varchar(30) NOT NULL,
  `OPT_TYPE` varchar(10) DEFAULT NULL,
  `REMARK` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`BAL_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xly_bal_record` */

/*Table structure for table `xly_bill` */

DROP TABLE IF EXISTS `xly_bill`;

CREATE TABLE `xly_bill` (
  `BILL_NO` int(10) NOT NULL AUTO_INCREMENT,
  `BILL_TIME` varchar(20) DEFAULT NULL,
  `CTM_ID` int(10) DEFAULT NULL,
  `FREIGHT` int(20) DEFAULT NULL,
  `DRIVER_PHONE` varchar(12) DEFAULT NULL,
  `CAR_NO` varchar(10) DEFAULT NULL,
  `CREATER` varchar(10) DEFAULT NULL,
  `REMARK` varchar(35) DEFAULT NULL,
  `BILL_TYPE` varchar(35) DEFAULT NULL,
  `STATE` smallint(1) DEFAULT '1',
  `TOTAL_AMOUNT` double DEFAULT NULL COMMENT '货物总价+运费',
  PRIMARY KEY (`BILL_NO`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xly_bill` */

/*Table structure for table `xly_bill_blankline` */

DROP TABLE IF EXISTS `xly_bill_blankline`;

CREATE TABLE `xly_bill_blankline` (
  `BLANKLINE_ID` int(10) NOT NULL AUTO_INCREMENT,
  `BLANKLINE` int(10) DEFAULT NULL,
  PRIMARY KEY (`BLANKLINE_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `xly_bill_blankline` */

/*Table structure for table `xly_bill_fake` */

DROP TABLE IF EXISTS `xly_bill_fake`;

CREATE TABLE `xly_bill_fake` (
  `BILL_NO` int(10) NOT NULL AUTO_INCREMENT,
  `BILL_TIME` varchar(20) DEFAULT NULL,
  `CTM_ID` int(10) DEFAULT NULL,
  `FREIGHT` int(20) DEFAULT NULL,
  `DRIVER_PHONE` varchar(12) DEFAULT NULL,
  `CAR_NO` varchar(10) DEFAULT NULL,
  `CREATER` varchar(10) DEFAULT NULL,
  `REMARK` varchar(35) DEFAULT NULL,
  `BILL_TYPE` varchar(35) DEFAULT NULL,
  `STATE` smallint(1) DEFAULT '1',
  `TOTAL_AMOUNT` double DEFAULT NULL COMMENT '货物总价+运费',
  PRIMARY KEY (`BILL_NO`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `xly_bill_fake` */

/*Table structure for table `xly_bill_record` */

DROP TABLE IF EXISTS `xly_bill_record`;

CREATE TABLE `xly_bill_record` (
  `RECORD_ID` int(10) NOT NULL AUTO_INCREMENT,
  `BILL_NO` int(10) DEFAULT NULL,
  `STOCK_ID` int(10) DEFAULT NULL,
  `COUNT` int(10) DEFAULT NULL,
  `PRICE` double DEFAULT NULL,
  `BENCHMARK` double DEFAULT '0',
  PRIMARY KEY (`RECORD_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xly_bill_record` */

/*Table structure for table `xly_bill_record_fake` */

DROP TABLE IF EXISTS `xly_bill_record_fake`;

CREATE TABLE `xly_bill_record_fake` (
  `RECORD_ID` int(10) NOT NULL AUTO_INCREMENT,
  `BILL_NO` int(10) DEFAULT NULL,
  `STOCK_ID` int(10) DEFAULT NULL,
  `COUNT` int(10) DEFAULT NULL,
  `PRICE` double DEFAULT NULL,
  `BENCHMARK` int(10) DEFAULT '0',
  PRIMARY KEY (`RECORD_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `xly_bill_record_fake` */

/*Table structure for table `xly_classes` */

DROP TABLE IF EXISTS `xly_classes`;

CREATE TABLE `xly_classes` (
  `CLASSES_ID` int(10) NOT NULL AUTO_INCREMENT,
  `CLASSES_NAME` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`CLASSES_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `xly_classes` */

insert  into `xly_classes`(`CLASSES_ID`,`CLASSES_NAME`) values (1,'一线一班'),(2,'一线二班'),(3,'一线三班'),(4,'导表（无）');

/*Table structure for table `xly_ctm_bal` */

DROP TABLE IF EXISTS `xly_ctm_bal`;

CREATE TABLE `xly_ctm_bal` (
  `BAL_ID` int(10) NOT NULL AUTO_INCREMENT,
  `CTM_ID` int(10) NOT NULL,
  `BALANCE` double DEFAULT '0',
  `END_MONTH` varchar(7) NOT NULL,
  `CREATE_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`BAL_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xly_ctm_bal` */

/*Table structure for table `xly_ctm_buy` */

DROP TABLE IF EXISTS `xly_ctm_buy`;

CREATE TABLE `xly_ctm_buy` (
  `RECORD_ID` int(10) NOT NULL AUTO_INCREMENT,
  `SALE_MGR_NAME` varchar(10) DEFAULT NULL,
  `SALE_MGR_ID` int(10) DEFAULT NULL,
  `CTM_NAME` varchar(10) DEFAULT NULL,
  `CTM_ID` int(10) DEFAULT NULL,
  `MYS_Q` double DEFAULT '0' COMMENT '都应该是销售额',
  `MYS_J` double DEFAULT '0',
  `BDMY_Q` double DEFAULT '0',
  `BDMY_J` double DEFAULT '0',
  `XSY_Q` double DEFAULT '0',
  `XSY_J` double DEFAULT '0',
  `MF_C` double DEFAULT '0',
  `CREATE_DATE` varchar(20) DEFAULT NULL,
  `END_MONTH` varchar(7) DEFAULT NULL COMMENT '某月内的数据',
  PRIMARY KEY (`RECORD_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xly_ctm_buy` */

/*Table structure for table `xly_ctm_type` */

DROP TABLE IF EXISTS `xly_ctm_type`;

CREATE TABLE `xly_ctm_type` (
  `TYPE_ID` int(10) NOT NULL AUTO_INCREMENT,
  `TYPE_NAME` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`TYPE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xly_ctm_type` */

/*Table structure for table `xly_customer` */

DROP TABLE IF EXISTS `xly_customer`;

CREATE TABLE `xly_customer` (
  `CTM_ID` int(10) NOT NULL AUTO_INCREMENT,
  `CTM_NAME` varchar(10) DEFAULT NULL,
  `TYPE_ID` smallint(6) DEFAULT NULL,
  `ADDRESS` varchar(30) DEFAULT NULL,
  `SHOP_NAME` varchar(30) DEFAULT NULL,
  `SALES_MGR_ID` int(10) DEFAULT NULL,
  `MONEY` blob COMMENT '加密后的余额',
  `GRT_MONEY` int(11) DEFAULT '0' COMMENT '保证金',
  `DEBT` int(11) DEFAULT '0' COMMENT '欠款',
  PRIMARY KEY (`CTM_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `xly_customer` */

insert  into `xly_customer`(`CTM_ID`,`CTM_NAME`,`TYPE_ID`,`ADDRESS`,`SHOP_NAME`,`SALES_MGR_ID`,`MONEY`,`GRT_MONEY`,`DEBT`) values (1,'零售',0,'无','无',27,'j',0,0);

/*Table structure for table `xly_drop_bill` */

DROP TABLE IF EXISTS `xly_drop_bill`;

CREATE TABLE `xly_drop_bill` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `BILL_NO` int(10) NOT NULL,
  `CREATER` varchar(20) DEFAULT NULL,
  `CREATE_DATE` varchar(20) DEFAULT NULL,
  `REASON` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xly_drop_bill` */

/*Table structure for table `xly_pdt_bra` */

DROP TABLE IF EXISTS `xly_pdt_bra`;

CREATE TABLE `xly_pdt_bra` (
  `BRAND_ID` int(10) NOT NULL AUTO_INCREMENT,
  `BRAND_NAME` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`BRAND_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `xly_pdt_bra` */

insert  into `xly_pdt_bra`(`BRAND_ID`,`BRAND_NAME`) values (1,'曼宜森'),(2,'布达米亚'),(3,'新圣悦'),(4,'牧梵');

/*Table structure for table `xly_pdt_gd` */

DROP TABLE IF EXISTS `xly_pdt_gd`;

CREATE TABLE `xly_pdt_gd` (
  `GRADES_ID` int(10) NOT NULL AUTO_INCREMENT,
  `GRADES_NAME` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`GRADES_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `xly_pdt_gd` */

insert  into `xly_pdt_gd`(`GRADES_ID`,`GRADES_NAME`) values (1,'优级'),(2,'优B'),(3,'一级'),(4,'合格'),(5,'次品_打包'),(6,'次品_未打包');

/*Table structure for table `xly_pdt_spec` */

DROP TABLE IF EXISTS `xly_pdt_spec`;

CREATE TABLE `xly_pdt_spec` (
  `SPEC_ID` int(5) NOT NULL AUTO_INCREMENT,
  `SPEC_NAME` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`SPEC_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `xly_pdt_spec` */

insert  into `xly_pdt_spec`(`SPEC_ID`,`SPEC_NAME`) values (1,'800*800');

/*Table structure for table `xly_pdt_stock` */

DROP TABLE IF EXISTS `xly_pdt_stock`;

CREATE TABLE `xly_pdt_stock` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `WAREHOUSE` varchar(10) NOT NULL,
  `PRODUCT_ID` int(10) NOT NULL,
  `STATE` smallint(1) DEFAULT '1' COMMENT '1为正常 0为冻结',
  `STOCK` int(10) DEFAULT NULL,
  `DATE_END` varchar(20) DEFAULT NULL,
  `CREATE_DATE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xly_pdt_stock` */

/*Table structure for table `xly_pdt_typ` */

DROP TABLE IF EXISTS `xly_pdt_typ`;

CREATE TABLE `xly_pdt_typ` (
  `TYPE_ID` int(10) NOT NULL AUTO_INCREMENT,
  `TYPE_NAME` varchar(10) DEFAULT NULL,
  `QTY` int(2) DEFAULT NULL,
  PRIMARY KEY (`TYPE_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `xly_pdt_typ` */

insert  into `xly_pdt_typ`(`TYPE_ID`,`TYPE_NAME`,`QTY`) values (1,'全抛釉',3),(2,'金刚石',2),(3,'超白坯',2);

/*Table structure for table `xly_pdt_typ_bra` */

DROP TABLE IF EXISTS `xly_pdt_typ_bra`;

CREATE TABLE `xly_pdt_typ_bra` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `TYPE_ID` int(10) DEFAULT NULL,
  `BRAND_ID` int(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `xly_pdt_typ_bra` */

insert  into `xly_pdt_typ_bra`(`ID`,`TYPE_ID`,`BRAND_ID`) values (1,1,1),(2,1,2),(3,1,3),(4,2,1),(5,2,2),(6,2,3),(7,3,4);

/*Table structure for table `xly_pdt_typ_gd_bm` */

DROP TABLE IF EXISTS `xly_pdt_typ_gd_bm`;

CREATE TABLE `xly_pdt_typ_gd_bm` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `TYPE_ID` int(10) DEFAULT NULL,
  `GRADES_ID` int(10) DEFAULT NULL,
  `BENCH_MARK` double DEFAULT NULL,
  `STATE` smallint(1) DEFAULT '1',
  `REMARK` varchar(50) DEFAULT NULL COMMENT '说明',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Data for the table `xly_pdt_typ_gd_bm` */

insert  into `xly_pdt_typ_gd_bm`(`ID`,`TYPE_ID`,`GRADES_ID`,`BENCH_MARK`,`STATE`,`REMARK`) values (1,1,1,21,1,NULL),(2,1,2,19,1,NULL),(3,1,3,16,1,NULL),(4,1,4,14,1,NULL),(5,1,5,8,1,NULL),(6,1,6,8,1,NULL),(7,2,1,24,1,NULL),(8,2,2,20,1,NULL),(9,2,3,19,1,NULL),(10,2,4,14,1,NULL),(11,2,5,8,1,NULL),(12,2,6,8,1,NULL),(13,3,1,30,1,NULL),(14,3,3,24,1,NULL),(15,3,4,18,1,NULL),(16,3,5,8,1,NULL),(17,3,6,8,1,NULL);

/*Table structure for table `xly_product` */

DROP TABLE IF EXISTS `xly_product`;

CREATE TABLE `xly_product` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TYPE_BRAND_ID` int(10) DEFAULT NULL,
  `CATEGORT` varchar(10) DEFAULT NULL,
  `PATTERN_NO` varchar(10) DEFAULT NULL,
  `COLOR` varchar(10) DEFAULT NULL,
  `GRADES_ID` int(10) DEFAULT NULL,
  `SPEC_ID` int(5) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xly_product` */

/*Table structure for table `xly_sale_pattern` */

DROP TABLE IF EXISTS `xly_sale_pattern`;

CREATE TABLE `xly_sale_pattern` (
  `SP_ID` int(10) NOT NULL AUTO_INCREMENT,
  `PATTERN_NO` varchar(8) DEFAULT NULL,
  `TYPE_ID` int(1) NOT NULL,
  `END_MONTH` varchar(7) NOT NULL,
  `GRADES_A` int(10) DEFAULT '0' COMMENT '优',
  `GRADES_B` int(10) DEFAULT '0' COMMENT '优B',
  `GRADES_C` int(10) DEFAULT '0' COMMENT '一级',
  `GRADES_D` int(10) DEFAULT '0' COMMENT '合格',
  `TOTAL_PACK` int(11) DEFAULT '0' COMMENT '总箱数',
  `CREATE_DATE` datetime DEFAULT NULL,
  `TOTAL_AREA` double DEFAULT '0' COMMENT '总面积 平米',
  `REMARK` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`SP_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xly_sale_pattern` */

/*Table structure for table `xly_sp_pdt_type` */

DROP TABLE IF EXISTS `xly_sp_pdt_type`;

CREATE TABLE `xly_sp_pdt_type` (
  `SP_ID` int(10) NOT NULL AUTO_INCREMENT,
  `PRODUCT_TYPE` int(1) NOT NULL,
  `END_MONTH` varchar(7) NOT NULL,
  `GRADES_A` int(10) DEFAULT '0' COMMENT '优',
  `GRADES_B` int(10) DEFAULT '0' COMMENT '优B',
  `GRADES_C` int(10) DEFAULT '0' COMMENT '一级',
  `GRADES_D` int(10) DEFAULT '0' COMMENT '合格',
  `GRADES_E` int(10) DEFAULT '0' COMMENT '次品',
  `TOTAL_PACK` int(11) DEFAULT '0' COMMENT '总箱数',
  `CREATE_DATE` date DEFAULT NULL,
  `TOTAL_AREA` double DEFAULT '0' COMMENT '总面积 平米',
  `SP_TYPE` char(2) NOT NULL COMMENT 'S表示销售 P表示生产',
  `SALE_PERCENT` double DEFAULT NULL COMMENT '销售占产量比',
  `REMARK` varchar(20) DEFAULT NULL,
  `QTY` int(1) DEFAULT NULL COMMENT '包装数',
  `MONTH_TOTAL_S` double DEFAULT '0' COMMENT '本月所有总类的总面积',
  `MONTH_TOTAL_P` double DEFAULT '0' COMMENT '本月所有总类的总面积生产',
  PRIMARY KEY (`SP_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xly_sp_pdt_type` */

/*Table structure for table `xly_wh_freeze` */

DROP TABLE IF EXISTS `xly_wh_freeze`;

CREATE TABLE `xly_wh_freeze` (
  `FREEZE_ID` int(10) NOT NULL AUTO_INCREMENT,
  `STOCK_ID` int(10) DEFAULT NULL,
  `CTM_ID` int(10) DEFAULT NULL,
  `WAREHOUSE` varchar(10) DEFAULT NULL,
  `COUNT` int(10) DEFAULT NULL,
  `CREATE_TIME` varchar(35) DEFAULT NULL,
  `CREATER` varchar(35) DEFAULT NULL,
  `END_DATE` varchar(35) DEFAULT NULL,
  `REMARK` varchar(100) DEFAULT NULL,
  `STATE` smallint(1) DEFAULT '1',
  PRIMARY KEY (`FREEZE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xly_wh_freeze` */

/*Table structure for table `xly_wh_record` */

DROP TABLE IF EXISTS `xly_wh_record`;

CREATE TABLE `xly_wh_record` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `WAREHOUSE` varchar(10) NOT NULL,
  `PRODUCT_ID` int(5) NOT NULL,
  `STOCK` int(10) NOT NULL DEFAULT '0',
  `CREATE_DATE` varchar(35) DEFAULT NULL,
  `CREATER` varchar(20) DEFAULT NULL,
  `PRODUCED_DATE` varchar(35) DEFAULT NULL,
  `CLASSES_ID` int(10) DEFAULT NULL,
  `TYPE_ID` int(1) DEFAULT '0',
  `REMARK` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xly_wh_record` */

/*Table structure for table `xly_wh_type` */

DROP TABLE IF EXISTS `xly_wh_type`;

CREATE TABLE `xly_wh_type` (
  `TYPE_ID` int(10) NOT NULL AUTO_INCREMENT,
  `TYPE_NAME` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`TYPE_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `xly_wh_type` */

insert  into `xly_wh_type`(`TYPE_ID`,`TYPE_NAME`) values (1,'正常'),(2,'增加库存'),(3,'减少库存'),(4,'破损处理'),(5,'导表入库');

/*Table structure for table `xly_year_month` */

DROP TABLE IF EXISTS `xly_year_month`;

CREATE TABLE `xly_year_month` (
  `ym` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xly_year_month` */

insert  into `xly_year_month`(`ym`) values ('2016-01'),('2016-02'),('2016-03'),('2016-04'),('2016-05'),('2016-06'),('2016-07'),('2016-08'),('2016-09'),('2016-10'),('2016-11'),('2016-12');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

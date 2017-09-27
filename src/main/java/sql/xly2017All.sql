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
) ENGINE=MyISAM AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;

/*Data for the table `xly_customer` */

insert  into `xly_customer`(`CTM_ID`,`CTM_NAME`,`TYPE_ID`,`ADDRESS`,`SHOP_NAME`,`SALES_MGR_ID`,`MONEY`,`GRT_MONEY`,`DEBT`) values (1,'零售',0,'无','无',27,'j',0,0),(2,'顾伟',2,'互助','店名测试',26,'j',0,0),(3,'黄金顺',2,'互助县城','',26,'j',0,0),(4,'黄金龙',2,'平安县城','',26,'j',0,0),(5,'陈颜青',2,'贵德县城','',26,'j',0,0),(6,'祁占禄',2,'大通','',26,'j',0,0),(7,'王精忠',2,'大通','',26,'j',0,0),(8,'张永青',2,'大通城关镇','',26,'j',0,0),(9,'胡宏斌',2,'大通县城','',26,'j',0,0),(10,'张官龙',2,'大通东峡','',26,'j',0,0),(11,'韩玉良',2,'大通塔尔镇','',26,'j',0,0),(12,'瓦金魁',2,'化隆县城','',26,'j',0,0),(13,'杜宏平',2,'都兰','',26,'j',0,0),(14,'王忠强',2,'都兰','',26,'j',0,0),(15,'邓小刚',2,'乐都','',26,'j',0,0),(16,'张吉善',2,'乐都','',26,'j',0,0),(17,'王志平',2,'乐都','',26,'j',0,0),(18,'哈忠辉',2,'民和县城','',26,'j',0,0),(19,'李兴中',2,'民和县西沟乡','',26,'j',0,0),(20,'冶成莫',2,'民和古鄯','',26,'j',0,0),(21,'刘永春',2,'民和巴州镇','',26,'j',0,0),(22,'王建广',2,'民和县城','',26,'j',0,0),(23,'谢有忠',2,'民和官亭','',26,'j',0,0),(24,'马富强',2,'民和李二堡镇','',26,'j',0,0),(25,'魏成富',2,'民和马营','',26,'j',0,0),(26,'马伟',2,'民和巴州镇','',26,'j',0,0),(27,'薜圣豹',2,'德令哈','',26,'j',0,0),(28,'刘彩华',2,'德令哈','',26,'j',0,0),(29,'林金辉',2,'格尔木','',26,'j',0,0),(30,'常充',2,'格尔木','',26,'j',0,0),(31,'林元锦',2,'格尔木','',26,'j',0,0),(32,'徐成杰',2,'格尔木','',26,'j',0,0),(33,'曾俊英',2,'西宁建国物流','',26,'j',0,0),(34,'郭贾林',2,'西宁建国物流','',26,'j',0,0),(35,'徐玉树',2,'西宁建国物流','',26,'j',0,0),(36,'田成',2,'西宁湟水河','',26,'j',0,0),(37,'林金旺',2,'西宁','',26,'j',0,0),(38,'尤德华',2,'西宁 ','',26,'j',0,0),(39,'马白克',2,'循化县街子镇','',26,'j',0,0),(40,'孔繁森',2,'门源县城','',26,'j',0,0),(41,'米金忠',2,'门源县克图口村','',26,'j',0,0),(42,'沈存昌',2,'门源青石咀','',26,'j',0,0),(43,'韩明德',2,'青海黄南','',26,'j',0,0),(44,'赵宝成',2,'湟中多巴镇','',26,'j',0,0),(45,'景占科',2,'湟中李家山镇','',26,'j',0,0),(46,'景宏业',2,'湟中兰隆口镇','',26,'j',0,0),(47,'肖永山',2,'湟中县大才乡','',26,'j',0,0),(48,'拜占全',2,'湟中上五庄','',26,'j',0,0),(49,'马启龙',2,'海西州乌兰县','',26,'j',0,0),(50,'鲍占吉',2,'海西州乌兰县','',26,'j',0,0),(51,'马秀英',2,'贵南县','',26,'j',0,0),(52,'李会明',2,'西藏那曲','',26,'j',0,0),(53,'陈刚',2,'西藏林芝','',26,'j',0,0),(54,'林',2,'拉萨','',26,'j',0,0),(55,'林/吴',2,'拉萨','',26,'j',0,0),(56,'严',2,'拉萨','',26,'j',0,0),(57,'林琳',2,'拉萨市天海建材市场33号','',26,'j',0,0),(58,'马强',2,'青海省泽库县','',26,'j',0,0),(59,'孙银宗',2,'青海贵南县','',26,'j',0,0),(60,'张永山',2,'果洛州玛沁大武镇','',26,'j',0,0),(61,'武',2,'果洛工地','',26,'j',0,0),(62,'颜文',2,'华隆牙什尕','',26,'j',0,0);

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

/* Trigger structure for table `bdf2_user_position` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `updateMgrName` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `updateMgrName` BEFORE INSERT ON `bdf2_user_position` FOR EACH ROW BEGIN
	set NEW.SALES_MGR_NAME=getMgrName(NEW.USERNAME_);
    END */$$


DELIMITER ;

/* Trigger structure for table `xly_ctm_bal` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `ctm-bal-createdate` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `ctm-bal-createdate` BEFORE INSERT ON `xly_ctm_bal` FOR EACH ROW BEGIN
	SET NEW.CREATE_DATE=NOW();
    END */$$


DELIMITER ;

/* Trigger structure for table `xly_customer` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `setCtmMoney` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `setCtmMoney` BEFORE INSERT ON `xly_customer` FOR EACH ROW BEGIN
	if NEW.MONEY is null or length(NEW.MONEY)<1 then
	SET  NEW.MONEY=ENCODE(0,'xly');
	end IF;
    END */$$


DELIMITER ;

/* Trigger structure for table `xly_sale_pattern` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `sale-pattern-createdate` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `sale-pattern-createdate` BEFORE INSERT ON `xly_sale_pattern` FOR EACH ROW BEGIN
    SET NEW.CREATE_DATE=NOW();
    END */$$


DELIMITER ;

/* Function  structure for function  `countTotalAmount` */

/*!50003 DROP FUNCTION IF EXISTS `countTotalAmount` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `countTotalAmount`(V_billNo int) RETURNS double
BEGIN
    DECLARE TOTAL_AMOUNT double DEFAULT 0;
	SELECT SUM(subTotal)+freight into TOTAL_AMOUNT FROM v_billrecord WHERE billNo=V_billNo;
	return TOTAL_AMOUNT;
    END */$$
DELIMITER ;

/* Function  structure for function  `dcoM` */

/*!50003 DROP FUNCTION IF EXISTS `dcoM` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `dcoM`(ctmId int) RETURNS double
BEGIN
    declare V_MONEY double default 0;
    SELECT DECODE(money,'xly') INTO V_MONEY FROM xly_customer WHERE CTM_ID=ctmId;
	return V_MONEY;
    END */$$
DELIMITER ;

/* Function  structure for function  `getBenchmarkByPId` */

/*!50003 DROP FUNCTION IF EXISTS `getBenchmarkByPId` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `getBenchmarkByPId`(pId int) RETURNS double
BEGIN
    declare V_benchmark double default 0;
    SELECT BENCHMARK into V_benchmark FROM v_product WHERE ID=pId;
    return V_benchmark;
	
    END */$$
DELIMITER ;

/* Function  structure for function  `getBenchmarkByStockId` */

/*!50003 DROP FUNCTION IF EXISTS `getBenchmarkByStockId` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `getBenchmarkByStockId`(stockId int) RETURNS double
BEGIN
    declare V_benchmark double default 0;
    SELECT BENCHMARK into V_benchmark FROM v_product WHERE ID= getPIdByStockId(stockId);
    return V_benchmark;
	
    END */$$
DELIMITER ;

/* Function  structure for function  `getMgrName` */

/*!50003 DROP FUNCTION IF EXISTS `getMgrName` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `getMgrName`(userName varchar(10) ) RETURNS varchar(10) CHARSET utf8
BEGIN
    declare  realName varchar(10);
	SELECT  u.`CNAME_` into realName FROM bdf2_user u WHERE u.`USERNAME_`=userName;
	RETURN realName;
    END */$$
DELIMITER ;

/* Function  structure for function  `getNowMonth` */

/*!50003 DROP FUNCTION IF EXISTS `getNowMonth` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `getNowMonth`() RETURNS varchar(7) CHARSET utf8
BEGIN
	RETURN (SELECT DATE_FORMAT(NOW(),'%Y-%m'));
    END */$$
DELIMITER ;

/* Function  structure for function  `getPIdByStockId` */

/*!50003 DROP FUNCTION IF EXISTS `getPIdByStockId` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `getPIdByStockId`(stockId int) RETURNS int(11)
BEGIN
    declare  pId int default 0;
	 SELECT PRODUCT_ID into pId FROM xly_pdt_stock WHERE ID = stockId;
	 RETURN pId;
    END */$$
DELIMITER ;

/* Function  structure for function  `sp_cn` */

/*!50003 DROP FUNCTION IF EXISTS `sp_cn` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `sp_cn`(n_LowerMoney  decimal(15,2)) RETURNS varchar(200) CHARSET utf8
begin
Declare v_LowerStr  VARCHAR(200) ;
Declare v_UpperPart VARCHAR(200) ;
Declare v_UpperStr VARCHAR(200) ;
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

/* Procedure structure for procedure `addBatchBillRecord` */

/*!50003 DROP PROCEDURE IF EXISTS  `addBatchBillRecord` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `addBatchBillRecord`(
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

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `batchUpdateBillTotal`()
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

/* Procedure structure for procedure `creatMonth` */

/*!50003 DROP PROCEDURE IF EXISTS  `creatMonth` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `creatMonth`()
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

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `dcoMoney`(in ctmId int)
BEGIN
	 SELECT DECODE(money,'xly') money from xly_customer where CTM_ID=ctmId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `delAndRevert` */

/*!50003 DROP PROCEDURE IF EXISTS  `delAndRevert` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `delAndRevert`(
IN recordId int,
out result boolean
)
BEGIN
declare  num int default 0;
DECLARE OPT_TYPE INT DEFAULT 0;
select  STOCK,TYPE_ID into num,OPT_TYPE from xly_wh_record whr where whr.ID=recordId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `delBrByBillNo` */

/*!50003 DROP PROCEDURE IF EXISTS  `delBrByBillNo` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `delBrByBillNo`(billNo int)
BEGIN
    DELETE FROM xly_bill  WHERE BILL_NO=billNo;
    DELETE FROM xly_bill_record WHERE BILL_NO=billNo;
    
    END */$$
DELIMITER ;

/* Procedure structure for procedure `deleteImportStock` */

/*!50003 DROP PROCEDURE IF EXISTS  `deleteImportStock` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `deleteImportStock`()
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

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `lastMonthCtmBal`()
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
    INSERT INTO xly_ctm_bal (CTM_ID,BALANCE,END_MONTH)VALUES (V_CTMID,V_MONEY,DATE_SUB(NOW(),INTERVAL 1 MONTH));
  END LOOP;
  CLOSE cur;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `resetAllXly` */

/*!50003 DROP PROCEDURE IF EXISTS  `resetAllXly` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `resetAllXly`(V_NEED int)
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

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `setMoney`(IN ctmId INT,IN money double)
BEGIN
	 update xly_customer set  money=encode(money,'xly')  where CTM_ID=ctmId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `setSaleMgrCtmCount` */

/*!50003 DROP PROCEDURE IF EXISTS  `setSaleMgrCtmCount` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `setSaleMgrCtmCount`(IN V_MONTH VARCHAR(7))
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

/* Procedure structure for procedure `sortCtmBuy` */

/*!50003 DROP PROCEDURE IF EXISTS  `sortCtmBuy` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `sortCtmBuy`(IN V_MONTH VARCHAR(7))
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
    -- Id和月份确定唯一行
	select count(*) into V_RECORD_COUNT from xly_ctm_buy cb where  cb.`CTM_ID`=V_CTM_ID AND END_MONTH=V_MONTH;
    -- 这里做你想做的循环的事件
	IF V_RECORD_COUNT = 0 THEN
	insert into xly_ctm_buy(SALE_MGR_ID,SALE_MGR_NAME,CTM_ID,CTM_NAME,CREATE_DATE,END_MONTH) 
	values(V_SALE_MGR_ID,V_SALE_MGR_NAME,V_CTM_ID,V_CTM_NAME,now(),V_MONTH);
	end IF;
	-- 11是曼宜森--全抛釉
	if V_BRAND_ID=1 and V_TYPE_ID=1 then
	update xly_ctm_buy set MYS_Q=MYS_Q+V_AMOUNT WHERE  CTM_ID=V_CTM_ID AND END_MONTH=V_MONTH;
	-- 12是曼宜森--金刚石
	ELSEIF V_BRAND_ID=1 AND V_TYPE_ID=2 THEN
	UPDATE xly_ctm_buy SET MYS_J=MYS_J+V_AMOUNT WHERE  CTM_ID=V_CTM_ID  AND END_MONTH=V_MONTH;
	-- 21是布达米亚--全抛釉
	ELSEIF V_BRAND_ID=2 AND V_TYPE_ID=1 THEN
	UPDATE xly_ctm_buy SET BDMY_Q=BDMY_Q+V_AMOUNT WHERE  CTM_ID=V_CTM_ID  AND END_MONTH=V_MONTH;
	-- 22是布达米亚--金刚石
	ELSEIF V_BRAND_ID=2 AND V_TYPE_ID=2 THEN
	UPDATE xly_ctm_buy SET BDMY_J=BDMY_J+V_AMOUNT WHERE  CTM_ID=V_CTM_ID AND END_MONTH=V_MONTH;
	-- 31是新圣悦--全抛釉
	ELSEIF V_BRAND_ID=3 AND V_TYPE_ID=1 THEN
	UPDATE xly_ctm_buy SET XSY_Q=XSY_Q+V_AMOUNT WHERE  CTM_ID=V_CTM_ID AND END_MONTH=V_MONTH;
	-- 32是新圣悦--金刚石
	ELSEIF V_BRAND_ID=3 AND V_TYPE_ID=2 THEN
	UPDATE xly_ctm_buy SET XSY_J=XSY_J+V_AMOUNT WHERE  CTM_ID=V_CTM_ID AND END_MONTH=V_MONTH;
	-- 43是牧梵--超白坯
	ELSE 
	UPDATE xly_ctm_buy SET MF_C=MF_C+V_AMOUNT WHERE  CTM_ID=V_CTM_ID AND END_MONTH=V_MONTH;
	SET @a=@a+1;
    END IF;
  END LOOP;
  CLOSE cur;  
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sortProduceByType` */

/*!50003 DROP PROCEDURE IF EXISTS  `sortProduceByType` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `sortProduceByType`(
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

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `sortSaleByType`(
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

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `testPrint`(OUT p_out varchar (100))
BEGIN
	set p_out='返回测试成功！';
    END */$$
DELIMITER ;

/* Procedure structure for procedure `unFreezeStock` */

/*!50003 DROP PROCEDURE IF EXISTS  `unFreezeStock` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `unFreezeStock`(OUT p_out VARCHAR (100))
BEGIN
DECLARE F_ID INT (11) ;
DECLARE STOCK_ID int (11) ;
DECLARE STOCK_COUNT INT (11) ;
DECLARE CUR_RECORD CURSOR FOR 
SELECT whf.FREEZE_ID,whf.STOCK_ID ,whf.COUNT FROm  xly_wh_freeze whf 
  WHERE str_to_date(whf.END_DATE,'%Y-%m-%d')<now() ;
  DECLARE EXIT HANDLER FOR NOT FOUND CLOSE CUR_RECORD;  
  SET p_out="";
  open CUR_RECORD;
  REPEAT  
  FETCH CUR_RECORD INTO F_ID,STOCK_ID,STOCK_COUNT;  
/**	
 select F_ID,STOCK_ID,STOCK_COUNT;
 **/
	UPDATE `xly_wh_freeze` SET STATE = 0 WHERE FREEZE_ID=F_ID;
    update xly_pdt_stock set STOCK = STOCK+STOCK_COUNT where ID=STOCK_ID;
    
  SET p_out=p_out+":"+F_ID;    
  UNTIL 0 END REPEAT;
  CLOSE CUR_RECORD;  
  END */$$
DELIMITER ;

/*Table structure for table `v_balrecord` */

DROP TABLE IF EXISTS `v_balrecord`;

/*!50001 DROP VIEW IF EXISTS `v_balrecord` */;
/*!50001 DROP TABLE IF EXISTS `v_balrecord` */;

/*!50001 CREATE TABLE  `v_balrecord`(
 `balId` int(10) ,
 `creater` varchar(10) ,
 `createTime` varchar(30) ,
 `optType` varchar(10) ,
 `ctmName` varchar(10) ,
 `amount` double ,
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
 `ctmName` varchar(10) ,
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
 `ctmName` varchar(10) ,
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
 `totalAmount` double ,
 `subTotal` double ,
 `ctmName` varchar(10) ,
 `ctmId` int(10) ,
 `salesMgrId` int(10) ,
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
 `ctmName` varchar(10) ,
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
 `ctmName` varchar(10) ,
 `typeId` smallint(6) ,
 `address` varchar(30) ,
 `shopName` varchar(30) ,
 `salesMgrId` int(10) ,
 `money` text ,
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
 `carNo` varchar(10) ,
 `creater` varchar(10) ,
 `driverPhone` varchar(12) ,
 `freight` int(20) ,
 `remark` varchar(35) ,
 `bState` smallint(1) ,
 `count` int(10) ,
 `price` double ,
 `subTotal` double ,
 `recordId` int(10) ,
 `ctmName` varchar(10) ,
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
 `ctmName` varchar(10) ,
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
 `carNo` varchar(10) ,
 `creater` varchar(10) ,
 `driverPhone` varchar(12) ,
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

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_balrecord` AS select `br`.`BAL_ID` AS `balId`,`br`.`CREATER` AS `creater`,`br`.`CREATE_TIME` AS `createTime`,`br`.`OPT_TYPE` AS `optType`,`ctm`.`CTM_NAME` AS `ctmName`,`br`.`AMOUNT` AS `amount`,`ctm`.`ADDRESS` AS `address` from (`xly_bal_record` `br` join `xly_customer` `ctm`) where (`ctm`.`CTM_ID` = `br`.`CTM_ID`) */;

/*View structure for view v_billrecord */

/*!50001 DROP TABLE IF EXISTS `v_billrecord` */;
/*!50001 DROP VIEW IF EXISTS `v_billrecord` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_billrecord` AS select `b`.`BILL_NO` AS `billNo`,lpad(`b`.`BILL_NO`,7,0) AS `billNoStr`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`CAR_NO` AS `carNo`,`b`.`CREATER` AS `creater`,`b`.`DRIVER_PHONE` AS `driverPhone`,`b`.`FREIGHT` AS `freight`,`b`.`REMARK` AS `remark`,`b`.`STATE` AS `bState`,`br`.`COUNT` AS `count`,`br`.`PRICE` AS `price`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,((`br`.`COUNT` * `br`.`PRICE`) * `vs`.`QTY`) AS `subTotal`,`br`.`RECORD_ID` AS `recordId`,`ctm`.`CTM_NAME` AS `ctmName`,`ctm`.`CTM_ID` AS `ctmId`,`ctm`.`ADDRESS` AS `address`,`ctm`.`SALES_MGR_ID` AS `salesMgrId`,`vs`.`STOCK_ID` AS `stockId`,`vs`.`WAREHOUSE` AS `warehouse`,`vs`.`STATE` AS `state`,`vs`.`STOCK` AS `stock`,`vs`.`ID` AS `id`,`vs`.`CATEGORT` AS `categort`,`vs`.`COLOR` AS `color`,`vs`.`PATTERN_NO` AS `patternNo`,`vs`.`BRAND_NAME` AS `brandName`,`vs`.`BRAND_ID` AS `brandId`,`vs`.`GRADES_NAME` AS `gradesName`,`vs`.`SPEC_ID` AS `specId`,`vs`.`SPEC_NAME` AS `specName`,`vs`.`TYPE_NAME` AS `typeName`,`vs`.`QTY` AS `qty`,(`br`.`COUNT` * `vs`.`QTY`) AS `qtyCount`,`vs`.`GRADES_ID` AS `gradesId`,`vs`.`TYPE_ID` AS `typeId`,`mgr`.`salesMgrName` AS `mgrName` from ((((`xly_bill` `b` join `xly_bill_record` `br`) join `xly_customer` `ctm`) join `v_mgr` `mgr`) join `v_stock` `vs`) where ((`b`.`BILL_NO` = `br`.`BILL_NO`) and (`b`.`CTM_ID` = `ctm`.`CTM_ID`) and (`mgr`.`salesMgrId` = `ctm`.`SALES_MGR_ID`) and (`br`.`STOCK_ID` = `vs`.`STOCK_ID`)) order by `b`.`BILL_NO` desc */;

/*View structure for view v_billrecord_fake */

/*!50001 DROP TABLE IF EXISTS `v_billrecord_fake` */;
/*!50001 DROP VIEW IF EXISTS `v_billrecord_fake` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_billrecord_fake` AS select `b`.`BILL_NO` AS `billNo`,lpad(`b`.`BILL_NO`,7,0) AS `billNoStr`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`CAR_NO` AS `carNo`,`b`.`CREATER` AS `creater`,`b`.`DRIVER_PHONE` AS `driverPhone`,`b`.`FREIGHT` AS `freight`,`b`.`REMARK` AS `remark`,`b`.`STATE` AS `bState`,`br`.`COUNT` AS `count`,`br`.`PRICE` AS `price`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,((`br`.`COUNT` * `br`.`PRICE`) * `vs`.`QTY`) AS `subTotal`,`br`.`RECORD_ID` AS `recordId`,`ctm`.`CTM_NAME` AS `ctmName`,`ctm`.`CTM_ID` AS `ctmId`,`ctm`.`ADDRESS` AS `address`,`ctm`.`SALES_MGR_ID` AS `salesMgrId`,`vs`.`STOCK_ID` AS `stockId`,`vs`.`WAREHOUSE` AS `warehouse`,`vs`.`STATE` AS `state`,`vs`.`STOCK` AS `stock`,`vs`.`ID` AS `id`,`vs`.`CATEGORT` AS `categort`,`vs`.`COLOR` AS `color`,`vs`.`PATTERN_NO` AS `patternNo`,`vs`.`BRAND_NAME` AS `brandName`,`vs`.`BRAND_ID` AS `brandId`,`vs`.`GRADES_NAME` AS `gradesName`,`vs`.`SPEC_ID` AS `specId`,`vs`.`SPEC_NAME` AS `specName`,`vs`.`TYPE_NAME` AS `typeName`,`vs`.`QTY` AS `qty`,(`br`.`COUNT` * `vs`.`QTY`) AS `qtyCount`,`vs`.`GRADES_ID` AS `gradesId`,`vs`.`TYPE_ID` AS `typeId`,`mgr`.`salesMgrName` AS `mgrName` from ((((`xly_bill_fake` `b` join `xly_bill_record_fake` `br`) join `xly_customer` `ctm`) join `v_mgr` `mgr`) join `v_stock` `vs`) where ((`b`.`BILL_NO` = `br`.`BILL_NO`) and (`b`.`CTM_ID` = `ctm`.`CTM_ID`) and (`mgr`.`salesMgrId` = `ctm`.`SALES_MGR_ID`) and (`br`.`STOCK_ID` = `vs`.`STOCK_ID`)) order by `b`.`BILL_NO` desc */;

/*View structure for view v_billrecord_simple */

/*!50001 DROP TABLE IF EXISTS `v_billrecord_simple` */;
/*!50001 DROP VIEW IF EXISTS `v_billrecord_simple` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_billrecord_simple` AS select `b`.`BILL_NO` AS `billNo`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`STATE` AS `bState`,`br`.`COUNT` AS `count`,`br`.`PRICE` AS `price`,`br`.`BENCHMARK` AS `benchmark`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,((`br`.`COUNT` * `br`.`PRICE`) * `vs`.`QTY`) AS `subTotal`,`ctm`.`CTM_NAME` AS `ctmName`,`ctm`.`CTM_ID` AS `ctmId`,`ctm`.`SALES_MGR_ID` AS `salesMgrId`,`ctm`.`ADDRESS` AS `address`,`vs`.`BRAND_NAME` AS `brandName`,`vs`.`BRAND_ID` AS `brandId`,`vs`.`GRADES_NAME` AS `gradesName`,`vs`.`TYPE_NAME` AS `typeName`,`vs`.`QTY` AS `qty`,(`br`.`COUNT` * `vs`.`QTY`) AS `qtyCount`,`vs`.`GRADES_ID` AS `gradesId`,`vs`.`TYPE_ID` AS `typeId`,`mgr`.`salesMgrName` AS `mgrName` from ((((`xly_bill` `b` join `xly_bill_record` `br`) join `xly_customer` `ctm`) join `v_mgr` `mgr`) join `v_stock` `vs`) where ((`b`.`BILL_NO` = `br`.`BILL_NO`) and (`b`.`CTM_ID` = `ctm`.`CTM_ID`) and (`mgr`.`salesMgrId` = `ctm`.`SALES_MGR_ID`) and (`br`.`STOCK_ID` = `vs`.`STOCK_ID`)) order by `b`.`BILL_NO` desc */;

/*View structure for view v_billrecord_sp */

/*!50001 DROP TABLE IF EXISTS `v_billrecord_sp` */;
/*!50001 DROP VIEW IF EXISTS `v_billrecord_sp` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_billrecord_sp` AS select `b`.`BILL_NO` AS `billNo`,lpad(`b`.`BILL_NO`,7,0) AS `billNoStr`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`CAR_NO` AS `carNo`,`b`.`CREATER` AS `creater`,`b`.`DRIVER_PHONE` AS `driverPhone`,`b`.`FREIGHT` AS `freight`,`b`.`REMARK` AS `remark`,`b`.`STATE` AS `bState`,`br`.`COUNT` AS `count`,`br`.`PRICE` AS `price`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,((`br`.`COUNT` * `br`.`PRICE`) * `vs`.`QTY`) AS `subTotal`,`br`.`RECORD_ID` AS `recordId`,`vs`.`STOCK_ID` AS `stockId`,`vs`.`WAREHOUSE` AS `warehouse`,`vs`.`STATE` AS `state`,`vs`.`STOCK` AS `stock`,`vs`.`ID` AS `id`,`vs`.`CATEGORT` AS `categort`,`vs`.`COLOR` AS `color`,`vs`.`PATTERN_NO` AS `patternNo`,`vs`.`BRAND_NAME` AS `brandName`,`vs`.`BRAND_ID` AS `brandId`,`vs`.`GRADES_NAME` AS `gradesName`,`vs`.`SPEC_ID` AS `specId`,`vs`.`SPEC_NAME` AS `specName`,`vs`.`TYPE_NAME` AS `typeName`,`vs`.`QTY` AS `qty`,(`br`.`COUNT` * `vs`.`QTY`) AS `qtyCount`,`vs`.`GRADES_ID` AS `gradesId`,`vs`.`TYPE_ID` AS `typeId` from ((`xly_bill` `b` join `xly_bill_record` `br`) join `v_stock` `vs`) where ((`b`.`BILL_NO` = `br`.`BILL_NO`) and (`br`.`STOCK_ID` = `vs`.`STOCK_ID`) and (`b`.`STATE` = 1)) order by `b`.`BILL_NO` desc */;

/*View structure for view v_buy_record */

/*!50001 DROP TABLE IF EXISTS `v_buy_record` */;
/*!50001 DROP VIEW IF EXISTS `v_buy_record` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_buy_record` AS select `b`.`BILL_NO` AS `billNo`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`FREIGHT` AS `freight`,`b`.`REMARK` AS `remark`,`b`.`STATE` AS `bState`,`br`.`COUNT` AS `count`,`br`.`PRICE` AS `price`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,((`br`.`COUNT` * `br`.`PRICE`) * `vs`.`QTY`) AS `subTotal`,`br`.`RECORD_ID` AS `recordId`,`ctm`.`CTM_NAME` AS `ctmName`,`ctm`.`CTM_ID` AS `ctmId`,`ctm`.`SALES_MGR_ID` AS `salesMgrId`,`vs`.`STOCK_ID` AS `stockId`,`vs`.`WAREHOUSE` AS `warehouse`,`vs`.`STATE` AS `state`,`vs`.`STOCK` AS `stock`,`vs`.`BRAND_NAME` AS `brandName`,`vs`.`BRAND_ID` AS `brandId`,`vs`.`GRADES_NAME` AS `gradesName`,`vs`.`TYPE_NAME` AS `typeName`,`vs`.`QTY` AS `qty`,(`br`.`COUNT` * `vs`.`QTY`) AS `qtyCount`,`vs`.`GRADES_ID` AS `gradesId`,`vs`.`TYPE_ID` AS `typeId`,`mgr`.`salesMgrName` AS `salesMgrName` from ((((`xly_bill` `b` join `xly_bill_record` `br`) join `xly_customer` `ctm`) join `v_mgr` `mgr`) join `v_stock` `vs`) where ((`b`.`BILL_NO` = `br`.`BILL_NO`) and (`b`.`CTM_ID` = `ctm`.`CTM_ID`) and (`b`.`STATE` = 1) and (`mgr`.`salesMgrId` = `ctm`.`SALES_MGR_ID`) and (`br`.`STOCK_ID` = `vs`.`STOCK_ID`)) */;

/*View structure for view v_customer */

/*!50001 DROP TABLE IF EXISTS `v_customer` */;
/*!50001 DROP VIEW IF EXISTS `v_customer` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_customer` AS select `cmt`.`CTM_ID` AS `ctmId`,`cmt`.`CTM_NAME` AS `ctmName`,`cmt`.`TYPE_ID` AS `typeId`,`cmt`.`ADDRESS` AS `address`,`cmt`.`SHOP_NAME` AS `shopName`,`cmt`.`SALES_MGR_ID` AS `salesMgrId`,convert(decode(`cmt`.`MONEY`,'xly') using utf8) AS `money`,`cmt`.`GRT_MONEY` AS `grtMoney`,`cmt`.`DEBT` AS `debt`,`mgr`.`SALES_MGR_NAME` AS `salesMgrName` from (`xly_customer` `cmt` join `bdf2_user_position` `mgr`) where (`mgr`.`SALES_MGR_ID` = `cmt`.`SALES_MGR_ID`) order by `cmt`.`CTM_ID` desc */;

/*View structure for view v_drop_record */

/*!50001 DROP TABLE IF EXISTS `v_drop_record` */;
/*!50001 DROP VIEW IF EXISTS `v_drop_record` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_drop_record` AS select `db`.`BILL_NO` AS `BILL_NO`,`db`.`CREATER` AS `dropCreater`,`db`.`CREATE_DATE` AS `dropDate`,`db`.`REASON` AS `reason`,`vb`.`billNo` AS `billNo`,`vb`.`billNoStr` AS `billNoStr`,`vb`.`billTime` AS `billTime`,`vb`.`billType` AS `billType`,`vb`.`carNo` AS `carNo`,`vb`.`creater` AS `creater`,`vb`.`driverPhone` AS `driverPhone`,`vb`.`freight` AS `freight`,`vb`.`remark` AS `remark`,`vb`.`bState` AS `bState`,`vb`.`count` AS `count`,`vb`.`price` AS `price`,`vb`.`subTotal` AS `subTotal`,`vb`.`recordId` AS `recordId`,`vb`.`ctmName` AS `ctmName`,`vb`.`ctmId` AS `ctmId`,`vb`.`address` AS `address`,`vb`.`salesMgrId` AS `salesMgrId`,`vb`.`stockId` AS `stockId`,`vb`.`warehouse` AS `warehouse`,`vb`.`state` AS `state`,`vb`.`stock` AS `stock`,`vb`.`id` AS `id`,`vb`.`categort` AS `categort`,`vb`.`color` AS `color`,`vb`.`patternNo` AS `patternNo`,`vb`.`brandName` AS `brandName`,`vb`.`brandId` AS `brandId`,`vb`.`gradesName` AS `gradesName`,`vb`.`specId` AS `specId`,`vb`.`specName` AS `specName`,`vb`.`typeName` AS `typeName`,`vb`.`qty` AS `qty`,`vb`.`gradesId` AS `gradesId`,`vb`.`typeId` AS `typeId`,`vb`.`mgrName` AS `mgrName` from (`xly_drop_bill` `db` join `v_billrecord` `vb`) where (`db`.`BILL_NO` = `vb`.`billNo`) */;

/*View structure for view v_freeze */

/*!50001 DROP TABLE IF EXISTS `v_freeze` */;
/*!50001 DROP VIEW IF EXISTS `v_freeze` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_freeze` AS select `whf`.`FREEZE_ID` AS `freezeId`,`whf`.`STOCK_ID` AS `stockId`,`whf`.`WAREHOUSE` AS `warehouse`,`ctm`.`CTM_NAME` AS `ctmName`,`whf`.`CTM_ID` AS `ctmId`,`whf`.`COUNT` AS `count`,`whf`.`CREATE_TIME` AS `createTime`,`whf`.`CREATER` AS `creater`,`whf`.`END_DATE` AS `endDate`,`whf`.`REMARK` AS `remark`,`whf`.`STATE` AS `state`,`vp`.`BRAND_NAME` AS `brandName`,`vp`.`TYPE_NAME` AS `typeName`,`vp`.`CATEGORT` AS `categort`,`vp`.`COLOR` AS `color`,`vp`.`GRADES_NAME` AS `gradesName`,`vp`.`PATTERN_NO` AS `patternNo`,`vp`.`SPEC_NAME` AS `specName` from (((`xly_customer` `ctm` join `xly_wh_freeze` `whf`) join `xly_pdt_stock` `pdts`) join `v_productall` `vp`) where ((`ctm`.`CTM_ID` = `whf`.`CTM_ID`) and (`whf`.`STOCK_ID` = `pdts`.`ID`) and (`pdts`.`PRODUCT_ID` = `vp`.`ID`) and (`whf`.`STATE` = 1)) order by `whf`.`FREEZE_ID` desc */;

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

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_productall` AS select `vp`.`ID` AS `ID`,`pt`.`TYPE_NAME` AS `TYPE_NAME`,`pb`.`BRAND_NAME` AS `BRAND_NAME`,`vp`.`CATEGORT` AS `CATEGORT`,`vp`.`COLOR` AS `COLOR`,`vp`.`BENCHMARK` AS `BENCHMARK`,`vp`.`PATTERN_NO` AS `PATTERN_NO`,`vp`.`BRAND_ID` AS `BRAND_ID`,`pg`.`GRADES_ID` AS `GRADES_ID`,`pg`.`GRADES_NAME` AS `GRADES_NAME`,`ps`.`SPEC_NAME` AS `SPEC_NAME`,`pt`.`QTY` AS `QTY`,`pt`.`TYPE_ID` AS `TYPE_ID`,`ps`.`SPEC_ID` AS `SPEC_ID` from ((((`v_product` `vp` join `xly_pdt_bra` `pb`) join `xly_pdt_gd` `pg`) join `xly_pdt_spec` `ps`) join `xly_pdt_typ` `pt`) where ((`vp`.`BRAND_ID` = `pb`.`BRAND_ID`) and (`vp`.`GRADES_ID` = `pg`.`GRADES_ID`) and (`vp`.`SPEC_ID` = `ps`.`SPEC_ID`) and (`vp`.`TYPE_ID` = `pt`.`TYPE_ID`)) */;

/*View structure for view v_simple_bill */

/*!50001 DROP TABLE IF EXISTS `v_simple_bill` */;
/*!50001 DROP VIEW IF EXISTS `v_simple_bill` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_simple_bill` AS select `b`.`BILL_NO` AS `billNo`,lpad(`b`.`BILL_NO`,7,0) AS `billNoStr`,`b`.`BILL_TIME` AS `billTime`,`b`.`BILL_TYPE` AS `billType`,`b`.`CAR_NO` AS `carNo`,`b`.`CREATER` AS `creater`,`b`.`DRIVER_PHONE` AS `driverPhone`,`b`.`FREIGHT` AS `freight`,`b`.`TOTAL_AMOUNT` AS `totalAmount`,`b`.`CTM_ID` AS `ctmId`,`ctm`.`SALES_MGR_ID` AS `salesMgrId`,`b`.`REMARK` AS `remark` from (`xly_bill` `b` join `xly_customer` `ctm`) where ((`b`.`CTM_ID` = `ctm`.`CTM_ID`) and (`b`.`STATE` = 1)) */;

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

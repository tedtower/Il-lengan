-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: illengan
-- ------------------------------------------------------
-- Server version	5.7.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_type` enum('Admin','Barista','Chef') NOT NULL,
  `account_username` varchar(15) NOT NULL,
  `account_password` varchar(20) NOT NULL,
  `is_online` enum('y','n') DEFAULT 'n',
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'Barista','barista1','barista1','n'),(2,'Barista','barista2','barista2','n'),(4,'Admin','admin','admin','n'),(5,'Chef','chef','chef1','n'),(6,'Admin','admin2','admin2','n'),(7,'Chef','chef2','chef2','n');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_type` enum('Menu','Inventory') NOT NULL,
  `category_name` varchar(45) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Inventory','Syrup'),(2,'Inventory','Refreshments'),(3,'Inventory','Coffee Beans'),(4,'Inventory','Ice Cream'),(5,'Inventory','Sauce'),(6,'Inventory','Flavored Powders'),(7,'Inventory','Dairy'),(8,'Inventory','Pasta'),(9,'Inventory','Tea'),(10,'Menu','Drinks'),(11,'Menu','Meals'),(12,'Menu','Dessert');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `damages`
--

DROP TABLE IF EXISTS `damages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `damages` (
  `damage_id` int(11) NOT NULL,
  `damage_type` enum('inventory','menu') NOT NULL,
  `damage_quantity` int(11) NOT NULL,
  `date_recorded` date NOT NULL,
  `damage_reason` varchar(100) NOT NULL,
  `stock_id` int(11) DEFAULT NULL,
  `menu_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`damage_id`),
  KEY `stock_idx` (`stock_id`),
  KEY `menu_idx` (`menu_id`),
  CONSTRAINT `menu` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`menu_id`) ON UPDATE CASCADE,
  CONSTRAINT `stock` FOREIGN KEY (`stock_id`) REFERENCES `stockitems` (`stock_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `damages`
--

LOCK TABLES `damages` WRITE;
/*!40000 ALTER TABLE `damages` DISABLE KEYS */;
/*!40000 ALTER TABLE `damages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `stock_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `log_date` date NOT NULL,
  `log_type` enum('restock','destock') NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `stock_id_idx` (`stock_id`),
  CONSTRAINT `stock_id` FOREIGN KEY (`stock_id`) REFERENCES `stockitems` (`stock_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(45) NOT NULL,
  `menu_description` varchar(200) NOT NULL,
  `menu_price` int(11) NOT NULL,
  `menu_availability` enum('Available','Unavailable') NOT NULL,
  `menu_image` varchar(45) NOT NULL,
  `size` varchar(45) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`menu_id`),
  KEY `category_idx` (`category_id`),
  CONSTRAINT `category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'Hazelnut Frappe','N/a',130,'Available','N/a','N/a',10),(2,'Caramel Frappe','N/a',130,'Available','N/a','N/a',10),(3,'Light Mocha Frappe','N/a',130,'Available','N/a','N/a',10),(4,'Strawberry Frappe','N/a',140,'Unavailable','N/a','N/a',10),(5,'Matcha Frappe','N/a',140,'Available','N/a','N/a',10),(6,'Chocolate Frappe','N/a',140,'Available','N/a','N/a',10),(7,'Pesto','N/a',140,'Available','N/a','N/a',11),(8,'Italian','N/a',140,'Available','N/a','N/a',11),(9,'Carbonara','N/a',140,'Available','N/a','N/a',11),(10,'Animal Fries','N/a',135,'Available','N/a','N/a',11),(11,'French Fries','N/a',95,'Available','N/a','N/a',11),(17,'Nachos','N/a',95,'Available','N/a','N/a',11),(18,'Buffalo Wings','N/a',165,'Available','N/a','N/a',11),(19,'Bacon Cheese Burger','N/a',140,'Available','N/a','N/a',11),(20,'Fish Fillet w/ Mango Sauce','N/a',165,'Available','N/a','N/a',11),(21,'Crispy Wings','N/a',150,'Available','N/a','N/a',11),(22,'Chicken Quesadilla','N/a',145,'Available','N/a','N/a',11),(23,'Fresh Lumpia','N/a',65,'Available','N/a','N/a',11),(24,'Fish and Chips','N/a',135,'Available','N/a','N/a',11),(25,'Clubhouse Sandwich','N/a',135,'Available','N/a','N/a',11),(26,'Waffles and bacon','N/a',105,'Available','N/a','N/a',11),(27,'Pesto melt','N/a',150,'Available','N/a','N/a',11),(28,'Chicken Sandwich','N/a',150,'Available','N/a','N/a',11),(29,'Baby back ribs','N/a',260,'Available','N/a','N/a',11),(35,'Wicked Oreos','N/a',100,'Available','N/a','N/a',12),(36,'Crepe','N/a',80,'Available','N/a','N/a',12),(37,'Turon ala Mode','N/a',95,'Available','N/a','N/a',11),(38,'Cakes','N/a',0,'Available','N/a','N/a',12),(39,'Caramel Frappe','N/a',140,'Available','N/a','N/a',10),(43,'Long Black/ Americano','N/a',80,'Available','N/a','N/a',10),(44,'Cappuccino','N/a',80,'Available','N/a','N/a',10),(45,'Vanilla Espresso','N/a',100,'Available','N/a','N/a',10),(51,'Hazelnut Espresso','N/a',100,'Available','N/a','N/a',10),(52,'Caramel Espresso','N/a',100,'Available','N/a','N/a',10),(53,'Caramel Macchiato Espresso','N/a',110,'Available','N/a','N/a',10),(54,'Cafe Latte Espresso','N/a',80,'Available','N/a','N/a',10),(60,'Benguet Coffee-Solo','N/a',60,'Available','N/a','N/a',10),(61,'Kalinga/Sagada Coffee-Solo','N/a',70,'Available','N/a','N/a',10),(62,'Cordillera City (Medium) Roast-Solo','N/a',90,'Available','N/a','N/a',10),(63,'Cordillera City (Dark) Roast-Solo','N/a',90,'Available','N/a','N/a',10),(64,'Benguet Coffee-Jumbo','N/a',110,'Available','N/a','N/a',10),(65,'Kalinga/Sagada Coffee-Jumbo','N/a',130,'Available','N/a','N/a',10),(66,'Cordillera City (Medium)-Jumbo','N/a',170,'Available','N/a','N/a',10),(67,'Cordillera City (Dark)-Jumbo','N/a',170,'Available','N/a','N/a',10),(68,'Honey-coated Lemon','N/a',120,'Available','N/a','N/a',10),(69,'Chamomile','N/a',110,'Available','N/a','N/a',10),(70,'Red Rose Bud','N/a',100,'Available','N/a','N/a',10),(71,'(HOT) Pakpakyaw (Butterfly) Pea','N/a',110,'Available','N/a','N/a',10),(72,'(ICED) Pakpakyaw (Butterfly) Pea','N/a',120,'Available','N/a','N/a',10),(73,'Matcha Latte','N/a',110,'Available','N/a','N/a',10),(74,'Hot Choco','N/a',90,'Available','N/a','N/a',10),(75,'Mango Canned Juice','N/a',55,'Available','N/a','N/a',10),(76,'Pineapple Canned Juice','N/a',55,'Available','N/a','N/a',10),(77,'Coke Soda','N/a',45,'Available','N/a','N/a',10),(78,'Sprite Soda','N/a',45,'Available','N/a','N/a',10),(79,'Royal Soda','N/a',45,'Available','N/a','N/a',10);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderlist`
--

DROP TABLE IF EXISTS `orderlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orderlist` (
  `order_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `order_qty` int(11) NOT NULL DEFAULT '1',
  `order_total` int(11) NOT NULL DEFAULT '0',
  `item_status` enum('pending','in preparation','finished') NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`order_id`,`menu_id`),
  KEY `menu_id_idx` (`menu_id`),
  CONSTRAINT `menu_id` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`menu_id`) ON UPDATE CASCADE,
  CONSTRAINT `slip_no` FOREIGN KEY (`order_id`) REFERENCES `orderslip` (`order_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderlist`
--

LOCK TABLES `orderlist` WRITE;
/*!40000 ALTER TABLE `orderlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderslip`
--

DROP TABLE IF EXISTS `orderslip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orderslip` (
  `order_id` int(11) NOT NULL,
  `cust_name` varchar(45) NOT NULL,
  `order_payable` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `payment_status` enum('Paid','Not Yet Paid') NOT NULL DEFAULT 'Not Yet Paid',
  `pay_date_time` datetime NOT NULL,
  `table_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `table_idx` (`table_no`),
  CONSTRAINT `table` FOREIGN KEY (`table_no`) REFERENCES `tables` (`table_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderslip`
--

LOCK TABLES `orderslip` WRITE;
/*!40000 ALTER TABLE `orderslip` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderslip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stockitems`
--

DROP TABLE IF EXISTS `stockitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockitems` (
  `stock_id` int(11) NOT NULL AUTO_INCREMENT,
  `stock_name` varchar(45) NOT NULL,
  `stock_minimum` int(11) NOT NULL,
  `stock_quantity` int(11) NOT NULL,
  `stock_unit` varchar(10) NOT NULL,
  `stock_status` enum('Available','Unavailable') NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`stock_id`),
  KEY `category_id_idx` (`category_id`),
  CONSTRAINT `category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockitems`
--

LOCK TABLES `stockitems` WRITE;
/*!40000 ALTER TABLE `stockitems` DISABLE KEYS */;
INSERT INTO `stockitems` VALUES (11,'Syrup',2,6,'per bottle','Available',1),(12,'Sauces',2,5,'per bottle','Available',5),(13,'Matcha Powder',2,5,'per bag kg','Available',6),(14,'Espresso Beans',2,6,'per bag kg','Available',3),(15,'Benguet Beans',2,6,'per bag kg','Available',3),(24,'Kalinga Beans',2,6,'per bag kg','Available',3),(25,'Sagada Beans',2,6,'per bag kg','Available',3),(26,'Cordillera City Beans (Medium) Roast',2,6,'per bag kg','Available',3),(27,'Cordillera Vienna (Dark) Roast',2,6,'per bag kg','Available',3),(28,'Honey-coated Lemon Tea',2,6,'per bag','Available',9),(29,'Chamomile Tea',2,6,'per bag','Available',9),(30,'Pakpakyaw (Butterfly) Pea Tea',2,6,'per bag','Available',9),(31,'Mango Canned Juice',3,10,'per bottle','Available',2),(33,'Pineapple Canned Juices',5,10,'per bottle','Available',2),(35,'Coke Soda',3,5,'per bottle','Available',2),(37,'Sprite Soda',3,5,'per bottle','Available',2),(40,'Royal Soda',2,6,'per bottle','Available',2),(41,'Bottled Water',3,5,'per bottle','Available',2),(43,'Frappe',2,6,'per bottle','Available',1);
/*!40000 ALTER TABLE `stockitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tables`
--

DROP TABLE IF EXISTS `tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tables` (
  `table_no` int(11) NOT NULL,
  PRIMARY KEY (`table_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tables`
--

LOCK TABLES `tables` WRITE;
/*!40000 ALTER TABLE `tables` DISABLE KEYS */;
/*!40000 ALTER TABLE `tables` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-24 17:28:49

-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 22, 2019 at 01:22 PM
-- Server version: 5.7.21
-- PHP Version: 5.6.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `il-lengan`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE IF NOT EXISTS `accounts` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_type` enum('Admin','Barista','Chef') NOT NULL,
  `account_username` varchar(15) NOT NULL,
  `account_password` varchar(20) NOT NULL,
  `is_online` enum('y','n') DEFAULT 'n',
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_type` enum('Menu','Inventory') NOT NULL,
  `category_name` varchar(45) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `damages`
--

DROP TABLE IF EXISTS `damages`;
CREATE TABLE IF NOT EXISTS `damages` (
  `damage_id` int(11) NOT NULL,
  `damage_type` enum('inventory','menu') NOT NULL,
  `damage_quantity` int(11) NOT NULL,
  `date_recorded` date NOT NULL,
  `damage_reason` varchar(100) NOT NULL,
  `stock_id` int(11) DEFAULT NULL,
  `menu_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`damage_id`),
  KEY `stock_idx` (`stock_id`),
  KEY `menu_idx` (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
CREATE TABLE IF NOT EXISTS `log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `stock_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `log_date` date NOT NULL,
  `log_type` enum('restock','destock') NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `stock_id_idx` (`stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
CREATE TABLE IF NOT EXISTS `menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(45) NOT NULL,
  `menu_description` varchar(200) NOT NULL,
  `menu_price` int(11) NOT NULL,
  `menu_availability` enum('Available','Unavailable') NOT NULL,
  `menu_image` varchar(45) NOT NULL,
  `size` varchar(45) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`menu_id`),
  KEY `category_idx` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `orderlist`
--

DROP TABLE IF EXISTS `orderlist`;
CREATE TABLE IF NOT EXISTS `orderlist` (
  `order_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `order_qty` int(11) NOT NULL DEFAULT '1',
  `order_total` int(11) NOT NULL DEFAULT '0',
  `item_status` enum('pending','in preparation','finished') NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`order_id`,`menu_id`),
  KEY `menu_id_idx` (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `orderslip`
--

DROP TABLE IF EXISTS `orderslip`;
CREATE TABLE IF NOT EXISTS `orderslip` (
  `order_id` int(11) NOT NULL,
  `cust_name` varchar(45) NOT NULL,
  `order_payable` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `payment_status` enum('Paid','Not Yet Paid') NOT NULL DEFAULT 'Not Yet Paid',
  `pay_date_time` datetime NOT NULL,
  `table_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `table_idx` (`table_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stockitems`
--

DROP TABLE IF EXISTS `stockitems`;
CREATE TABLE IF NOT EXISTS `stockitems` (
  `stock_id` int(11) NOT NULL AUTO_INCREMENT,
  `stock_name` varchar(45) NOT NULL,
  `stock_minimum` int(11) NOT NULL,
  `stock_quantity` int(11) NOT NULL,
  `stock_unit` varchar(10) NOT NULL,
  `stock_status` enum('Available','Unavailable') NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`stock_id`),
  KEY `category_id_idx` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tables`
--

DROP TABLE IF EXISTS `tables`;
CREATE TABLE IF NOT EXISTS `tables` (
  `table_no` int(11) NOT NULL,
  PRIMARY KEY (`table_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `damages`
--
ALTER TABLE `damages`
  ADD CONSTRAINT `menu` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`menu_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `stock` FOREIGN KEY (`stock_id`) REFERENCES `stockitems` (`stock_id`) ON UPDATE CASCADE;

--
-- Constraints for table `log`
--
ALTER TABLE `log`
  ADD CONSTRAINT `stock_id` FOREIGN KEY (`stock_id`) REFERENCES `stockitems` (`stock_id`) ON UPDATE CASCADE;

--
-- Constraints for table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON UPDATE CASCADE;

--
-- Constraints for table `orderlist`
--
ALTER TABLE `orderlist`
  ADD CONSTRAINT `menu_id` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`menu_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `slip_no` FOREIGN KEY (`order_id`) REFERENCES `orderslip` (`order_id`) ON UPDATE CASCADE;

--
-- Constraints for table `orderslip`
--
ALTER TABLE `orderslip`
  ADD CONSTRAINT `table` FOREIGN KEY (`table_no`) REFERENCES `tables` (`table_no`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `stockitems`
--
ALTER TABLE `stockitems`
  ADD CONSTRAINT `category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

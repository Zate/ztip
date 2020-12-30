CREATE DATABASE  IF NOT EXISTS `itip` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `itip`;
-- MySQL dump 10.13  Distrib 5.7.20, for Linux (x86_64)
--
-- Host: 172.16.122.92    Database: itip
-- ------------------------------------------------------
-- Server version	5.7.20

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
-- Table structure for table `feeds`
--

DROP TABLE IF EXISTS `feeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feeds` (
  `id` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `category` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `feed_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `feed_url` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `info_url` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`tag`,`category`,`feed_name`,`feed_url`,`info_url`,`created`,`updated`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `tag_UNIQUE` (`tag`),
  UNIQUE KEY `feed_name_UNIQUE` (`feed_name`),
  KEY `feeds` (`id`,`tag`,`feed_name`,`feed_url`,`category`,`info_url`,`created`,`updated`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intel`
--

DROP TABLE IF EXISTS `intel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intel` (
  `id` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `ip_id` int(11) unsigned NOT NULL,
  `feed_id` int(11) unsigned NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ip_id`,`feed_id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `intel_UNIQUE` (`ip_id`,`feed_id`,`id`,`created`,`updated`)
) ENGINE=InnoDB AUTO_INCREMENT=410231 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ip`
--

DROP TABLE IF EXISTS `ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip` (
  `id` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `ipaddr` int(10) unsigned NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lat` decimal(10,8) DEFAULT NULL,
  `lang` decimal(11,8) DEFAULT NULL,
  `city` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `continent` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_anonymous` tinyint(4) DEFAULT '0',
  `is_anon_vpn` tinyint(4) DEFAULT '0',
  `is_hosting_provider` tinyint(4) DEFAULT '0',
  `is_public_proxy` tinyint(4) DEFAULT '0',
  `is_tor_exit_node` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `ipaddr_UNIQUE` (`ipaddr`),
  KEY `id_ip` (`id`,`ipaddr`),
  KEY `ip_geo` (`ipaddr`,`id`,`lat`,`lang`,`city`,`continent`,`country`),
  KEY `ip_risk` (`id`,`ipaddr`,`is_anonymous`,`is_anon_vpn`,`is_hosting_provider`,`is_public_proxy`,`is_tor_exit_node`)
) ENGINE=InnoDB AUTO_INCREMENT=1247784 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'itip'
--

--
-- Dumping routines for database 'itip'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-28 20:01:47
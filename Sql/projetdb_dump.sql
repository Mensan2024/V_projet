-- MySQL dump 10.13  Distrib 5.7.42, for Linux (x86_64)
--
-- Host: localhost    Database: projetdb
-- ------------------------------------------------------
-- Server version	5.7.42-0ubuntu0.18.04.1-log

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
-- Position to start replication or point-in-time recovery from
--

-- CHANGE MASTER TO MASTER_LOG_FILE='mysql-bin.000014', MASTER_LOG_POS=154;

--
-- Current Database: `projetdb`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `projetdb` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `projetdb`;

--
-- Table structure for table `COURS`
--

DROP TABLE IF EXISTS `COURS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `COURS` (
  `CODE_COURS` int(11) NOT NULL,
  `NOM_COURS` varchar(100) DEFAULT NULL,
  `CODE_PROF` int(11) DEFAULT NULL,
  PRIMARY KEY (`CODE_COURS`),
  KEY `CODE_PROF` (`CODE_PROF`),
  CONSTRAINT `COURS_ibfk_1` FOREIGN KEY (`CODE_PROF`) REFERENCES `PROFESSEUR` (`CODE_PROF`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COURS`
--

LOCK TABLES `COURS` WRITE;
/*!40000 ALTER TABLE `COURS` DISABLE KEYS */;
INSERT INTO `COURS` VALUES (101,'Virtualisation',1),(102,'Securite informatique',2),(103,'Base de données avancées',3);
/*!40000 ALTER TABLE `COURS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ETUDIANT`
--

DROP TABLE IF EXISTS `ETUDIANT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ETUDIANT` (
  `N_ETUD` int(11) NOT NULL AUTO_INCREMENT,
  `NOM_ETUD` varchar(50) DEFAULT NULL,
  `PRENOM_ETUD` varchar(50) DEFAULT NULL,
  `DATE_INSCRIP` date DEFAULT NULL,
  `EMAIL` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`N_ETUD`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ETUDIANT`
--

LOCK TABLES `ETUDIANT` WRITE;
/*!40000 ALTER TABLE `ETUDIANT` DISABLE KEYS */;
INSERT INTO `ETUDIANT` VALUES (1,'Zoundi','philippe','2024-09-01','philippe.zoundi@example.com'),(2,'moreno','codja','2024-09-02','codja.moreno@example.com'),(3,'bendja','Sophie','2024-09-02','sophie.bendja@example.com'),(4,'Ouedraogo','rapouyouga','2024-09-02','rapougouya.ouedraogo@example.com'),(5,'KONE','JACOB','2025-05-20','jacob.kone@example.com');
/*!40000 ALTER TABLE `ETUDIANT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ETUDIANT_COURS`
--

DROP TABLE IF EXISTS `ETUDIANT_COURS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ETUDIANT_COURS` (
  `N_ETUD` int(11) NOT NULL,
  `CODE_COURS` int(11) NOT NULL,
  `DATE_INSCRIP` date DEFAULT NULL,
  `MNT_PAYE` decimal(6,2) DEFAULT NULL,
  `GRADE` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`N_ETUD`,`CODE_COURS`),
  KEY `CODE_COURS` (`CODE_COURS`),
  CONSTRAINT `ETUDIANT_COURS_ibfk_1` FOREIGN KEY (`N_ETUD`) REFERENCES `ETUDIANT` (`N_ETUD`),
  CONSTRAINT `ETUDIANT_COURS_ibfk_2` FOREIGN KEY (`CODE_COURS`) REFERENCES `COURS` (`CODE_COURS`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ETUDIANT_COURS`
--

LOCK TABLES `ETUDIANT_COURS` WRITE;
/*!40000 ALTER TABLE `ETUDIANT_COURS` DISABLE KEYS */;
INSERT INTO `ETUDIANT_COURS` VALUES (1,101,'2024-09-05',250.00,'A'),(2,102,'2024-09-06',200.00,'B');
/*!40000 ALTER TABLE `ETUDIANT_COURS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROFESSEUR`
--

DROP TABLE IF EXISTS `PROFESSEUR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROFESSEUR` (
  `CODE_PROF` int(11) NOT NULL,
  `NOM_PROF` varchar(50) DEFAULT NULL,
  `PRENOM_PROF` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CODE_PROF`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROFESSEUR`
--

LOCK TABLES `PROFESSEUR` WRITE;
/*!40000 ALTER TABLE `PROFESSEUR` DISABLE KEYS */;
INSERT INTO `PROFESSEUR` VALUES (1,'SOMDA','Flavien'),(2,'SANA','Mohamadi'),(3,'KABORE','Kizito');
/*!40000 ALTER TABLE `PROFESSEUR` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-21  1:54:40

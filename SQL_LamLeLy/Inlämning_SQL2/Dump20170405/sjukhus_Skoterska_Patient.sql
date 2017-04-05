-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: localhost    Database: sjukhus
-- ------------------------------------------------------
-- Server version	5.6.35

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
-- Table structure for table `Skoterska_Patient`
--

DROP TABLE IF EXISTS `Skoterska_Patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Skoterska_Patient` (
  `fk_idSkoterska` int(11) NOT NULL,
  `fk_Patient_idPatient` int(11) NOT NULL,
  `Skoterska_Patientcol` int(11) NOT NULL,
  PRIMARY KEY (`Skoterska_Patientcol`),
  KEY `fk_Skoterska_has_Patient_Patient1_idx` (`fk_Patient_idPatient`),
  KEY `fk_Skoterska_has_Patient_Skoterska1_idx` (`fk_idSkoterska`),
  CONSTRAINT `fk_Skoterska_has_Patient_Patient1` FOREIGN KEY (`fk_Patient_idPatient`) REFERENCES `Patient` (`idPatient`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Skoterska_has_Patient_Skoterska1` FOREIGN KEY (`fk_idSkoterska`) REFERENCES `Skoterska` (`idSkoterska`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Skoterska_Patient`
--

LOCK TABLES `Skoterska_Patient` WRITE;
/*!40000 ALTER TABLE `Skoterska_Patient` DISABLE KEYS */;
INSERT INTO `Skoterska_Patient` VALUES (3,8,1),(2,7,2),(1,6,3),(3,5,4),(1,4,5),(2,1,6),(3,2,7),(2,3,8);
/*!40000 ALTER TABLE `Skoterska_Patient` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-05 14:14:59

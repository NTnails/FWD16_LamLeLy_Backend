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
-- Table structure for table `Patient_has_Diagnos`
--

DROP TABLE IF EXISTS `Patient_has_Diagnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Patient_has_Diagnos` (
  `idPatient` int(11) NOT NULL,
  `idDiagnos` int(11) NOT NULL,
  PRIMARY KEY (`idPatient`,`idDiagnos`),
  KEY `fk_Patient_has_Diagnos_Diagnos1_idx` (`idDiagnos`),
  KEY `fk_Patient_has_Diagnos_Patient1_idx` (`idPatient`),
  CONSTRAINT `fk_Patient_has_Diagnos_Diagnos1` FOREIGN KEY (`idDiagnos`) REFERENCES `Diagnos` (`idDiagnos`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Patient_has_Diagnos_Patient1` FOREIGN KEY (`idPatient`) REFERENCES `Patient` (`idPatient`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient_has_Diagnos`
--

LOCK TABLES `Patient_has_Diagnos` WRITE;
/*!40000 ALTER TABLE `Patient_has_Diagnos` DISABLE KEYS */;
INSERT INTO `Patient_has_Diagnos` VALUES (3,1),(6,1),(7,1),(1,2),(2,2),(5,2),(8,2),(4,3);
/*!40000 ALTER TABLE `Patient_has_Diagnos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-02 23:23:08

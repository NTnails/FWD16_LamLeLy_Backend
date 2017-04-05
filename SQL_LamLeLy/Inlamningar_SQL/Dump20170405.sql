CREATE DATABASE  IF NOT EXISTS `sjukhus` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `sjukhus`;
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
-- Table structure for table `Diagnos`
--

DROP TABLE IF EXISTS `Diagnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Diagnos` (
  `idDiagnos` int(11) NOT NULL AUTO_INCREMENT,
  `diagnos_namn` varchar(255) NOT NULL,
  `diagnos_kategori` varchar(45) NOT NULL,
  PRIMARY KEY (`idDiagnos`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Diagnos`
--

LOCK TABLES `Diagnos` WRITE;
/*!40000 ALTER TABLE `Diagnos` DISABLE KEYS */;
INSERT INTO `Diagnos` VALUES (1,'Malaria','Smittsam'),(2,'Alergi','Besvär'),(3,'Rabies','Ont');
/*!40000 ALTER TABLE `Diagnos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Lakare`
--

DROP TABLE IF EXISTS `Lakare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Lakare` (
  `idLakare` int(11) NOT NULL AUTO_INCREMENT,
  `lakare_namn` varchar(45) NOT NULL,
  `lakare_efternamn` varchar(45) NOT NULL,
  PRIMARY KEY (`idLakare`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Lakare`
--

LOCK TABLES `Lakare` WRITE;
/*!40000 ALTER TABLE `Lakare` DISABLE KEYS */;
INSERT INTO `Lakare` VALUES (1,'Le','Ly'),(2,'David','Szmak'),(3,'Carlos',' Demirovic');
/*!40000 ALTER TABLE `Lakare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Medicin`
--

DROP TABLE IF EXISTS `Medicin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Medicin` (
  `idMedicin` int(11) NOT NULL AUTO_INCREMENT,
  `medicin_namn` varchar(225) NOT NULL,
  `medicin_doz` int(11) NOT NULL,
  `fk_idDiagnos` int(11) NOT NULL,
  PRIMARY KEY (`idMedicin`),
  KEY `fk_Medicin_Diagnos1_idx` (`fk_idDiagnos`),
  CONSTRAINT `fk_Medicin_Diagnos1` FOREIGN KEY (`fk_idDiagnos`) REFERENCES `Diagnos` (`idDiagnos`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Medicin`
--

LOCK TABLES `Medicin` WRITE;
/*!40000 ALTER TABLE `Medicin` DISABLE KEYS */;
INSERT INTO `Medicin` VALUES (1,'Alvedon',100,3),(2,'Ipren',200,2),(3,'Panodin',150,1);
/*!40000 ALTER TABLE `Medicin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient`
--

DROP TABLE IF EXISTS `Patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Patient` (
  `idPatient` int(11) NOT NULL AUTO_INCREMENT,
  `patient_namn` varchar(45) NOT NULL,
  `patient_efternamn` varchar(45) NOT NULL,
  `fk_idLakare` int(11) DEFAULT NULL,
  PRIMARY KEY (`idPatient`),
  KEY `fk_Patient_Lakare1_idx` (`fk_idLakare`),
  CONSTRAINT `fk_Patient_Lakare1` FOREIGN KEY (`fk_idLakare`) REFERENCES `Lakare` (`idLakare`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient`
--

LOCK TABLES `Patient` WRITE;
/*!40000 ALTER TABLE `Patient` DISABLE KEYS */;
INSERT INTO `Patient` VALUES (1,'Kalle','Anka',2),(2,'Musse','Pigg',3),(3,'Lång','Ben',1),(4,'Smurf','Blå',1),(5,'Tom','Mus',2),(6,'Jerry','Katt',3),(7,'King','Kong',2),(8,'X','Men',1);
/*!40000 ALTER TABLE `Patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient_Diagnos`
--

DROP TABLE IF EXISTS `Patient_Diagnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Patient_Diagnos` (
  `fk_Patient_idPatient` int(11) NOT NULL,
  `fk_Diagnos_idDiagnos` int(11) NOT NULL,
  `Patient_Diagnos` int(11) NOT NULL,
  PRIMARY KEY (`Patient_Diagnos`),
  KEY `fk_Patient_has_Diagnos_Diagnos1_idx` (`fk_Diagnos_idDiagnos`),
  KEY `fk_Patient_has_Diagnos_Patient1_idx` (`fk_Patient_idPatient`),
  CONSTRAINT `fk_Patient_has_Diagnos_Diagnos1` FOREIGN KEY (`fk_Diagnos_idDiagnos`) REFERENCES `Diagnos` (`idDiagnos`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Patient_has_Diagnos_Patient1` FOREIGN KEY (`fk_Patient_idPatient`) REFERENCES `Patient` (`idPatient`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient_Diagnos`
--

LOCK TABLES `Patient_Diagnos` WRITE;
/*!40000 ALTER TABLE `Patient_Diagnos` DISABLE KEYS */;
INSERT INTO `Patient_Diagnos` VALUES (1,2,1),(2,1,2),(3,3,3),(4,3,4),(5,2,5),(6,1,6),(7,2,7),(8,2,8);
/*!40000 ALTER TABLE `Patient_Diagnos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Skoterska`
--

DROP TABLE IF EXISTS `Skoterska`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Skoterska` (
  `idSkoterska` int(11) NOT NULL AUTO_INCREMENT,
  `skoterska_namn` varchar(45) NOT NULL,
  `skoterska_efternamn` varchar(45) NOT NULL,
  PRIMARY KEY (`idSkoterska`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Skoterska`
--

LOCK TABLES `Skoterska` WRITE;
/*!40000 ALTER TABLE `Skoterska` DISABLE KEYS */;
INSERT INTO `Skoterska` VALUES (1,'Angelica','Gaintatzi'),(2,'Dragana','Jankovic'),(3,'Malena','Brinkheden');
/*!40000 ALTER TABLE `Skoterska` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Temporary view structure for view `alergi_medicin`
--

DROP TABLE IF EXISTS `alergi_medicin`;
/*!50001 DROP VIEW IF EXISTS `alergi_medicin`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `alergi_medicin` AS SELECT 
 1 AS `diagnos`,
 1 AS `medicin`,
 1 AS `mg/ml`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `antal_patient`
--

DROP TABLE IF EXISTS `antal_patient`;
/*!50001 DROP VIEW IF EXISTS `antal_patient`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `antal_patient` AS SELECT 
 1 AS `antal_patient`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `antal_patient_diagnos`
--

DROP TABLE IF EXISTS `antal_patient_diagnos`;
/*!50001 DROP VIEW IF EXISTS `antal_patient_diagnos`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `antal_patient_diagnos` AS SELECT 
 1 AS `antal_patient`,
 1 AS `diagnos_namn`,
 1 AS `beskrivning`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `lakare_patient`
--

DROP TABLE IF EXISTS `lakare_patient`;
/*!50001 DROP VIEW IF EXISTS `lakare_patient`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `lakare_patient` AS SELECT 
 1 AS `lakare_Id`,
 1 AS `lakare_namn`,
 1 AS `lakare_efternamn`,
 1 AS `patient_Id`,
 1 AS `patient_namn`,
 1 AS `patient_efternamn`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `malaria_medicin`
--

DROP TABLE IF EXISTS `malaria_medicin`;
/*!50001 DROP VIEW IF EXISTS `malaria_medicin`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `malaria_medicin` AS SELECT 
 1 AS `diagnos`,
 1 AS `medicin`,
 1 AS `mg/ml`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `patient_skoterska`
--

DROP TABLE IF EXISTS `patient_skoterska`;
/*!50001 DROP VIEW IF EXISTS `patient_skoterska`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `patient_skoterska` AS SELECT 
 1 AS `patient`,
 1 AS `skoterska_namn`,
 1 AS `skoterska_efternamn`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `rabies_medicin`
--

DROP TABLE IF EXISTS `rabies_medicin`;
/*!50001 DROP VIEW IF EXISTS `rabies_medicin`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `rabies_medicin` AS SELECT 
 1 AS `diagnos`,
 1 AS `medicin`,
 1 AS `mg/ml`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'sjukhus'
--

--
-- Dumping routines for database 'sjukhus'
--
/*!50003 DROP PROCEDURE IF EXISTS `antal_insjukna_patienter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `antal_insjukna_patienter`()
BEGIN
SELECT 
    COUNT(`sjukhus`.`patient`.`idPatient`) AS `antal_patient`
FROM
    `sjukhus`.`patient`;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `antal_patient_diagnos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `antal_patient_diagnos`()
BEGIN
SELECT 
    COUNT(`patient`.`idPatient`) AS `antal_patient`,
    `diagnos`.`diagnos_namn` AS `diagnos_namn`,
    `diagnos`.`diagnos_kategori` AS `beskrivning`
FROM
    `diagnos`
        JOIN
    `patient_diagnos` ON `diagnos`.`idDiagnos` = `patient_diagnos`.`fk_Diagnos_idDiagnos`
        JOIN
    `patient` ON `patient`.`idPatient` = `patient_diagnos`.`fk_Patient_idPatient`
GROUP BY `diagnos`.`diagnos_kategori`;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lakare_patient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lakare_patient`()
BEGIN
SELECT 
    `lakare`.`idLakare` AS `lakare_Id`,
    `lakare`.`lakare_namn` AS `lakare_namn`,
    `lakare`.`lakare_efternamn` AS `lakare_efternamn`,
    `patient`.`idPatient` AS `patient_Id`,
    `patient`.`patient_namn` AS `patient_namn`,
    `patient`.`patient_efternamn` AS `patient_efternamn`
FROM
    `lakare`
    JOIN `patient` ON `lakare`.`idLakare` = `patient`.`fk_idLakare`;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `patient_sjukskoterskor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `patient_sjukskoterskor`()
BEGIN
SELECT 
    `sjukhus`.`patient`.`idPatient` AS `patient`,
    `sjukhus`.`skoterska`.`skoterska_namn` AS `skoterska_namn`,
    `sjukhus`.`skoterska`.`skoterska_efternamn` AS `skoterska_efternamn`
FROM
    `sjukhus`.`patient`
    JOIN `sjukhus`.`skoterska_patient` ON `sjukhus`.`patient`.`idPatient` = `sjukhus`.`skoterska_patient`.`fk_Patient_idPatient`
    JOIN `sjukhus`.`skoterska` ON `sjukhus`.`skoterska`.`idSkoterska` = `sjukhus`.`skoterska_patient`.`fk_idSkoterska`;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Rabies` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Rabies`()
BEGIN
SELECT 
    `diagnos`.`diagnos_namn` AS `diagnos`,
    `medicin`.`medicin_namn` AS `medicin`,
    `medicin`.`medicin_doz` AS `mg/ml`
FROM
    `diagnos`
        JOIN
    `medicin` ON `diagnos`.`idDiagnos` = `medicin`.`fk_idDiagnos`
WHERE
    `diagnos`.`diagnos_namn` LIKE 'Rabies';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `alergi_medicin`
--

/*!50001 DROP VIEW IF EXISTS `alergi_medicin`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `alergi_medicin` AS select `diagnos`.`diagnos_namn` AS `diagnos`,`medicin`.`medicin_namn` AS `medicin`,`medicin`.`medicin_doz` AS `mg/ml` from (`diagnos` join `medicin` on((`diagnos`.`idDiagnos` = `medicin`.`fk_idDiagnos`))) where (`diagnos`.`diagnos_namn` like 'Alergi') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `antal_patient`
--

/*!50001 DROP VIEW IF EXISTS `antal_patient`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `antal_patient` AS select count(`patient`.`idPatient`) AS `antal_patient` from `patient` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `antal_patient_diagnos`
--

/*!50001 DROP VIEW IF EXISTS `antal_patient_diagnos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `antal_patient_diagnos` AS select count(`patient`.`idPatient`) AS `antal_patient`,`diagnos`.`diagnos_namn` AS `diagnos_namn`,`diagnos`.`diagnos_kategori` AS `beskrivning` from ((`diagnos` join `patient_diagnos` on((`diagnos`.`idDiagnos` = `patient_diagnos`.`fk_Diagnos_idDiagnos`))) join `patient` on((`patient`.`idPatient` = `patient_diagnos`.`fk_Patient_idPatient`))) group by `diagnos`.`diagnos_kategori` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `lakare_patient`
--

/*!50001 DROP VIEW IF EXISTS `lakare_patient`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `lakare_patient` AS select `lakare`.`idLakare` AS `lakare_Id`,`lakare`.`lakare_namn` AS `lakare_namn`,`lakare`.`lakare_efternamn` AS `lakare_efternamn`,`patient`.`idPatient` AS `patient_Id`,`patient`.`patient_namn` AS `patient_namn`,`patient`.`patient_efternamn` AS `patient_efternamn` from (`lakare` join `patient` on((`lakare`.`idLakare` = `patient`.`fk_idLakare`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `malaria_medicin`
--

/*!50001 DROP VIEW IF EXISTS `malaria_medicin`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `malaria_medicin` AS select `diagnos`.`diagnos_namn` AS `diagnos`,`medicin`.`medicin_namn` AS `medicin`,`medicin`.`medicin_doz` AS `mg/ml` from (`diagnos` join `medicin` on((`diagnos`.`idDiagnos` = `medicin`.`fk_idDiagnos`))) where (`diagnos`.`diagnos_namn` like 'Malaria') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `patient_skoterska`
--

/*!50001 DROP VIEW IF EXISTS `patient_skoterska`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `patient_skoterska` AS select `patient`.`idPatient` AS `patient`,`skoterska`.`skoterska_namn` AS `skoterska_namn`,`skoterska`.`skoterska_efternamn` AS `skoterska_efternamn` from ((`patient` join `skoterska_patient` on((`patient`.`idPatient` = `skoterska_patient`.`fk_Patient_idPatient`))) join `skoterska` on((`skoterska`.`idSkoterska` = `skoterska_patient`.`fk_idSkoterska`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `rabies_medicin`
--

/*!50001 DROP VIEW IF EXISTS `rabies_medicin`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `rabies_medicin` AS select `diagnos`.`diagnos_namn` AS `diagnos`,`medicin`.`medicin_namn` AS `medicin`,`medicin`.`medicin_doz` AS `mg/ml` from (`diagnos` join `medicin` on((`diagnos`.`idDiagnos` = `medicin`.`fk_idDiagnos`))) where (`diagnos`.`diagnos_namn` like 'Rabies') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-05 17:14:02

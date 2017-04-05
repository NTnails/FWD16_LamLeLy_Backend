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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-05 14:14:59

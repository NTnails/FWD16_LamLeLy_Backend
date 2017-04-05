SQL Inlämning 2 Lam Le Ly

--
-- Antal insjukna i olika sjukdom.
--
/*CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `antal_patient_diagnos` AS
    SELECT 
        COUNT(`patient`.`idPatient`) AS `antal_patient`,
        `diagnos`.`diagnos_namn` AS `antal_diagnos`
    FROM
        ((`diagnos`
        JOIN `patient_diagnos` ON ((`diagnos`.`idDiagnos` = `patient_diagnos`.`idDiagnos`)))
        JOIN `patient` ON ((`patient`.`idPatient` = `patient_diagnos`.`idPatient`)))
    GROUP BY `diagnos`.`diagnos_namn`
 */   
 
 
--
-- Antal insjukna i olika sjukdom med beskrivning
--
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `antal_patient_diagnos` AS
    SELECT 
        COUNT(`patient`.`idPatient`) AS `antal_patient`,
        `diagnos`.`diagnos_namn` AS `diagnos_namn`,
        `diagnos`.`diagnos_kategori` AS `beskrivning`
    FROM
        ((`diagnos`
        JOIN `patient_diagnos` ON ((`diagnos`.`idDiagnos` = `patient_diagnos`.`idDiagnos`)))
        JOIN `patient` ON ((`patient`.`idPatient` = `patient_diagnos`.`idPatient`)))
    GROUP BY `diagnos`.`diagnos_kategori`
    
--
-- Antal insjukna patienter.
--
CREATE VIEW `sjukhus`.`antal_patient` AS
SELECT 
        COUNT(`sjukhus`.`patient`.`idPatient`) AS `antal_patient`
    FROM
        `sjukhus`.`patient`

--
-- Visa olika mediciner och dosering för en viss sjukdom Rabies_medicin.
--
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `rabies_medicin` AS
    SELECT 
        `diagnos`.`diagnos_namn` AS `diagnos`,
        `medicin`.`medicin_namn` AS `medicin`,
        `medicin`.`medicin_doz` AS `mg/ml`
    FROM
        (`diagnos`
        JOIN `medicin` ON ((`diagnos`.`idDiagnos` = `medicin`.`fk_idDiagnos`)))
    WHERE
        (`diagnos`.`diagnos_namn` LIKE 'Rabies')
        
 --
-- Visa olika mediciner och dosering för en viss sjukdom Malaria_medicin
--       
/*
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `malaria_medicin` AS
    SELECT 
        `diagnos`.`diagnos_namn` AS `diagnos`,
        `medicin`.`medicin_namn` AS `medicin`,
        `medicin`.`medicin_doz` AS `mg/ml`
    FROM
        (`diagnos`
        JOIN `medicin` ON ((`diagnos`.`idDiagnos` = `medicin`.`fk_idDiagnos`)))
    WHERE
        (`sjukhus`.`diagnos`.`diagnos_namn` LIKE 'Malaria')
  */  
  
-- Visa olika mediciner och dosering för en viss sjukdom Alergi_medicin
--
/*      
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `Alergi_medicin` AS
    SELECT 
        `diagnos`.`diagnos_namn` AS `diagnos`,
        `medicin`.`medicin_namn` AS `medicin`,
        `medicin`.`medicin_doz` AS `mg/ml`
    FROM
        (`diagnos`
        JOIN `medicin` ON ((`diagnos`.`idDiagnos` = `medicin`.`fk_idDiagnos`)))
    WHERE        
        (`sjukhus`.`diagnos`.`diagnos_namn` LIKE 'Alergi')
*/


--
-- Vilka sjuksköterskor som behandlar en viss patient.
--
CREATE VIEW `sjukhus`.`patient_skoterska` AS

    SELECT 
        `sjukhus`.`patient`.`idPatient` AS `patient`,
        
        `sjukhus`.`skoterska`.`skoterska_namn` AS `skoterska_namn`,
        
        `sjukhus`.`skoterska`.`skoterska_efternamn` AS `skoterska_efternamn`
   
   FROM
        ((`sjukhus`.`patient`
        
          JOIN `sjukhus`.`skoterska_patient` ON 
          ((`sjukhus`.`patient`.`idPatient` = `sjukhus`.`skoterska_patient`.`fk_Patient_idPatient`)))

JOIN `sjukhus`.`skoterska` ON ((`sjukhus`.`skoterska`.`idSkoterska` = `sjukhus`.`skoterska_patient`.`fk_idSkoterska`)))


--
-- Visa vilka patienter behandlas av en läkare.
--
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `lakare_patient` AS
    SELECT 
        `lakare`.`idLakare` AS `lakare_Id`,
        `lakare`.`lakare_namn` AS `lakare_namn`,
        `lakare`.`lakare_efternamn` AS `lakare_efternamn`,
        `patient`.`idPatient` AS `patient_Id`,
        `patient`.`patient_namn` AS `patient_namn`,
        `patient`.`patient_efternamn` AS `patient_efternamn`
    FROM
        (`lakare`
        JOIN `patient` ON ((`lakare`.`idLakare` = `patient`.`fk_idLakare`)))


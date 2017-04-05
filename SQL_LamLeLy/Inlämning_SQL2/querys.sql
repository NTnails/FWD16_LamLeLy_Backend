-- Query SQL Inlämning 2 Lam Le Ly

--
-- Antal insjukna i olika sjukdom med beskrivning
--
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
GROUP BY `diagnos`.`diagnos_kategori`
-- SELECT * FROM `antal_patient_diagnos`

--
-- Antal insjukna patienter.
--
SELECT 
    COUNT(`sjukhus`.`patient`.`idPatient`) AS `antal_patient`
FROM
    `sjukhus`.`patient`
-- SELECT * FROM sjukhus.antal_patient;

--
-- Visa olika mediciner och dosering för en viss sjukdom Rabies_medicin.
--
SELECT 
    `diagnos`.`diagnos_namn` AS `diagnos`,
    `medicin`.`medicin_namn` AS `medicin`,
    `medicin`.`medicin_doz` AS `mg/ml`
FROM
    `diagnos`
        JOIN
    `medicin` ON `diagnos`.`idDiagnos` = `medicin`.`fk_idDiagnos`
WHERE
    `diagnos`.`diagnos_namn` LIKE 'Rabies'
-- SELECT * FROM sjukhus.antal_patient_diagnos;

--
-- Vilka sjuksköterskor som behandlar en viss patient.
--
    SELECT 
    `sjukhus`.`patient`.`idPatient` AS `patient`,
    `sjukhus`.`skoterska`.`skoterska_namn` AS `skoterska_namn`,
    `sjukhus`.`skoterska`.`skoterska_efternamn` AS `skoterska_efternamn`
FROM
    `sjukhus`.`patient`
    JOIN `sjukhus`.`skoterska_patient` ON `sjukhus`.`patient`.`idPatient` = `sjukhus`.`skoterska_patient`.`fk_Patient_idPatient`
    JOIN `sjukhus`.`skoterska` ON `sjukhus`.`skoterska`.`idSkoterska` = `sjukhus`.`skoterska_patient`.`fk_idSkoterska`
--SELECT * FROM sjukhus.patient_skoterska;

--
-- Visa vilka patienter behandlas av en läkare.
--
SELECT 
    `lakare`.`idLakare` AS `lakare_Id`,
    `lakare`.`lakare_namn` AS `lakare_namn`,
    `lakare`.`lakare_efternamn` AS `lakare_efternamn`,
    `patient`.`idPatient` AS `patient_Id`,
    `patient`.`patient_namn` AS `patient_namn`,
    `patient`.`patient_efternamn` AS `patient_efternamn`
FROM
    (`lakare`
    JOIN `patient` ON `lakare`.`idLakare` = `patient`.`fk_idLakare`
-- SELECT * FROM sjukhus.lakare_patient;






       
 



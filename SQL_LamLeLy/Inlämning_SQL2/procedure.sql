-- Procedurequery SQL Inlämning 2 Lam Le Ly

--
-- Antal insjukna i olika sjukdom med beskrivning
--

CREATE PROCEDURE `antal_patient_diagnos` ()
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
END
-- call sjukhus.antal_patient_diagnos();

--
-- Antal insjukna patienter.
--
CREATE PROCEDURE `new_procedure` ()
BEGIN
SELECT 
    COUNT(`sjukhus`.`patient`.`idPatient`) AS `antal_patient`
FROM
    `sjukhus`.`patient`;
END
-- call sjukhus.antal_insjukna_patienter();

--
-- Visa olika mediciner och dosering för en viss sjukdom Rabies_medicin.
--
CREATE PROCEDURE `Rabies` ()
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
END
-- call sjukhus.Rabies();

--
-- Vilka sjuksköterskor som behandlar en viss patient.
--
CREATE PROCEDURE `patient_sjuksköterskor` ()
BEGIN
SELECT 
    `sjukhus`.`patient`.`idPatient` AS `patient`,
    `sjukhus`.`skoterska`.`skoterska_namn` AS `skoterska_namn`,
    `sjukhus`.`skoterska`.`skoterska_efternamn` AS `skoterska_efternamn`
FROM
    `sjukhus`.`patient`
    JOIN `sjukhus`.`skoterska_patient` ON `sjukhus`.`patient`.`idPatient` = `sjukhus`.`skoterska_patient`.`fk_Patient_idPatient`
    JOIN `sjukhus`.`skoterska` ON `sjukhus`.`skoterska`.`idSkoterska` = `sjukhus`.`skoterska_patient`.`fk_idSkoterska`;
END
--call sjukhus.patient_sjukskoterskor();

--
-- Visa vilka patienter behandlas av en läkare.
--
CREATE PROCEDURE `lakare_patient` ()
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
END
-- call sjukhus.lakare_patient();

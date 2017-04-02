CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `patient_diagnos` AS
    SELECT 
        COUNT(`patient`.`idPatient`) AS `COUNT(idPatient)`
    FROM
        (`diagnos`
        JOIN `patient` ON ((`diagnos`.`idDiagnos` = `patient`.`idPatient`)))
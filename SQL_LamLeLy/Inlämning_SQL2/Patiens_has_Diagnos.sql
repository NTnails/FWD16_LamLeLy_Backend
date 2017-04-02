CREATE DEFINER=`root`@`localhost` PROCEDURE `srcDiagnos`(IN `arr` INT(11))
    NO SQL
BEGIN
SELECT COUNT(*), idDiagnos FROM `Patient_has_Diagnos` WHERE idDiagnos = arr;
END 
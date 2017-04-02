--
-- Antal insjukna i olika sjukdom
--
SELECT *
FROM Diagnos AS D, Patient_has_Diagnos AS PD
WHERE D.idDiagnos = PD.idDiagnos;


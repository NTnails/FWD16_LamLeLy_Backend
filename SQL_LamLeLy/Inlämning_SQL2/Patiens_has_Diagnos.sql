--
-- Antal insjukna i olika sjukdom
--
SELECT *
FROM Diagnos AS D, Patient_has_Diagnos AS PD
WHERE D.idDiagnos = PD.idDiagnos;

--Antal insjukna patienter
--
SELECT COUNT(idPatient) 
FROM Patient;

--Visa olika mediciner och dosering för en viss sjukdom.
--
SELECT COUNT(idPatient) 
FROM Patient;


--
--SELECT *
FROM Diagnos AS D, Patient_has_Diagnos AS PD
WHERE D.idDiagnos = PD.idDiagnos;

CREATE VIEW VDiagnos
AS
SELECT *
FROM Diagnos AS D, Patient_has_Diagnos AS PD
WHERE D.idDiagnos = PD.idDiagnos;
SELECT * FROM VDiagnos;

-------------
--
--CREATE VIEW `Patient_has_Diagnos` AS
SELECT COUNT(idPatient)
FROM Diagnos
INNER JOIN Patient ON Diagnos.idDiagnos = Patient.idPatient;
--


CREATE VIEW `Antal_patienter_i_olika_diagnoser` AS
SELECT COUNT(PatientID)
FROM Diagnose
INNER JOIN Patient ON Diagnose.DiagnoseID = Patient.PatientID;



-----

--
-- Inner join av samtliga tabeller.
--
SELECT
  K.kodKurs AS Kurskod,
  K.namnKurs AS Kursnamn,
  Kt.lasperiodKurstillfalle AS Läsperiod,
  CONCAT(L.namnLarare, ' (', L.akronymLarare, ')') AS Kursansvarig
FROM Kurstillfalle AS Kt
  INNER JOIN Kurs AS K
    ON Kt.Kurstillfalle_kodKurs = K.kodKurs
  INNER JOIN Larare AS L
    ON Kt.Kurstillfalle_akronymLarare = L.akronymLarare
 ORDER BY K.kodKurs;
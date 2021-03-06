-- MySQL Script generated by MySQL Workbench
-- Wed Apr  5 01:50:18 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema sjukhus
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sjukhus
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sjukhus` DEFAULT CHARACTER SET utf8 ;
USE `sjukhus` ;

-- -----------------------------------------------------
-- Table `sjukhus`.`Lakare`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sjukhus`.`Lakare` (
  `idLakare` INT NOT NULL AUTO_INCREMENT,
  `lakare_namn` VARCHAR(45) NOT NULL,
  `lakare_efternamn` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idLakare`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sjukhus`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sjukhus`.`Patient` (
  `idPatient` INT NOT NULL AUTO_INCREMENT,
  `patient_namn` VARCHAR(45) NOT NULL,
  `patient_efternamn` VARCHAR(45) NOT NULL,
  `fk_idLakare` INT NULL,
  PRIMARY KEY (`idPatient`),
  INDEX `fk_Patient_Lakare1_idx` (`fk_idLakare` ASC),
  CONSTRAINT `fk_Patient_Lakare1`
    FOREIGN KEY (`fk_idLakare`)
    REFERENCES `sjukhus`.`Lakare` (`idLakare`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sjukhus`.`Diagnos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sjukhus`.`Diagnos` (
  `idDiagnos` INT NOT NULL AUTO_INCREMENT,
  `diagnos_namn` VARCHAR(255) NOT NULL,
  `diagnos_kategori` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDiagnos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sjukhus`.`Skoterska`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sjukhus`.`Skoterska` (
  `idSkoterska` INT NOT NULL AUTO_INCREMENT,
  `skoterska_namn` VARCHAR(45) NOT NULL,
  `skoterska_efternamn` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSkoterska`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sjukhus`.`Medicin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sjukhus`.`Medicin` (
  `idMedicin` INT NOT NULL AUTO_INCREMENT,
  `medicin_namn` VARCHAR(225) NOT NULL,
  `medicin_doz` INT NOT NULL,
  `fk_idDiagnos` INT NOT NULL,
  PRIMARY KEY (`idMedicin`),
  INDEX `fk_Medicin_Diagnos1_idx` (`fk_idDiagnos` ASC),
  CONSTRAINT `fk_Medicin_Diagnos1`
    FOREIGN KEY (`fk_idDiagnos`)
    REFERENCES `sjukhus`.`Diagnos` (`idDiagnos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sjukhus`.`Patient_Diagnos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sjukhus`.`Patient_Diagnos` (
  `fk_Patient_idPatient` INT NOT NULL,
  `fk_Diagnos_idDiagnos` INT NOT NULL,
  `Patient_Diagnos` INT NOT NULL,
  INDEX `fk_Patient_has_Diagnos_Diagnos1_idx` (`fk_Diagnos_idDiagnos` ASC),
  INDEX `fk_Patient_has_Diagnos_Patient1_idx` (`fk_Patient_idPatient` ASC),
  PRIMARY KEY (`Patient_Diagnos`),
  CONSTRAINT `fk_Patient_has_Diagnos_Patient1`
    FOREIGN KEY (`fk_Patient_idPatient`)
    REFERENCES `sjukhus`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Patient_has_Diagnos_Diagnos1`
    FOREIGN KEY (`fk_Diagnos_idDiagnos`)
    REFERENCES `sjukhus`.`Diagnos` (`idDiagnos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sjukhus`.`Skoterska_Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sjukhus`.`Skoterska_Patient` (
  `fk_idSkoterska` INT NOT NULL,
  `fk_Patient_idPatient` INT NOT NULL,
  `Skoterska_Patientcol` INT NOT NULL,
  INDEX `fk_Skoterska_has_Patient_Patient1_idx` (`fk_Patient_idPatient` ASC),
  INDEX `fk_Skoterska_has_Patient_Skoterska1_idx` (`fk_idSkoterska` ASC),
  PRIMARY KEY (`Skoterska_Patientcol`),
  CONSTRAINT `fk_Skoterska_has_Patient_Skoterska1`
    FOREIGN KEY (`fk_idSkoterska`)
    REFERENCES `sjukhus`.`Skoterska` (`idSkoterska`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Skoterska_has_Patient_Patient1`
    FOREIGN KEY (`fk_Patient_idPatient`)
    REFERENCES `sjukhus`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

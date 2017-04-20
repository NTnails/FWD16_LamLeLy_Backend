-- phpMyAdmin SQL Dump
-- version 2.11.11.3
-- http://www.phpmyadmin.net
--
-- Värd: 83.168.227.23
-- Skapad: 20 april 2017 kl 13:43
-- Serverversion: 5.0.83
-- PHP-version: 4.4.9

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databas: `db1164707_LaHoal`
--

-- --------------------------------------------------------

--
-- Struktur för tabell `director`
--

CREATE TABLE IF NOT EXISTS `director` (
  `iddirector` int(11) NOT NULL auto_increment,
  `name` varchar(45) default NULL,
  `state` varchar(45) default NULL,
  `gender` varchar(45) default NULL,
  PRIMARY KEY  (`iddirector`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Data i tabell `director`
--

INSERT INTO `director` (`iddirector`, `name`, `state`, `gender`) VALUES
(1, 'Sohail', 'Stockholm', 'male'),
(2, 'David', 'Malmo', 'male'),
(3, 'Carlos', 'Helsingborg', 'male');

-- --------------------------------------------------------

--
-- Struktur för tabell `film`
--

CREATE TABLE IF NOT EXISTS `film` (
  `idfilm` int(11) NOT NULL auto_increment,
  `title` varchar(45) default NULL,
  `date` date default NULL,
  `fl_iddirector` int(11) NOT NULL,
  PRIMARY KEY  (`idfilm`,`fl_iddirector`),
  KEY `fk_film_director_idx` (`fl_iddirector`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Data i tabell `film`
--

INSERT INTO `film` (`idfilm`, `title`, `date`, `fl_iddirector`) VALUES
(1, 'youtube', '2017-04-01', 1),
(2, 'redtube', '2017-04-02', 3),
(3, '4tube', '2017-04-03', 2),
(4, 'xhamster', '2017-04-05', 3),
(5, 'dreamfilm', '2017-04-06', 2);

--
-- Restriktioner för dumpade tabeller
--

--
-- Restriktioner för tabell `film`
--
ALTER TABLE `film`
  ADD CONSTRAINT `fk_film_director` FOREIGN KEY (`fl_iddirector`) REFERENCES `director` (`iddirector`) ON DELETE NO ACTION ON UPDATE NO ACTION;

DELIMITER $$
--
-- Procedurer
--
CREATE DEFINER=`u1164707_LaHoal`@`%` PROCEDURE `account`(IN Fname VARCHAR(45))
BEGIN

SELECT * FROM Account where accountFname = Fname;

END$$

CREATE DEFINER=`u1164707_LaHoal`@`%` PROCEDURE `jokes_author`()
SELECT joke.joketext, author.name FROM author INNER JOIN joke ON author.id = joke.authorid where name = author$$

CREATE DEFINER=`u1164707_LaHoal`@`%` PROCEDURE `sp_show_all_films`()
SELECT 
        film.idfilm,
        film.title AS title,
        director.name AS name,
        director.gender AS gender,
        director.state AS state
        
    FROM
        (director
        JOIN film ON ((director.iddirector = 
        film.fl_iddirector)))$$

CREATE DEFINER=`u1164707_LaHoal`@`%` PROCEDURE `sp_show_all_jokes`()
SELECT 
        joke.id,
        joke.joketext AS joketext,
        author.name AS name
    FROM
        (author
        JOIN joke ON ((author.id = 
        joke.authorid)))$$

DELIMITER ;

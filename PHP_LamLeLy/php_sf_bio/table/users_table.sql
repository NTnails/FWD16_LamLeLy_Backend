---
CREATE PROCEDURE `sp_movies`()
SELECT 
        movie.movieId,
        movie.movieName AS movieName,
        movie.movieDuration AS movieDuration,
        movie.movieCopies AS movieCopies,
        category.categoryId,
        category.categoryName AS categoryName
        
    FROM
        (category
        JOIN movie ON ((category.categoryId = 
        movie.fk_categoryId)))

-----
CREATE PROCEDURE `sp_categories`()
SELECT 
        
        category.categoryId,
        category.categoryName AS categoryName
        
    FROM
category

--
--
-- Struktur för tabell `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `categoryId` int(11) NOT NULL auto_increment,
  `categoryName` varchar(45) default NULL,
  PRIMARY KEY  (`categoryId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- Data i tabell `category`
--

INSERT INTO `category` (`categoryId`, `categoryName`) VALUES
(1, 'Kid movies'),
(2, 'Action'),
(3, 'Porn'),
(4, 'Drama'),
(5, 'Horor'),
(6, 'Comedi');
-- --------------------------------------------------------

--
-- Struktur för tabell `movie`
--

CREATE TABLE IF NOT EXISTS `movie` (
  `movieId` int(11) NOT NULL auto_increment,
  `movieName` varchar(45) default NULL,
  `movieDuration` int(3) default NULL,
  `movieCopies` int(11) default NULL,
  `fk_categoryId` int(11) NOT NULL,
  PRIMARY KEY  (`movieId`,`fk_categoryId`),
  KEY `fk_Movie_Category_idx` (`fk_categoryId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Data i tabell `movie`
--

INSERT INTO `movie` (`movieId`, `movieName`, `movieDuration`, `movieCopies`, `fk_categoryId`) VALUES
(1, 'Kalle Anka', 120, 4, 1),
(2, 'My litle Pony', 90, 4, 2),
(3, 'Banan Pyjammas', 120, 3, 3),
(4, 'Halo', 60, 1, 4),
(6, 'Redtube', 122, 3, 1);

-- --------------------------------------------------------

--
-- Struktur för tabell `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(5) NOT NULL auto_increment,
  `name` varchar(25) NOT NULL,
  `email` varchar(25) NOT NULL,
  `pass` varchar(40) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;


--
-- Restriktioner för tabell `movie`
--
ALTER TABLE `movie`
  ADD CONSTRAINT `fk_Movie_Category` FOREIGN KEY (`fk_categoryID`) REFERENCES `category` (`categoryID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

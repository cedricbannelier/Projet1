-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Ven 01 Décembre 2017 à 13:56
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `projettest2`
--

-- --------------------------------------------------------

--
-- Structure de la table `choix`
--

CREATE TABLE IF NOT EXISTS `choix` (
  `numChoix` int(11) NOT NULL AUTO_INCREMENT,
  `nomChoix` text NOT NULL,
  `numSondage` int(11) NOT NULL,
  PRIMARY KEY (`numChoix`),
  KEY `FK_Choix_numSondage` (`numSondage`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Contenu de la table `choix`
--

INSERT INTO `choix` (`numChoix`, `nomChoix`, `numSondage`) VALUES
(3, 'Bleu', 1),
(4, 'Vert', 1),
(5, 'Rouge', 1),
(6, 'Gris', 1),
(7, 'Rose', 1),
(8, 'Noir', 1),
(9, 'Blanc', 1),
(10, 'Orange', 1),
(11, 'Wow', 2),
(12, 'D3', 2),
(13, 'GW1', 2),
(14, 'GW2', 2),
(15, 'Destiny2', 2),
(16, 'Heroes of the storm', 2),
(17, 'Starcraft1', 2),
(18, 'Starcraft2', 2),
(19, 'D1', 2),
(20, 'D2', 2);

-- --------------------------------------------------------

--
-- Structure de la table `lien`
--

CREATE TABLE IF NOT EXISTS `lien` (
  `numLien` int(11) NOT NULL AUTO_INCREMENT,
  `adresseLien` text NOT NULL,
  `numSondage` int(11) NOT NULL,
  PRIMARY KEY (`numLien`),
  KEY `FK_Lien_numSondage` (`numSondage`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Contenu de la table `lien`
--

INSERT INTO `lien` (`numLien`, `adresseLien`, `numSondage`) VALUES
(1, 'http://lienVote1', 1),
(2, 'http://lienVote2', 2),
(3, 'http://lienResultat1', 1),
(4, 'http://lienResultat2', 2),
(5, 'http://lienDesactivationAlea1', 1),
(6, 'http://lienDesactivationAlea2', 2);

-- --------------------------------------------------------

--
-- Structure de la table `sondage`
--

CREATE TABLE IF NOT EXISTS `sondage` (
  `numSondage` int(11) NOT NULL AUTO_INCREMENT,
  `questionSondage` text NOT NULL,
  `typeSondage` tinyint(1) NOT NULL,
  PRIMARY KEY (`numSondage`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `sondage`
--

INSERT INTO `sondage` (`numSondage`, `questionSondage`, `typeSondage`) VALUES
(1, 'Couleur préféré ?', 1),
(2, 'Jeux préférés ?', 2);

-- --------------------------------------------------------

--
-- Structure de la table `votant`
--

CREATE TABLE IF NOT EXISTS `votant` (
  `numVotant` int(11) NOT NULL AUTO_INCREMENT,
  `adresseIP` text,
  PRIMARY KEY (`numVotant`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Contenu de la table `votant`
--

INSERT INTO `votant` (`numVotant`, `adresseIP`) VALUES
(1, '1.1.1.1'),
(2, '2.2.2.2'),
(3, '3.3.3.3'),
(4, '4.4.4.4'),
(5, '5.5.5.5'),
(6, '6.6.6.6'),
(7, '7.7.7.7'),
(8, '8.8.8.8'),
(9, '9.9.9.9'),
(10, '10.10.10.10');

-- --------------------------------------------------------

--
-- Structure de la table `vote`
--

CREATE TABLE IF NOT EXISTS `vote` (
  `numVote` int(11) NOT NULL AUTO_INCREMENT,
  `nbVote` int(11) DEFAULT NULL,
  `nbVotant` int(11) DEFAULT NULL,
  `numChoix` int(11) NOT NULL,
  `numVotant` int(11) NOT NULL,
  PRIMARY KEY (`numVote`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Contenu de la table `vote`
--

INSERT INTO `vote` (`numVote`, `nbVote`, `nbVotant`, `numChoix`, `numVotant`) VALUES
(1, NULL, NULL, 3, 1),
(2, NULL, NULL, 4, 2),
(3, NULL, NULL, 4, 3),
(4, NULL, NULL, 5, 4),
(5, NULL, NULL, 6, 5),
(6, NULL, NULL, 6, 6),
(7, NULL, NULL, 8, 7),
(8, NULL, NULL, 10, 8),
(9, NULL, NULL, 10, 9),
(10, NULL, NULL, 10, 10);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `choix`
--
ALTER TABLE `choix`
  ADD CONSTRAINT `FK_Choix_numSondage` FOREIGN KEY (`numSondage`) REFERENCES `sondage` (`numSondage`);

--
-- Contraintes pour la table `lien`
--
ALTER TABLE `lien`
  ADD CONSTRAINT `FK_Lien_numSondage` FOREIGN KEY (`numSondage`) REFERENCES `sondage` (`numSondage`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

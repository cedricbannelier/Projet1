-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Lun 27 Novembre 2017 à 13:55
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `projettest`
--

-- --------------------------------------------------------

--
-- Structure de la table `choix`
--

CREATE TABLE IF NOT EXISTS `choix` (
  `numChoix` int(11) NOT NULL AUTO_INCREMENT,
  `reponse` text NOT NULL,
  `numSondage` int(11) NOT NULL,
  PRIMARY KEY (`numChoix`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Contenu de la table `choix`
--

INSERT INTO `choix` (`numChoix`, `reponse`, `numSondage`) VALUES
(1, 'Salade verte', 1),
(2, 'Frite', 1),
(3, 'Lasagne', 1),
(4, 'Steack', 1),
(5, 'Moule', 1),
(6, 'Verte', 2),
(7, 'Rouge', 2),
(8, 'Orange', 2),
(9, 'Bleu', 2);

-- --------------------------------------------------------

--
-- Structure de la table `comprend`
--

CREATE TABLE IF NOT EXISTS `comprend` (
  `nbVote` int(11) NOT NULL,
  `nbVotant` int(11) NOT NULL,
  `numSondage` int(11) NOT NULL,
  `numChoix` int(11) NOT NULL,
  PRIMARY KEY (`numSondage`,`numChoix`),
  KEY `FK_Comprend_numChoix` (`numChoix`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `comprend`
--

INSERT INTO `comprend` (`nbVote`, `nbVotant`, `numSondage`, `numChoix`) VALUES
(5, 5, 1, 1),
(2, 2, 1, 2),
(7, 7, 1, 3),
(4, 4, 1, 4),
(8, 8, 1, 5),
(4, 4, 2, 6),
(6, 6, 2, 7),
(2, 2, 2, 8),
(1, 1, 2, 9);

-- --------------------------------------------------------

--
-- Structure de la table `liens`
--

CREATE TABLE IF NOT EXISTS `liens` (
  `numLiens` int(11) NOT NULL AUTO_INCREMENT,
  `adresseLiens` text NOT NULL,
  `numSondage` int(11) NOT NULL,
  PRIMARY KEY (`numLiens`),
  KEY `FK_Liens_numSondage` (`numSondage`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Contenu de la table `liens`
--

INSERT INTO `liens` (`numLiens`, `adresseLiens`, `numSondage`) VALUES
(1, 'http://lienSup1', 1),
(2, 'http://lienVote1', 1),
(3, 'http://lienRes1', 1),
(6, 'http://lienSup2', 2),
(7, 'http://lienVote2', 2),
(8, 'http://lienRes2', 2);

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
(1, 'Votre repas préféré ?', 0),
(2, 'Votre couleur préférée', 1);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `comprend`
--
ALTER TABLE `comprend`
  ADD CONSTRAINT `FK_Comprend_numChoix` FOREIGN KEY (`numChoix`) REFERENCES `choix` (`numChoix`),
  ADD CONSTRAINT `FK_Comprend_numSondage` FOREIGN KEY (`numSondage`) REFERENCES `sondage` (`numSondage`);

--
-- Contraintes pour la table `liens`
--
ALTER TABLE `liens`
  ADD CONSTRAINT `FK_Liens_numSondage` FOREIGN KEY (`numSondage`) REFERENCES `sondage` (`numSondage`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

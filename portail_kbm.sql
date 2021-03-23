-- phpMyAdmin SQL Dump
-- version 4.5.4.1
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Sam 20 Mars 2021 à 21:12
-- Version du serveur :  5.7.11
-- Version de PHP :  5.6.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `portail_kbm`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_verify_pseudo` (IN `new_pseudo` VARCHAR(32))  BEGIN
DECLARE temp VARCHAR(32);
SET temp = "";
SELECT pseudocli INTO temp FROM client WHERE pseudocli = new_pseudo;
IF temp != "" THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Le pseudo existe déja dans la base';
END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE `client` (
  `idcli` bigint(20) NOT NULL,
  `nomcli` varchar(50) NOT NULL,
  `prencli` varchar(50) NOT NULL,
  `telcli` varchar(20) NOT NULL,
  `mailcli` varchar(100) NOT NULL,
  `categoriecli` smallint(6) NOT NULL,
  `pseudocli` varchar(32) NOT NULL,
  `mdpcli` varchar(32) NOT NULL,
  `cp` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `client`
--

INSERT INTO `client` (`idcli`, `nomcli`, `prencli`, `telcli`, `mailcli`, `categoriecli`, `pseudocli`, `mdpcli`, `cp`) VALUES
(1, 'girard', 'Jean-claude', '0690070277', 'jeanclaude.girard71@example.com', 2, 'giro', 'gijae7', 97139),
(5, 'vida', 'alexandra', '0690117901', 'alexandra.vadal63@example.com', 1, 'alex', 'viale1', 97110),
(7, 'brun', 'patrick', '0690030281', 'patrick.brun41@example.com', 3, 'pat', 'brpat1', 97139),
(12, 'rolland', 'laure', '0690102798', 'laure.rolland94@example.com', 2, 'laure', 'rolau8', 97190),
(18, 'blanc', 'magali', '0690021286', 'magali.blanc27@example.com', 3, 'magi', 'blmag6', 97111),
(19, 'colin', 'florian', '0690112794', 'florian.colin@example.com', 1, 'flori', 'coflo4', 97160),
(20, 'ok', 'notbad', '06254845', 'mai@mail.com', 1, 'caitlin', '45sdf52', 97139);

--
-- Déclencheurs `client`
--
DELIMITER $$
CREATE TRIGGER `verify_pseudo1` BEFORE INSERT ON `client` FOR EACH ROW CALL p_verify_pseudo(NEW.pseudocli)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `verify_pseudo2` BEFORE UPDATE ON `client` FOR EACH ROW CALL p_verify_pseudo(NEW.pseudocli)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `evenement`
--

CREATE TABLE `evenement` (
  `idevent` bigint(20) NOT NULL,
  `typeevent` varchar(50) DEFAULT NULL,
  `libevent` varchar(100) DEFAULT NULL,
  `desevent` varchar(300) DEFAULT NULL,
  `photoevent` varchar(100) DEFAULT NULL,
  `flyer` varchar(100) DEFAULT NULL,
  `debutevent` date NOT NULL,
  `debutevent_hr` time NOT NULL,
  `finevent` date DEFAULT NULL,
  `finevent_hr` time DEFAULT NULL,
  `cr_event` varchar(300) DEFAULT NULL,
  `visevent` tinyint(1) DEFAULT NULL,
  `cp` bigint(20) NOT NULL,
  `idlak` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `evenement`
--

INSERT INTO `evenement` (`idevent`, `typeevent`, `libevent`, `desevent`, `photoevent`, `flyer`, `debutevent`, `debutevent_hr`, `finevent`, `finevent_hr`, `cr_event`, `visevent`, `cp`, `idlak`) VALUES
(1, 'culturelle', 'dejeuné', 'festin kréol', 'https://google.com/image.png', 'https://google.com/image.png', '1990-01-01', '07:00:00', '1990-01-01', '07:01:00', 'on a passé un bon moment', 1, 97190, 1),
(2, 'cultuelle', 'concert', 'ferstival an nou', 'https://google.com/image.png', 'https://google.com/image.png', '1990-01-01', '07:00:00', '1990-01-01', '07:01:00', 'les musiciens avais le covid-19', 1, 97190, 1);

-- --------------------------------------------------------

--
-- Structure de la table `lakou`
--

CREATE TABLE `lakou` (
  `idlak` bigint(20) NOT NULL,
  `nomlak` varchar(100) DEFAULT NULL,
  `activitelak` varchar(300) DEFAULT NULL,
  `photo_lak_1` varchar(100) DEFAULT NULL,
  `photo_lak_2` varchar(100) DEFAULT NULL,
  `photo_lak_3` varchar(100) DEFAULT NULL,
  `maillak` varchar(100) DEFAULT NULL,
  `cp` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `lakou`
--

INSERT INTO `lakou` (`idlak`, `nomlak`, `activitelak`, `photo_lak_1`, `photo_lak_2`, `photo_lak_3`, `maillak`, `cp`) VALUES
(1, 'les gaillard', 'divers', 'https://google.com/image.png', 'https://google.com/image.png', 'https://google.com/image.png', 'lesgaillard@divers.com', 97190);

-- --------------------------------------------------------

--
-- Structure de la table `ville`
--

CREATE TABLE `ville` (
  `cp` bigint(20) NOT NULL,
  `nomville` varchar(50) NOT NULL,
  `idzone` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `ville`
--

INSERT INTO `ville` (`cp`, `nomville`, `idzone`) VALUES
(97110, 'pointe a pitre', 2),
(97111, 'morne a l’eau', 4),
(97139, 'Les abymes', 2),
(97160, 'Le moule', 4),
(97190, 'Le gosier', 2);

-- --------------------------------------------------------

--
-- Structure de la table `zone`
--

CREATE TABLE `zone` (
  `idzone` smallint(6) NOT NULL,
  `nomzone` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `zone`
--

INSERT INTO `zone` (`idzone`, `nomzone`) VALUES
(2, 'Zone 2'),
(4, 'Zone 4');

--
-- Index pour les tables exportées
--

--
-- Index pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`idcli`),
  ADD KEY `cp` (`cp`);

--
-- Index pour la table `evenement`
--
ALTER TABLE `evenement`
  ADD PRIMARY KEY (`idevent`),
  ADD KEY `idlak` (`idlak`),
  ADD KEY `cp` (`cp`);

--
-- Index pour la table `lakou`
--
ALTER TABLE `lakou`
  ADD PRIMARY KEY (`idlak`),
  ADD KEY `cp` (`cp`);

--
-- Index pour la table `ville`
--
ALTER TABLE `ville`
  ADD PRIMARY KEY (`cp`),
  ADD KEY `idzone` (`idzone`);

--
-- Index pour la table `zone`
--
ALTER TABLE `zone`
  ADD PRIMARY KEY (`idzone`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
  MODIFY `idcli` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT pour la table `evenement`
--
ALTER TABLE `evenement`
  MODIFY `idevent` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `lakou`
--
ALTER TABLE `lakou`
  MODIFY `idlak` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `zone`
--
ALTER TABLE `zone`
  MODIFY `idzone` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `client_ibfk_1` FOREIGN KEY (`cp`) REFERENCES `ville` (`cp`);

--
-- Contraintes pour la table `evenement`
--
ALTER TABLE `evenement`
  ADD CONSTRAINT `evenement_ibfk_1` FOREIGN KEY (`idlak`) REFERENCES `lakou` (`idlak`),
  ADD CONSTRAINT `evenement_ibfk_2` FOREIGN KEY (`cp`) REFERENCES `ville` (`cp`);

--
-- Contraintes pour la table `lakou`
--
ALTER TABLE `lakou`
  ADD CONSTRAINT `lakou_ibfk_1` FOREIGN KEY (`cp`) REFERENCES `ville` (`cp`);

--
-- Contraintes pour la table `ville`
--
ALTER TABLE `ville`
  ADD CONSTRAINT `ville_ibfk_1` FOREIGN KEY (`idzone`) REFERENCES `zone` (`idzone`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

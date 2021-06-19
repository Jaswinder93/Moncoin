-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : sam. 19 juin 2021 à 20:05
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `moncoin`
--

-- --------------------------------------------------------

--
-- Structure de la table `administrateur`
--

DROP TABLE IF EXISTS `administrateur`;
CREATE TABLE IF NOT EXISTS `administrateur` (
  `idAdmin` int(11) NOT NULL,
  `idUtilisateur` int(11) NOT NULL,
  PRIMARY KEY (`idAdmin`),
  KEY `idUtilisateur` (`idUtilisateur`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `administrateur`
--

INSERT INTO `administrateur` (`idAdmin`, `idUtilisateur`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `administre`
--

DROP TABLE IF EXISTS `administre`;
CREATE TABLE IF NOT EXISTS `administre` (
  `idAdmin` int(11) NOT NULL,
  `idUtilisateur` int(11) NOT NULL,
  `ActionAdmin` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idAdmin`,`idUtilisateur`),
  KEY `idUtilisateur` (`idUtilisateur`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `cartebancaire`
--

DROP TABLE IF EXISTS `cartebancaire`;
CREATE TABLE IF NOT EXISTS `cartebancaire` (
  `NumCarte` int(11) NOT NULL,
  `Montant` decimal(15,2) DEFAULT NULL,
  `cryptogramme` int(11) DEFAULT NULL,
  `idUtilisateur` int(11) NOT NULL,
  PRIMARY KEY (`NumCarte`),
  KEY `idUtilisateur` (`idUtilisateur`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `idCommande` int(11) NOT NULL,
  `EtatCommande` varchar(50) NOT NULL,
  `MontantCommande` decimal(15,2) DEFAULT NULL,
  `DateCommande` datetime DEFAULT NULL,
  `idAdmin` int(11) NOT NULL,
  `idPaiement` int(11) NOT NULL,
  `idUtilisateur` int(11) NOT NULL,
  PRIMARY KEY (`idCommande`),
  KEY `idAdmin` (`idAdmin`),
  KEY `idPaiement` (`idPaiement`),
  KEY `idUtilisateur` (`idUtilisateur`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `constitue`
--

DROP TABLE IF EXISTS `constitue`;
CREATE TABLE IF NOT EXISTS `constitue` (
  `idProduit` int(11) NOT NULL,
  `idCommande` int(11) NOT NULL,
  PRIMARY KEY (`idProduit`,`idCommande`),
  KEY `idCommande` (`idCommande`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `paiement`
--

DROP TABLE IF EXISTS `paiement`;
CREATE TABLE IF NOT EXISTS `paiement` (
  `idPaiement` int(11) NOT NULL,
  `typePaiement` int(11) DEFAULT NULL,
  PRIMARY KEY (`idPaiement`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `panier`
--

DROP TABLE IF EXISTS `panier`;
CREATE TABLE IF NOT EXISTS `panier` (
  `idPanier` varchar(50) NOT NULL,
  `nbProduits` int(11) DEFAULT NULL,
  `idUtilisateur` int(11) NOT NULL,
  PRIMARY KEY (`idPanier`),
  KEY `idUtilisateur` (`idUtilisateur`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

DROP TABLE IF EXISTS `produit`;
CREATE TABLE IF NOT EXISTS `produit` (
  `idProduit` int(11) NOT NULL,
  `NomProduit` varchar(50) NOT NULL,
  `PrixProduit` decimal(15,2) NOT NULL,
  `QteProduit` int(11) DEFAULT NULL,
  `Categorie` varchar(50) NOT NULL,
  `idVendeur` int(11) DEFAULT NULL,
  `image` longblob,
  PRIMARY KEY (`idProduit`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `idUtilisateur` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(50) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `mail` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `tel` varchar(50) DEFAULT NULL,
  `typeUtilisateur` varchar(20) NOT NULL DEFAULT 'utilisateur',
  `adresse` varchar(50) DEFAULT NULL,
  `dateInscription` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reponseSecrete` varchar(50) NOT NULL,
  `questionSecrete` varchar(100) NOT NULL,
  PRIMARY KEY (`idUtilisateur`),
  UNIQUE KEY `login` (`login`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`idUtilisateur`, `login`, `nom`, `mail`, `prenom`, `password`, `tel`, `typeUtilisateur`, `adresse`, `dateInscription`, `reponseSecrete`, `questionSecrete`) VALUES
(1, 'jaswinder', 'Singh', 'jas93@gmail.com', 'Jaswinder', 'jaswinder', '0802930339', 'administrateur', '1 rue de paris', '2021-06-03 20:52:54', 'dofus', 'Quel est mon premier jeu ?'),
(2, 'tanguy', 'Amiot', 'tanguy@gmail.com', 'Tanguy', 'tanguy', '0802930330', 'utilisateur', '1 rue de rien', '2021-06-12 20:55:12', 'test1', 'test un ?'),
(3, 'zineb', 'Chaouche', 'zineb@gmail.com', 'Zineb', 'chaouche', '0802930331', 'utilisateur', '1 rue de rien 2', '2021-06-12 20:57:47', 'test2', 'test deux ?'),
(22, 'jaskay93', 'jaskay', 'jas@gmail.com', 'test', 'jaskay', '1111111111', 'utilisateur', 'aaaaa', '2021-06-16 22:10:44', 'idem', 'je c pas quoi mettre');

-- --------------------------------------------------------

--
-- Structure de la table `vente`
--

DROP TABLE IF EXISTS `vente`;
CREATE TABLE IF NOT EXISTS `vente` (
  `idVente` int(11) NOT NULL,
  `EtatVente` varchar(50) NOT NULL,
  `DateVente` datetime NOT NULL,
  `idProduit` int(11) NOT NULL,
  `idUtilisateur` int(11) NOT NULL,
  PRIMARY KEY (`idVente`),
  KEY `idProduit` (`idProduit`),
  KEY `idUtilisateur` (`idUtilisateur`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

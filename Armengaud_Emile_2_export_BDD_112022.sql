-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 21 nov. 2022 à 19:27
-- Version du serveur : 8.0.27
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `express_food`
--

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(32) NOT NULL,
  `telephone` int NOT NULL,
  `rue` varchar(64) NOT NULL,
  `ville` varchar(64) NOT NULL,
  `code_postal` varchar(5) NOT NULL,
  `pays` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`id`, `nom`, `telephone`, `rue`, `ville`, `code_postal`, `pays`) VALUES
(1, 'Antoine', 684368436, '11 carrefour Aristide Briand', 'Bordeaux', '33000', 'France'),
(2, 'Franck', 614371437, '105 Rue de la Course', 'Bordeaux', '33000', 'France'),
(3, 'Samuël', 689428942, '1 Rue Ducau', 'Bordeaux', '33000', 'France');

-- --------------------------------------------------------

--
-- Structure de la table `commandes`
--

DROP TABLE IF EXISTS `commandes`;
CREATE TABLE IF NOT EXISTS `commandes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_client` int NOT NULL,
  `id_livreur` int NOT NULL DEFAULT '0',
  `numero_rue` int NOT NULL,
  `rue` varchar(64) NOT NULL,
  `ville` varchar(64) NOT NULL,
  `code_postal` int NOT NULL,
  `pays` varchar(32) NOT NULL,
  `infor_complementaire_addresse` varchar(1500) NOT NULL,
  `date_heure_commande` datetime NOT NULL,
  `date_heure_livraison` datetime NOT NULL,
  `a_ete_livre` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id_client` (`id_client`),
  KEY `id_livreur` (`id_livreur`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `commandes`
--

INSERT INTO `commandes` (`id`, `id_client`, `id_livreur`, `numero_rue`, `rue`, `ville`, `code_postal`, `pays`, `infor_complementaire_addresse`, `date_heure_commande`, `date_heure_livraison`, `a_ete_livre`) VALUES
(1, 1, 2, 11, 'carrefour Aristide Briand', 'Bordeaux', 33000, 'France', '', '2022-11-17 19:00:00', '2022-11-17 19:23:00', 0),
(2, 2, 3, 105, 'rue de la Course', 'Bordeaux', 33000, 'France', '', '2022-11-18 13:14:07', '2022-11-18 13:25:00', 1);

-- --------------------------------------------------------

--
-- Structure de la table `composition_commandes`
--

DROP TABLE IF EXISTS `composition_commandes`;
CREATE TABLE IF NOT EXISTS `composition_commandes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_commande` int NOT NULL,
  `id_plat` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_id_commandes` (`id_commande`),
  KEY `FK_id_plats` (`id_plat`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `composition_commandes`
--

INSERT INTO `composition_commandes` (`id`, `id_commande`, `id_plat`) VALUES
(1, 1, 2),
(2, 1, 4),
(3, 2, 5),
(4, 2, 7);

-- --------------------------------------------------------

--
-- Structure de la table `etat_livreur`
--

DROP TABLE IF EXISTS `etat_livreur`;
CREATE TABLE IF NOT EXISTS `etat_livreur` (
  `id` int NOT NULL AUTO_INCREMENT,
  `libelle` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `etat_livreur`
--

INSERT INTO `etat_livreur` (`id`, `libelle`) VALUES
(1, 'libre'),
(2, 'en_livraison');

-- --------------------------------------------------------

--
-- Structure de la table `livreurs`
--

DROP TABLE IF EXISTS `livreurs`;
CREATE TABLE IF NOT EXISTS `livreurs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(32) NOT NULL,
  `prenom` varchar(32) NOT NULL,
  `etat` int NOT NULL,
  `rue` varchar(64) NOT NULL,
  `ville` varchar(64) NOT NULL,
  `code_postale` int NOT NULL,
  `pays` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `etat` (`etat`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `livreurs`
--

INSERT INTO `livreurs` (`id`, `nom`, `prenom`, `etat`, `rue`, `ville`, `code_postale`, `pays`) VALUES
(1, 'Patrick', 'Dupont', 1, 'Rue Frère', 'Bordeaux', 33000, 'France'),
(2, 'Henry', 'Michelon', 1, 'Rue de Varize', 'Bordeaux', 33000, 'France'),
(3, 'François', 'Beck', 2, 'Quai De La Douane', 'Bordeaux', 33000, 'France'),
(4, 'Antoine', 'Arouet', 1, 'Rue Roustaing', 'Talence', 33400, 'France');

-- --------------------------------------------------------

--
-- Structure de la table `plats_du_jour`
--

DROP TABLE IF EXISTS `plats_du_jour`;
CREATE TABLE IF NOT EXISTS `plats_du_jour` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` int NOT NULL,
  `jour` date NOT NULL,
  `libelle_plat` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_type_plat` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `plats_du_jour`
--

INSERT INTO `plats_du_jour` (`id`, `type`, `jour`, `libelle_plat`) VALUES
(1, 1, '2022-11-17', 'spaghetti bolognaise '),
(2, 1, '2022-11-17', 'ravioli  à la truffe'),
(3, 2, '2022-11-17', 'turt'),
(4, 2, '2022-11-17', 'Banana split'),
(5, 1, '2022-11-18', 'couscous'),
(6, 1, '2022-11-18', 'marinade de poisson'),
(7, 2, '2022-11-18', 'Mousse au chocolat'),
(8, 2, '2022-11-18', 'Forêt noir'),
(9, 1, '2022-11-21', 'Flamenkuche');

-- --------------------------------------------------------

--
-- Structure de la table `type_plat`
--

DROP TABLE IF EXISTS `type_plat`;
CREATE TABLE IF NOT EXISTS `type_plat` (
  `id` int NOT NULL AUTO_INCREMENT,
  `libelle` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `type_plat`
--

INSERT INTO `type_plat` (`id`, `libelle`) VALUES
(1, 'plat_principal'),
(2, 'dessert');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commandes`
--
ALTER TABLE `commandes`
  ADD CONSTRAINT `FK_commande_id_client` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `FK_commande_id_livreur_` FOREIGN KEY (`id_livreur`) REFERENCES `livreurs` (`id`);

--
-- Contraintes pour la table `composition_commandes`
--
ALTER TABLE `composition_commandes`
  ADD CONSTRAINT `FK_id_commandes` FOREIGN KEY (`id_commande`) REFERENCES `commandes` (`id`),
  ADD CONSTRAINT `FK_id_plats` FOREIGN KEY (`id_plat`) REFERENCES `plats_du_jour` (`id`);

--
-- Contraintes pour la table `livreurs`
--
ALTER TABLE `livreurs`
  ADD CONSTRAINT `FK_etat_livreur` FOREIGN KEY (`etat`) REFERENCES `etat_livreur` (`id`);

--
-- Contraintes pour la table `plats_du_jour`
--
ALTER TABLE `plats_du_jour`
  ADD CONSTRAINT `FK_type_plat` FOREIGN KEY (`type`) REFERENCES `type_plat` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

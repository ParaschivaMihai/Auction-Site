-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: site_licitati
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id_admin` int(11) NOT NULL AUTO_INCREMENT,
  `nume_admin` varchar(50) NOT NULL,
  `parola` varchar(100) NOT NULL,
  PRIMARY KEY (`id_admin`),
  UNIQUE KEY `nume_admin_UNIQUE` (`nume_admin`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'ion','1234'),(2,'Gica','12313');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `licitatie`
--

DROP TABLE IF EXISTS `licitatie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `licitatie` (
  `id_cumparator` int(11) NOT NULL,
  `id_telefon` int(11) NOT NULL,
  `oferta` double NOT NULL,
  `data_oferta` datetime NOT NULL,
  `status_licitatie` int(11) NOT NULL,
  PRIMARY KEY (`id_cumparator`,`id_telefon`),
  KEY `id_telefon` (`id_telefon`),
  KEY `status_licitatie` (`status_licitatie`),
  CONSTRAINT `licitatie_ibfk_1` FOREIGN KEY (`id_cumparator`) REFERENCES `users` (`id_user`),
  CONSTRAINT `licitatie_ibfk_2` FOREIGN KEY (`id_telefon`) REFERENCES `telefon` (`id_telefon`),
  CONSTRAINT `licitatie_ibfk_3` FOREIGN KEY (`status_licitatie`) REFERENCES `status` (`id_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `licitatie`
--

LOCK TABLES `licitatie` WRITE;
/*!40000 ALTER TABLE `licitatie` DISABLE KEYS */;
INSERT INTO `licitatie` VALUES (1,4,1700,'2019-02-10 00:00:00',3),(1,5,1600,'2019-02-11 00:00:00',3),(2,1,1500,'2019-03-03 00:00:00',3),(3,1,1600,'2019-03-04 00:00:00',3);
/*!40000 ALTER TABLE `licitatie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_telefon`
--

DROP TABLE IF EXISTS `model_telefon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_telefon` (
  `id_model` int(11) NOT NULL AUTO_INCREMENT,
  `nume_model` varchar(50) NOT NULL,
  `model_procesor` varchar(50) NOT NULL,
  `marime_ecran` varchar(10) NOT NULL,
  `camera` varchar(10) NOT NULL,
  `memorie_ram` varchar(10) NOT NULL,
  `memorie` varchar(10) NOT NULL,
  `sistem_operare` varchar(10) NOT NULL,
  `capacitate_baterie` varchar(10) NOT NULL,
  `data_lansare` date NOT NULL,
  PRIMARY KEY (`id_model`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_telefon`
--

LOCK TABLES `model_telefon` WRITE;
/*!40000 ALTER TABLE `model_telefon` DISABLE KEYS */;
INSERT INTO `model_telefon` VALUES (1,'Samsung Galaxy S8','Snapdragon 855','6.1\'\'','10M','6Gb','128GB','Android','3400mAh','2017-02-20'),(2,'Samsung Galaxy s9','Samsung Exynos 9810','5.8\'\'','12M','6GB','128GB','Android','3100mAh','2018-03-25'),(3,'Iphone X','Apple A11 Bionic','5.8\'\'','12M','3GB','64GB','IOS','3100mAh','2017-09-11'),(4,'OnePlus 6','Snapdragon 845','6.28\'\'','12M','8GB','256GB','Android','3300mAh','2018-05-05');
/*!40000 ALTER TABLE `model_telefon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `id_status` int(11) NOT NULL AUTO_INCREMENT,
  `nume_status` varchar(50) NOT NULL,
  PRIMARY KEY (`id_status`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'activ'),(2,'inactiv'),(3,'in procesare'),(4,'procesat'),(6,'finalizat'),(7,'in licitatie'),(10,'test');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telefon`
--

DROP TABLE IF EXISTS `telefon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telefon` (
  `id_telefon` int(11) NOT NULL AUTO_INCREMENT,
  `data_cumparare` date DEFAULT NULL,
  `pret_initial` double NOT NULL,
  `descriere` varchar(255) NOT NULL,
  `id_proprietar` int(11) NOT NULL,
  `id_model` int(11) NOT NULL,
  `imagine` varchar(45) DEFAULT NULL,
  `status_telefon` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_telefon`),
  KEY `id_proprietar` (`id_proprietar`),
  KEY `id_model` (`id_model`),
  KEY `status_telefon` (`status_telefon`),
  CONSTRAINT `telefon_ibfk_1` FOREIGN KEY (`id_proprietar`) REFERENCES `users` (`id_user`),
  CONSTRAINT `telefon_ibfk_2` FOREIGN KEY (`id_model`) REFERENCES `model_telefon` (`id_model`),
  CONSTRAINT `telefon_ibfk_3` FOREIGN KEY (`status_telefon`) REFERENCES `status` (`id_status`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telefon`
--

LOCK TABLES `telefon` WRITE;
/*!40000 ALTER TABLE `telefon` DISABLE KEYS */;
INSERT INTO `telefon` VALUES (1,'2019-01-01',2000,'bun',1,1,'assets/1.jpg',7),(2,'2019-04-29',2600,'bun',1,3,'assets/2.jpg',7),(3,'2018-12-10',3000,'bun',1,1,'assets/3.jpg',7),(4,'2019-10-10',3400,'bun',2,3,'assets/4.jpg',7),(5,'2019-02-01',2999,'mediu',3,1,'assets/5.jpg',7),(6,'2019-07-20',1920,'mediu',4,2,'assets/6.jpg',7),(7,'2019-08-11',2500,'ok',1,4,'assets/7.jpg',7),(8,'2018-11-23',1900,'bun',2,4,'assets/8.jpg',7),(9,'2019-03-31',1700,'rau',4,1,'assets/9.jpg',7),(10,'2019-09-08',2990,'bun',2,2,'assets/10.jpg',7),(11,'2019-12-24',3300,'bun',3,3,'assets/11.jpg',7),(12,'2019-10-30',1900,'rau',5,4,'assets/12.jpg',7);
/*!40000 ALTER TABLE `telefon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tip_plata`
--

DROP TABLE IF EXISTS `tip_plata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tip_plata` (
  `id_tip_plata` int(11) NOT NULL AUTO_INCREMENT,
  `nume_plata` varchar(50) NOT NULL,
  PRIMARY KEY (`id_tip_plata`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tip_plata`
--

LOCK TABLES `tip_plata` WRITE;
/*!40000 ALTER TABLE `tip_plata` DISABLE KEYS */;
INSERT INTO `tip_plata` VALUES (1,'card'),(2,'cash');
/*!40000 ALTER TABLE `tip_plata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tranzactie`
--

DROP TABLE IF EXISTS `tranzactie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tranzactie` (
  `id_telefon` int(11) NOT NULL,
  `id_cumparator` int(11) NOT NULL,
  `data_deschidere` datetime NOT NULL,
  `data_inchidere` datetime NOT NULL,
  `status_tranzactie` int(11) DEFAULT NULL,
  `pret_final` double DEFAULT NULL,
  `tip_plata` int(11) NOT NULL,
  PRIMARY KEY (`id_telefon`,`id_cumparator`),
  KEY `id_cumparator` (`id_cumparator`),
  KEY `tip_plata` (`tip_plata`),
  KEY `tranzactie_ibfk_3` (`status_tranzactie`),
  CONSTRAINT `tranzactie_ibfk_1` FOREIGN KEY (`id_cumparator`) REFERENCES `users` (`id_user`),
  CONSTRAINT `tranzactie_ibfk_2` FOREIGN KEY (`id_telefon`) REFERENCES `telefon` (`id_telefon`),
  CONSTRAINT `tranzactie_ibfk_3` FOREIGN KEY (`status_tranzactie`) REFERENCES `status` (`id_status`),
  CONSTRAINT `tranzactie_ibfk_4` FOREIGN KEY (`tip_plata`) REFERENCES `tip_plata` (`id_tip_plata`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tranzactie`
--

LOCK TABLES `tranzactie` WRITE;
/*!40000 ALTER TABLE `tranzactie` DISABLE KEYS */;
INSERT INTO `tranzactie` VALUES (1,3,'2019-02-01 00:00:00','2019-04-01 00:00:00',3,1600,1),(4,1,'2019-02-01 00:00:00','2019-04-01 00:00:00',3,1700,1),(5,1,'2019-02-01 00:00:00','2019-04-01 00:00:00',3,1600,1);
/*!40000 ALTER TABLE `tranzactie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `nume` varchar(50) NOT NULL,
  `prenume` varchar(50) NOT NULL,
  `mail` varchar(50) NOT NULL,
  `nr_telefon` varchar(50) NOT NULL,
  `adresa` varchar(50) NOT NULL,
  `parola` varchar(100) NOT NULL,
  `data_inregistrare` date NOT NULL,
  `status_user` int(11) NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `mail` (`mail`),
  UNIQUE KEY `nr_telefon` (`nr_telefon`),
  KEY `status_user` (`status_user`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`status_user`) REFERENCES `status` (`id_status`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'mihai','paraschiva','mihai@yahoo.com','0001','abc','0000','2020-01-06',1),(2,'Andrei','Bogdan','andrei@yahoo.com','111077','adfaa','0000','2020-01-06',1),(3,'Ionut','Dumitru','Ionut@gmail.com','0002','abc','0000','2020-01-06',1),(4,'Alexandra','Popescu','alexandra@gmail.com','1110001','abccda','0000','2020-01-06',1),(5,'Georgiana','Avram','georgiana@yahoo.com','00010100','aaafafa','0000','2020-01-06',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-09 22:22:43

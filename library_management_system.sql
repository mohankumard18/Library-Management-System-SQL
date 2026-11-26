CREATE DATABASE  IF NOT EXISTS `library_management_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `library_management_db`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: library_management_db
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authors` (
  `author_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(80) NOT NULL,
  `last_name` varchar(80) NOT NULL,
  `nationality` varchar(80) DEFAULT 'Indian',
  `birth_year` int DEFAULT NULL,
  PRIMARY KEY (`author_id`),
  CONSTRAINT `authors_chk_1` CHECK (((`birth_year` >= 1500) and (`birth_year` <= 2015)))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` VALUES (1,'Martin','Kleppmann','British',1982),(2,'Robert','Martin','American',1952),(3,'Thomas','Cormen','American',1956),(4,'Charles','Leiserson','American',1953),(5,'Arundhati','Roy','Indian',1961),(6,'Morgan','Housel','American',1984),(7,'James','Clear','American',1986),(8,'A.P.J. Abdul','Kalam','Indian',1931),(9,'Yuval Noah','Harari','Israeli',1976),(10,'Wes','McKinney','American',1985),(11,'Eric','Matthes','American',1972),(12,'Vikram','Seth','Indian',1952);
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_authors`
--

DROP TABLE IF EXISTS `book_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_authors` (
  `book_id` int NOT NULL,
  `author_id` int NOT NULL,
  `author_role` enum('Primary Author','Co-Author','Editor') NOT NULL DEFAULT 'Primary Author',
  PRIMARY KEY (`book_id`,`author_id`),
  KEY `fk_ba_author` (`author_id`),
  CONSTRAINT `fk_ba_author` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_ba_book` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_authors`
--

LOCK TABLES `book_authors` WRITE;
/*!40000 ALTER TABLE `book_authors` DISABLE KEYS */;
INSERT INTO `book_authors` VALUES (1,1,'Primary Author'),(2,2,'Primary Author'),(3,3,'Primary Author'),(3,4,'Co-Author'),(4,5,'Primary Author'),(5,6,'Primary Author'),(6,7,'Primary Author'),(7,8,'Primary Author'),(8,9,'Primary Author'),(9,10,'Primary Author'),(10,11,'Primary Author'),(11,12,'Primary Author'),(12,1,'Editor');
/*!40000 ALTER TABLE `book_authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_issues`
--

DROP TABLE IF EXISTS `book_issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_issues` (
  `issue_id` int NOT NULL AUTO_INCREMENT,
  `book_id` int NOT NULL,
  `member_id` int NOT NULL,
  `issue_date` date NOT NULL,
  `due_date` date NOT NULL,
  `status` enum('Issued','Returned','Overdue') NOT NULL DEFAULT 'Issued',
  PRIMARY KEY (`issue_id`),
  KEY `fk_issue_book` (`book_id`),
  KEY `idx_issues_member_status` (`member_id`,`status`),
  CONSTRAINT `fk_issue_book` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_issue_member` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_issue_dates` CHECK ((`due_date` >= `issue_date`))
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_issues`
--

LOCK TABLES `book_issues` WRITE;
/*!40000 ALTER TABLE `book_issues` DISABLE KEYS */;
INSERT INTO `book_issues` VALUES (1,1,1,'2026-08-01','2026-08-15','Returned'),(2,2,2,'2026-08-03','2026-08-17','Returned'),(3,5,3,'2026-08-10','2026-08-24','Returned'),(4,6,4,'2026-08-12','2026-08-26','Returned'),(5,3,5,'2026-09-01','2026-09-15','Returned'),(6,7,6,'2026-09-05','2026-09-19','Returned'),(7,8,7,'2026-09-10','2026-09-24','Returned'),(8,9,8,'2026-09-18','2026-10-02','Returned'),(9,1,9,'2026-10-01','2026-10-15','Returned'),(10,6,10,'2026-10-05','2026-10-19','Returned'),(11,1,2,'2026-10-20','2026-11-03','Overdue'),(12,2,7,'2026-10-22','2026-11-05','Overdue'),(13,3,3,'2026-10-25','2026-11-08','Overdue'),(14,4,1,'2026-11-12','2026-11-26','Issued'),(15,5,12,'2026-11-15','2026-11-29','Issued'),(16,6,8,'2026-11-21','2026-12-05','Issued'),(17,8,10,'2026-11-21','2026-12-05','Issued');
/*!40000 ALTER TABLE `book_issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_returns`
--

DROP TABLE IF EXISTS `book_returns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_returns` (
  `return_id` int NOT NULL AUTO_INCREMENT,
  `issue_id` int NOT NULL,
  `return_date` date NOT NULL,
  `book_condition` enum('Good','Fair','Damaged') NOT NULL DEFAULT 'Good',
  `remarks` varchar(255) DEFAULT 'Returned on time',
  PRIMARY KEY (`return_id`),
  UNIQUE KEY `issue_id` (`issue_id`),
  CONSTRAINT `fk_return_issue` FOREIGN KEY (`issue_id`) REFERENCES `book_issues` (`issue_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_returns`
--

LOCK TABLES `book_returns` WRITE;
/*!40000 ALTER TABLE `book_returns` DISABLE KEYS */;
INSERT INTO `book_returns` VALUES (1,1,'2026-08-14','Good','Returned 1 day early'),(2,2,'2026-08-21','Good','Returned 4 days late'),(3,3,'2026-08-24','Good','Returned on due date'),(4,4,'2026-08-25','Good','Returned on time'),(5,5,'2026-09-20','Fair','Returned 5 days late; slight cover wear'),(6,6,'2026-09-18','Good','Returned on time'),(7,7,'2026-10-02','Fair','Returned 8 days late'),(8,8,'2026-10-01','Good','Returned on time'),(9,9,'2026-10-18','Good','Returned 3 days late'),(10,10,'2026-10-19','Good','Returned on due date');
/*!40000 ALTER TABLE `book_returns` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_after_book_return` AFTER INSERT ON `book_returns` FOR EACH ROW BEGIN
    DECLARE v_book_id INT;
    DECLARE v_due_date DATE;
    DECLARE v_member_id INT;
    DECLARE v_late_days INT;

    SELECT book_id, due_date, member_id 
    INTO v_book_id, v_due_date, v_member_id
    FROM book_issues
    WHERE issue_id = NEW.issue_id;

    UPDATE book_issues
    SET status = 'Returned'
    WHERE issue_id = NEW.issue_id;

    UPDATE books
    SET available_copies = available_copies + 1
    WHERE book_id = v_book_id;

    SET v_late_days = DATEDIFF(NEW.return_date, v_due_date);
    IF v_late_days > 0 THEN
        INSERT INTO fines (issue_id, member_id, overdue_days, fine_amount, payment_status)
        VALUES (NEW.issue_id, v_member_id, v_late_days, v_late_days * 10.00, 'Pending')
        ON DUPLICATE KEY UPDATE 
            overdue_days = v_late_days,
            fine_amount = v_late_days * 10.00;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `isbn` varchar(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `category_id` int NOT NULL,
  `publisher_id` int NOT NULL,
  `publication_year` int NOT NULL,
  `total_copies` int NOT NULL DEFAULT '1',
  `available_copies` int NOT NULL DEFAULT '1',
  `shelf_location` varchar(30) NOT NULL,
  PRIMARY KEY (`book_id`),
  UNIQUE KEY `isbn` (`isbn`),
  KEY `fk_books_category` (`category_id`),
  KEY `fk_books_publisher` (`publisher_id`),
  KEY `idx_books_title` (`title`),
  CONSTRAINT `fk_books_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_books_publisher` FOREIGN KEY (`publisher_id`) REFERENCES `publishers` (`publisher_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `books_chk_1` CHECK (((`publication_year` >= 1800) and (`publication_year` <= 2026))),
  CONSTRAINT `books_chk_2` CHECK ((`total_copies` >= 1)),
  CONSTRAINT `books_chk_3` CHECK ((`available_copies` >= 0)),
  CONSTRAINT `chk_copies_valid` CHECK ((`available_copies` <= `total_copies`))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'978-1449373320','Designing Data-Intensive Applications',1,1,2017,5,4,'CS-A1'),(2,'978-0132350884','Clean Code: Agile Software Craftsmanship',1,2,2008,4,3,'CS-A2'),(3,'978-0262046305','Introduction to Algorithms (CLRS)',1,5,2022,6,5,'CS-B1'),(4,'978-0679462736','The God of Small Things',3,3,1997,3,2,'FIC-C1'),(5,'978-0857197689','The Psychology of Money',4,10,2020,5,4,'BUS-D1'),(6,'978-0735211292','Atomic Habits',5,3,2018,6,5,'SH-E1'),(7,'978-8173711466','Wings of Fire: An Autobiography',8,8,1999,4,4,'BIO-F1'),(8,'978-0062316097','Sapiens: A Brief History of Humankind',6,4,2014,4,3,'HIS-G1'),(9,'978-1491957660','Python for Data Analysis',2,1,2022,5,5,'DS-A3'),(10,'978-1593279288','Python Crash Course',1,6,2019,4,4,'CS-A4'),(11,'978-0060977580','A Suitable Boy',3,4,1993,2,2,'FIC-C2'),(12,'978-3030113513','Database System Concepts & Architecture',1,9,2021,3,3,'CS-B2');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT 'General library collection',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Computer Science','Programming, algorithms, databases, and software engineering'),(2,'Data Science & AI','Machine learning, analytics, statistics, and artificial intelligence'),(3,'Fiction','Classic and contemporary novels and short stories'),(4,'Business & Finance','Management, economics, entrepreneurship, and investing'),(5,'Self-Help','Personal development, productivity, and psychology'),(6,'History','World history, Indian history, and civilizations'),(7,'Science & Technology','Physics, space exploration, engineering, and innovations'),(8,'Biography','Memoirs and biographies of notable leaders and thinkers'),(9,'Mathematics','Linear algebra, calculus, discrete math, and probability'),(10,'Reference','Encyclopedias, dictionaries, and academic handbooks');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fines`
--

DROP TABLE IF EXISTS `fines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fines` (
  `fine_id` int NOT NULL AUTO_INCREMENT,
  `issue_id` int NOT NULL,
  `member_id` int NOT NULL,
  `overdue_days` int NOT NULL,
  `fine_amount` decimal(8,2) NOT NULL,
  `payment_status` enum('Pending','Paid','Waived') NOT NULL DEFAULT 'Pending',
  `paid_date` date DEFAULT NULL,
  PRIMARY KEY (`fine_id`),
  UNIQUE KEY `issue_id` (`issue_id`),
  KEY `fk_fine_member` (`member_id`),
  CONSTRAINT `fk_fine_issue` FOREIGN KEY (`issue_id`) REFERENCES `book_issues` (`issue_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_fine_member` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fines_chk_1` CHECK ((`overdue_days` > 0)),
  CONSTRAINT `fines_chk_2` CHECK ((`fine_amount` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fines`
--

LOCK TABLES `fines` WRITE;
/*!40000 ALTER TABLE `fines` DISABLE KEYS */;
INSERT INTO `fines` VALUES (1,2,2,4,40.00,'Paid','2026-08-21'),(2,5,5,5,50.00,'Paid','2026-09-22'),(3,7,7,8,80.00,'Paid','2026-11-21'),(4,9,9,3,30.00,'Waived',NULL),(5,11,2,18,180.00,'Pending',NULL),(6,12,7,16,160.00,'Pending',NULL),(7,13,3,13,130.00,'Pending',NULL);
/*!40000 ALTER TABLE `fines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `member_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(120) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `membership_type` enum('Student','Standard','Premium') NOT NULL DEFAULT 'Standard',
  `join_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `max_books_allowed` int NOT NULL DEFAULT '3',
  `status` enum('Active','Inactive','Suspended') NOT NULL DEFAULT 'Active',
  `referred_by` int DEFAULT NULL,
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `fk_member_referral` (`referred_by`),
  CONSTRAINT `fk_member_referral` FOREIGN KEY (`referred_by`) REFERENCES `members` (`member_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `chk_member_dates` CHECK ((`expiry_date` > `join_date`)),
  CONSTRAINT `members_chk_1` CHECK ((`max_books_allowed` between 1 and 10))
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (1,'Ananya Sharma','ananya.sharma@email.com','9000100001','Premium','2026-01-10','2027-01-10',6,'Active',NULL),(2,'Rohan Verma','rohan.verma@email.com','9000100002','Student','2026-01-15','2027-01-15',3,'Active',1),(3,'Karthik Reddy','karthik.reddy@email.com','9000100003','Standard','2026-02-01','2027-02-01',4,'Active',1),(4,'Sneha Nair','sneha.nair@email.com','9000100004','Premium','2026-02-12','2027-02-12',6,'Active',NULL),(5,'Vikramaditya Rao','vikram.rao@email.com','9000100005','Student','2026-03-05','2027-03-05',3,'Active',2),(6,'Priya Deshmukh','priya.deshmukh@email.com','9000100006','Standard','2026-03-18','2027-03-18',4,'Active',4),(7,'Arjun Mehta','arjun.mehta@email.com','9000100007','Student','2026-04-02','2027-04-02',3,'Suspended',3),(8,'Divya Krishnan','divya.krishnan@email.com','9000100008','Premium','2026-04-20','2027-04-20',6,'Active',NULL),(9,'Siddharth Joshi','siddharth.joshi@email.com','9000100009','Standard','2026-05-11','2027-05-11',4,'Active',4),(10,'Meera Iyer','meera.iyer@email.com','9000100010','Student','2026-06-01','2027-06-01',3,'Active',8),(11,'Nikhil Kulkarni','nikhil.kulkarni@email.com','9000100011','Standard','2026-06-15','2026-10-15',4,'Inactive',NULL),(12,'Pooja Hegde','pooja.hegde@email.com','9000100012','Premium','2026-07-01','2027-07-01',6,'Active',1);
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publishers`
--

DROP TABLE IF EXISTS `publishers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publishers` (
  `publisher_id` int NOT NULL AUTO_INCREMENT,
  `publisher_name` varchar(150) NOT NULL,
  `city` varchar(100) NOT NULL,
  `contact_email` varchar(150) NOT NULL,
  `phone` varchar(20) NOT NULL,
  PRIMARY KEY (`publisher_id`),
  UNIQUE KEY `publisher_name` (`publisher_name`),
  UNIQUE KEY `contact_email` (`contact_email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publishers`
--

LOCK TABLES `publishers` WRITE;
/*!40000 ALTER TABLE `publishers` DISABLE KEYS */;
INSERT INTO `publishers` VALUES (1,'O\'Reilly Media','Sebastopol','support@oreilly.com','9848011001'),(2,'Pearson Education','Chennai','india.support@pearson.com','9848011002'),(3,'Penguin Random House','New Delhi','info@penguinrandomhouse.in','9848011003'),(4,'HarperCollins India','Noida','contact@harpercollins.co.in','9848011004'),(5,'McGraw Hill Education','Hyderabad','orders@mheducation.com','9848011005'),(6,'Manning Publications','Shelter Island','support@manning.com','9848011006'),(7,'Packt Publishing','Mumbai','customercare@packt.com','9848011007'),(8,'Rupa Publications','New Delhi','sales@rupapublications.com','9848011008'),(9,'Springer Nature','Bengaluru','service@springernature.com','9848011009'),(10,'Jaico Publishing House','Mumbai','jaicopub@jaicobooks.com','9848011010');
/*!40000 ALTER TABLE `publishers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_library_catalog`
--

DROP TABLE IF EXISTS `vw_library_catalog`;
/*!50001 DROP VIEW IF EXISTS `vw_library_catalog`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_library_catalog` AS SELECT 
 1 AS `isbn`,
 1 AS `title`,
 1 AS `authors`,
 1 AS `category_name`,
 1 AS `publisher_name`,
 1 AS `publication_year`,
 1 AS `available_copies`,
 1 AS `shelf_location`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_pending_fines_summary`
--

DROP TABLE IF EXISTS `vw_pending_fines_summary`;
/*!50001 DROP VIEW IF EXISTS `vw_pending_fines_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_pending_fines_summary` AS SELECT 
 1 AS `member_id`,
 1 AS `full_name`,
 1 AS `email`,
 1 AS `phone`,
 1 AS `book_title`,
 1 AS `overdue_days`,
 1 AS `fine_amount`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'library_management_db'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_issue_book` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_issue_book`(
    IN p_book_id INT,
    IN p_member_id INT,
    IN p_loan_days INT
)
BEGIN
    DECLARE v_available INT DEFAULT 0;
    DECLARE v_member_status VARCHAR(20);

    SELECT available_copies INTO v_available FROM books WHERE book_id = p_book_id;
    SELECT status INTO v_member_status FROM members WHERE member_id = p_member_id;

    IF v_member_status <> 'Active' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot issue book: Member account is not Active.';
    ELSEIF v_available <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot issue book: No copies currently available.';
    ELSE
        INSERT INTO book_issues (book_id, member_id, issue_date, due_date, status)
        VALUES (p_book_id, p_member_id, CURDATE(), DATE_ADD(CURDATE(), INTERVAL p_loan_days DAY), 'Issued');

        UPDATE books
        SET available_copies = available_copies - 1
        WHERE book_id = p_book_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_pay_fine` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pay_fine`(IN p_fine_id INT)
BEGIN
    UPDATE fines
    SET payment_status = 'Paid',
        paid_date = CURDATE()
    WHERE fine_id = p_fine_id
      AND payment_status = 'Pending';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_library_catalog`
--

/*!50001 DROP VIEW IF EXISTS `vw_library_catalog`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_library_catalog` AS select `b`.`isbn` AS `isbn`,`b`.`title` AS `title`,group_concat(concat(`a`.`first_name`,' ',`a`.`last_name`) separator ', ') AS `authors`,`c`.`category_name` AS `category_name`,`p`.`publisher_name` AS `publisher_name`,`b`.`publication_year` AS `publication_year`,`b`.`available_copies` AS `available_copies`,`b`.`shelf_location` AS `shelf_location` from ((((`books` `b` join `categories` `c` on((`b`.`category_id` = `c`.`category_id`))) join `publishers` `p` on((`b`.`publisher_id` = `p`.`publisher_id`))) join `book_authors` `ba` on((`b`.`book_id` = `ba`.`book_id`))) join `authors` `a` on((`ba`.`author_id` = `a`.`author_id`))) group by `b`.`book_id`,`b`.`isbn`,`b`.`title`,`c`.`category_name`,`p`.`publisher_name`,`b`.`publication_year`,`b`.`available_copies`,`b`.`shelf_location` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_pending_fines_summary`
--

/*!50001 DROP VIEW IF EXISTS `vw_pending_fines_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_pending_fines_summary` AS select `m`.`member_id` AS `member_id`,`m`.`full_name` AS `full_name`,`m`.`email` AS `email`,`m`.`phone` AS `phone`,`b`.`title` AS `book_title`,`f`.`overdue_days` AS `overdue_days`,`f`.`fine_amount` AS `fine_amount` from (((`fines` `f` join `members` `m` on((`f`.`member_id` = `m`.`member_id`))) join `book_issues` `bi` on((`f`.`issue_id` = `bi`.`issue_id`))) join `books` `b` on((`bi`.`book_id` = `b`.`book_id`))) where (`f`.`payment_status` = 'Pending') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-26 14:44:04

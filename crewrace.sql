-- MySQL dump 10.13  Distrib 5.1.49, for debian-linux-gnu (i486)
--
-- Host: localhost    Database: 
-- ------------------------------------------------------
-- Server version	5.1.49-3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `crewrace`
--

CREATE DATABASE IF NOT EXISTS `crewrace` DEFAULT CHARACTER SET latin1;

USE `crewrace`;

--
-- Table structure for table `race`
--

DROP TABLE IF EXISTS `race`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `race` (
  `rank` int(11) NOT NULL COMMENT 'Rank stored is last weeks rank',
  `crew_name` char(12) NOT NULL,
  `player_name` char(12) NOT NULL,
  `player_icon` char(12) NOT NULL,
  `emblem_bg` char(10) NOT NULL,
  `emblem_fg` char(10) NOT NULL,
  `song_1` char(16) NOT NULL,
  `song_1_difficulty` enum('0','1','2','3','4') NOT NULL,
  `song_1_mod_1` enum('FI','FI2','FO','FO2','-') NOT NULL,
  `song_1_mod_2` enum('BK','BK2','BL','-') NOT NULL,
  `song_1_mod_3` enum('RR','LL','ACW','-') NOT NULL,
  `song_2` char(16) NOT NULL,
  `song_2_difficulty` enum('0','1','2','3','4') NOT NULL,
  `song_2_mod_1` enum('-','FI','FI2','FO','FO2') NOT NULL,
  `song_2_mod_2` enum('-','BK','BK2','BL') NOT NULL,
  `song_2_mod_3` enum('-','RR','LL','ACW') NOT NULL,
  `song_3` char(16) NOT NULL,
  `song_3_difficulty` enum('0','1','2','3','4') NOT NULL,
  `song_3_mod_1` enum('-','FI','FI2','FO','FO2') NOT NULL,
  `song_3_mod_2` enum('-','BK','BK2','BL') NOT NULL,
  `song_3_mod_3` enum('-','RR','LL','ACW') NOT NULL,
  `play` int(11) unsigned NOT NULL,
  `win` int(11) unsigned NOT NULL,
  KEY `rank` (`rank`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `songs`
--

DROP TABLE IF EXISTS `songs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `songs` (
  `filename` char(16) NOT NULL,
  `title` char(36) NOT NULL,
  `nm` enum('?','1','2','3','4','5','6','7','8','9','10') NOT NULL,
  `hd` enum('?','1','2','3','4','5','6','7','8','9','10') NOT NULL,
  `mx` enum('?','1','2','3','4','5','6','7','8','9','10') NOT NULL,
  `ex` enum('?','1','2','3','4','5','6','7','8','9','10') NOT NULL,
  KEY `filename` (`filename`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `songs`
--

LOCK TABLES `songs` WRITE;
/*!40000 ALTER TABLE `songs` DISABLE KEYS */;
INSERT INTO `songs` VALUES 
	('access','Access','5','7','8','?'),
	('ai','A.I','5','7','8','?'),
	('airwave','Airwave','5','9','?','?'),
	('@baramege','Ask to Wind','1','5','?','?'),
	('@baramegelive','Ask to Wind (Live Mix)','6','8','?','?'),
	('beatudown','Beat U Down','6','7','?','?'),
	('beeutiful','BEE-U-TIFUL','7','9','?','?'),
	('beyondthe','Beyond the Future','6','7','8','?'),
	('blythe','BlythE','6','9','?','?'),
	('brandnewdays','Brand NEW Days','2','6','?','?'),
	('burnitdown','Burn It Down','5','6','?','?'),
	('closer','Closer','3','5','?','?'),
	('coastaltempo','Coastal Tempo','5','6','7','?'),
	('color','Color','5','6','7','?'),
	('cosmicfantastic','Cosmic Fantastic Lovesong','3','5','6','?'),
	('cozyquilt','Cozy Quilt','5','8','?','?'),
	('creator','Creator','6','7','?','?'),
	('cypher','Cypher Gate','6','9','10','?'),
	('d2','D2','8','9','10','?'),
	('darkenvy','Dark Envy','6','7','?','?'),
	('desperado','Desperado','5','?','?','?'),
	('desperadormx1','Desperado (Nu skool Mix)','5','6','?','?'),
	('divineservice','Divine Service','4','5','6','?'),
	('djmax','DJMAX','3','4','?','?'),
	('dreamofwinds','Dream of Winds','6','8','9','?'),
	('dualstrikers','Dual Strikers','6','8','?','?'),
	('electronics','Electronics','6','8','?','?'),
	('endofthemoon','End of the Moonlihgt','4','7','8','?'),
	('enemystorm','Enemy Storm','3','6','9','?'),
	('enemyrmx1','Enemy Storm (Dark Jungle Mix)','6','8','9','?'),
	('eternalfantasy','Eternal Fantasy','4','5','6','?'),
	('eternalmemory','Eternal Memory','3','5','?','?'),
	('fate','Fate','4','5','6','?'),
	('fermion','Fermion','8','10','?','?'),
	('firstkiss','First Kiss','2','4','5','?'),
	('flea','Flea','5','6','7','?'),
	('@youngwon','Forever','4','6','?','?'),
	('freedom','Freedom','4','5','6','?'),
	('fury','Fury','6','7','8','?'),
	('getdown','Get Down','4','?','?','?'),
	('grave','Grave Consequence','7','8','?','?'),
	('heartofwitch','Heart of Witch','5','7','?','?'),
	('hereinthe','Here in the Moment','5','6','7','?'),
	('hexad','HEXAD','5','6','7','?'),
	('honeymoon','Honeymoon','3','4','8','?'),
	('iwantyou','I Want You','4','6','7','?'),
	('inmydream','In My Dream','5','?','?','?'),
	('inmyheart','In My Heart','3','4','5','?'),
	('jealousy','Jealousy','5','6','?','?'),
	('jupiter','Jupiter Driving','5','6','7','?'),
	('keystothe','Keys to the World','6','7','8','?'),
	('lacamp','La Campanella : Nu Rave','6','7','?','?'),
	('ladymade','Ladymade Star','4','5','6','?'),
	('landscape','Landscape','5','6','9','?'),
	('loveis','Love is Beautiful','4','5','6','?'),
	('lovemode','Love Mode','3','6','7','?'),
	('lovely','Lovely Hands','5','6','?','?'),
	('lover','Lover','5','6','7','?'),
	('luvflowrmx1','Luv Flow (Funky House Mix)','5','6','?','?'),
	('masairmx1','MASAI (Electro House Mix)','5','6','?','?'),
	('melody','Melody','5','6','8','?'),('miles','Miles','5','6','7','?'),
	('monoxide','Monoxide','6','7','?','?'),
	('novarmx','Nova (Fr. Funky Remix)','4','6','?','?'),
	('oblivion','Oblivion','3','6','8','?'),
	('outlawreborn','Out Law - Reborn','5','7','8','?'),
	('pdm','PDM','5','6','8','?'),
	('@piano','Piano Concerto No.1','6','8','9','?'),
	('playthefuture','Play the Future','4','5','7','?'),
	('@gobaek1','Proposed, Flower, Wolf part 1','3','4','?','?'),
	('@gobaek2','Proposed, Flower, Wolf part 2','5','7','8','?'),
	('putemup','Put Em Up','4','5','?','?'),
	('puzzler','Puzzler','4','7','?','?'),
	('rage','Rage of Demon','6','9','10','?'),
	('rayof','Ray of Illuminati','5','7','8','?'),
	('readynow','Ready Now','5','6','8','?'),
	('remember','Remember','5','6','7','?'),
	('rutin','Ruti\'n','5','6','?','?'),
	('secretworld','Secret World','5','6','?','?'),
	('shoreline','Shoreline','6','7','8','?'),
	('sin','SIN','6','8','9','?'),
	('sonof','Son of Sun','6','8','10','?'),
	('someday','Someday','3','5','?','?'),
	('spaceofsoul','Space of Soul','8','9','?','?'),
	('stop','STOP','5','6','7','?'),
	('supersonic','Supersonic','4','5','7','?'),
	('supersonicrmx','SuperSonic (Mr.Funky Dirty Remix)','6','7','9','?'),
	('sweetdream','Sweet Dream','4','6','?','?'),
	('sweetshining','Sweet Shining Shooting Star','5','7','8','?'),
	('theclear','The Clear Blue Sky','4','7','8','?'),
	('thelastdance','The Last Dance','4','5','7','?'),
	('thenightstage','The Night Stage','4','6','?','?'),
	('theguilty','The Guilty','5','6','?','?'),
	('thor','Thor','6','10','?','?'),
	('@ner','To You','4','5','7','?'),
	('trip','Trip','4','6','?','?'),
	('voyage','Voyage','5','6','?','?'),
	('whiteblue','WhiteBlue','6','7','8','?'),
	('xlasher','XLASHER','6','7','?','?'),
	('y','Y','5','6','7','?'),
	('yourown','Your Own Miracle','4','6','8','?'),(
	'zetrmx1','Zet (Mr. Funky Remix)','5','6','?','?'),
	('area7','Area 7','3','7','8','?'),
	('cherokee','Cherokee','5','6','7','?'),
	('coloursof','Colours of Sorrow','6','7','8','?'),
	('sayitfrom','Say It From Your Heart','4','6','?','?'),
	('@naege','Come to Me','4','6','8','?'),
	('dearmylady','Dear My Lady','4','6','7','?');
/*!40000 ALTER TABLE `songs` ENABLE KEYS */;
UNLOCK TABLES;
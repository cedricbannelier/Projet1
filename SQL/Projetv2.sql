USE [master]
GO
/****** Object:  Database [projet]    Script Date: 25/01/2018 16:46:42 ******/
CREATE DATABASE [projet]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'sondage', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\sondage.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'sondage_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\sondage_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [projet] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [projet].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [projet] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [projet] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [projet] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [projet] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [projet] SET ARITHABORT OFF 
GO
ALTER DATABASE [projet] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [projet] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [projet] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [projet] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [projet] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [projet] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [projet] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [projet] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [projet] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [projet] SET  DISABLE_BROKER 
GO
ALTER DATABASE [projet] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [projet] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [projet] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [projet] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [projet] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [projet] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [projet] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [projet] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [projet] SET  MULTI_USER 
GO
ALTER DATABASE [projet] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [projet] SET DB_CHAINING OFF 
GO
ALTER DATABASE [projet] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [projet] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [projet] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [projet] SET QUERY_STORE = OFF
GO
USE [projet]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [projet]
GO
/****** Object:  Table [dbo].[choix]    Script Date: 25/01/2018 16:46:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[choix](
	[numChoix] [int] IDENTITY(1,1) NOT NULL,
	[nomChoix] [nvarchar](max) NOT NULL,
	[numSondage] [int] NOT NULL,
 CONSTRAINT [PK_choix] PRIMARY KEY CLUSTERED 
(
	[numChoix] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lien]    Script Date: 25/01/2018 16:46:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lien](
	[numLien] [int] IDENTITY(1,1) NOT NULL,
	[adresseLien] [varchar](max) NOT NULL,
	[numSondage] [int] NOT NULL,
 CONSTRAINT [PK_lien] PRIMARY KEY CLUSTERED 
(
	[numLien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sondage]    Script Date: 25/01/2018 16:46:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sondage](
	[numSondage] [int] IDENTITY(1,1) NOT NULL,
	[questionSondage] [text] NOT NULL,
	[typeSondage] [int] NOT NULL,
 CONSTRAINT [PK_sondage] PRIMARY KEY CLUSTERED 
(
	[numSondage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[votant]    Script Date: 25/01/2018 16:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[votant](
	[numVotant] [int] IDENTITY(1,1) NOT NULL,
	[adresseIp] [varchar](50) NULL,
 CONSTRAINT [PK_votant] PRIMARY KEY CLUSTERED 
(
	[numVotant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vote]    Script Date: 25/01/2018 16:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vote](
	[numVote] [int] IDENTITY(1,1) NOT NULL,
	[nbVote] [int] NOT NULL,
	[nbVotant] [int] NULL,
	[numChoix] [int] NOT NULL,
	[numVotant] [int] NOT NULL,
 CONSTRAINT [PK_vote] PRIMARY KEY CLUSTERED 
(
	[numVote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[choix] ON 

INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (1, N'1 en 1', 24)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (2, N'2 en 3', 24)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (3, N'3 en 4', 24)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (4, N'a', 25)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (5, N'b', 25)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (6, N'c', 25)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (7, N'd', 25)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (8, N'splif', 26)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (9, N'surtoutpas plouf', 26)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (10, N'non azertyuiop', 27)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (11, N'qsdfg', 27)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (12, N'1', 28)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (13, N'2', 28)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (14, N'3', 28)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (15, N'er', 29)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (16, N'ty', 29)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (17, N'ui', 29)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (18, N'op', 29)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (19, N'1982', 30)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (20, N'1955', 30)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (21, N'02', 30)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (22, N'2001', 30)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (23, N'asus', 31)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (24, N'acer', 31)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (25, N'hanns.G', 31)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (26, N'rzerzertze', 32)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (27, N'rzerze', 32)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (28, N'rzerze', 32)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (29, N'aze', 33)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (30, N'zae', 33)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (31, N'zae', 33)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (32, N'aze', 33)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (33, N'aze', 33)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (34, N'j''y crois', 34)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (35, N'moyen', 34)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (36, N'pas trop', 34)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (37, N'rep 1', 35)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (38, N'rep 2', 35)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (39, N'rep 3', 35)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (40, N'rep 4', 35)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (41, N'az', 36)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (42, N'qs', 36)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (43, N'qsf', 36)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (44, N'rzear', 37)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (45, N'eaze', 37)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (46, N'zzzzz', 37)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (47, N't''es un pro', 38)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (48, N'p-e', 38)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (49, N't''es nul mec', 38)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (50, N'vive linux', 38)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (51, N'choix1', 39)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (52, N'choix2', 39)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (53, N'ca marchera ', 40)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (54, N'ca va marcher', 40)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (55, N'ou pas', 40)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (56, N'erterter', 41)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (57, N'terterter', 41)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (58, N'trete', 41)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (59, N'&', 42)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (60, N'a', 42)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (61, N'e', 42)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (62, N'r', 42)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (63, N'aaaa', 43)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (64, N'aa', 43)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (65, N'a', 43)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (66, N'a', 44)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (67, N'&', 44)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (68, N'é"', 44)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (69, N'""', 44)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (70, N'aaaa', 45)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (71, N'aa', 45)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (72, N'a', 45)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (73, N'nn', 46)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (74, N'bb', 46)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (75, N'vv', 46)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (76, N'a1', 47)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (77, N'z', 47)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (78, N'eaze', 47)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (79, N'retyre', 48)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (80, N'ryerye', 48)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (81, N'eazeazeae', 50)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (82, N'eaeaeaea', 50)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (83, N'eazeaeaea', 50)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (84, N'eazeaeaeza', 50)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (85, N'ééé', 51)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (86, N'""', 51)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (87, N'eee', 52)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (88, N'rrr', 52)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (89, N'treter', 53)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (90, N'tert', 53)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (91, N'0', 54)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (92, N'1', 54)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (93, N'aaaz', 55)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (94, N'zzzzz', 55)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (95, N'ez', 56)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (96, N'zz', 56)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (97, N'a', 57)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (98, N'zae', 57)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (99, N'eee', 57)
GO
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (100, N'aaa', 58)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (101, N'aa', 58)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (102, N'a', 58)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (103, N'aaa', 59)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (104, N'aa', 59)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (105, N'a', 59)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (106, N'q', 60)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (107, N'surtoutpas plouf', 60)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (108, N'd', 60)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (109, N'q', 61)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (110, N'surtoutpas plouf', 61)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (111, N'd', 61)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (112, N'q', 62)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (113, N'surtoutpas plouf', 62)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (114, N'd', 62)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (115, N'qezrtzet', 63)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (116, N'surtoutpas plouf', 63)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (117, N'd', 63)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (118, N'qezrtzet', 64)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (119, N'surtoutpas plouf', 64)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (120, N'd', 64)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (121, N'2', 65)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (122, N'3', 65)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (123, N'22', 65)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (124, N'11111', 66)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (125, N'111', 66)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (126, N'ddddddddddddddddd', 67)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (127, N'drrrrrrrrrrrrrrrrrrrrrrrr', 67)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (128, N'de la merde', 68)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (129, N'de la bouze fermenté', 68)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (130, N'bien pour le creonage', 68)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (131, N'oui', 69)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (132, N'non', 69)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (133, N'seulement sur le ventre d''une pute thai', 69)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (134, N'oui', 70)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (135, N'non', 70)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (136, N'seulement sur le ventre d''une pute thai', 70)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (137, N'a1', 71)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (138, N'aa', 71)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (139, N'a2 en 3', 71)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (140, N'ca pue', 72)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (141, N'bcp', 72)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (142, N'mais', 72)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (143, N'espoir', 72)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (144, N'zaraezrza', 73)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (145, N'rza razr azraz', 73)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (146, N'razrazr az', 73)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (147, N'oui', 74)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (148, N'non ', 74)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (149, N'100', 74)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (150, N'CroqVite', 76)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (151, N'kebab', 76)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (152, N'bagel', 76)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (153, N'hello', 76)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (154, N'CroqVite', 77)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (155, N'kebab', 77)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (156, N'bagel', 77)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (157, N'hello', 77)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (158, N'qsfqs', 78)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (159, N'fqsfqsqf', 78)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (160, N'croq vite ', 79)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (161, N'ungut', 79)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (162, N'ru', 79)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (163, N'tacos', 79)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (164, N'eaz', 80)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (165, N'eaz', 80)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (166, N'zz', 80)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (167, N'rzerze', 81)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (168, N'rzerze', 81)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (169, N'oui', 82)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (170, N'non', 82)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (171, N'je parie pas j''ai deja pedu une main', 82)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (172, N'aaa', 83)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (173, N'zea', 83)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (174, N'tert', 84)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (175, N'terter', 84)
SET IDENTITY_INSERT [dbo].[choix] OFF
SET IDENTITY_INSERT [dbo].[lien] ON 

INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (3, N'2608B536-5FA4-4FEC-B5A3-7269A6DACBDA', 27)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (4, N'9D56F64D-2DF6-46F8-A75C-2503E7BBEF93', 28)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (5, N'3353C077-2FC1-4F84-BE5F-05F6C6598A8D', 29)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (6, N'F995B3FB-95EE-4955-B139-31E81633FCA8', 30)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (7, N'A6DE29D9-0AA8-4CE6-97F3-CF46794EB7FC', 31)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (8, N'FA4BAD0C-D321-410D-B370-6E64ECBAB332', 32)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (9, N'EA9F74B6-C45F-4BDC-942A-5A0849FDF2FB', 33)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (10, N'5D9A2CD3-EBE9-4878-888B-1C997464D716', 34)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (11, N'A748AB58-3622-477D-9A6B-A669F9735833', 35)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (12, N'B42EB443-FC58-4EAF-B0C7-61A3BDABC50D', 36)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (13, N'4162C9BF-26D5-4135-B7FA-C389F391AA8E', 37)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (14, N'3BB8DBA2-1262-4E82-868D-DB4FB0C0F3EF', 38)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (15, N'02B43277-A526-4950-8151-A00F51130333', 39)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (16, N'9F2D0716-CC37-4942-AA2A-99A1D50FB251', 40)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (17, N'CC116244-2ADB-428B-9D48-3EB2F96276D0', 41)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (18, N'1639B229-3677-492F-9F39-F0CA29D471B0', 42)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (19, N'CF444318-EE7E-45F8-950C-E5FBC2E9A2E0', 43)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (20, N'D4018403-13A0-4D38-BBE3-80ADC516F4BF', 44)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (21, N'B763B372-FBBD-4EDB-8998-30B8D32B29DF', 45)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (22, N'E2D54F3B-00F2-46BC-BCA0-64B65CA09ACC', 46)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (23, N'E57AB4DE-168E-4261-8768-66A60E6CF8FB', 47)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (24, N'86FAB0D0-A209-4D2F-938A-7F4108A3F37C', 48)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (25, N'39F1695B-C469-459E-A028-4F33DC42F287', 49)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (26, N'8AF9B8E6-EB47-4ED9-AC5A-067428AEF6A6', 50)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (27, N'A9E181E0-0DFE-44C0-BCE3-C111D9B4D720', 51)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (28, N'9FC6C308-0A15-449D-80F5-B021CFDA593B', 52)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (29, N'D137D583-E88E-4CF9-BEE7-7E52E52418DC', 53)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (30, N'F2BC6FF5-C05B-40D2-97CF-DB1AC5F6E754', 54)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (31, N'5B5C1F42-CCB9-4EE7-8C06-1E332B4D3B23', 55)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (32, N'8FFFB3A6-DCAC-40FA-8A43-75A4A83E5DBD', 56)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (33, N'A01896A9-FD8A-46A7-826E-D9E130A9E6A0', 57)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (34, N'1BACAF4F-F229-40CD-A4D7-9349944B3DBD', 58)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (35, N'7F1B5288-6417-4725-A621-61860E56B74A', 59)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (36, N'9B9B3958-164D-415D-913F-F6BEEBB0827E', 60)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (37, N'29BB7AAF-E1F2-4614-9A3A-69AF30D93703', 61)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (38, N'499DEBA6-5D40-4D78-9B43-65DBD5023AC7', 62)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (39, N'3A3675F0-3624-475F-8CE3-87619A91C509', 63)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (40, N'54B67EC3-8993-4BE2-9C97-E4D7DCB450CC', 64)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (41, N'9C34D3FE-C246-494A-A975-229387A73003', 65)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (42, N'D4D849B0-5ACC-452A-8535-EF264A6A5F32', 66)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (43, N'FDF72600-131A-43FB-90E0-208569580538', 67)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (44, N'9BA91B07-5885-4C7B-9BF2-5C0C00747815', 68)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (45, N'0759BA5E-1457-4FBF-A904-E274B6C1D7A7', 69)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (46, N'E3893642-552F-4079-9651-B553FDF5BEEA', 70)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (47, N'200C08DE-6168-425F-859F-0FE9073BA160', 71)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (48, N'176C7D86-8249-406F-8A11-8E822271A84B', 72)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (49, N'1E7CFF16-9930-47B2-8E18-EA523A6D156C', 73)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (50, N'7509DAE5-BAAC-4F5E-AA3A-44BD38F88003', 74)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (51, N'12A06A27-3DC4-44B9-A1D2-6B6B43FDAA2C', 75)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (52, N'379D0CFB-BED7-43FF-8FBD-82CA245F2B3F', 76)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (53, N'8A9C6C1D-7B47-49BA-BD25-D4CB1DD4B156', 77)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (54, N'BD9A49DC-4A3A-45A4-BF7B-FD27075304EC', 78)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (55, N'367557E2-66C9-427B-A7B1-822A550061EC', 79)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (56, N'7F4135C7-4E2C-4E3F-960C-1612BE85A333', 80)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (57, N'94AC7B23-7658-454F-A6EA-6DDE479BD114', 81)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (58, N'B2AA4589-6BFB-4B34-8EDD-7A8282D504C4', 82)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (59, N'64677412-C5B9-4357-B9E0-1911C3F394A7', 83)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (60, N'5750154E-00B9-432C-9E7C-E1DDB8EFF798', 84)
SET IDENTITY_INSERT [dbo].[lien] OFF
SET IDENTITY_INSERT [dbo].[sondage] ON 

INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (13, N'nous aimons les soucisses', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (14, N'magicarpe', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (15, N'Titre de votre sondage', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (16, N'pokepoke', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (17, N'', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (18, N'tretrtrt', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (19, N'multi test', 0)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (20, N'Linux mec', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (21, N'toto', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (22, N'first test', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (23, N'test 145', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (24, N'test dc on y croit', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (25, N'test liens', 103)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (26, N'plouf ou plif', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (27, N'azerty', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (28, N'titi titi titi', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (29, N'az', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (30, N'année', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (31, N'ecran', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (32, N'rzeretz', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (33, N'aze', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (34, N'1er test veridique', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (35, N'J''aime ', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (36, N'tretertre', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (37, N'eztertze', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (38, N'ca marche', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (39, N'test cedric', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (40, N'test resultat', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (41, N'tertrte', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (42, N'testtttttteuysk rgke', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (43, N'test cedric 2', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (44, N'test resultat sans vote', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (45, N'test cedric 2', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (46, N'Test Ced', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (47, N'aze', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (48, N'rarazr ', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (49, N'', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (50, N'eazeaze aaaaaaaaaaaaaaaaaaaa', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (51, N'&&&&', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (52, N'zzz', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (53, N'treteryreter', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (54, N'rezrz', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (55, N'rezrz', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (56, N'eaze', 0)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (57, N'&é"', 0)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (58, N'aaaaa', 0)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (59, N'aaaaa', 0)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (60, N'testaa', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (61, N'testaa', 0)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (62, N'testaa', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (63, N'testaarzerzer', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (64, N'testaarzerzer', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (65, N'1', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (66, N'1111', 0)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (67, N'aaaaaaaaaaaaaaaaaaa', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (68, N'Html c''est comment', 0)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (69, N'j''aime la coke', 0)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (70, N'coke', 0)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (71, N'michelle', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (72, N'Guid', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (73, N'aaaaaaaaaaaaaaaa', 103)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (74, N'patatte', 103)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (75, N'', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (76, N'Quel Resto', 103)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (77, N'Quel Resto', 0)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (78, N'qfqfqs', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (79, N'quel resto', 0)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (80, N'zaeza', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (81, N'erzre', 0)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (82, N'bug', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (83, N'zae', 1)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (84, N'rteter', 1)
SET IDENTITY_INSERT [dbo].[sondage] OFF
SET IDENTITY_INSERT [dbo].[votant] ON 

INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (2, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (3, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (4, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (5, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (6, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (7, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (8, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (9, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (10, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (11, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (12, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (13, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (14, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (15, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (16, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (17, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (18, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (19, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (20, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (21, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (22, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (23, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (24, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (25, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (26, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (27, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (28, N'172.19.240.10')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (29, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (30, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (31, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (32, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (33, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (34, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (35, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (36, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (37, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (38, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (39, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (40, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (41, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (42, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (43, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (44, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (45, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (46, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (47, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (48, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (49, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (50, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (51, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (52, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (53, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (54, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (55, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (56, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (57, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (58, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (59, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (60, N'172.19.250.55')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (61, N'172.19.250.55')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (62, N'172.19.240.6')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (63, N'172.19.250.55')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (64, N'172.19.240.1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (65, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (66, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (67, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (68, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (69, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (70, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (71, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (72, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (73, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (74, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (75, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (76, N'::1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (77, N'::1')
SET IDENTITY_INSERT [dbo].[votant] OFF
SET IDENTITY_INSERT [dbo].[vote] ON 

INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (3, 1, 0, 23, 15)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (4, 1, 0, 47, 16)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (5, 1, 0, 47, 17)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (6, 1, 0, 47, 18)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (7, 1, 0, 50, 19)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (8, 1, 0, 50, 20)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (9, 1, 0, 54, 21)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (10, 1, 0, 54, 22)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (11, 1, 0, 57, 23)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (12, 1, 0, 60, 24)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (13, 1, 0, 60, 25)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (14, 1, 0, 60, 26)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (15, 1, 0, 61, 27)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (16, 1, 0, 73, 28)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (17, 1, 0, 77, 29)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (18, 1, 0, 78, 30)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (19, 1, 0, 77, 31)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (20, 1, 0, 77, 32)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (21, 1, 0, 80, 33)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (22, 1, 0, 80, 34)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (23, 1, 0, 89, 35)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (24, 1, 0, 92, 36)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (25, 1, 0, 93, 37)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (26, 1, 0, 126, 38)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (27, 1, 0, 127, 39)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (28, 1, 0, 127, 40)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (29, 1, 0, 127, 41)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (30, 1, 0, 127, 42)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (31, 1, 0, 126, 43)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (32, 1, 0, 126, 44)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (33, 1, 0, 126, 45)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (34, 1, 0, 126, 46)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (35, 1, 0, 128, 47)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (36, 1, 0, 129, 47)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (37, 1, NULL, 129, 48)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (38, 1, NULL, 130, 48)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (39, 1, NULL, 128, 49)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (40, 1, NULL, 129, 49)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (41, 1, NULL, 130, 49)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (42, 1, NULL, 136, 50)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (43, 1, NULL, 134, 51)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (44, 1, NULL, 135, 51)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (45, 1, NULL, 136, 51)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (46, 1, NULL, 143, 52)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (47, 1, NULL, 143, 53)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (48, 1, NULL, 141, 54)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (49, 1, NULL, 142, 54)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (50, 1, NULL, 145, 55)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (51, 1, NULL, 145, 56)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (52, 1, NULL, 147, 57)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (53, 1, NULL, 149, 57)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (54, 1, NULL, 147, 58)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (55, 1, NULL, 148, 58)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (56, 1, NULL, 149, 58)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (57, 1, NULL, 147, 59)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (58, 1, NULL, 155, 60)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (59, 1, NULL, 156, 60)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (60, 1, NULL, 155, 61)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (61, 1, NULL, 156, 61)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (62, 1, NULL, 159, 62)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (63, 1, NULL, 154, 63)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (64, 1, NULL, 156, 63)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (65, 1, NULL, 157, 63)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (66, 1, NULL, 160, 64)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (67, 1, NULL, 161, 64)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (68, 1, NULL, 163, 64)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (69, 1, NULL, 165, 65)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (70, 1, NULL, 167, 66)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (71, 1, NULL, 87, 67)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (72, 1, NULL, 88, 68)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (73, 1, NULL, 87, 69)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (74, 1, NULL, 87, 70)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (75, 1, NULL, 87, 71)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (76, 1, NULL, 171, 72)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (77, 1, NULL, 171, 73)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (78, 1, NULL, 172, 74)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (79, 1, NULL, 173, 75)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (80, 1, NULL, 172, 76)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (81, 1, NULL, 174, 77)
SET IDENTITY_INSERT [dbo].[vote] OFF
ALTER TABLE [dbo].[choix]  WITH CHECK ADD  CONSTRAINT [FK_choix_sondage1] FOREIGN KEY([numSondage])
REFERENCES [dbo].[sondage] ([numSondage])
GO
ALTER TABLE [dbo].[choix] CHECK CONSTRAINT [FK_choix_sondage1]
GO
ALTER TABLE [dbo].[lien]  WITH CHECK ADD  CONSTRAINT [FK_lien_sondage1] FOREIGN KEY([numSondage])
REFERENCES [dbo].[sondage] ([numSondage])
GO
ALTER TABLE [dbo].[lien] CHECK CONSTRAINT [FK_lien_sondage1]
GO
ALTER TABLE [dbo].[vote]  WITH CHECK ADD  CONSTRAINT [FK_vote_choix] FOREIGN KEY([numChoix])
REFERENCES [dbo].[choix] ([numChoix])
GO
ALTER TABLE [dbo].[vote] CHECK CONSTRAINT [FK_vote_choix]
GO
ALTER TABLE [dbo].[vote]  WITH CHECK ADD  CONSTRAINT [FK_vote_votant] FOREIGN KEY([numVotant])
REFERENCES [dbo].[votant] ([numVotant])
GO
ALTER TABLE [dbo].[vote] CHECK CONSTRAINT [FK_vote_votant]
GO
USE [master]
GO
ALTER DATABASE [projet] SET  READ_WRITE 
GO

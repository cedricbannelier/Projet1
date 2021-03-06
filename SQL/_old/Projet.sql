USE [master]
GO
/****** Object:  Database [projet]    Script Date: 22/01/2018 08:59:50 ******/
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
/****** Object:  Table [dbo].[choix]    Script Date: 22/01/2018 08:59:50 ******/
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
/****** Object:  Table [dbo].[lien]    Script Date: 22/01/2018 08:59:51 ******/
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
/****** Object:  Table [dbo].[sondage]    Script Date: 22/01/2018 08:59:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sondage](
	[numSondage] [int] IDENTITY(1,1) NOT NULL,
	[questionSondage] [text] NOT NULL,
	[typeSondage] [bit] NOT NULL,
 CONSTRAINT [PK_sondage] PRIMARY KEY CLUSTERED 
(
	[numSondage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[votant]    Script Date: 22/01/2018 08:59:51 ******/
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
/****** Object:  Table [dbo].[vote]    Script Date: 22/01/2018 08:59:51 ******/
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
SET IDENTITY_INSERT [dbo].[choix] OFF
SET IDENTITY_INSERT [dbo].[lien] ON 

INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (1, N'00000000-0000-0000-0000-000000000000', 25)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (2, N'00000000-0000-0000-0000-000000000000', 26)
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
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (25, N'test liens', 1)
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
SET IDENTITY_INSERT [dbo].[votant] OFF
SET IDENTITY_INSERT [dbo].[vote] ON 

INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (3, 1, NULL, 23, 15)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (4, 1, NULL, 47, 16)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (5, 1, NULL, 47, 17)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (6, 1, NULL, 47, 18)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (7, 1, NULL, 50, 19)
INSERT [dbo].[vote] ([numVote], [nbVote], [nbVotant], [numChoix], [numVotant]) VALUES (8, 1, NULL, 50, 20)
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

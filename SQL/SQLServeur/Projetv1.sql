USE [master]
GO
/****** Object:  Database [projet]    Script Date: 04/01/2018 16:56:58 ******/
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
/****** Object:  Table [dbo].[choix]    Script Date: 04/01/2018 16:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[choix](
	[numChoix] [int] IDENTITY(1,1) NOT NULL,
	[nomChoix] [nvarchar](255) NOT NULL,
	[numSondage] [int] NOT NULL,
 CONSTRAINT [PK_choix] PRIMARY KEY CLUSTERED 
(
	[numChoix] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lien]    Script Date: 04/01/2018 16:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lien](
	[numLien] [int] IDENTITY(1,1) NOT NULL,
	[adresseLien] [text] NOT NULL,
	[numSondage] [int] NOT NULL,
 CONSTRAINT [PK_lien] PRIMARY KEY CLUSTERED 
(
	[numLien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sondage]    Script Date: 04/01/2018 16:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sondage](
	[numSondage] [int] IDENTITY(1,1) NOT NULL,
	[questionSondage] [nvarchar](max) NOT NULL,
	[typeSondage] [bit] NOT NULL,
 CONSTRAINT [PK_sondage] PRIMARY KEY CLUSTERED 
(
	[numSondage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[votant]    Script Date: 04/01/2018 16:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[votant](
	[numVotant] [int] IDENTITY(1,1) NOT NULL,
	[adresseIp] [nvarchar](50) NULL,
 CONSTRAINT [PK_votant] PRIMARY KEY CLUSTERED 
(
	[numVotant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vote]    Script Date: 04/01/2018 16:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vote](
	[numVote] [int] IDENTITY(1,1) NOT NULL,
	[nbVote] [int] NOT NULL,
	[nbVotant] [int] NOT NULL,
	[numChoix] [int] NOT NULL,
	[numVotant] [int] NOT NULL,
 CONSTRAINT [PK_vote] PRIMARY KEY CLUSTERED 
(
	[numVote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[choix] ON 

INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (1, N'Bleu', 1)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (2, N'Vert', 1)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (3, N'Rouge', 1)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (4, N'Gris', 1)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (5, N'Rose', 1)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (6, N'Noir', 1)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (7, N'Blanc', 1)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (8, N'Orange', 1)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (9, N'WOW', 2)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (10, N'D3', 2)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (11, N'GW1', 2)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (14, N'GW2', 2)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (15, N'Destiny2', 2)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (16, N'Hereoes of the storm', 2)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (17, N'Starcraft1', 2)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (18, N'Starcraft2', 2)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (19, N'D1', 2)
INSERT [dbo].[choix] ([numChoix], [nomChoix], [numSondage]) VALUES (20, N'D2', 2)
SET IDENTITY_INSERT [dbo].[choix] OFF
SET IDENTITY_INSERT [dbo].[lien] ON 

INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (1, N'http://vote1', 1)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (3, N'http://resultat1', 1)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (4, N'http://supAleatoire1', 1)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (5, N'http://vote2', 2)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (6, N'http://resultat2', 2)
INSERT [dbo].[lien] ([numLien], [adresseLien], [numSondage]) VALUES (7, N'http://supAleatoire2', 2)
SET IDENTITY_INSERT [dbo].[lien] OFF
SET IDENTITY_INSERT [dbo].[sondage] ON 

INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (1, N'Votre couleur préférée ?', 0)
INSERT [dbo].[sondage] ([numSondage], [questionSondage], [typeSondage]) VALUES (2, N'Votre jeux favoris ?', 1)
SET IDENTITY_INSERT [dbo].[sondage] OFF
SET IDENTITY_INSERT [dbo].[votant] ON 

INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (1, N'1.1.1.1')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (2, N'2.2.2.2')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (3, N'3.3.3.3')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (4, N'4.4.4.4')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (5, N'5.5.5.5')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (6, N'6.6.6.6')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (7, N'7.7.7.7')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (8, N'8.8.8.8')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (9, N'9.9.9.9')
INSERT [dbo].[votant] ([numVotant], [adresseIp]) VALUES (10, N'10.10.10.10')
SET IDENTITY_INSERT [dbo].[votant] OFF
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

USE [master]
GO
/****** Object:  Database [AVM]    Script Date: 2/2/2021 10:46:39 PM ******/
CREATE DATABASE [AVM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AVM', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AVM.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AVM_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AVM_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [AVM] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AVM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AVM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AVM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AVM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AVM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AVM] SET ARITHABORT OFF 
GO
ALTER DATABASE [AVM] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AVM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AVM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AVM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AVM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AVM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AVM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AVM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AVM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AVM] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AVM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AVM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AVM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AVM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AVM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AVM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AVM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AVM] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AVM] SET  MULTI_USER 
GO
ALTER DATABASE [AVM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AVM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AVM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AVM] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AVM] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AVM] SET QUERY_STORE = OFF
GO
USE [AVM]
GO
/****** Object:  Table [dbo].[SEMT]    Script Date: 2/2/2021 10:46:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SEMT](
	[semtid] [int] NOT NULL,
	[semtisim] [varchar](50) NOT NULL,
	[lokasyon] [varchar](50) NOT NULL,
	[nufus] [int] NOT NULL,
 CONSTRAINT [PK_SEMT] PRIMARY KEY CLUSTERED 
(
	[semtid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AVMM]    Script Date: 2/2/2021 10:46:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AVMM](
	[avmid] [int] NOT NULL,
	[avmisim] [varchar](50) NOT NULL,
	[semtid] [int] NOT NULL,
	[mudurid] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[avmid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MAGAZA]    Script Date: 2/2/2021 10:46:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MAGAZA](
	[magazaid] [int] NOT NULL,
	[magazaisim] [varchar](50) NOT NULL,
	[katid] [int] NOT NULL,
	[avmid] [int] NOT NULL,
	[kasaSayisi] [int] NOT NULL,
	[sektorisim] [varchar](50) NOT NULL,
	[mudurid] [int] NOT NULL,
	[kapasite] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[magazaid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[SEKTORMAGAZA]    Script Date: 2/2/2021 10:46:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SEKTORMAGAZA]
AS
SELECT        dbo.AVMM.avmisim, dbo.MAGAZA.sektorisim, dbo.MAGAZA.magazaisim, dbo.SEMT.semtisim
FROM            dbo.AVMM INNER JOIN
                         dbo.MAGAZA ON dbo.AVMM.avmid = dbo.MAGAZA.avmid INNER JOIN
                         dbo.SEMT ON dbo.SEMT.semtid = dbo.AVMM.semtid
WHERE        (dbo.MAGAZA.sektorisim = 'giyim')
GO
/****** Object:  Table [dbo].[PERSONEL]    Script Date: 2/2/2021 10:46:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERSONEL](
	[personelid] [int] NOT NULL,
	[personeltipi] [char](1) NOT NULL,
	[magazaid] [int] NOT NULL,
	[avmid] [int] NOT NULL,
	[katid] [int] NOT NULL,
	[personelisim] [varchar](50) NOT NULL,
	[personelcinsiyet] [varchar](50) NOT NULL,
	[personelyas] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[personelid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ORTALAMAYAS]    Script Date: 2/2/2021 10:46:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ORTALAMAYAS]
AS
SELECT        dbo.SEMT.semtisim, dbo.AVMM.avmisim, dbo.AVMM.avmid, AVG(dbo.PERSONEL.personelyas) AS ortalamayas
FROM            dbo.AVMM INNER JOIN
                         dbo.PERSONEL ON dbo.AVMM.avmid = dbo.PERSONEL.avmid INNER JOIN
                         dbo.SEMT ON dbo.AVMM.semtid = dbo.SEMT.semtid
GROUP BY dbo.AVMM.avmid, dbo.AVMM.avmisim, dbo.SEMT.semtisim
GO
/****** Object:  View [dbo].[CINSIYETSAYISI]    Script Date: 2/2/2021 10:46:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CINSIYETSAYISI]
AS
SELECT        dbo.AVMM.avmisim, dbo.SEMT.semtisim, dbo.PERSONEL.personelcinsiyet, COUNT(dbo.PERSONEL.personelcinsiyet) AS calisansayisi
FROM            dbo.AVMM INNER JOIN
                         dbo.PERSONEL ON dbo.AVMM.avmid = dbo.PERSONEL.avmid INNER JOIN
                         dbo.SEMT ON dbo.AVMM.semtid = dbo.SEMT.semtid
GROUP BY dbo.AVMM.avmid, dbo.AVMM.avmisim, dbo.SEMT.semtisim, dbo.PERSONEL.personelcinsiyet
GO
/****** Object:  Table [dbo].[URUN]    Script Date: 2/2/2021 10:46:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[URUN](
	[urunid] [int] NOT NULL,
	[fiyat] [float] NOT NULL,
	[uruntip] [varchar](50) NOT NULL,
	[magazaid] [int] NOT NULL,
	[satisadet] [int] NOT NULL,
	[stokadet] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[urunid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[URUNSTOGU]    Script Date: 2/2/2021 10:46:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[URUNSTOGU]
AS
SELECT        dbo.SEMT.semtisim, dbo.AVMM.avmisim, dbo.MAGAZA.magazaisim, dbo.URUN.uruntip, dbo.URUN.stokadet
FROM            dbo.AVMM INNER JOIN
                         dbo.MAGAZA ON dbo.AVMM.avmid = dbo.MAGAZA.avmid INNER JOIN
                         dbo.SEMT ON dbo.AVMM.semtid = dbo.SEMT.semtid INNER JOIN
                         dbo.URUN ON dbo.MAGAZA.magazaid = dbo.URUN.magazaid
WHERE        (dbo.URUN.stokadet < 10)
GROUP BY dbo.AVMM.avmid, dbo.AVMM.avmisim, dbo.MAGAZA.magazaisim, dbo.SEMT.semtisim, dbo.URUN.uruntip, dbo.URUN.stokadet
GO
/****** Object:  View [dbo].[KAZANC]    Script Date: 2/2/2021 10:46:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[KAZANC]
AS
SELECT        TOP (100) PERCENT dbo.AVMM.avmisim, dbo.MAGAZA.magazaisim, dbo.SEMT.semtisim, SUM(dbo.URUN.satisadet * dbo.URUN.fiyat) AS toplamfiyat
FROM            dbo.AVMM INNER JOIN
                         dbo.MAGAZA ON dbo.AVMM.avmid = dbo.MAGAZA.avmid INNER JOIN
                         dbo.SEMT ON dbo.AVMM.semtid = dbo.SEMT.semtid INNER JOIN
                         dbo.URUN ON dbo.MAGAZA.magazaid = dbo.URUN.magazaid
GROUP BY dbo.AVMM.avmid, dbo.AVMM.avmisim, dbo.SEMT.semtisim, dbo.MAGAZA.magazaisim
ORDER BY toplamfiyat DESC
GO
/****** Object:  Table [dbo].[KAT]    Script Date: 2/2/2021 10:46:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KAT](
	[katid] [int] NOT NULL,
	[katno] [int] NOT NULL,
	[avmid] [int] NOT NULL,
	[tuvalet] [char](1) NOT NULL,
	[bakımodası] [char](1) NOT NULL,
	[mescid] [char](1) NOT NULL,
 CONSTRAINT [PK_KAT] PRIMARY KEY CLUSTERED 
(
	[katid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MUSTERI]    Script Date: 2/2/2021 10:46:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MUSTERI](
	[musterid] [int] NOT NULL,
	[musteriyas] [int] NOT NULL,
	[magazaid] [int] NOT NULL,
 CONSTRAINT [PK_MUSTERI] PRIMARY KEY CLUSTERED 
(
	[musterid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OTOPARK]    Script Date: 2/2/2021 10:46:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OTOPARK](
	[otoparkid] [int] NOT NULL,
	[avmid] [int] NOT NULL,
	[katid] [int] NOT NULL,
	[tuvalet] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[otoparkid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[URUNSATIS]    Script Date: 2/2/2021 10:46:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[URUNSATIS](
	[satisid] [int] NOT NULL,
	[urunid] [int] NOT NULL,
	[magazaid] [int] NOT NULL,
 CONSTRAINT [PK_URUNSATIS] PRIMARY KEY CLUSTERED 
(
	[satisid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AVMM]  WITH CHECK ADD  CONSTRAINT [FK_AVMM_SEMT] FOREIGN KEY([semtid])
REFERENCES [dbo].[SEMT] ([semtid])
GO
ALTER TABLE [dbo].[AVMM] CHECK CONSTRAINT [FK_AVMM_SEMT]
GO
ALTER TABLE [dbo].[KAT]  WITH CHECK ADD  CONSTRAINT [FK_KAT_AVMM] FOREIGN KEY([avmid])
REFERENCES [dbo].[AVMM] ([avmid])
GO
ALTER TABLE [dbo].[KAT] CHECK CONSTRAINT [FK_KAT_AVMM]
GO
ALTER TABLE [dbo].[MAGAZA]  WITH CHECK ADD FOREIGN KEY([avmid])
REFERENCES [dbo].[AVMM] ([avmid])
GO
ALTER TABLE [dbo].[MAGAZA]  WITH CHECK ADD  CONSTRAINT [FK_MAGAZA_KAT] FOREIGN KEY([katid])
REFERENCES [dbo].[KAT] ([katid])
GO
ALTER TABLE [dbo].[MAGAZA] CHECK CONSTRAINT [FK_MAGAZA_KAT]
GO
ALTER TABLE [dbo].[MUSTERI]  WITH CHECK ADD  CONSTRAINT [FK_MUSTERI_MAGAZA] FOREIGN KEY([magazaid])
REFERENCES [dbo].[MAGAZA] ([magazaid])
GO
ALTER TABLE [dbo].[MUSTERI] CHECK CONSTRAINT [FK_MUSTERI_MAGAZA]
GO
ALTER TABLE [dbo].[OTOPARK]  WITH CHECK ADD FOREIGN KEY([avmid])
REFERENCES [dbo].[AVMM] ([avmid])
GO
ALTER TABLE [dbo].[PERSONEL]  WITH CHECK ADD FOREIGN KEY([avmid])
REFERENCES [dbo].[AVMM] ([avmid])
GO
ALTER TABLE [dbo].[PERSONEL]  WITH CHECK ADD FOREIGN KEY([magazaid])
REFERENCES [dbo].[MAGAZA] ([magazaid])
GO
ALTER TABLE [dbo].[URUN]  WITH CHECK ADD FOREIGN KEY([magazaid])
REFERENCES [dbo].[MAGAZA] ([magazaid])
GO
ALTER TABLE [dbo].[URUNSATIS]  WITH CHECK ADD  CONSTRAINT [FK_URUNSATIS_MAGAZA] FOREIGN KEY([magazaid])
REFERENCES [dbo].[MAGAZA] ([magazaid])
GO
ALTER TABLE [dbo].[URUNSATIS] CHECK CONSTRAINT [FK_URUNSATIS_MAGAZA]
GO
ALTER TABLE [dbo].[URUNSATIS]  WITH CHECK ADD  CONSTRAINT [FK_URUNSATIS_URUN] FOREIGN KEY([urunid])
REFERENCES [dbo].[URUN] ([urunid])
GO
ALTER TABLE [dbo].[URUNSATIS] CHECK CONSTRAINT [FK_URUNSATIS_URUN]
GO
/****** Object:  StoredProcedure [dbo].[personel_update]    Script Date: 2/2/2021 10:46:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[personel_update]
	-- Add the parameters for the stored procedure here
	@magazaid int

AS
BEGIN TRANSACTION
BEGIN
	
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AVMM"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PERSONEL"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 420
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "SEMT"
            Begin Extent = 
               Top = 6
               Left = 458
               Bottom = 136
               Right = 628
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CINSIYETSAYISI'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CINSIYETSAYISI'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AVMM"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MAGAZA"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SEMT"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "URUN"
            Begin Extent = 
               Top = 6
               Left = 662
               Bottom = 136
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'KAZANC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'KAZANC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AVMM"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PERSONEL"
            Begin Extent = 
               Top = 2
               Left = 337
               Bottom = 132
               Right = 511
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "SEMT"
            Begin Extent = 
               Top = 6
               Left = 666
               Bottom = 136
               Right = 836
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ORTALAMAYAS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ORTALAMAYAS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AVMM"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MAGAZA"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "SEMT"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SEKTORMAGAZA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SEKTORMAGAZA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AVMM"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MAGAZA"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SEMT"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "URUN"
            Begin Extent = 
               Top = 6
               Left = 662
               Bottom = 136
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'URUNSTOGU'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'URUNSTOGU'
GO
USE [master]
GO
ALTER DATABASE [AVM] SET  READ_WRITE 
GO

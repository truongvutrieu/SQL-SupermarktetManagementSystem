USE [SupermarketManagementSystem]
GO
/****** Object:  Table [dbo].[tbCancel]    Script Date: 10/12/2023 20:46:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbCancel](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[transno] [varchar](50) NULL,
	[pcode] [varchar](50) NULL,
	[price] [decimal](18, 2) NULL,
	[qty] [int] NULL,
	[total] [decimal](18, 2) NULL,
	[sdate] [date] NULL,
	[voidby] [varchar](50) NULL,
	[cancelledby] [varchar](50) NULL,
	[reason] [text] NULL,
	[action] [varchar](50) NULL,
 CONSTRAINT [PK_tbCancel] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbProduct]    Script Date: 10/12/2023 20:46:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbProduct](
	[pcode] [varchar](50) NOT NULL,
	[barcode] [varchar](50) NULL,
	[pdesc] [varchar](max) NOT NULL,
	[bid] [int] NOT NULL,
	[cid] [int] NOT NULL,
	[price] [decimal](18, 2) NOT NULL,
	[qty] [int] NULL,
	[reorder] [int] NULL,
 CONSTRAINT [PK_tbProduct_1] PRIMARY KEY CLUSTERED 
(
	[pcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwCancelItems]    Script Date: 10/12/2023 20:46:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCancelItems]
AS
SELECT        dbo.tbCancel.transno, dbo.tbCancel.pcode, dbo.tbProduct.pdesc, 
                         dbo.tbCancel.price, dbo.tbCancel.qty, dbo.tbCancel.total, dbo.tbCancel.sdate, 
                         dbo.tbCancel.voidby, dbo.tbCancel.cancelledby, dbo.tbCancel.reason, 
                         dbo.tbCancel.action
FROM            dbo.tbCancel INNER JOIN
                         dbo.tbProduct ON dbo.tbCancel.pcode = dbo.tbProduct.pcode
GO
/****** Object:  Table [dbo].[tbBrand]    Script Date: 10/12/2023 20:46:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbBrand](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[brand] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tbBrand] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbCategory]    Script Date: 10/12/2023 20:46:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[category] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tbCategory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwCriticalItems]    Script Date: 10/12/2023 20:46:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCriticalItems]
AS
SELECT        dbo.tbProduct.pcode, dbo.tbProduct.barcode, dbo.tbProduct.pdesc, 
                         dbo.tbBrand.brand, dbo.tbCategory.category, dbo.tbProduct.price, 
                         dbo.tbProduct.reorder, dbo.tbProduct.qty
FROM            dbo.tbProduct INNER JOIN
                         dbo.tbCategory ON dbo.tbProduct.cid = dbo.tbCategory.id INNER JOIN
                         dbo.tbBrand ON dbo.tbProduct.bid = dbo.tbBrand.id
WHERE        (dbo.tbProduct.qty <= dbo.tbProduct.reorder)
GO
/****** Object:  View [dbo].[vwInventoryList]    Script Date: 10/12/2023 20:46:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwInventoryList]
AS
SELECT        dbo.tbProduct.pcode, dbo.tbProduct.barcode, dbo.tbProduct.pdesc, 
                         dbo.tbBrand.brand, dbo.tbCategory.category, dbo.tbProduct.price, 
                         dbo.tbProduct.qty, dbo.tbProduct.reorder
FROM            dbo.tbProduct INNER JOIN
                         dbo.tbCategory ON dbo.tbProduct.cid = dbo.tbCategory.id INNER JOIN
                         dbo.tbBrand ON dbo.tbProduct.bid = dbo.tbBrand.id
GO
/****** Object:  Table [dbo].[tbStockIn]    Script Date: 10/12/2023 20:46:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbStockIn](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[refno] [varchar](50) NULL,
	[pcode] [varchar](50) NULL,
	[qty] [int] NULL,
	[sdate] [datetime] NULL,
	[stockinby] [varchar](50) NULL,
	[status] [varchar](50) NULL,
	[supplierid] [int] NULL,
 CONSTRAINT [PK_tbStockIn_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbSupplier]    Script Date: 10/12/2023 20:46:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbSupplier](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[supplier] [varchar](50) NOT NULL,
	[address] [text] NOT NULL,
	[contactperson] [varchar](50) NOT NULL,
	[phone] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[fax] [varchar](50) NULL,
 CONSTRAINT [PK_tbSupplier_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwStockIn]    Script Date: 10/12/2023 20:46:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwStockIn]
AS
SELECT        dbo.tbStockIn.id, dbo.tbStockIn.refno, dbo.tbStockIn.pcode, dbo.tbProduct.pdesc, 
                         dbo.tbStockIn.qty, dbo.tbStockIn.sdate, dbo.tbStockIn.stockinby, 
                         dbo.tbStockIn.status, dbo.tbSupplier.supplier
FROM            dbo.tbProduct INNER JOIN
                         dbo.tbStockIn ON dbo.tbProduct.pcode = dbo.tbStockIn.pcode INNER JOIN
                         dbo.tbSupplier ON dbo.tbStockIn.supplierid = dbo.tbSupplier.id
GO
/****** Object:  Table [dbo].[tbCart]    Script Date: 10/12/2023 20:46:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbCart](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[transno] [varchar](50) NULL,
	[pcode] [varchar](50) NULL,
	[price] [decimal](18, 2) NULL,
	[qty] [int] NULL,
	[disc_percent] [decimal](18, 2) NULL,
	[disc] [decimal](18, 2) NULL,
	[total] [decimal](18, 2) NULL,
	[sdate] [date] NULL,
	[status] [varchar](50) NULL,
	[cashier] [varchar](50) NULL,
 CONSTRAINT [PK_tbCart] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwTopSelling]    Script Date: 10/12/2023 20:46:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwTopSelling]
AS
SELECT        dbo.tbCart.pcode, dbo.tbProduct.pdesc, dbo.tbCart.qty, dbo.tbCart.sdate, 
                         dbo.tbCart.total, dbo.tbCart.status
FROM            dbo.tbCart INNER JOIN
                         dbo.tbProduct ON dbo.tbCart.pcode = dbo.tbProduct.pcode
GO
/****** Object:  Table [dbo].[tbAdjustment]    Script Date: 10/12/2023 20:46:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbAdjustment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[referenceno] [varchar](50) NULL,
	[pcode] [varchar](50) NULL,
	[qty] [int] NULL,
	[action] [varchar](50) NULL,
	[remarks] [varchar](50) NULL,
	[sdate] [date] NULL,
	[user] [varchar](50) NULL,
 CONSTRAINT [PK_tbAdjustment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbStore]    Script Date: 10/12/2023 20:46:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbStore](
	[store] [varchar](50) NOT NULL,
	[address] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbUser]    Script Date: 10/12/2023 20:46:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbUser](
	[username] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[role] [varchar](50) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[isactivate] [varchar](50) NULL,
 CONSTRAINT [PK_tbUser] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbCart] ADD  CONSTRAINT [DF_tbCart_qty]  DEFAULT ((0)) FOR [qty]
GO
ALTER TABLE [dbo].[tbCart] ADD  CONSTRAINT [DF_tbCart_disc_percent]  DEFAULT ((0)) FOR [disc_percent]
GO
ALTER TABLE [dbo].[tbCart] ADD  CONSTRAINT [DF_tbCart_disc]  DEFAULT ((0)) FOR [disc]
GO
ALTER TABLE [dbo].[tbCart] ADD  CONSTRAINT [DF_tbCart_status]  DEFAULT ('Pending') FOR [status]
GO
ALTER TABLE [dbo].[tbProduct] ADD  CONSTRAINT [DF_tbProduct_qty]  DEFAULT ((0)) FOR [qty]
GO
ALTER TABLE [dbo].[tbStockIn] ADD  CONSTRAINT [DF_tbStockIn_qty]  DEFAULT ((0)) FOR [qty]
GO
ALTER TABLE [dbo].[tbStockIn] ADD  CONSTRAINT [DF_tbStockIn_status]  DEFAULT ('Pending') FOR [status]
GO
ALTER TABLE [dbo].[tbUser] ADD  CONSTRAINT [DF_tbUser_isactive]  DEFAULT ('True') FOR [isactivate]
GO
ALTER TABLE [dbo].[tbCart]  WITH CHECK ADD  CONSTRAINT [FK_tbCart_tbProduct] FOREIGN KEY([pcode])
REFERENCES [dbo].[tbProduct] ([pcode])
GO
ALTER TABLE [dbo].[tbCart] CHECK CONSTRAINT [FK_tbCart_tbProduct]
GO
ALTER TABLE [dbo].[tbProduct]  WITH CHECK ADD  CONSTRAINT [FK_tbProduct_tbBrand] FOREIGN KEY([bid])
REFERENCES [dbo].[tbBrand] ([id])
GO
ALTER TABLE [dbo].[tbProduct] CHECK CONSTRAINT [FK_tbProduct_tbBrand]
GO
ALTER TABLE [dbo].[tbStockIn]  WITH CHECK ADD  CONSTRAINT [FK_tbStockIn_tbProduct] FOREIGN KEY([pcode])
REFERENCES [dbo].[tbProduct] ([pcode])
GO
ALTER TABLE [dbo].[tbStockIn] CHECK CONSTRAINT [FK_tbStockIn_tbProduct]
GO
ALTER TABLE [dbo].[tbStockIn]  WITH CHECK ADD  CONSTRAINT [FK_tbStockIn_tbSupplier] FOREIGN KEY([supplierid])
REFERENCES [dbo].[tbSupplier] ([id])
GO
ALTER TABLE [dbo].[tbStockIn] CHECK CONSTRAINT [FK_tbStockIn_tbSupplier]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[16] 3) )"
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
         Begin Table = "tbCancel"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 268
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbProduct"
            Begin Extent = 
               Top = 6
               Left = 244
               Bottom = 141
               Right = 412
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
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCancelItems'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCancelItems'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[11] 2[19] 3) )"
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
         Begin Table = "tbBrand"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 105
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbCategory"
            Begin Extent = 
               Top = 6
               Left = 244
               Bottom = 105
               Right = 412
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbProduct"
            Begin Extent = 
               Top = 153
               Left = 252
               Bottom = 288
               Right = 420
            End
            DisplayFlags = 280
            TopColumn = 4
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCriticalItems'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCriticalItems'
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
         Begin Table = "tbBrand"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 105
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbCategory"
            Begin Extent = 
               Top = 13
               Left = 430
               Bottom = 112
               Right = 598
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbProduct"
            Begin Extent = 
               Top = 164
               Left = 231
               Bottom = 299
               Right = 399
            End
            DisplayFlags = 280
            TopColumn = 4
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwInventoryList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwInventoryList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[12] 2[29] 3) )"
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
         Begin Table = "tbProduct"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 141
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbStockIn"
            Begin Extent = 
               Top = 6
               Left = 244
               Bottom = 141
               Right = 412
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "tbSupplier"
            Begin Extent = 
               Top = 6
               Left = 450
               Bottom = 141
               Right = 618
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
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwStockIn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwStockIn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[15] 2[15] 3) )"
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
         Begin Table = "tbCart"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 230
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "tbProduct"
            Begin Extent = 
               Top = 6
               Left = 244
               Bottom = 241
               Right = 412
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwTopSelling'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwTopSelling'
GO

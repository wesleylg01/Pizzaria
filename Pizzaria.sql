USE  master

IF (ISNULL((SELECT 'TRUE' 
            FROM sys.databases 
            WHERE name = 'Pizzaria'),'FALSE') = 'TRUE')
BEGIN
   DROP DATABASE Pizzaria
END 

CREATE DATABASE Pizzaria

use Pizzaria

CREATE TABLE [dbo].[INGREDIENTE](
	[IdIngrediente] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](100) NOT NULL,
	[Unidade] [varchar](20) NOT NULL,
	[Cod_Barras] [varchar](13) NULL,
	[Valor] [decimal](10, 2) NULL,
	[Qtd] [decimal](10, 3) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdIngrediente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROD_PRONTO]    Script Date: 11/02/2020 21:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROD_PRONTO](
	[IdProd_Pronto] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](100) NOT NULL,
	[Valor_Custo] [decimal](10, 2) NOT NULL,
	[Valor_Final] [decimal](10, 2) NOT NULL,
	[Margem] [decimal](10, 2) NULL,
	[Unidade] [varchar](20) NULL,
	[Qtd] [decimal](10, 3) NULL,
	[Valor] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProd_Pronto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PROD_INGREDIENTES]    Script Date: 11/02/2020 21:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PROD_INGREDIENTES] AS    
SELECT Id         = IdIngrediente,    
       Unidade,    
       Nome,    
       Tipo       = 'Ingrediente',  
       Tbl_Origem = 'INGREDIENTE',
	   Valor      = ISNULL(Valor,0.00)
FROM   INGREDIENTE    
UNION  ALL    
SELECT Id         = IdProd_Pronto,    
       Unidade,    
       Nome,    
       tbl_origem = 'Produto de prep. Pronto',  
       Tbl_Origem = 'PROD_PRONTO',
	   Valor      = ISNULL(Valor_Final,0.00)
FROM   PROD_PRONTO 
GO
/****** Object:  Table [dbo].[PRODUTO]    Script Date: 11/02/2020 21:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUTO](
	[IdProduto] [int] IDENTITY(1,1) NOT NULL,
	[Unidade] [varchar](20) NOT NULL,
	[Nome] [varchar](100) NOT NULL,
	[Cod_Barras] [varchar](13) NULL,
	[Qtd_Estoque] [decimal](10, 3) NOT NULL,
	[MateriaPrima] [bit] NULL,
	[Valor] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TAMANHO]    Script Date: 11/02/2020 21:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TAMANHO](
	[IdTamanho] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTamanho] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRATO]    Script Date: 11/02/2020 21:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRATO](
	[IdPrato] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](100) NOT NULL,
	[Custo] [decimal](10, 2) NOT NULL,
	[Margem] [decimal](10, 2) NULL,
	[Valor_Final] [decimal](10, 2) NOT NULL,
	[IdCategoria] [int] NOT NULL,
	[IdTamanho] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPrato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PROD_PRATOS]    Script Date: 11/02/2020 21:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PROD_PRATOS] AS      
SELECT Id              = IdProduto,
       Unidade_Tamanho = Unidade,      
       Nome,      
       Tbl_Origem = 'PRODUTO',  
       Valor      = ISNULL(Valor,0.00)  
FROM   PRODUTO
UNION  ALL      
SELECT Id              = P.IdPrato,      
       Unidade_Tamanho = T.Nome,      
       P.Nome,      
       Tbl_Origem      = 'PRATO',  
       Valor           = ISNULL(Valor_Final,0.00)  
FROM   PRATO P
INNER  JOIN TAMANHO T ON T.IdTamanho = P.IdTamanho
GO
/****** Object:  Table [dbo].[CAIXA]    Script Date: 11/02/2020 21:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAIXA](
	[IdCaixa] [int] IDENTITY(1,1) NOT NULL,
	[Situacao_Caixa] [bit] NULL,
	[DtHrAbertura] [datetime] NULL,
	[DtHrFechamento] [datetime] NULL,
	[Total_Dia] [decimal](10, 2) NULL,
	[IdUsr] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCaixa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CATEGORIA]    Script Date: 11/02/2020 21:10:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORIA](
	[IdCategoria] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ITENSPEDIDO]    Script Date: 11/02/2020 21:10:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ITENSPEDIDO](
	[IdItensPedido] [int] IDENTITY(1,1) NOT NULL,
	[Qtd] [decimal](10, 3) NOT NULL,
	[IdPedido] [int] NOT NULL,
	[IdOrigem] [int] NOT NULL,
	[TabelaOrigem] [varchar](30) NOT NULL,
	[Valor] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdItensPedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ITENSPRATO]    Script Date: 11/02/2020 21:10:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ITENSPRATO](
	[IdItensPrato] [int] IDENTITY(1,1) NOT NULL,
	[Qtd] [decimal](10, 3) NOT NULL,
	[IdPrato] [int] NOT NULL,
	[idorigem] [int] NOT NULL,
	[TabelaOrigem] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdItensPrato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ITENSPROD_PRONTO]    Script Date: 11/02/2020 21:10:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ITENSPROD_PRONTO](
	[IdItensProd_Pronto] [int] IDENTITY(1,1) NOT NULL,
	[Qtd] [decimal](10, 3) NOT NULL,
	[IdProd_Pronto] [int] NOT NULL,
	[IdIngrediente] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdItensProd_Pronto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MESAS]    Script Date: 11/02/2020 21:10:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MESAS](
	[IdMesa] [int] IDENTITY(1,1) NOT NULL,
	[Cod_Mesa] [int] NOT NULL,
	[Obs] [varchar](200) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMesa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PEDIDO]    Script Date: 11/02/2020 21:10:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PEDIDO](
	[IdPedido] [int] IDENTITY(1,1) NOT NULL,
	[Situacao_Pedido] [bit] NULL,
	[Tpo_Pedido] [int] NOT NULL,
	[Cliente] [varchar](100) NULL,
	[Telefone] [varchar](17) NULL,
	[Valor_Pedido] [decimal](10, 2) NOT NULL,
	[Forma_Pagamento] [int] NULL,
	[DtHrPedido] [datetime] NOT NULL,
	[IdMesa] [int] NOT NULL,
	[IdCaixa] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USUARIO]    Script Date: 11/02/2020 21:10:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIO](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](100) NOT NULL,
	[usr] [varchar](20) NOT NULL,
	[datanasc] [datetime] NULL,
	[datacad] [datetime] NULL,
	[nivel] [int] NULL,
	[bloqueia] [bit] NULL,
	[Senha] [varbinary](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VALIDADE]    Script Date: 11/02/2020 21:10:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VALIDADE](
	[IdValidade] [int] IDENTITY(1,1) NOT NULL,
	[IdProduto] [int] NOT NULL,
	[Qtd] [decimal](10, 3) NULL,
	[DataValidade] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdValidade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CAIXA] ADD  DEFAULT ((0)) FOR [Situacao_Caixa]
GO
ALTER TABLE [dbo].[PEDIDO] ADD  DEFAULT ((0)) FOR [Situacao_Pedido]
GO
ALTER TABLE [dbo].[PRODUTO] ADD  DEFAULT ((0)) FOR [MateriaPrima]
GO
ALTER TABLE [dbo].[USUARIO] ADD  DEFAULT ((0)) FOR [bloqueia]
GO
ALTER TABLE [dbo].[CAIXA]  WITH CHECK ADD FOREIGN KEY([IdUsr])
REFERENCES [dbo].[USUARIO] ([IdUsuario])
GO
ALTER TABLE [dbo].[ITENSPEDIDO]  WITH CHECK ADD FOREIGN KEY([IdPedido])
REFERENCES [dbo].[PEDIDO] ([IdPedido])
GO
ALTER TABLE [dbo].[ITENSPRATO]  WITH CHECK ADD FOREIGN KEY([IdPrato])
REFERENCES [dbo].[PRATO] ([IdPrato])
GO
ALTER TABLE [dbo].[ITENSPROD_PRONTO]  WITH CHECK ADD FOREIGN KEY([IdIngrediente])
REFERENCES [dbo].[INGREDIENTE] ([IdIngrediente])
GO
ALTER TABLE [dbo].[ITENSPROD_PRONTO]  WITH CHECK ADD FOREIGN KEY([IdProd_Pronto])
REFERENCES [dbo].[PROD_PRONTO] ([IdProd_Pronto])
GO
ALTER TABLE [dbo].[PEDIDO]  WITH CHECK ADD FOREIGN KEY([IdCaixa])
REFERENCES [dbo].[CAIXA] ([IdCaixa])
GO
ALTER TABLE [dbo].[PEDIDO]  WITH CHECK ADD FOREIGN KEY([IdMesa])
REFERENCES [dbo].[MESAS] ([IdMesa])
GO
ALTER TABLE [dbo].[PRATO]  WITH CHECK ADD FOREIGN KEY([IdCategoria])
REFERENCES [dbo].[CATEGORIA] ([IdCategoria])
GO
ALTER TABLE [dbo].[PRATO]  WITH CHECK ADD FOREIGN KEY([IdTamanho])
REFERENCES [dbo].[TAMANHO] ([IdTamanho])
GO
ALTER TABLE [dbo].[VALIDADE]  WITH CHECK ADD FOREIGN KEY([IdProduto])
REFERENCES [dbo].[PRODUTO] ([IdProduto])
GO
USE [master]
GO
ALTER DATABASE [Pizzaria] SET  READ_WRITE 
GO



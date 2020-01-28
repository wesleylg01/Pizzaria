USE  master

DROP DATABASE Pizzaria

CREATE DATABASE Pizzaria

USE Pizzaria

CREATE TABLE USUARIO (IdUsuario INT IDENTITY(1,1) PRIMARY KEY,
                      Nome		VARCHAR(100)  NOT NULL,
					  usr		VARCHAR(20)   NOT NULL,
					  senha		VARBINARY(20) NOT NULL,
					  datanasc  DATETIME,
					  datacad	DATETIME,
					  nivel		INT,
					  bloqueia	BIT DEFAULT (0))

CREATE TABLE CAIXA (IdCaixa			INT IDENTITY(1,1) PRIMARY KEY,
					Situacao_Caixa	BIT DEFAULT (0),
					Valor			DECIMAL(10,2),
					DtHrAbertura	DATETIME,
					DtHrFechamento	DATETIME,
					Total_Dia		DECIMAL(10,2),
					IdUsr			INT FOREIGN KEY REFERENCES USUARIO(IdUsuario) NOT NULL)

CREATE TABLE CATEGORIA (IdCategoria INT IDENTITY(1,1) PRIMARY KEY,
                        Nome        VARCHAR(100))

CREATE TABLE TAMANHO (IdTamanho INT IDENTITY(1,1) PRIMARY KEY,
                      Nome      VARCHAR(100))

CREATE TABLE PRODUTO (IdProduto    INT IDENTITY(1,1) PRIMARY KEY,
					  Unidade      VARCHAR(20)   NOT NULL,
					  Nome         VARCHAR(100)  NOT NULL,
					  Cod_Barras   VARCHAR(13),
					  MateriaPrima BIT DEFAULT (0),
					  Qtd_Estoque  DECIMAL(10,3) NOT NULL
					  Valor        DECIMAL(10,2))

CREATE TABLE PEDIDO (IdPedido		 INT IDENTITY(1,1) PRIMARY KEY,
                     Situacao_Pedido BIT DEFAULT (0),
                     Tpo_Pedido      INT NOT NULL,
					 NroMesa		 INT,
					 Cliente		 VARCHAR(100),
					 Telefone		 VARCHAR(17),
					 Valor_Pedido	 DECIMAL(10,2) NOT NULL,
					 Forma_Pagamento INT,
					 DtHrPedido      DATETIME NOT NULL,
					 IdCaixa         INT FOREIGN KEY REFERENCES CAIXA(IdCaixa) NOT NULL)

CREATE TABLE PRATO (IdPrato		INT IDENTITY(1,1) PRIMARY KEY,
					Nome		VARCHAR(100)  NOT NULL,
					Custo		DECIMAL(10,2) NOT NULL,
					Margem		DECIMAL(10,2),
					Valor_Final  DECIMAL(10,2) NOT NULL,
					IdCategoria INT FOREIGN KEY REFERENCES CATEGORIA (IdCategoria) NOT NULL,
					IdTamanho   INT FOREIGN KEY REFERENCES TAMANHO (IdTamanho) NOT NULL)

CREATE TABLE ITENSPRATO(IdItensPrato INT IDENTITY(1,1) PRIMARY KEY,
						Qtd          DECIMAL(10,3) NOT NULL,
						IdPrato	     INT FOREIGN KEY REFERENCES PRATO   (IdPrato)   NOT NULL,
						IdProduto	 INT FOREIGN KEY REFERENCES PRODUTO (IdProduto) NOT NULL)
.
CREATE TABLE ITENSPEDIDO (IdItensPedido INT IDENTITY(1,1) PRIMARY KEY,
						  Qtd           DECIMAL(10,3) NOT NULL,
						  IdPedido		INT FOREIGN KEY REFERENCES PEDIDO  (IdPedido)  NOT NULL,
						  IdProduto	    INT FOREIGN KEY REFERENCES PRODUTO (IdProduto) NOT NULL,
						  IdPrato	    INT FOREIGN KEY REFERENCES PRATO   (IdPrato)   NOT NULL)

CREATE TABLE MESAS (IdMesa INT PRIMARY KEY NOT NULL IDENTITY(1,1),
                    Cod_Mesa INT NOT NULL,
					Obs VARCHAR(200))
					
CREATE TABLE VALIDADE(IdValidade   INT IDENTITY(1,1) PRIMARY KEY,
					  IdProduto    INT FOREIGN KEY REFERENCES PRODUTO (IdProduto) NOT NULL,
					  Qtd          DECIMAL(10,3),
					  DataValidade DATETIME  NOT NULL)

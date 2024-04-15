CREATE DATABASE loja;
GO

USE loja;
GO

CREATE TABLE produto (
  id INTEGER NOT NULL IDENTITY,
  nome VARCHAR(255) NOT NULL,
  quantidade INTEGER NOT NULL,
  preco_venda NUMERIC(14,2) NOT NULL,
CONSTRAINT pk_produto PRIMARY KEY(id));
GO

CREATE TABLE pessoa (
  id INTEGER NOT NULL, 
  nome VARCHAR(150) NOT NULL, 
  logradouro VARCHAR(100) NOT NULL,
  cidade VARCHAR(100) NOT NULL, 
  estado CHAR(2) NOT NULL, 
  telefone VARCHAR(11) NOT NULL,
  email VARCHAR(150) NOT NULL,
CONSTRAINT pk_pessoa PRIMARY KEY(id));
GO

CREATE TABLE usuario (
  id INTEGER NOT NULL IDENTITY,
  [login] VARCHAR(20) NOT NULL,
  senha VARCHAR(20) NOT NULL,
  CONSTRAINT pk_usuario PRIMARY KEY(id));
GO

CREATE TABLE pessoa_juridica (
  idpessoa INTEGER NOT NULL,
  cnpj VARCHAR(14) NOT NULL,
  CONSTRAINT pk_pessoa_juridica PRIMARY KEY(idpessoa),
  CONSTRAINT fk_pj_pessoa FOREIGN KEY(idpessoa) REFERENCES pessoa(id));
GO

CREATE TABLE pessoa_fisica (
  idpessoa INTEGER NOT NULL,
  cpf VARCHAR(11) NOT NULL,
  CONSTRAINT pk_pessoa_fisica PRIMARY KEY(idpessoa),
  CONSTRAINT fk_pf_pessoa FOREIGN KEY(idpessoa) REFERENCES pessoa(id));
GO

CREATE TABLE movimento (
  id INTEGER NOT NULL IDENTITY,
  idusuario INTEGER NOT NULL,
  idpessoa INTEGER NOT NULL,
  idproduto INTEGER NOT NULL,
  tipo_movimento CHAR(1) NOT NULL,
  quantidade INTEGER NOT NULL,
  valor_unitario NUMERIC(14,2) NOT NULL,
  CONSTRAINT pk_movimento PRIMARY KEY(id),
  CONSTRAINT fk_movimento_usuario FOREIGN KEY(idusuario) REFERENCES usuario(id),
  CONSTRAINT fk_movimento_pessoa FOREIGN KEY(idpessoa) REFERENCES pessoa(id),
  CONSTRAINT fk_movimento_produto FOREIGN KEY(idproduto) REFERENCES produto(id),
  CONSTRAINT chk_tipo_movimento CHECK (tipo_movimento = 's' or tipo_movimento = 'e')
 );
GO

CREATE SEQUENCE sqc_pessoa_id
	AS INT
	START WITH 1
	INCREMENT BY 1 ;
GO
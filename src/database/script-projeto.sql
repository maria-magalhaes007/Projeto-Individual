-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql server
*/

CREATE DATABASE carpe_diem;
USE carpe_diem;

CREATE TABLE usuario (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(45) UNIQUE NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  senha VARCHAR(80) NOT NULL
);

CREATE TABLE personagem (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  ator VARCHAR(45) NOT NULL
);

CREATE TABLE avaliacao (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nota DECIMAL(2,1) NOT NULL,
	CONSTRAINT chNota CHECK(nota BETWEEN 0 AND 5),
  descricao VARCHAR(300),
  dtAvaliacao DATETIME DEFAULT CURRENT_TIMESTAMP,
  assistido BOOLEAN NOT NULL,
  fkPersonagem INT,
	FOREIGN KEY (fkPersonagem) REFERENCES personagem(id),
  fkUsuario INT NOT NULL,
  	FOREIGN KEY (fkUsuario) REFERENCES usuario(id)
);
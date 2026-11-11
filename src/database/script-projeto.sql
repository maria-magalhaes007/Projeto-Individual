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

INSERT INTO personagem (nome, ator) VALUES 
('John Keating', 'Robin Williams'),
('Neil Perry', 'Robert Sean Leonard'),
('Todd Anderson', 'Ethan Hawke'),
('Knox Overstreet', 'Josh Charles'),
('Charlie Dalton', 'Gale Hansen'),
('Richard Cameron', 'Dylan Kussman'),
('Steven Meeks', 'Allelon Ruggiero'),
('Gerard Pitts', 'James Waterston');

INSERT INTO usuario (nome, email, senha) VALUES 
('Ana Souza', 'ana.souza@email.com', '123456'),
('Carlos Lima', 'carlos.lima@email.com', '123456'),
('Beatriz Silva', 'beatriz.silva@email.com', '123456');

INSERT INTO avaliacao (nota, descricao, assistido, favorito, fkPersonagem, fkUsuario) VALUES 
(5, 'John Keating é simplesmente inspirador. Oh Captain, my Captain!', TRUE, TRUE, 1, 1),
(4, 'A atuação do Robert Sean Leonard como Neil Perry é emocionante e dolorosa.', TRUE, FALSE, 2, 2),
(4, 'A evolução do Todd Anderson ao longo do filme me faz chorar todas as vezes.', FALSE, FALSE, 3, 3),
(3, 'Gosto do Knox, mas o arco romântico dele às vezes quebra o ritmo para mim.', TRUE, TRUE, 4, 4),
(5, 'Filme espetacular, marcou a minha juventude. Carpe Diem!', TRUE, TRUE, 3, 1);

-- SELECT PARA KPI DE FILME RECOMEDADO OU NÃO
CREATE VIEW vw_filme_recomendado AS
SELECT 
	TRUNCATE(
    (COUNT(*) * 100.0) / (SELECT COUNT(*) FROM avaliacao), 2) AS 'porcentagemTotal',

    TRUNCATE(
        SUM(
            CASE
                WHEN recomendado = 1 THEN 1
                ELSE 0
            END) * 100 / COUNT(*), 2
    ) AS 'recomendado',

    TRUNCATE(
        SUM(
            CASE
                WHEN recomendado = 1 THEN 0
                ELSE 1
            END) * 100 / COUNT(*), 2
    ) AS 'naoRecomendado'

FROM avaliacao;

DROP VIEW vw_filme_recomendado;
SELECT * FROM carpe_diem.vw_filme_recomendaria;


ALTER TABLE avaliacao ADD COLUMN recomendado BOOLEAN DEFAULT FALSE;

-- SELECT PARA A KPI DE NOTA MÉDIA
SELECT TRUNCATE(AVG(nota), 1) AS 'Média' FROM avaliacao; 

-- SELECT PARA A KPI DE QUANTOS USUARIOS JÁ ASSISTIRAM AO FILME
SELECT COUNT(assistido) FROM avaliacao WHERE assistido = TRUE;

ALTER TABLE avaliacao DROP COLUMN favorito;
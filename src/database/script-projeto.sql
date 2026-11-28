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
  dataPublicacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  recomendado TINYINT,
  assistido BOOLEAN NOT NULL,
  fkPersonagem INT,
	FOREIGN KEY (fkPersonagem) REFERENCES personagem(id),
  fkUsuario INT NOT NULL,
  	FOREIGN KEY (fkUsuario) REFERENCES usuario(id)
);

-- SELECT NOTA PARA GRÁFICO
SELECT nota, COUNT(*) AS quantidade
FROM avaliacao
GROUP BY nota
ORDER BY nota DESC;

-- SELECT PARA KPI DE FILME RECOMEDADO OU NÃO
SELECT 
    TRUNCATE(
        SUM(recomendado) * 100 / COUNT(*), 2
    ) AS 'recomendado',
    -- Explicando: sum [1, 1, 0, 1] = 3 logo: 3 * 100 / 4 = 75

    TRUNCATE(
        SUM(1 - recomendado) * 100 / COUNT(*), 2
    ) AS 'naoRecomendado'
    -- Explicando: sum [1 - 1, 1 - 1, 1 - 0, 1 - 1] =  logo: 1 * 100 / 4 = 25
FROM avaliacao;

-- SELECT PARA A KPI DE NOTA MÉDIA
SELECT TRUNCATE(AVG(nota), 1) AS 'Média' FROM avaliacao; 

-- SELECT PARA A KPI DE QUANTOS USUARIOS JÁ ASSISTIRAM AO FILME
SELECT COUNT(assistido) AS 'totalAssistidos' FROM avaliacao WHERE assistido = TRUE;

-- SELECT PARA A KPI DE PERSONAGEM FAVORITO
SELECT p.nome AS nome, COUNT(p.id) AS totalVotos
FROM avaliacao a
JOIN personagem p ON a.fkPersonagem = p.id
GROUP BY p.nome, p.id
ORDER BY totalVotos DESC
LIMIT 1;

-- VIZUALIZAR COMENTARIOS
SELECT
	a.id AS idAvaliacao,
	a.nota,
	a.descricao,
	a.assistido,
	a.recomendado,
	a.dataPublicacao,
	u.nome AS nomeUsuario,
    CASE 
		WHEN a.descricao IS NULL THEN ''
	END
FROM avaliacao a
JOIN usuario u ON a.fkUsuario = u.id
ORDER BY a.dataPublicacao DESC;

INSERT INTO personagem (nome, ator) VALUES 
('John Keating', 'Robin Williams'),
('Neil Perry', 'Robert Sean Leonard'),
('Todd Anderson', 'Ethan Hawke'),
('Knox Overstreet', 'Josh Charles'),
('Charlie Dalton', 'Gale Hansen'),
('Richard Cameron', 'Dylan Kussman'),
('Stephen Meeks Jr.', 'Allelon Ruggiero'),
('Gerard Pitts', 'James Waterston'),
('Sr. Norlan', 'Norman Lloyd'),
('Mr. Perry ', 'Kurtwood Smith');

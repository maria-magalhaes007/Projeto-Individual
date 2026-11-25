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

SELECT * FROM carpe_diem.vw_filme_recomendaria;

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

INSERT INTO usuario (nome, email, senha) VALUES
  ('Lucas Costa', 'lucas.costa1@exemplo.com', 'HashSenha@1001'),
  ('Ana Fernandes', 'ana.fernandes2@exemplo.com', 'HashSenha@1002'),
  ('Mateus Moreira', 'mateus.moreira3@exemplo.com', 'HashSenha@1003'),
  ('Julia Santos', 'julia.santos4@exemplo.com', 'HashSenha@1004'),
  ('Gabriel Lima', 'gabriel.lima5@exemplo.com', 'HashSenha@1005'),
  ('Beatriz Lopes', 'beatriz.lopes6@exemplo.com', 'HashSenha@1006'),
  ('Rafael Nascimento', 'rafael.nascimento7@exemplo.com', 'HashSenha@1007'),
  ('Larissa Freitas', 'larissa.freitas8@exemplo.com', 'HashSenha@1008'),
  ('Gustavo Alves', 'gustavo.alves9@exemplo.com', 'HashSenha@1009'),
  ('Mariana Carvalho', 'mariana.carvalho10@exemplo.com', 'HashSenha@1010'),
  ('Pedro Rocha', 'pedro.rocha11@exemplo.com', 'HashSenha@1011'),
  ('Camila Machado', 'camila.machado12@exemplo.com', 'HashSenha@1012'),
  ('Felipe Rodrigues', 'felipe.rodrigues13@exemplo.com', 'HashSenha@1013'),
  ('Leticia Ribeiro', 'leticia.ribeiro14@exemplo.com', 'HashSenha@1014'),
  ('Bruno Vieira', 'bruno.vieira15@exemplo.com', 'HashSenha@1015'),
  ('Amanda Nunes', 'amanda.nunes16@exemplo.com', 'HashSenha@1016'),
  ('Thiago Oliveira', 'thiago.oliveira17@exemplo.com', 'HashSenha@1017'),
  ('Isabela Gomes', 'isabela.gomes18@exemplo.com', 'HashSenha@1018'),
  ('Eduardo Soares', 'eduardo.soares19@exemplo.com', 'HashSenha@1019'),
  ('Carolina Andrade', 'carolina.andrade20@exemplo.com', 'HashSenha@1020'),
  ('Leonardo Silva', 'leonardo.silva21@exemplo.com', 'HashSenha@1021'),
  ('Fernanda Pereira', 'fernanda.pereira22@exemplo.com', 'HashSenha@1022'),
  ('Diego Almeida', 'diego.almeida23@exemplo.com', 'HashSenha@1023'),
  ('Patricia Dias', 'patricia.dias24@exemplo.com', 'HashSenha@1024'),
  ('Henrique Mendes', 'henrique.mendes25@exemplo.com', 'HashSenha@1025'),
  ('Vanessa Ferreira', 'vanessa.ferreira26@exemplo.com', 'HashSenha@1026'),
  ('Vitor Martins', 'vitor.martins27@exemplo.com', 'HashSenha@1027'),
  ('Juliana Barbosa', 'juliana.barbosa28@exemplo.com', 'HashSenha@1028'),
  ('Daniel Marques', 'daniel.marques29@exemplo.com', 'HashSenha@1029'),
  ('Bianca Souza', 'bianca.souza30@exemplo.com', 'HashSenha@1030'),
  ('Andre Costa', 'andre.costa31@exemplo.com', 'HashSenha@1031'),
  ('Natalia Fernandes', 'natalia.fernandes32@exemplo.com', 'HashSenha@1032'),
  ('Caio Moreira', 'caio.moreira33@exemplo.com', 'HashSenha@1033'),
  ('Priscila Santos', 'priscila.santos34@exemplo.com', 'HashSenha@1034'),
  ('Rodrigo Lima', 'rodrigo.lima35@exemplo.com', 'HashSenha@1035'),
  ('Tatiane Lopes', 'tatiane.lopes36@exemplo.com', 'HashSenha@1036'),
  ('Murilo Nascimento', 'murilo.nascimento37@exemplo.com', 'HashSenha@1037'),
  ('Aline Freitas', 'aline.freitas38@exemplo.com', 'HashSenha@1038'),
  ('Guilherme Alves', 'guilherme.alves39@exemplo.com', 'HashSenha@1039'),
  ('Renata Carvalho', 'renata.carvalho40@exemplo.com', 'HashSenha@1040'),
  ('Samuel Rocha', 'samuel.rocha41@exemplo.com', 'HashSenha@1041'),
  ('Monica Machado', 'monica.machado42@exemplo.com', 'HashSenha@1042'),
  ('Enzo Rodrigues', 'enzo.rodrigues43@exemplo.com', 'HashSenha@1043'),
  ('Paula Ribeiro', 'paula.ribeiro44@exemplo.com', 'HashSenha@1044'),
  ('Arthur Vieira', 'arthur.vieira45@exemplo.com', 'HashSenha@1045'),
  ('Roberta Nunes', 'roberta.nunes46@exemplo.com', 'HashSenha@1046'),
  ('Bernardo Oliveira', 'bernardo.oliveira47@exemplo.com', 'HashSenha@1047'),
  ('Sabrina Gomes', 'sabrina.gomes48@exemplo.com', 'HashSenha@1048'),
  ('Davi Soares', 'davi.soares49@exemplo.com', 'HashSenha@1049'),
  ('Helena Andrade', 'helena.andrade50@exemplo.com', 'HashSenha@1050'),
  ('Heitor Silva', 'heitor.silva51@exemplo.com', 'HashSenha@1051'),
  ('Lorena Pereira', 'lorena.pereira52@exemplo.com', 'HashSenha@1052'),
  ('Nicolas Almeida', 'nicolas.almeida53@exemplo.com', 'HashSenha@1053'),
  ('Clara Dias', 'clara.dias54@exemplo.com', 'HashSenha@1054'),
  ('Lucca Mendes', 'lucca.mendes55@exemplo.com', 'HashSenha@1055'),
  ('Melissa Ferreira', 'melissa.ferreira56@exemplo.com', 'HashSenha@1056'),
  ('Otavio Martins', 'otavio.martins57@exemplo.com', 'HashSenha@1057'),
  ('Rebeca Barbosa', 'rebeca.barbosa58@exemplo.com', 'HashSenha@1058'),
  ('Caua Marques', 'caua.marques59@exemplo.com', 'HashSenha@1059'),
  ('Cecilia Souza', 'cecilia.souza60@exemplo.com', 'HashSenha@1060'),
  ('Yuri Costa', 'yuri.costa61@exemplo.com', 'HashSenha@1061'),
  ('Sofia Fernandes', 'sofia.fernandes62@exemplo.com', 'HashSenha@1062'),
  ('Breno Moreira', 'breno.moreira63@exemplo.com', 'HashSenha@1063'),
  ('Vitoria Santos', 'vitoria.santos64@exemplo.com', 'HashSenha@1064'),
  ('Joao Lima', 'joao.lima65@exemplo.com', 'HashSenha@1065'),
  ('Alice Lopes', 'alice.lopes66@exemplo.com', 'HashSenha@1066'),
  ('Vinicius Nascimento', 'vinicius.nascimento67@exemplo.com', 'HashSenha@1067'),
  ('Laura Freitas', 'laura.freitas68@exemplo.com', 'HashSenha@1068'),
  ('Fernando Alves', 'fernando.alves69@exemplo.com', 'HashSenha@1069'),
  ('Valentina Carvalho', 'valentina.carvalho70@exemplo.com', 'HashSenha@1070'),
  ('Marcelo Rocha', 'marcelo.rocha71@exemplo.com', 'HashSenha@1071'),
  ('Luana Machado', 'luana.machado72@exemplo.com', 'HashSenha@1072'),
  ('Ricardo Rodrigues', 'ricardo.rodrigues73@exemplo.com', 'HashSenha@1073'),
  ('Elaine Ribeiro', 'elaine.ribeiro74@exemplo.com', 'HashSenha@1074'),
  ('Alex Vieira', 'alex.vieira75@exemplo.com', 'HashSenha@1075'),
  ('Simone Nunes', 'simone.nunes76@exemplo.com', 'HashSenha@1076'),
  ('Igor Oliveira', 'igor.oliveira77@exemplo.com', 'HashSenha@1077'),
  ('Debora Gomes', 'debora.gomes78@exemplo.com', 'HashSenha@1078'),
  ('Alan Soares', 'alan.soares79@exemplo.com', 'HashSenha@1079'),
  ('Cristina Andrade', 'cristina.andrade80@exemplo.com', 'HashSenha@1080'),
  ('Wesley Silva', 'wesley.silva81@exemplo.com', 'HashSenha@1081'),
  ('Andrea Pereira', 'andrea.pereira82@exemplo.com', 'HashSenha@1082'),
  ('Leandro Almeida', 'leandro.almeida83@exemplo.com', 'HashSenha@1083'),
  ('Adriana Dias', 'adriana.dias84@exemplo.com', 'HashSenha@1084'),
  ('Fabricio Mendes', 'fabricio.mendes85@exemplo.com', 'HashSenha@1085'),
  ('Carla Ferreira', 'carla.ferreira86@exemplo.com', 'HashSenha@1086'),
  ('Ruan Martins', 'ruan.martins87@exemplo.com', 'HashSenha@1087'),
  ('Daniela Barbosa', 'daniela.barbosa88@exemplo.com', 'HashSenha@1088'),
  ('Cesar Marques', 'cesar.marques89@exemplo.com', 'HashSenha@1089'),
  ('Viviane Souza', 'viviane.souza90@exemplo.com', 'HashSenha@1090');
  
  INSERT INTO avaliacao (nota, descricao, dataPublicacao, recomendado, assistido, fkPersonagem, fkUsuario) VALUES
  (5.0, NULL, '2025-01-01 09:00:00', 1, 1, 4, 74),
  (5.0, NULL, '2025-01-02 10:11:00', 1, 1, 3, 71),
  (4.0, 'Neil Perry só queria ser livre para escolher o próprio caminho.', '2025-01-03 11:22:00', 1, 1, 2, 50),
  (4.0, NULL, '2025-01-04 12:33:00', 1, 1, 1, 88),
  (5.0, 'Knox Overstreet arriscando tudo pelo que sente dá um toque romântico muito genuíno.', '2025-01-05 13:44:00', 1, 1, 4, 26),
  (4.5, NULL, '2025-01-06 14:55:00', 1, 1, 7, 34),
  (4.0, NULL, '2025-01-07 15:06:00', 1, 0, 1, 37),
  (4.0, NULL, '2025-01-08 16:17:00', 1, 1, 2, 7),
  (4.0, 'A atuação do Neil como Puck mostra o quanto ele nasceu para os palcos.', '2025-01-09 17:28:00', 1, 1, 2, 58),
  (3.5, NULL, '2025-01-10 18:39:00', 0, 1, 2, 8),
  (5.0, 'A timidez do Todd no início torna o desfecho dele ainda mais poderoso.', '2025-02-11 19:50:00', 1, 1, 3, 29),
  (4.0, NULL, '2025-02-12 20:01:00', 1, 1, 1, 55),
  (4.0, 'Não vi o filme completo ainda, avaliando pela expectativa altíssima e pelo elenco.', '2025-02-13 21:12:00', 1, 0, NULL, 47),
  (4.0, NULL, '2025-02-14 09:23:00', 1, 0, 2, 28),
  (4.5, 'Comecei a ver trechos na aula de literatura, preciso terminar esse clássico urgente.', '2025-02-15 10:34:00', 1, 0, 3, 90),
  (5.0, 'As aulas do Keating transformam literatura em algo vivo e urgente.', '2025-02-16 11:45:00', 1, 1, 1, 32),
  (5.0, 'Todd saiu da sombra do irmão mais velho para escrever a própria história.', '2025-02-17 12:56:00', 1, 1, 3, 71),
  (5.0, 'O Capitão, meu Capitão! Difícil esquecer o impacto do Keating naquela turma.', '2025-02-18 13:07:00', 1, 1, 1, 76),
  (5.0, 'Todd Anderson é o verdadeiro coração do filme, começa calado e termina liderando a despedida.', '2025-02-19 14:18:00', 1, 1, 3, 15),
  (5.0, NULL, '2025-02-20 15:29:00', 1, 1, 3, 61),
  (5.0, 'Todd Anderson tem o arco mais emocionante do filme; ver ele superando a timidez é lindo.', '2025-03-21 16:40:00', 1, 1, 3, 77),
  (5.0, 'A fotografia de outono e a trilha sonora elevam cada cena dramática.', '2025-03-22 17:51:00', 1, 1, 4, 75),
  (4.5, NULL, '2025-03-23 18:02:00', 1, 1, 8, 13),
  (4.5, NULL, '2025-03-24 19:13:00', 1, 0, 2, 39),
  (4.0, NULL, '2025-03-25 20:24:00', 1, 1, 2, 42),
  (3.5, NULL, '2025-03-26 21:35:00', 0, 1, 2, 63),
  (4.0, NULL, '2025-03-27 09:46:00', 1, 1, 1, 40),
  (5.0, 'Impossível não se identificar com a insegurança do Todd e torcer por cada passo dele.', '2025-03-28 10:57:00', 1, 1, 3, 19),
  (5.0, 'John Keating inspira sem precisar impor autoridade pelo medo.', '2025-03-01 11:08:00', 1, 1, 1, 51),
  (5.0, NULL, '2025-03-02 12:19:00', 1, 1, 3, 85),
  (5.0, NULL, '2025-04-03 13:30:00', 1, 1, 3, 84),
  (5.0, 'Meeks e Pitts trazem leveza e companheirismo verdadeiro ao grupo.', '2025-04-04 14:41:00', 1, 1, 7, 45),
  (5.0, NULL, '2025-04-05 15:52:00', 1, 1, 5, 38),
  (5.0, NULL, '2025-04-06 16:03:00', 1, 1, 5, 19),
  (5.0, 'Meu personagem favorito sem dúvida é o Todd Anderson, evolução impecável.', '2025-04-07 17:14:00', 1, 1, 3, 48),
  (5.0, NULL, '2025-04-08 18:25:00', 1, 1, 3, 7),
  (5.0, 'A cena rasgando a introdução do livro de poesia é simplesmente genial.', '2025-04-09 19:36:00', 1, 1, 1, 79),
  (5.0, NULL, '2025-04-10 20:47:00', 1, 1, 5, 83),
  (4.0, NULL, '2025-04-11 21:58:00', 1, 1, 1, 34),
  (4.5, NULL, '2025-04-12 09:09:00', 1, 1, 8, 84),
  (5.0, NULL, '2025-05-13 10:20:00', 1, 1, 3, 65),
  (5.0, NULL, '2025-05-14 11:31:00', 1, 1, 3, 87),
  (5.0, 'Carpe diem! John Keating é o professor que todo estudante merecia ter na vida.', '2025-05-15 12:42:00', 1, 1, 1, 16),
  (5.0, 'Todd Anderson prova que até os mais quietos carregam uma tempestade poética dentro de si.', '2025-05-16 13:53:00', 1, 1, 3, 43),
  (4.0, NULL, '2025-05-17 14:04:00', 1, 1, 2, 24),
  (5.0, NULL, '2025-05-18 15:15:00', 1, 1, 5, 73),
  (4.0, 'O talento e a paixão do Neil pelo teatro partem o coração diante de tanta repressão.', '2025-05-19 16:26:00', 1, 1, 2, 44),
  (4.0, NULL, '2025-05-20 17:37:00', 1, 1, 1, 72),
  (4.0, NULL, '2025-05-21 18:48:00', 1, 1, 2, 5),
  (5.0, NULL, '2025-05-22 19:59:00', 1, 1, 3, 3),
  (4.0, NULL, '2025-06-23 20:10:00', 1, 1, 2, 25),
  (4.0, NULL, '2025-06-24 21:21:00', 1, 1, 1, 53),
  (4.0, NULL, '2025-06-25 09:32:00', 1, 1, 1, 41),
  (5.0, NULL, '2025-06-26 10:43:00', 1, 1, 3, 68),
  (4.5, 'Chorei muito com a reação do Todd no final, atuação absurdamente sensível.', '2025-06-27 11:54:00', 1, 1, 3, 42),
  (5.0, 'Todd Anderson representa quem finalmente encontra a própria voz no meio da pressão.', '2026-06-28 12:05:00', 1, 1, 3, 27),
  (4.0, 'Atuação inesquecível de Robin Williams como um mentor humano e corajoso.', '2026-06-01 13:16:00', 1, 1, 1, 22),
  (4.0, 'A história do Neil é um alerta doloroso sobre expectativas sufocantes dentro de casa.', '2026-06-02 14:27:00', 1, 1, 2, 36),
  (4.0, NULL, '2026-06-03 15:38:00', 1, 1, 1, 67),
  (4.0, NULL, '2026-06-04 16:49:00', 1, 1, 1, 82),
  (4.0, 'Robert Sean Leonard dá um carisma enorme ao Neil Perry.', '2026-07-05 17:00:00', 1, 1, 2, 31),
  (5.0, NULL, '2026-07-06 18:11:00', 1, 1, 3, 17),
  (5.0, NULL, '2026-07-07 19:22:00', 1, 1, 3, 21),
  (3.5, 'Um clássico atemporal sobre amizade, arte e coragem de ser autêntico.', '2026-07-08 20:33:00', 0, 1, 5, 4),
  (5.0, NULL, '2026-07-09 21:44:00', 1, 1, 3, 52),
  (4.0, NULL, '2026-07-10 09:55:00', 1, 0, NULL, 10),
  (5.0, 'Ethan Hawke está impecável como Todd Anderson, cada expressão diz mais que mil palavras.', '2026-07-11 10:06:00', 1, 1, 3, 89),
  (5.0, 'A amizade entre Todd e Neil transforma completamente a forma como ele enxerga o mundo.', '2026-07-12 11:17:00', 1, 1, 3, 86),
  (3.5, 'A rebeldia do Charlie traz energia e ousadia para a Sociedade dos Poetas Mortos.', '2026-07-13 12:28:00', 0, 1, 5, 78),
  (4.5, 'Não assisti ainda, mas já admiro muito a proposta do filme e o elenco.', '2026-07-14 13:39:00', 1, 0, 3, 11),
  (4.5, NULL, '2026-08-15 14:50:00', 1, 1, 8, 12),
  (4.0, NULL, '2026-08-16 15:01:00', 1, 1, 1, 80),
  (5.0, NULL, '2026-08-17 16:12:00', 1, 1, 3, 66),
  (3.5, NULL, '2026-08-18 17:23:00', 0, 1, 5, 9),
  (3.5, NULL, '2026-08-19 18:34:00', 0, 0, 1, 14),
  (4.5, 'A atmosfera da Academia Welton contrasta perfeitamente com as reuniões na caverna.', '2026-08-20 19:45:00', 1, 1, 7, 1),
  (3.5, 'Charlie Dalton não tem medo de enfrentar o sistema, mesmo pagando caro por isso.', '2026-08-21 20:56:00', 0, 1, 5, 54),
  (4.5, 'Escolha polêmica: o arco do Richard Cameron mostra como o medo revela o lado mais fraco das pessoas.', '2026-08-22 21:07:00', 1, 1, 6, 56),
  (4.0, NULL, '2026-08-23 09:18:00', 1, 1, 1, 35),
  (4.0, 'Ainda não consegui assistir inteiro, mas pelas cenas e comentários já sei que é obra-prima.', '2026-08-24 10:29:00', 1, 0, NULL, 46),
  (5.0, 'Roteiro sensível que faz rir na primeira metade e emocionar profundamente no final.', '2026-09-25 11:40:00', 1, 1, 4, 33),
  (5.0, NULL, '2026-09-26 12:51:00', 1, 1, 3, 3),
  (5.0, NULL, '2026-09-27 13:02:00', 1, 1, 4, 25),
  (5.0, NULL, '2026-09-28 14:13:00', 1, 1, 4, 59),
  (5.0, NULL, '2026-09-01 15:24:00', 1, 1, 4, 18),
  (5.0, 'Subir na carteira primeiro exige uma coragem gigantesca — Todd merece todo o destaque.', '2026-09-02 16:35:00', 1, 1, 3, 2),
  (5.0, 'O desenvolvimento do Todd ao longo das aulas do Keating é o ponto alto da narrativa.', '2026-09-03 17:46:00', 1, 1, 3, 6),
  (4.5, 'Kurtwood Smith entrega uma atuação marcante como Mr. Perry, essencial para o peso trágico da história.', '2026-09-04 18:57:00', 1, 1, 10, 60),
  (5.0, 'Keating ensina a pensar por conta própria em um ambiente feito para moldar robôs.', '2026-09-05 19:08:00', 1, 1, 1, 49),
  (5.0, 'Robin Williams entrega uma atuação histórica, equilibrando humor e profundidade.', '2026-09-06 20:19:00', 1, 1, 1, 57),
  (4.0, NULL, '2026-10-07 21:30:00', 1, 1, 2, 69),
  (4.0, NULL, '2026-10-08 09:41:00', 1, 1, 2, 20),
  (4.0, 'Keating mostra que medicina e direito sustentam a vida, mas poesia é o motivo de viver.', '2026-10-09 10:52:00', 1, 1, 1, 23),
  (4.0, 'Ainda na minha lista para assistir esse fim de semana, todo mundo recomenda demais.', '2026-10-10 11:03:00', 1, 0, 3, 62),
  (5.0, 'A cena em que Todd improvisa o poema com os olhos fechados me arrepiou inteiro.', '2026-10-11 12:14:00', 1, 1, 3, 70),
  (4.5, 'Como antagonista, o Sr. Nolan impõe respeito e representa perfeitamente o rigor tradicional de Welton.', '2026-10-12 13:25:00', 1, 1, 9, 30),
  (4.0, NULL, '2026-10-13 14:36:00', 1, 1, 1, 12),
  (4.0, NULL, '2026-10-14 15:47:00', 1, 0, 5, 81),
  (5.0, NULL, '2026-10-15 16:58:00', 1, 1, 3, 58),
  (4.5, 'Falta só arrumar um tempo livre para assistir do início ao fim.', '2026-10-16 17:09:00', 1, 0, 1, 64);
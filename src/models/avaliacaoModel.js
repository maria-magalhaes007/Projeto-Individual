var database = require("../database/config");

// Dados dash de KPI nota média
function buscarFavoritoKpi() {
  var instrucaoSql = `
    SELECT p.nome AS nome, COUNT(p.id) AS totalVotos
    FROM avaliacao a
    JOIN personagem p ON a.fkPersonagem = p.id
    GROUP BY p.nome, p.id
    ORDER BY totalVotos DESC
    LIMIT 1;
  `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// Dados dash de KPI assistidos
function buscarTotalAssitidosKpi() {
    var instrucaoSql = `
      SELECT COUNT(assistido) AS 'totalAssistidos' FROM avaliacao WHERE assistido = TRUE;`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// Dados dash de KPI nota média
function buscarNotaMediaKpi() {
    var instrucaoSql = `
      SELECT TRUNCATE(AVG(nota), 1) AS 'notaMedia' FROM avaliacao; `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// buscar comentários
function buscarComentarioUsuario() {

  var instrucaoSql = `
  SELECT
    a.id AS idAvaliacao,
    a.nota,
    CASE 
      WHEN a.descricao IS NULL THEN ''
          else a.descricao
    END descricao,
    a.assistido,
    a.recomendado,
    a.dataPublicacao,
    u.nome AS nomeUsuario
  FROM avaliacao a
  JOIN usuario u ON a.fkUsuario = u.id
  ORDER BY a.dataPublicacao DESC;`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// usada no gráfico
// Monta o comando SQL e manda para o MySQL através do database.executar. 
// O ${idUsuario} é substituído pelo número do usuário logado,
function buscarNotasParaGrafico() {
  var instrucaoSql = `
    SELECT nota, COUNT(*) AS quantidade
    FROM avaliacao
    GROUP BY nota
    ORDER BY nota DESC;`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// Dados dash de % recomendado
function buscarRecomendadoParaGrafico() {
  var instrucaoSql = `
    SELECT * FROM vw_filme_recomendado`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// usada no cadastro
function cadastrar(nota, assistido, descricao, recomendado, fkPersonagem, fkUsuario) {
  
  var instrucaoSql = `
      INSERT INTO avaliacao
      (nota, assistido, descricao, recomendado, fkPersonagem, fkUsuario)
      VALUES
      (${nota}, ${assistido}, '${descricao}', ${recomendado}, ${fkPersonagem}, ${fkUsuario})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarNotasParaGrafico,
  buscarRecomendadoParaGrafico,
  buscarNotaMediaKpi,
  buscarComentarioUsuario,
  buscarTotalAssitidosKpi,
  buscarFavoritoKpi,
  cadastrar
}

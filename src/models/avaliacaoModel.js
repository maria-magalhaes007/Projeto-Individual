var database = require("../database/config");

// usada no login
function buscarNotasParaGrafico(usuarioId) {

  var instrucaoSql = `SELECT * FROM avaliacao a WHERE fkUsuario = ${usuarioId}`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarComentarioUsuario() {

  var instrucaoSql = `
    SELECT c.descricao FROM avaliacao a JOIN comentario c ON a.fkComentario = c.id;`;

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

// Dados dash de KPI nota média
function buscarNotaMediaKpi() {
    var instrucaoSql = `
      SELECT TRUNCATE(AVG(nota), 1) AS 'notaMedia' FROM avaliacao; `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// usada no cadastro
function cadastrar(nota, fkComentario, assistido, recomendado, fkPersonagem, fkUsuario) {

  var instrucaoSql = `INSERT INTO avaliacao (nota, fkComentario, assistido, recomendado, fkPersonagem, fkUsuario) VALUES (${nota}, '${fkComentario}', ${assistido}, ${recomendado},${fkPersonagem}, ${fkUsuario})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarNotasParaGrafico,
  buscarRecomendadoParaGrafico,
  buscarNotaMediaKpi,
  buscarComentarioUsuario,
  cadastrar
}

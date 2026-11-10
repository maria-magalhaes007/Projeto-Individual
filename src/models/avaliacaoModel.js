var database = require("../database/config");

// usada no login
function buscarNotasParaGrafico(usuarioId) {

  var instrucaoSql = `SELECT * FROM avaliacao a WHERE fkUsuario = ${usuarioId}`;

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

function buscarRecomendadoParaGrafico() {
    var instrucaoSql = `
      SELECT * FROM vw_filme_recomendaria`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// usada no cadastro
function cadastrar(nota, descricao, assistido, recomendado, fkPersonagem, fkUsuario) {

  var instrucaoSql = `INSERT INTO avaliacao (nota, descricao, assistido, recomendado, fkPersonagem, fkUsuario) VALUES (${nota}, '${descricao}', ${assistido}, ${recomendado},${fkPersonagem}, ${fkUsuario})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarNotasParaGrafico,
  buscarRecomendadoParaGrafico,
  cadastrar
}

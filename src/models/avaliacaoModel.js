var database = require("../database/config");

function buscarAvaliacaoPorUsuario(usuarioId) {

  var instrucaoSql = `SELECT * FROM avaliacao a WHERE fkUsuario = ${usuarioId}`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(nota, descricao, assistido, fkPersonagem, fkUsuario) {

  var instrucaoSql = `INSERT INTO avaliacao (nota, descricao, assistido, fkPersonagem, fkUsuario) VALUES (${nota}, '${descricao}', ${assistido}, ${fkPersonagem}, ${fkUsuario})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarAvaliacaoPorUsuario,
  cadastrar
}

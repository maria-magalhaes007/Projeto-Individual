var avaliacaoModel = require("../models/avaliacaoModel");

function buscarComentarioUsuario(req, res) {
  var idUsuario = req.params.idUsuario;

  avaliacaoModel.buscarComentarioUsuario(idUsuario).then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } 
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar as avaliações de Recomendados: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}

function buscarNotaMediaKpi(req, res) {
  var idUsuario = req.params.idUsuario;

  avaliacaoModel.buscarNotaMediaKpi(idUsuario).then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } 
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar as avaliações de Recomendados: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}

function buscarRecomendadoParaGrafico(req, res) {
  var idUsuario = req.params.idUsuario;

  avaliacaoModel.buscarRecomendadoParaGrafico(idUsuario).then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } 
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar as avaliações de Recomendados: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}

function buscarNotasParaGrafico(req, res) {
  var idUsuario = req.params.idUsuario;

  avaliacaoModel.buscarNotasParaGrafico(idUsuario).then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } 
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar as avaliações: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}

function cadastrar(req, res) {
  var nota = req.body.nota;
  var fkComentario = req.body.fkComentario;
  var assistido = req.body.assistido;
  var recomendado = req.body.recomendado;
  var fkPersonagem = req.body.fkPersonagem;
  var fkUsuario = req.body.fkUsuario;

  if (nota == undefined) {
    res.status(400).send("nota está undefined!");
  } else if (fkUsuario == undefined) {
    res.status(400).send("fkUsuario está undefined!");
  } else {

    avaliacaoModel.cadastrar(nota, fkComentario, assistido, recomendado, fkPersonagem, fkUsuario)
      .then((resultado) => {
        res.status(201).json(resultado);
      }
      ).catch((erro) => {
        console.log(erro);
        console.log(
          "\nHouve um erro ao realizar o cadastro! Erro: ",
          erro.sqlMessage
        );
        res.status(500).json(erro.sqlMessage);
      });
  }
}

module.exports = {
  buscarNotasParaGrafico,
  buscarRecomendadoParaGrafico,
  buscarNotaMediaKpi,
  buscarComentarioUsuario,
  cadastrar
}
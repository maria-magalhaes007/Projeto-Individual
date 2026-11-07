var avaliacaoModel = require("../models/avaliacaoModel");

function buscarAvaliacaoPorUsuario(req, res) {
  var idUsuario = req.params.idUsuario;

  avaliacaoModel.buscarAvaliacaoPorUsuario(idUsuario).then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar as avaliações: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}


function cadastrar(req, res) {
  var nota = req.body.nota;
  var descricao = req.body.descricao;
  var assistido = req.body.assistido;
  var fkPersonagem = req.body.fkPersonagem;
  var fkUsuario = req.body.fkUsuario;

  if (nota == undefined) {
    res.status(400).send("nota está undefined!");
  } else if (fkUsuario == undefined) {
    res.status(400).send("fkUsuario está undefined!");
  } else {

    avaliacaoModel.cadastrar(nota, descricao, assistido, fkPersonagem, fkUsuario)
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
  buscarAvaliacaoPorUsuario,
  cadastrar
}
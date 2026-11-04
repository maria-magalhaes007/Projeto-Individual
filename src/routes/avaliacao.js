var express = require("express");
var router = express.Router();

var avaliacaoController = require("../controllers/avaliacaoController");

router.get("/:usuarioId", function (req, res) {
  avaliacaoController.buscarAvaliacaoPorUsuario(req, res);
});

router.post("/cadastrar", function (req, res) {
  avaliacaoController.cadastrar(req, res);
});

module.exports = router;
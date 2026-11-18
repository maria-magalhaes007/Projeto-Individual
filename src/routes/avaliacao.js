var express = require("express");
var router = express.Router();

var avaliacaoController = require("../controllers/avaliacaoController");

router.get("/kpi/notaMedia", function (req, res) {
  avaliacaoController.buscarNotaMediaKpi(req, res);
});

router.get("/grafico/recomendacao", function (req, res) {
  avaliacaoController.buscarRecomendadoParaGrafico(req, res);
});

router.get("/grafico/notas", function (req, res) {
  avaliacaoController.buscarNotasParaGrafico(req, res);
});

router.post("/cadastrar", function (req, res) {
  avaliacaoController.cadastrar(req, res);
});

router.get("/comentarios", function (req, res) {
    avaliacaoController.buscarComentarioUsuario(req, res);
});

module.exports = router;
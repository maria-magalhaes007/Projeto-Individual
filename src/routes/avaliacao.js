var express = require("express");
var router = express.Router();

var avaliacaoController = require("../controllers/avaliacaoController");

router.get("/kpi/favorito", function (req, res) {
  avaliacaoController.buscarFavoritoKpi(req, res);
});

router.get("/kpi/totalAssistidos", function (req, res) {
  avaliacaoController.buscarTotalAssitidosKpi(req, res);
});

router.get("/kpi/notaMedia", function (req, res) {
  avaliacaoController.buscarNotaMediaKpi(req, res);
});

router.get("/grafico/recomendacao", function (req, res) {
  avaliacaoController.buscarRecomendadoParaGrafico(req, res);
});

router.get("/grafico/notas", function (req, res) {
  avaliacaoController.buscarNotasParaGrafico(req, res);
});

router.post("/cadastrarAvaliacao", function (req, res) {
    avaliacaoController.cadastrarAvaliacao(req, res);
});

router.get("/comentarios", function (req, res) {
    avaliacaoController.buscarComentarioUsuario(req, res);
});

module.exports = router;
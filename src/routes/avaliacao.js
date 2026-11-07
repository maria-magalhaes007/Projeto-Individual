var express = require("express");
var router = express.Router();

var avaliacaoController = require("../controllers/avaliacaoController");

router.get("/grafico", function (req, res) {
  avaliacaoController.buscarNotasParaGrafico(req, res);
});

router.post("/cadastrar", function (req, res) {
  avaliacaoController.cadastrar(req, res);
});

router.get("/:usuarioId", function (req, res) {
  avaliacaoController.buscarNotasParaGrafico(req, res);
}); // pq /:usuario fica em baixo??


module.exports = router;
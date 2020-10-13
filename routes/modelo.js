const express = require('express');
const router = express.Router();

const modeloController = require('../controllers/modelo.controller');

router.get('/cargar', modeloController.loadData);
router.get('/eliminar', modeloController.delete);

module.exports = router;
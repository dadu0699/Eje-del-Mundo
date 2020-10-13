const express = require('express');
const router = express.Router();

const temporalController = require('../controllers/temporal.controller');

router.get('/crear', temporalController.create);
router.get('/cargar', temporalController.loadData);
router.get('/obtener', temporalController.getData);
router.get('/eliminar', temporalController.delete);

module.exports = router;
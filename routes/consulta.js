const express = require('express');
const router = express.Router();

const consultaController = require('../controllers/consulta.controller');

router.get('/1', consultaController.consulta1);
router.get('/2', consultaController.consulta2);
router.get('/3', consultaController.consulta3);
router.get('/4', consultaController.consulta4);
router.get('/5', consultaController.consulta5);
router.get('/6', consultaController.consulta6);
router.get('/7', consultaController.consulta7);
router.get('/8', consultaController.consulta8);
router.get('/9', consultaController.consulta9);
router.get('/10', consultaController.consulta10);

module.exports = router;
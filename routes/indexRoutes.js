const express = require('express');
const router = express.Router();

const temporalController = require('../controllers/temporal.controller');
const modeloController = require('../controllers/modelo.controller');
const consultaController = require('../controllers/consulta.controller');

router.get('/', (req, res) => {
    res.send({
        Carnet: '201801266',
        Nombre: 'Didier Domìnguez',
        Curso: 'Manejo e Implementación de Archivos'
    });
});

router.get('/crearTemporal', temporalController.create);
router.get('/cargarTemporal', temporalController.loadData);
router.get('/obtenerTemporal', temporalController.getData);
router.get('/eliminarTemporal', temporalController.delete);

router.get('/cargarModelo', modeloController.loadData);
router.get('/eliminarModelo', modeloController.delete);

router.get('/consulta1', consultaController.consulta1);
router.get('/consulta2', consultaController.consulta2);
router.get('/consulta3', consultaController.consulta3);

router.get('/consulta5', consultaController.consulta5);
router.get('/consulta6', consultaController.consulta6);
router.get('/consulta7', consultaController.consulta7);

module.exports = router;
const express = require('express');
const router = express.Router();

const compainaController = require('../controllers/compania.controller');
const temporalController = require('../controllers/temporal.controller');
const modeloController = require('../controllers/modelo.controller');

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

router.get('/compania', compainaController.getAll);
router.post('/compania', compainaController.create);

module.exports = router;
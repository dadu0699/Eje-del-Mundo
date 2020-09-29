const express = require('express');
const router = express.Router();

const compainaController = require('../controllers/compania.controller');
const temporalController = require('../controllers/temporal.controller');

router.get('/', (req, res, next) => {
    res.send({
        title: 'Express'
    });
});

router.get('/crearTemporal', temporalController.create);
router.get('/cargarTemporal', temporalController.loadData);
router.get('/obtenerTemporal', temporalController.getData);
router.get('/eliminarTemporal', temporalController.delete);

router.get('/compania', compainaController.getAll);
router.post('/compania', compainaController.create);

module.exports = router;
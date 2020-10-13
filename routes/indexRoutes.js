const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    res.send({
        Carnet: '201801266',
        Nombre: 'Didier Domìnguez',
        Curso: 'Manejo e Implementación de Archivos'
    });
});

module.exports = router;
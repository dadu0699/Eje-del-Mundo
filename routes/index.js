const express = require('express');
const router = express.Router();

const compainaController = require('../controllers/compania.controller');

router.get('/', (req, res, next) => {
    res.send({
        title: 'Express'
    });
});
module.exports = router;
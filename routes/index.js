const express = require('express');
const router = express.Router();

const compainaController = require('../controllers/compania.controller');

router.get('/', (req, res, next) => {
    res.send({
        title: 'Express'
    });
});

router.get('/compania', compainaController.getAll);
router.post('/compania', compainaController.create);

module.exports = router;
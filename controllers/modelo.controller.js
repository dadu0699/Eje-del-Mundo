const modelo = require('../models/modelo');

const modeloController = {
    loadData: (req, res) => {
        modelo.loadData((err, results) => {
            if (err) {
                res.status(500).send(err);
                return;
            }
            res.status(200).send({
                code: '200',
                data: results
            });
        });
    },

    delete: (req, res) => {
        modelo.delete((err, results) => {
            if (err) {
                res.status(500).send(err);
                return;
            }
            res.status(200).send({
                code: '200',
                data: results
            });
        });
    }
};

module.exports = modeloController;
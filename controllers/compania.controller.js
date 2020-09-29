const compania = require('../models/compania');

const companiaController = {
    create: (req, res) => {
        compania.create(req.body, (err, results) => {
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

    getAll: (req, res) => {
        compania.getAll((err, results) => {
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

module.exports = companiaController;
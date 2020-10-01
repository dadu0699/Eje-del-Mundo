const consultas = require('../models/consulta');

const consultasController = {
    consulta1: (req, res) => {
        consultas.consulta1((err, results) => {
            if (err) {
                res.status(500).send(err);
                return;
            }
            res.status(200).send({
                code: '200',
                data: results[0]
            });
        });
    },
    consulta2: (req, res) => {
        consultas.consulta2((err, results) => {
            if (err) {
                res.status(500).send(err);
                return;
            }
            res.status(200).send({
                code: '200',
                data: results[0]
            });
        });
    },
    consulta3: (req, res) => {
        consultas.consulta3((err, results) => {
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



    consulta5: (req, res) => {
        consultas.consulta5((err, results) => {
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
    consulta6: (req, res) => {
        consultas.consulta6((err, results) => {
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
    consulta7: (req, res) => {
        consultas.consulta7((err, results) => {
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

module.exports = consultasController;
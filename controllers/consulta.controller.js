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
    consulta61: (req, res) => {
        consultas.consulta61((err, results) => {
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
    },
    consulta8: (req, res) => {
        consultas.consulta8((err, results) => {
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
    consulta9: (req, res) => {
        consultas.consulta9((err, results) => {
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
    consulta10: (req, res) => {
        consultas.consulta10((err, results) => {
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
    consulta4: (req, res) => {
        consultas.consulta4((err, results) => {
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
    consulta41: (req, res) => {
        consultas.consulta41((err, results) => {
            if (err) {
                res.status(500).send(err);
                return;
            }
            res.status(200).send({
                code: '200',
                title: 'DETALLES DE ORDENES SOLO CON MARCA Cheese',
                data: results
            });
        });
    },
    consulta42: (req, res) => {
        consultas.consulta42((err, results) => {
            if (err) {
                res.status(500).send(err);
                return;
            }
            res.status(200).send({
                code: '200',
                title: 'CLIENTES QUE COMPRARON MAS PRODUCTOS DE LA MARCA Cheese',
                data: results
            });
        });
    },
    consulta43: (req, res) => {
        consultas.consulta43((err, results) => {
            if (err) {
                res.status(500).send(err);
                return;
            }
            res.status(200).send({
                code: '200',
                title: 'CLIENTES QUE COMPRARON PRODCUTOS DE LA MARCA Cheese',
                data: results
            });
        });
    }
};

module.exports = consultasController;
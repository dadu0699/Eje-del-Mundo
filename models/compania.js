const mysqlConnection = require('../config/database');

const compania = {
    executeQuery(query, callback) {
        mysqlConnection.query(query, (err, res) => callback(err, res));
    },

    create(params, callback) {
        const {
            nombre,
            contacto,
            correo,
            telefono,
        } = params;
        const query = `INSERT INTO Compania (nombre, contacto, correo, telefono) 
            VALUES ("${nombre}", "${contacto}", "${correo}", "${telefono}");`;
        return this.executeQuery(query, callback);
    },

    getAll(callback) {
        const query = 'SELECT * FROM Compania;'
        return this.executeQuery(query, callback);
    }
};

module.exports = compania;
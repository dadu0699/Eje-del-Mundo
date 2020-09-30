const mysqlConnection = require('../config/database');

const temporal = {
    executeQuery(query, callback) {
        mysqlConnection.query(query, (err, res) => callback(err, res));
    },

    create(callback) {
        const query = `CREATE TEMPORARY TABLE Temporal(
            nombreCompania VARCHAR(255) NOT NULL,
            contactoCompania VARCHAR(255) NOT NULL,
            correoCompania VARCHAR(255) NOT NULL,
            telefonoCompania VARCHAR(255) NOT NULL,
            tipo CHAR(1) NOT NULL,
            nombre VARCHAR(255) NOT NULL,
            correo VARCHAR(255) NOT NULL,
            telefono VARCHAR(255) NOT NULL,
            fechaRegistro DATE NOT NULL,
            direccion VARCHAR(255) NOT NULL,
            ciudad VARCHAR(255) NOT NULL,
            codigoPostal INT NOT NULL,
            region VARCHAR(255) NOT NULL,
            producto VARCHAR(255) NOT NULL,
            categoriaProducto VARCHAR(255) NOT NULL,
            cantidad INT NOT NULL,
            precio DECIMAL(10,2) NOT NULL DEFAULT 0
          );`;
        return this.executeQuery(query, callback);
    },

    loadData(callback) {
        // SET GLOBAL local_infile=1;
        const query = `LOAD DATA LOCAL INFILE '/home/didier/ProyectosNodejs/Eje-del-Mundo/data/DataCenterData.csv'
            INTO TABLE Temporal
            CHARACTER SET latin1
            FIELDS TERMINATED BY ';'
            LINES TERMINATED BY '\\r\\n'
            IGNORE 1 LINES
            (nombreCompania, contactoCompania, correoCompania, telefonoCompania, tipo, nombre, correo, telefono, @varfecha, direccion, ciudad, codigoPostal, region, producto, categoriaProducto, cantidad, precio)
            SET fechaRegistro = STR_TO_DATE(@varfecha, '%d/%m/%Y');
            
            INSERT INTO Persona (nombre, correo, telefono, 
                fechaRegistro, direccion, ciudad, 
                codigoPostal, region)
                SELECT DISTINCT t.nombre, t.correo, t.telefono, 
                    t.fechaRegistro, t.direccion, t.ciudad, 
                    t.codigoPostal, t.region
                FROM Temporal t;
                
            INSERT INTO Proveedor (idPersona)
            SELECT p.idPersona FROM Persona p WHERE p.nombre IN 
                (SELECT DISTINCT t.nombre FROM Temporal t WHERE t.tipo = 'P');
            
            INSERT INTO Cliente (idPersona)
            SELECT p.idPersona FROM Persona p WHERE p.nombre IN 
                (SELECT DISTINCT t.nombre FROM Temporal t WHERE t.tipo = 'C');
            
            INSERT INTO Compania (nombre, contacto, correo, telefono)
            SELECT DISTINCT t.nombreCompania, t.contactoCompania, t.correoCompania, 
                t.telefonoCompania FROM Temporal t; `;
        return this.executeQuery(query, callback);
    },

    getData(callback) {
        const query = 'SELECT * FROM Temporal';
        return this.executeQuery(query, callback);
    },

    delete(callback) {
        const query = 'DROP TEMPORARY TABLE Temporal;';
        return this.executeQuery(query, callback);
    }
};

module.exports = temporal;
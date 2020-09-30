const mysqlConnection = require('../config/database');

const modelo = {
    executeQuery(query, callback) {
        mysqlConnection.query(query, (err, res) => callback(err, res));
    },

    loadData(callback) {
        const query = `            
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
                t.telefonoCompania FROM Temporal t;
            
            INSERT INTO Categoria (nombre)
            SELECT DISTINCT t.categoriaProducto FROM Temporal t;
                
            INSERT INTO Producto (idCategoria, nombre, precio)
            SELECT DISTINCT c.idCategoria, t.producto, t.precio FROM Temporal t
                INNER JOIN Categoria c ON (t.categoriaProducto = c.nombre);
            
            INSERT INTO OrdenCompra(idCompania, idCliente)
            SELECT DISTINCT cm.idCompania, cl.idCliente FROM Temporal t
                INNER JOIN Compania cm ON (cm.nombre = t.nombreCompania)
                INNER JOIN Persona p ON (p.nombre = t.nombre)
                INNER JOIN Cliente cl ON (cl.idPersona = p.idPersona);
                
            INSERT INTO OrdenVenta(idCompania, idProveedor)
            SELECT DISTINCT cm.idCompania, pr.idProveedor FROM Temporal t 
                INNER JOIN Compania cm ON (cm.nombre = t.nombreCompania)
                INNER JOIN Persona p ON (p.nombre = t.nombre)
                INNER JOIN Proveedor pr ON (pr.idPersona = p.idPersona);
                
            INSERT INTO DetalleOrdenCompra(NoOrdenCompra, idProducto, cantidad, subTotal)
                SELECT oc.NoOrdenCompra, prod.idProducto, t.cantidad, (t.cantidad*prod.precio) FROM Temporal t
                INNER JOIN Persona p ON (p.nombre = t.nombre)
                INNER JOIN Cliente cl ON (cl.idPersona = p.idPersona)
                INNER JOIN Compania cm ON (cm.nombre = t.nombreCompania)
                INNER JOIN Producto prod ON (prod.nombre = t.producto)
                INNER JOIN OrdenCompra oc ON (oc.idCliente = cl.idCliente AND oc.idCompania = cm.idCompania); 
            
            INSERT INTO DetalleOrdenVenta (NoOrdenVenta, idProducto, cantidad, subTotal)
                SELECT ov.NoOrdenVenta, prod.idProducto, t.cantidad, (t.cantidad*prod.precio) FROM Temporal t
                INNER JOIN Persona p ON (p.nombre = t.nombre)
                INNER JOIN Proveedor pr ON (pr.idPersona = p.idPersona)
                INNER JOIN Compania cm ON (cm.nombre = t.nombreCompania)
                INNER JOIN Producto prod ON (prod.nombre = t.producto)
                INNER JOIN OrdenVenta ov ON (ov.idProveedor = pr.idProveedor AND ov.idCompania = cm.idCompania);`;
        return this.executeQuery(query, callback);
    },

    delete(callback) {
        const query = '';
        return this.executeQuery(query, callback);
    }
};

module.exports = modelo;
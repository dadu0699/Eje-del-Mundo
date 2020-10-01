const mysqlConnection = require('../config/database');

const consultas = {
    executeQuery(query, callback) {
        mysqlConnection.query(query, (err, res) => callback(err, res));
    },

    consulta1(callback) {
        const query = `SELECT p.nombre AS 'Nombre Proveedor', p.telefono AS 'Telefono', 
            dov.NoOrdenVenta, SUM(dov.subTotal) AS 'Total' FROM DetalleOrdenVenta dov
            INNER JOIN OrdenVenta ov ON (dov.NoOrdenVenta = ov.NoOrdenVenta)
            INNER JOIN Proveedor pro ON (ov.idProveedor = pro.idProveedor)
            INNER JOIN Persona p ON (pro.idPersona = p.idPersona)
            GROUP BY NoOrdenVenta
            ORDER BY Total DESC
            LIMIT 1;`;
        return this.executeQuery(query, callback);
    },

    consulta2(callback) {
        const query = `SELECT cl.idCliente AS 'Numero de cliente', p.nombre AS 'Nombre y apellido',
            SUM(doc.cantidad) AS 'Cantidad productos comprados' FROM DetalleOrdenCompra doc
            INNER JOIN OrdenCompra oc ON (doc.NoOrdenCompra = oc.NoOrdenCompra)
            INNER JOIN Cliente cl ON (oc.idCliente = cl.idCliente)
            INNER JOIN Persona p ON (cl.idPersona = p.idPersona)
            GROUP BY cl.idCliente
            ORDER BY SUM(doc.cantidad) DESC
            LIMIT 1;`;
        return this.executeQuery(query, callback);
    },

    consulta3(callback) {
        const query = `SELECT * FROM (
                (SELECT p.direccion AS 'Dirección', p.region AS 'Region', 
                    p.ciudad AS 'Ciudad', p.codigoPostal AS 'Código Postal',
                    COUNT(*) AS 'Pedidos' FROM OrdenVenta ov
                    INNER JOIN Proveedor pr ON (ov.idProveedor = pr.idProveedor)
                    INNER JOIN Persona p ON (pr.idPersona = p.idPersona)
                    GROUP BY p.direccion, p.ciudad, p.codigoPostal, p.region
                    HAVING COUNT(*) > 1
                    ORDER BY Pedidos DESC
                    LIMIT 2) 
                UNION
                (SELECT p.direccion AS 'Dirección', p.region AS 'Region', 
                    p.ciudad AS 'Ciudad', p.codigoPostal AS 'Código Postal',
                    COUNT(*) AS 'Pedidos' FROM OrdenVenta ov
                    INNER JOIN Proveedor pr ON (ov.idProveedor = pr.idProveedor)
                    INNER JOIN Persona p ON (pr.idPersona = p.idPersona)
                    GROUP BY p.direccion, p.ciudad, p.codigoPostal, p.region
                    HAVING COUNT(*) > 1
                    ORDER BY Pedidos ASC
                    LIMIT 2)
            ) a ORDER BY Pedidos DESC;`;
        return this.executeQuery(query, callback);
    },



    consulta5(callback) {
        const query = `SELECT * FROM ((SELECT EXTRACT(MONTH FROM p.fechaRegistro) AS 'Mes', p.nombre AS 'Nombre y apellido', 
            SUM(doc.subTotal) AS 'Total' FROM DetalleOrdenCompra doc
            INNER JOIN OrdenCompra oc ON (doc.NoOrdenCompra = oc.NoOrdenCompra)
            INNER JOIN Cliente cl ON (oc.idCliente = cl.idCliente)
            INNER JOIN Persona p ON (cl.idPersona = p.idPersona)
            GROUP BY cl.idCliente
            ORDER BY SUM(doc.subTotal) DESC
            LIMIT 5)
            UNION
            (SELECT EXTRACT(MONTH FROM p.fechaRegistro) AS 'Mes', p.nombre AS 'Nombre y apellido', 
                SUM(doc.subTotal) AS 'Total' FROM DetalleOrdenCompra doc
            INNER JOIN OrdenCompra oc ON (doc.NoOrdenCompra = oc.NoOrdenCompra)
            INNER JOIN Cliente cl ON (oc.idCliente = cl.idCliente)
            INNER JOIN Persona p ON (cl.idPersona = p.idPersona)
            GROUP BY cl.idCliente
            ORDER BY SUM(doc.subTotal) ASC
            LIMIT 5)) a
            ORDER BY Total DESC;`;
        return this.executeQuery(query, callback);
    },
    consulta6(callback) {
        const query = `SELECT * FROM (
                (SELECT c.nombre, SUM(doc.cantidad) 'Cantidad', 
                    SUM(doc.cantidad*pr.precio) AS 'Total vendido' FROM DetalleOrdenCompra doc
                INNER JOIN Producto pr ON (pr.idProducto = doc.idProducto)
                INNER JOIN Categoria c ON (c.idCategoria = pr.idCategoria)
                GROUP BY c.nombre
                ORDER BY Cantidad DESC
                LIMIT 5)
            UNION
                (SELECT c.nombre, SUM(doc.cantidad) 'Cantidad', 
                    SUM(doc.cantidad*pr.precio) AS 'Total vendido' FROM DetalleOrdenCompra doc
                INNER JOIN Producto pr ON (pr.idProducto = doc.idProducto)
                INNER JOIN Categoria c ON (c.idCategoria = pr.idCategoria)
                GROUP BY c.nombre
                ORDER BY Cantidad ASC
                LIMIT 5)
            ) a ORDER BY Cantidad DESC;`;
        return this.executeQuery(query, callback);
    },
    consulta7(callback) {
        const query = `SELECT * FROM (
                (SELECT p.nombre AS 'Nombre', p.correo AS 'Correo', p.telefono AS 'Telefono',
                    p.fechaRegistro AS 'Fecha Registro', SUM(dov.subTotal) AS 'Total'
                    FROM DetalleOrdenVenta dov
                    INNER JOIN OrdenVenta ov ON (dov.NoOrdenVenta = ov.NoOrdenVenta)
                    INNER JOIN Proveedor pr ON (ov.idProveedor = pr.idProveedor)
                    INNER JOIN Persona p ON (pr.idPersona = p.idPersona)
                    INNER JOIN Producto prd ON (prd.idProducto = dov.idProducto)
                    INNER JOIN Categoria c ON (c.idCategoria = prd.idCategoria)
                    WHERE c.nombre = 'Fresh Vegetables'
                    GROUP BY p.nombre, p.correo, p.telefono, p.fechaRegistro
                    ORDER BY Total DESC
                LIMIT 5)
            UNION
                (SELECT p.nombre AS 'Nombre', p.correo AS 'Correo', p.telefono AS 'Telefono',
                    p.fechaRegistro AS 'Fecha Registro', SUM(dov.subTotal) AS 'Total'
                    FROM DetalleOrdenVenta dov
                    INNER JOIN OrdenVenta ov ON (dov.NoOrdenVenta = ov.NoOrdenVenta)
                    INNER JOIN Proveedor pr ON (ov.idProveedor = pr.idProveedor)
                    INNER JOIN Persona p ON (pr.idPersona = p.idPersona)
                    INNER JOIN Producto prd ON (prd.idProducto = dov.idProducto)
                    INNER JOIN Categoria c ON (c.idCategoria = prd.idCategoria)
                    WHERE c.nombre = 'Fresh Vegetables'
                    GROUP BY p.nombre, p.correo, p.telefono, p.fechaRegistro
                    ORDER BY Total ASC
                LIMIT 5)
            ) a ORDER BY Total DESC;`;
        return this.executeQuery(query, callback);
    },
    consulta8(callback) {
        const query = `SELECT * FROM (
                (SELECT p.nombre, p.direccion AS 'Dirección', p.ciudad AS 'Ciudad', p.codigoPostal AS 'Código Postal',
                    SUM(doc.subTotal) AS 'Total' FROM OrdenCompra oc
                INNER JOIN DetalleOrdenCompra doc ON (oc.NoOrdenCompra = doc.NoOrdenCompra)
                INNER JOIN Cliente cl ON (oc.idCliente = cl.idCliente)
                INNER JOIN Persona p ON (cl.idPersona = p.idPersona)
                GROUP BY cl.idCliente
                ORDER BY Total DESC
                LIMIT 5)
            UNION
                (SELECT p.nombre, p.direccion AS 'Dirección', p.ciudad AS 'Ciudad', p.codigoPostal AS 'Código Postal',
                    SUM(doc.subTotal) AS 'Total' FROM OrdenCompra oc
                INNER JOIN DetalleOrdenCompra doc ON (oc.NoOrdenCompra = doc.NoOrdenCompra)
                INNER JOIN Cliente cl ON (oc.idCliente = cl.idCliente)
                INNER JOIN Persona p ON (cl.idPersona = p.idPersona)
                GROUP BY cl.idCliente
                ORDER BY Total ASC
                LIMIT 5)
            ) a ORDER BY Total DESC;`;
        return this.executeQuery(query, callback);
    },
    consulta9(callback) {
        const query = `SELECT p.nombre AS 'Nombre y apellido', p.telefono AS 'Teléfono', 
                ov.NoOrdenVenta AS 'No. Orden Venta', SUM(dov.cantidad) AS 'Pedidos', 
                SUM(dov.subTotal) AS 'Total' FROM OrdenVenta ov
            INNER JOIN DetalleOrdenVenta dov ON (ov.NoOrdenVenta = dov.NoOrdenVenta)
            INNER JOIN Proveedor pr ON (ov.idProveedor = pr.idProveedor)
            INNER JOIN Persona p ON (pr.idPersona = p.idPersona)
            GROUP BY ov.NoOrdenVenta
            ORDER BY Pedidos ASC, Total ASC
            LIMIT 2;`;
        return this.executeQuery(query, callback);
    },
    consulta10(callback) {
        const query = `SELECT p.nombre AS 'Nombre', p.correo AS 'Correo', p.telefono AS 'Telefono',
                p.fechaRegistro AS 'Fecha Registro', SUM(doc.cantidad) AS 'Total'
            FROM DetalleOrdenCompra doc
            INNER JOIN OrdenCompra oc ON (doc.NoOrdenCompra = oc.NoOrdenCompra)
            INNER JOIN Cliente cl ON (oc.idCliente = cl.idCliente)
            INNER JOIN Persona p ON (cl.idPersona = p.idPersona)
            INNER JOIN Producto prd ON (prd.idProducto = doc.idProducto)
            INNER JOIN Categoria c ON (c.idCategoria = prd.idCategoria)
            WHERE c.nombre = 'Seafood'
            GROUP BY p.nombre, p.correo, p.telefono, p.fechaRegistro
            ORDER BY Total DESC
            LIMIT 11;`;
        return this.executeQuery(query, callback);
    }
};

module.exports = consultas;
LOAD DATA LOCAL INFILE '/home/didier/ProyectosNodejs/Eje-del-Mundo/data/DataCenterData.csv'
    INTO TABLE Temporal
    CHARACTER SET latin1
    FIELDS TERMINATED BY ';'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (nombreCompania, contactoCompania, correoCompania, telefonoCompania, tipo, nombre, 
        correo, telefono, @var_fec, direccion, ciudad, codigoPostal, region, producto, 
        categoriaProducto, cantidad, precio)
    SET fechaRegistro = STR_TO_DATE(@var_fec, '%d/%m/%Y');

/* SELECCIONAR USUARIOS O CLIENTES */
SELECT DISTINCT t.nombre, t.correo, t.telefono, 
    t.fechaRegistro, t.direccion, t.ciudad, 
    t.codigoPostal, t.region
    FROM Temporal t; 

/* INSERTAR PERSONAS DE LA TABLA TEMPORAL */
INSERT INTO Persona (nombre, correo, telefono, 
    fechaRegistro, direccion, ciudad, 
    codigoPostal, region)
    SELECT DISTINCT t.nombre, t.correo, t.telefono, 
        t.fechaRegistro, t.direccion, t.ciudad, 
        t.codigoPostal, t.region
    FROM Temporal t;

/* INSERTANDO PROVEEDORES */
INSERT INTO Proveedor (idPersona)
	SELECT p.idPersona FROM Persona p WHERE p.nombre IN 
        (SELECT DISTINCT t.nombre FROM Temporal t WHERE t.tipo = 'P');

/* INSERTANDO CLIENTES */
INSERT INTO Cliente (idPersona)
	SELECT p.idPersona FROM Persona p WHERE p.nombre IN 
        (SELECT DISTINCT t.nombre FROM Temporal t WHERE t.tipo = 'C');

/* SELECT COMPANIAS */
SELECT DISTINCT t.nombreCompania, t.contactoCompania, t.correoCompania, 
	t.telefonoCompania FROM Temporal t; 

/* INSERTANDO COMPANIA */
INSERT INTO Compania (nombre, contacto, correo, telefono)
    SELECT DISTINCT t.nombreCompania, t.contactoCompania, t.correoCompania, 
	    t.telefonoCompania FROM Temporal t; 

/* INSERTANDO CATEGORIAS */
INSERT INTO Categoria (nombre)
    SELECT DISTINCT t.categoriaProducto FROM Temporal t;

/* INSERTANDO PRODUCTOS */
INSERT INTO Producto (idCategoria, nombre, precio)
    SELECT DISTINCT c.idCategoria, t.producto, t.precio FROM Temporal t
	    INNER JOIN Categoria c ON (t.categoriaProducto = c.nombre);

/* SELECT COMPANIA CLIENTE */
SELECT DISTINCT cm.idCompania, cm.nombre, cl.idCliente, p.nombre FROM Temporal t
	INNER JOIN Compania cm ON (cm.nombre = t.nombreCompania)
	INNER JOIN Persona p ON (p.nombre = t.nombre)
	INNER JOIN Cliente cl ON (cl.idPersona = p.idPersona);

/* INSERTANDO ORDEN DE COMPRA */
INSERT INTO OrdenCompra(idCompania, idCliente)
    SELECT DISTINCT cm.idCompania, cl.idCliente FROM Temporal t
        INNER JOIN Compania cm ON (cm.nombre = t.nombreCompania)
        INNER JOIN Persona p ON (p.nombre = t.nombre)
        INNER JOIN Cliente cl ON (cl.idPersona = p.idPersona);

/* SELECT COMPANIA PROVEEDOR */
SELECT DISTINCT cm.idCompania, cm.nombre, pr.idProveedor, p.nombre FROM Temporal t 
	INNER JOIN Compania cm ON (cm.nombre = t.nombreCompania)
	INNER JOIN Persona p ON (p.nombre = t.nombre)
	INNER JOIN Proveedor pr ON (pr.idPersona = p.idPersona);

/* INSERTANDO ORDEN DE VENTA */
INSERT INTO OrdenVenta(idCompania, idProveedor)
    SELECT DISTINCT cm.idCompania, pr.idProveedor FROM Temporal t 
        INNER JOIN Compania cm ON (cm.nombre = t.nombreCompania)
        INNER JOIN Persona p ON (p.nombre = t.nombre)
        INNER JOIN Proveedor pr ON (pr.idPersona = p.idPersona);

/* SELECT DETALLE ODEN COMPRA */
SELECT oc.NoOrdenCompra, prod.idProducto, prod.nombre AS 'Producto', 
	cl.idCliente, p.nombre AS 'Cliente', cm.idCompania, 
    cm.nombre AS 'Compania', t.cantidad, (t.cantidad*prod.precio) FROM Temporal t
    INNER JOIN Persona p ON (p.nombre = t.nombre)
    INNER JOIN Cliente cl ON (cl.idPersona = p.idPersona)
    INNER JOIN Compania cm ON (cm.nombre = t.nombreCompania)
    INNER JOIN Producto prod ON (prod.nombre = t.producto)
    INNER JOIN OrdenCompra oc ON (oc.idCliente = cl.idCliente AND oc.idCompania = cm.idCompania); 

/* INSERTANDO DETALLE ORDEN COMPRA */
INSERT INTO DetalleOrdenCompra(NoOrdenCompra, idProducto, cantidad, subTotal)
	SELECT oc.NoOrdenCompra, prod.idProducto, t.cantidad, (t.cantidad*prod.precio) FROM Temporal t
	INNER JOIN Persona p ON (p.nombre = t.nombre)
	INNER JOIN Cliente cl ON (cl.idPersona = p.idPersona)
	INNER JOIN Compania cm ON (cm.nombre = t.nombreCompania)
	INNER JOIN Producto prod ON (prod.nombre = t.producto)
	INNER JOIN OrdenCompra oc ON (oc.idCliente = cl.idCliente AND oc.idCompania = cm.idCompania); 

/* SELECT DETALLE ODEN VENTA */
SELECT ov.NoOrdenVenta, prod.idProducto, prod.nombre AS 'Producto', 
	pr.idProveedor, p.nombre AS 'Proveedor', cm.idCompania, 
    cm.nombre AS 'Compania', t.cantidad, (t.cantidad*prod.precio) FROM Temporal t
    INNER JOIN Persona p ON (p.nombre = t.nombre)
    INNER JOIN Proveedor pr ON (pr.idPersona = p.idPersona)
    INNER JOIN Compania cm ON (cm.nombre = t.nombreCompania)
    INNER JOIN Producto prod ON (prod.nombre = t.producto)
    INNER JOIN OrdenVenta ov ON (ov.idProveedor = pr.idProveedor AND ov.idCompania = cm.idCompania); 

/* INSERTANDO DETALLE ORDEN COMPRA */
INSERT INTO DetalleOrdenVenta (NoOrdenVenta, idProducto, cantidad, subTotal)
    SELECT ov.NoOrdenVenta, prod.idProducto, t.cantidad, (t.cantidad*prod.precio) FROM Temporal t
    INNER JOIN Persona p ON (p.nombre = t.nombre)
    INNER JOIN Proveedor pr ON (pr.idPersona = p.idPersona)
    INNER JOIN Compania cm ON (cm.nombre = t.nombreCompania)
    INNER JOIN Producto prod ON (prod.nombre = t.producto)
    INNER JOIN OrdenVenta ov ON (ov.idProveedor = pr.idProveedor AND ov.idCompania = cm.idCompania); 

INSERT INTO Region (nombre)
    SELECT DISTINCT t.region FROM Temporal t;

INSERT INTO Ciudad (nombre, codigoPostal, idRegion)
    SELECT DISTINCT t.ciudad, t.codigoPostal, r.idRegion FROM Temporal t
    INNER JOIN Region r ON (t.region = r.nombre);

DROP TEMPORARY TABLE Temporal;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM Compania;
DELETE FROM Persona;
DELETE FROM Cliente;
DELETE FROM Proveedor;
DELETE FROM Categoria;
DELETE FROM Producto;
DELETE FROM OrdenCompra;
DELETE FROM DetalleOrdenCompra;
DELETE FROM OrdenVenta;
DELETE FROM DetalleOrdenVenta;
DELETE FROM Region;
DELETE FROM Ciudad;
SET FOREIGN_KEY_CHECKS = 1;
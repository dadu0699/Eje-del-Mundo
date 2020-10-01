/* Consulta 1 ORDEN DE VENTA CON MAYOR TOTAL */
SELECT p.nombre AS 'Nombre Proveedor', p.telefono AS 'Telefono', 
	dov.NoOrdenVenta, SUM(dov.subTotal) AS 'Total' FROM DetalleOrdenVenta dov
    INNER JOIN OrdenVenta ov ON (dov.NoOrdenVenta = ov.NoOrdenVenta)
    INNER JOIN Proveedor pro ON (ov.idProveedor = pro.idProveedor)
    INNER JOIN Persona p ON (pro.idPersona = p.idPersona)
    GROUP BY NoOrdenVenta
    ORDER BY Total DESC
    LIMIT 1; 

/* Consulta 2 CLIENTE CON MAS PRODUCTOS COMPRADOS */
SELECT cl.idCliente AS 'Numero de cliente', p.nombre AS 'Nombre y apellido',
	SUM(doc.cantidad) AS 'Cantidad productos comprados' FROM DetalleOrdenCompra doc
    INNER JOIN OrdenCompra oc ON (doc.NoOrdenCompra = oc.NoOrdenCompra)
    INNER JOIN Cliente cl ON (oc.idCliente = cl.idCliente)
    INNER JOIN Persona p ON (cl.idPersona = p.idPersona)
    GROUP BY cl.idCliente
    ORDER BY SUM(doc.cantidad) DESC
    LIMIT 1; 

/* Consulta 3 MAYOR Y MENOR (VENTAS) PEDIDOS REALIZADOS */
SELECT * FROM (
    (SELECT p.direccion AS 'Dirección', p.ciudad AS 'Ciudad', p.codigoPostal AS 'Código Postal',
        COUNT(*) AS 'Pedidos' FROM OrdenVenta ov
        INNER JOIN Proveedor pr ON (ov.idProveedor = pr.idProveedor)
        INNER JOIN Persona p ON (pr.idPersona = p.idPersona)
        GROUP BY p.direccion, p.ciudad, p.codigoPostal
        HAVING COUNT(*) > 1
        ORDER BY Pedidos DESC
        LIMIT 2) 
    UNION
    (SELECT p.direccion AS 'Dirección', p.ciudad AS 'Ciudad', p.codigoPostal AS 'Código Postal',
        COUNT(*) AS 'Pedidos' FROM OrdenVenta ov
        INNER JOIN Proveedor pr ON (ov.idProveedor = pr.idProveedor)
        INNER JOIN Persona p ON (pr.idPersona = p.idPersona)
        GROUP BY p.direccion, p.ciudad, p.codigoPostal
        HAVING COUNT(*) > 1
        ORDER BY Pedidos ASC
        LIMIT 2)
) a ORDER BY Pedidos DESC;

/* CONSULTA 5 */
SELECT * FROM (
    (SELECT EXTRACT(MONTH FROM p.fechaRegistro) AS 'Mes', p.nombre AS 'Nombre y apellido', 
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
    LIMIT 5)
) a ORDER BY Total DESC;

/* CONSULTA 6 */
SELECT * FROM (
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
) a ORDER BY Cantidad DESC;

/* CONSULTA 7 */
SELECT * FROM (
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
    LIMIT 1)
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
    LIMIT 1)
) a ORDER BY Total DESC;

/* CONSULTA 4*/
SELECT cl.idCliente, p.nombre AS 'Nombre y Apellido', COUNT(oc.idCliente) AS 'ORDENES' FROM OrdenCompra oc
INNER JOIN Cliente cl ON (oc.idCliente = cl.idCliente)
INNER JOIN Persona p ON (cl.idPersona = p.idPersona)
WHERE oc.NoOrdenCompra IN (
	SELECT doc.NoOrdenCompra FROM DetalleOrdenCompra doc
    INNER JOIN Producto pr ON (pr.idProducto = doc.idProducto)
    INNER JOIN Categoria c ON (c.idCategoria = pr.idCategoria)
    WHERE c.nombre = 'Cheese'
)
GROUP BY cl.idCliente
ORDER BY ORDENES DESC; 


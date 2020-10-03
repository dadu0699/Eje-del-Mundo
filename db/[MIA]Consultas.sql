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
) a ORDER BY Total DESC;

/* CONSULTA 8 */
SELECT * FROM (
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
) a ORDER BY Total DESC;

/* CONSULTA 9 */
SELECT p.nombre AS 'Nombre y apellido', p.telefono AS 'Teléfono', 
    ov.NoOrdenVenta AS 'No. Orden Venta', SUM(dov.cantidad) AS 'Pedidos', 
    SUM(dov.subTotal) AS 'Total' FROM OrdenVenta ov
INNER JOIN DetalleOrdenVenta dov ON (ov.NoOrdenVenta = dov.NoOrdenVenta)
INNER JOIN Proveedor pr ON (ov.idProveedor = pr.idProveedor)
INNER JOIN Persona p ON (pr.idPersona = p.idPersona)
GROUP BY ov.NoOrdenVenta
ORDER BY Pedidos ASC, Total ASC
LIMIT 12;

/* CONSULTA 10 */
SELECT p.nombre AS 'Nombre', p.correo AS 'Correo', p.telefono AS 'Telefono',
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
    LIMIT 11;

/* CONSULTA 4*/
SELECT cl.idCliente, p.nombre AS 'Nombre y Apellido', ord.Ordenes, dt.DetalleOrden AS 'Detalle Orden', 
	ct.Cantidad FROM Cliente cl
INNER JOIN Persona p ON (cl.idPersona = p.idPersona)
INNER JOIN
	(SELECT cl.idCliente, COUNT(oc.idCliente) AS 'DetalleOrden' FROM OrdenCompra oc
	INNER JOIN Cliente cl ON (oc.idCliente = cl.idCliente)
	INNER JOIN Persona p ON (cl.idPersona = p.idPersona)
	INNER JOIN DetalleOrdenCompra doc ON (oc.NoOrdenCompra = doc.NoOrdenCompra)
	WHERE doc.idDetalleOrdenCompra IN (
		SELECT doc.idDetalleOrdenCompra FROM DetalleOrdenCompra doc
		INNER JOIN Producto pr ON (pr.idProducto = doc.idProducto)
		INNER JOIN Categoria c ON (c.idCategoria = pr.idCategoria)
		WHERE c.nombre = 'Cheese'
	)
	GROUP BY cl.idCliente) dt ON (cl.idCliente = dt.idCliente)
INNER JOIN
	(SELECT cl.idCliente, SUM(doc.cantidad) AS 'Cantidad' FROM DetalleOrdenCompra doc
		INNER JOIN OrdenCompra oc ON (doc.NoOrdenCompra = oc.NoOrdenCompra)
		INNER JOIN Cliente cl ON (oc.idCliente = cl.idCliente)
		INNER JOIN Producto pr ON (pr.idProducto = doc.idProducto)
		INNER JOIN Categoria c ON (c.idCategoria = pr.idCategoria)
		WHERE c.nombre = 'Cheese'
		GROUP BY cl.idCliente) ct ON (cl.idCliente = ct.idCliente)
INNER JOIN
	(SELECT cl.idCliente, COUNT(oc.idCliente) AS 'Ordenes' FROM OrdenCompra oc
	INNER JOIN Cliente cl ON (oc.idCliente = cl.idCliente)
	WHERE oc.NoOrdenCompra IN (
		SELECT doc.NoOrdenCompra FROM DetalleOrdenCompra doc
		INNER JOIN Producto pr ON (pr.idProducto = doc.idProducto)
		INNER JOIN Categoria c ON (c.idCategoria = pr.idCategoria)
		WHERE c.nombre = 'Cheese'
	)
	GROUP BY cl.idCliente) ord ON (cl.idCliente = ord.idCliente)
ORDER BY ct.Cantidad DESC
LIMIT 5;

SELECT cl.idCliente, p.nombre AS 'Nombre y Apellido', COUNT(*) AS 'Ordenes', prueba.Total
	FROM OrdenCompra oc
INNER JOIN Cliente cl ON (oc.idCliente = cl.idCliente)
INNER JOIN Persona p ON (cl.idPersona = p.idPersona)
INNER JOIN
	(SELECT cl.idCliente, SUM(doc.subTotal) AS 'Total'
		FROM OrdenCompra oc
	INNER JOIN DetalleOrdenCompra doc ON (oc.NoOrdenCompra = doc.NoOrdenCompra)
	INNER JOIN Cliente cl ON (oc.idCliente = cl.idCliente)
	GROUP BY cl.idCliente) prueba ON (prueba.idCliente = cl.idCliente)
WHERE cl.idCliente IN (SELECT idCliente FROM (SELECT cl.idCliente, SUM(doc.cantidad) AS 'Cantidad' FROM DetalleOrdenCompra doc
	INNER JOIN OrdenCompra oc ON (doc.NoOrdenCompra = oc.NoOrdenCompra)
	INNER JOIN Cliente cl ON (oc.idCliente = cl.idCliente)
	INNER JOIN Persona p ON (cl.idPersona = p.idPersona)
    INNER JOIN Producto pr ON (pr.idProducto = doc.idProducto)
    INNER JOIN Categoria c ON (c.idCategoria = pr.idCategoria)
    WHERE c.nombre = 'Cheese'
    GROUP BY cl.idCliente
    ORDER BY Cantidad DESC
    LIMIT 5) AS temp)
GROUP BY cl.idCliente
ORDER BY Ordenes DESC;


/* DETALLES DE ORDENES SOLO CON MARCA Cheese */
SELECT cl.idCliente, p.nombre AS 'Nombre y Apellido', COUNT(oc.idCliente) AS 'ORDENES' FROM OrdenCompra oc
INNER JOIN Cliente cl ON (oc.idCliente = cl.idCliente)
INNER JOIN Persona p ON (cl.idPersona = p.idPersona)
INNER JOIN DetalleOrdenCompra doc ON (oc.NoOrdenCompra = doc.NoOrdenCompra)
WHERE doc.idDetalleOrdenCompra IN (
	SELECT doc.idDetalleOrdenCompra FROM DetalleOrdenCompra doc
    INNER JOIN Producto pr ON (pr.idProducto = doc.idProducto)
    INNER JOIN Categoria c ON (c.idCategoria = pr.idCategoria)
    WHERE c.nombre = 'Cheese'
)
GROUP BY cl.idCliente
ORDER BY ORDENES DESC; 

/* CLIENTES QUE COMPRARON MAS PRODUCTOS DE LA MARCA Cheese */
SELECT cl.idCliente, p.nombre, SUM(doc.cantidad) AS 'Cantidad Producto Marca Cheese' FROM DetalleOrdenCompra doc
	INNER JOIN OrdenCompra oc ON (doc.NoOrdenCompra = oc.NoOrdenCompra)
	INNER JOIN Cliente cl ON (oc.idCliente = cl.idCliente)
	INNER JOIN Persona p ON (cl.idPersona = p.idPersona)
    INNER JOIN Producto pr ON (pr.idProducto = doc.idProducto)
    INNER JOIN Categoria c ON (c.idCategoria = pr.idCategoria)
    WHERE c.nombre = 'Cheese'
    GROUP BY cl.idCliente
    ORDER BY SUM(doc.cantidad) DESC
    LIMIT 5

/* CLIENTES QUE COMPRARON PRODCUTOS DE LA MARCA Cheese */
SELECT cl.idCliente, p.nombre AS 'Nombre y Apellido', COUNT(*) AS 'Ordenes', prueba.Total
	FROM OrdenCompra oc
INNER JOIN Cliente cl ON (oc.idCliente = cl.idCliente)
INNER JOIN Persona p ON (cl.idPersona = p.idPersona)
INNER JOIN
	(SELECT cl.idCliente, SUM(doc.subTotal) AS 'Total'
		FROM OrdenCompra oc
	INNER JOIN DetalleOrdenCompra doc ON (oc.NoOrdenCompra = doc.NoOrdenCompra)
	INNER JOIN Cliente cl ON (oc.idCliente = cl.idCliente)
	GROUP BY cl.idCliente) prueba ON (prueba.idCliente = cl.idCliente)
WHERE cl.idCliente IN (SELECT cl.idCliente FROM DetalleOrdenCompra doc
	INNER JOIN OrdenCompra oc ON (doc.NoOrdenCompra = oc.NoOrdenCompra)
	INNER JOIN Cliente cl ON (oc.idCliente = cl.idCliente)
	INNER JOIN Persona p ON (cl.idPersona = p.idPersona)
    INNER JOIN Producto pr ON (pr.idProducto = doc.idProducto)
    INNER JOIN Categoria c ON (c.idCategoria = pr.idCategoria)
    WHERE c.nombre = 'Cheese')
GROUP BY cl.idCliente
ORDER BY Ordenes DESC;
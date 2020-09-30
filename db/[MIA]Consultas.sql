LOAD DATA LOCAL INFILE '/home/didier/ProyectosNodejs/Eje-del-Mundo/data/DataCenterData.csv'
    INTO TABLE Temporal
    CHARACTER SET latin1
    FIELDS TERMINATED BY ';'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (nombreCompania, contactoCompania, correoCompania, telefonoCompania, tipo, nombre, c
        orreo, telefono, @var_fec, direccion, ciudad, codigoPostal, region, producto, 
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
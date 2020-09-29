LOAD DATA LOCAL INFILE 'C:\proyectosNodeJS\Eje-del-Mundo\data\DataCenterData.csv'
INTO TABLE Temporal
    CHARACTER SET latin1
    FIELDS TERMINATED BY ';'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (nombreCompania, contactoCompania, correoCompania, telefonoCompania, tipo, nombre, correo, telefono, @var_fec, direccion, ciudad, codigoPostal, region, producto, categoriaProducto, cantidad, precio)
    SET fechaRegistro = STR_TO_DATE(@var_fec, '%d/%m/%Y');
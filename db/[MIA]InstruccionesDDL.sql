DROP DATABASE IF EXISTS practicaMIA;
CREATE DATABASE practicaMIA;
USE practicaMIA;

CREATE TABLE Compania (
  idCompania INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL,
  contacto VARCHAR(255) NOT NULL,
  correo VARCHAR(255) NOT NULL,
  telefono VARCHAR(255) NOT NULL,
  PRIMARY KEY (idCompania)
);

CREATE TABLE Persona (
  idPersona INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL, 
  correo VARCHAR(255) NOT NULL, 
  telefono VARCHAR(255) NOT NULL, 
  direccion VARCHAR(255) NOT NULL,
  ciudad VARCHAR(255) NOT NULL,
  codigoPostal INT NOT NULL,
  region VARCHAR(255) NOT NULL,
  fechaRegistro DATE NOT NULL,
  PRIMARY KEY (idPersona)
);

CREATE TABLE Cliente (
  idCliente INT NOT NULL AUTO_INCREMENT,
  idPersona INT NOT NULL,
  PRIMARY KEY (idCliente),
  FOREIGN KEY (idPersona) REFERENCES Persona(idPersona)
);

CREATE TABLE Proveedor (
  idProveedor INT NOT NULL AUTO_INCREMENT,
  idPersona INT NOT NULL,
  PRIMARY KEY (idProveedor),
  FOREIGN KEY (idPersona) REFERENCES Persona(idPersona)
);

CREATE TABLE Categoria ( 
  idCategoria INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(255),
  PRIMARY KEY (idCategoria)
);

CREATE TABLE Producto (
  idProducto INT NOT NULL AUTO_INCREMENT,
  idCategoria INT NOT NULL,
  nombre VARCHAR(255) NOT NULL,
  precio DECIMAL(10,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (idProducto),
  FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria)
);

CREATE TABLE OrdenCompra (
  NoOrdenCompra INT NOT NULL AUTO_INCREMENT,
  idCompania INT NOT NULL,
  idCliente INT NOT NULL,
  PRIMARY KEY (NoOrdenCompra),
  FOREIGN KEY (idCompania) REFERENCES Compania(idCompania),
  FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE DetalleOrdenCompra (
  idDetalleOrdenCompra INT NOT NULL AUTO_INCREMENT,
  NoOrdenCompra INT NOT NULL,
  idProducto INT NOT NULL,
  cantidad INT NOT NULL,
  subTotal DECIMAL(10,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (idDetalleOrdenCompra),
  FOREIGN KEY (NoOrdenCompra) REFERENCES OrdenCompra(NoOrdenCompra),
  FOREIGN KEY (idProducto) REFERENCES Producto(idProducto)
);

CREATE TABLE OrdenVenta (
  NoOrdenVenta INT NOT NULL AUTO_INCREMENT,
  idCompania INT NOT NULL,
  idProveedor INT NOT NULL,
  PRIMARY KEY (NoOrdenVenta),
  FOREIGN KEY (idCompania) REFERENCES Compania(idCompania),
  FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProveedor)
);

CREATE TABLE DetalleOrdenVenta (
  idDetalleOrdenVenta INT NOT NULL AUTO_INCREMENT,
  NoOrdenVenta INT NOT NULL,
  idProducto INT NOT NULL,
  cantidad INT NOT NULL,
  subTotal DECIMAL(10,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (idDetalleOrdenVenta),
  FOREIGN KEY (NoOrdenVenta) REFERENCES OrdenVenta(NoOrdenVenta),
  FOREIGN KEY (idProducto) REFERENCES Producto(idProducto)
);

CREATE TABLE Region (
  idRegion INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL, 
  PRIMARY KEY (idRegion)
);

CREATE TABLE Ciudad (
  idCiudad INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL, 
  codigoPostal INT NOT NULL,
  idRegion INT NOT NULL,
  PRIMARY KEY (idCiudad),
  FOREIGN KEY (idRegion) REFERENCES Region(idRegion)
);

SET GLOBAL local_infile=1;
CREATE TEMPORARY TABLE Temporal (
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
);

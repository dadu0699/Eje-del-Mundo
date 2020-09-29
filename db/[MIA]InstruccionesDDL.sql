DROP DATABASE IF EXISTS practicaMIA;
CREATE DATABASE practicaMIA;
USE practicaMIA;

CREATE TEMPORARY TABLE Temporal(
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

CREATE TABLE Compania (
  idCompania INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL,
  contacto VARCHAR(255) NOT NULL,
  correo VARCHAR(255) NOT NULL,
  telefono VARCHAR(255) NOT NULL,
  PRIMARY KEY (idCompania)
);

CREATE TABLE ClienteProveedor (
  idClienteProveedor INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL, 
  correo VARCHAR(255) NOT NULL, 
  telefono VARCHAR(255) NOT NULL, 
  direccion VARCHAR(255) NOT NULL,
  ciudad VARCHAR(255) NOT NULL,
  codigoPostal INT NOT NULL,
  region VARCHAR(255) NOT NULL,
  rol CHAR(1) NOT NULL,
  fechaRegistro DATE NOT NULL, /* Verificar */
  PRIMARY KEY (idClienteProveedor)
);

CREATE TABLE Producto (
  idProducto INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL,
  categoria VARCHAR(255) NOT NULL,
  precio DECIMAL(10,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (idProducto)
);

CREATE TABLE Orden (
  NoOrden INT NOT NULL AUTO_INCREMENT,
  idCompania INT NOT NULL,
  idClienteProveedor INT NOT NULL,
  PRIMARY KEY (NoOrden),
  FOREIGN KEY (idCompania) REFERENCES Compania(idCompania),
  FOREIGN KEY (idClienteProveedor) REFERENCES ClienteProveedor(idClienteProveedor)
);

CREATE TABLE DetalleOrden(
  NoOrden INT NOT NULL,
  idProducto INT NOT NULL,
  cantidad INT NOT NULL,
  subTotal INT NOT NULL,
  PRIMARY KEY(NoOrden, idProducto),
  FOREIGN KEY(NoOrden) REFERENCES Orden(NoOrden),
  FOREIGN KEY(idProducto) REFERENCES Producto(idProducto)
);
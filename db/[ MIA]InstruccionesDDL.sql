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

CREATE TABLE ClienteProveedor (
  idClienteProveedor INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL, 
  correo VARCHAR(255) NOT NULL, 
  telefono VARCHAR(255) NOT NULL, 
  direccion VARCHAR(255) NOT NULL,
  ciudad VARCHAR(255) NOT NULL,
  codigoPostal INT NOT NULL,
  fechaRegistro VARCHAR(255) NOT NULL, --Verificar
  PRIMARY KEY (idClienteProveedor)
);

CREATE TABLE Producto (
  idProducto INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL,
  categoria VARCHAR(255) NOT NULL,
  precio DECIMAL(10,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (idProducto)
);
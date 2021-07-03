-- Start transaction
BEGIN WORK;

-- Drop schema &  tables
DROP SCHEMA IF EXISTS sprint17_t1 CASCADE;

-- Create schema
CREATE SCHEMA sprint17_t1;

-- Set the path
SET search_path TO sprint17_t1;

-- Create table establecimientos
CREATE TABLE tb_establecimientos (
	establecimiento_id SERIAL,
	ciudad CHARACTER VARYING(50) NOT NULL,
	codigoPostal NUMERIC(5) NOT NULL,
	direccion CHARACTER VARYING(250) NOT NULL,
	CONSTRAINT PK_tb_establecimiento PRIMARY KEY(establecimiento_id)
	);
	
-- Create table trabajadores
CREATE TABLE tb_trabajadores (
	trabajadores_id SERIAL,
	nombre CHARACTER VARYING(50) NOT NULL,
	apellido CHARACTER VARYING(50),
	dni CHARACTER(9) NOT NULL,
	telefono NUMERIC(9),
	correo CHARACTER VARYING(250),
	establecimiento_id INTEGER NOT NULL,
	CONSTRAINT PK_tb_trabajadores PRIMARY KEY(trabajadores_id),
	CONSTRAINT FK_tb_establecimientos FOREIGN KEY (establecimiento_id) REFERENCES tb_establecimientos (establecimiento_id)
	);
	
-- Create table clientes
CREATE TABLE tb_clientes (
	cliente_id SERIAL,
	nombre CHARACTER VARYING(50) NOT NULL,
	apellido CHARACTER VARYING(50),
	telefono NUMERIC(9),
	correo CHARACTER VARYING(250),
	codigoPostal NUMERIC(5) NOT NULL,
	CONSTRAINT PK_tb_clientes PRIMARY KEY(cliente_id)
	);
	
-- Create table tipos_producto
CREATE TABLE tb_tipos_producto (
	tipos_producto_id SERIAL, 
	categoria CHARACTER VARYING(50) NOT NULL,
	descripcion CHARACTER VARYING(500) NOT NULL,
	CONSTRAINT PK_tb_tipos_producto PRIMARY KEY(tipos_producto_id)
	);
	
-- Create table productos
CREATE TABLE tb_productos (
	producto_id SERIAL, 
	nombre CHARACTER VARYING(50) NOT NULL,
	descripcion CHARACTER VARYING(500) NOT NULL,
	precio NUMERIC(6,2) NOT NULL,
	tipos_producto_id INTEGER NOT NULL,
	CONSTRAINT PK_tb_productos PRIMARY KEY(producto_id),
	CONSTRAINT FK_tb_tipos_producto FOREIGN KEY (tipos_producto_id) REFERENCES tb_tipos_producto (tipos_producto_id)
	);

-- Create table compras
CREATE TABLE tb_compras (
	compra_id SERIAL, 
	producto_id INTEGER NOT NULL,
	cliente_id INTEGER NOT NULL,
	establecimiento_id INTEGER NOT NULL,
	CONSTRAINT PK_tb_compras PRIMARY KEY(compra_id),
	CONSTRAINT FK_tb_productos FOREIGN KEY (producto_id) REFERENCES tb_productos (producto_id),
	CONSTRAINT FK_tb_clientes FOREIGN KEY (cliente_id) REFERENCES tb_clientes (cliente_id),
	CONSTRAINT FK_tb_establecimientos FOREIGN KEY (establecimiento_id) REFERENCES tb_establecimientos (establecimiento_id)
	);
	
-- End transaction
COMMIT WORK;
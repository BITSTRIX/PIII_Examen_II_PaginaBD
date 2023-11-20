

--JOSE ANTONIO VALERIO CHAVES
--EXAMEN II DE PROGRAMACION III

CREATE DATABASE SoporteTecnico
GO

USE SoporteTecnico
GO

CREATE TABLE Usuarios
(
usuarioID INT IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
correoElectronico VARCHAR(50),
telefono VARCHAR(15) UNIQUE
)
GO

CREATE TABLE Tecnicos
(
tecnicoID INT IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
especialidad VARCHAR(50)
)
GO

CREATE TABLE Equipos
(
equipoID INT IDENTITY(1,1) PRIMARY KEY,
tipoEquipo VARCHAR(50) NOT NULL,
modelo VARCHAR(50),
usuarioID int,
CONSTRAINT fkEquiposUsuarioID FOREIGN KEY (usuarioID) REFERENCES Usuarios(usuarioID)
)
GO

CREATE TABLE Reparaciones
(
reparacionID INT IDENTITY(1,1) PRIMARY KEY,
equipoID int,
fechaSolicitud DATETIME,
estado Char(1),
CONSTRAINT fkReparacionesUsuarioID FOREIGN KEY (equipoID) REFERENCES Equipos(equipoID)
)
GO

CREATE TABLE DetallesReparacion
(
DetalleID INT IDENTITY(1,1) PRIMARY KEY,
reparacionID int,
descripcion varchar(50),
fechaInicio DATETIME,
fechaFin DATETIME,
CONSTRAINT fkDetalleID FOREIGN KEY (DetalleID) REFERENCES Reparaciones(reparacionID)
)
GO

CREATE TABLE Asignaciones
(
asignacionID INT IDENTITY(1,1) PRIMARY KEY,
reparacionID int,
tecnicoID int,
fechaAsignacion DATETIME,
CONSTRAINT fkAsignacionesreparacionID FOREIGN KEY (reparacionID) REFERENCES Reparaciones(reparacionID),
CONSTRAINT fkAsignacionestecnicoID FOREIGN KEY (tecnicoID) REFERENCES Tecnicos(tecnicoID)
)
GO


--INGRESO DE INFORMACION PARA TRABAJAR LA BASE DE DATOS

-- Insertar datos en la tabla Usuarios
INSERT INTO Usuarios (nombre, correoElectronico, telefono)
VALUES
('Juan Pérez', 'juan.perez@example.com', '123-456-7890'),
('María Gómez', 'maria.gomez@example.com', '987-654-3210'),
('Carlos Rodriguez', 'carlos.rodriguez@example.com', '555-123-4567'),
('Elena Ramírez', 'elena.ramirez@example.com', '111-222-3333'),
('Javier García', 'javier.garcia@example.com', '444-555-6666'),
('Isabel Fernández', 'isabel.fernandez@example.com', '777-888-9999');

-- Insertar datos en la tabla Tecnicos
INSERT INTO Tecnicos (nombre, especialidad)
VALUES
('Laura González', 'Hardware'),
('Miguel Sánchez', 'Redes'),
('Ana Martínez', 'Software'),
('Pedro López', 'Seg Informática'),
('Carmen Martín', 'Base de Datos'),
('Rafael Castro', 'Desarrollo Web');

-- Insertar datos en la tabla Equipos
INSERT INTO Equipos (tipoEquipo, modelo, usuarioID)
VALUES
('Laptop', 'Dell XPS 13', 1),
('Impresora', 'HP LaserJet Pro', 2),
('Router', 'Linksys AC1200', 3),
('Tablet', 'Samsung Galaxy Tab S7', 4),
('Desktop', 'HP Pavilion', 5),
('Smartphone', 'iPhone 13', 6);

-- Insertar datos en la tabla Reparaciones
INSERT INTO Reparaciones (equipoID, fechaSolicitud, estado)
VALUES
(1, '2023-01-15 09:00:00', 'P'),
(2, '2023-02-01 14:30:00', 'P'),
(3, '2023-03-10 11:45:00', 'P'),
(4, '2023-04-02 08:45:00', 'P'),
(5, '2023-04-15 13:20:00', 'P'),
(6, '2023-05-03 10:30:00', 'P');

-- Insertar datos en la tabla DetallesReparacion
INSERT INTO DetallesReparacion (reparacionID, descripcion, fechaInicio, fechaFin)
VALUES
(1, 'Reemplazo de batería', '2023-01-20 10:00:00', '2023-01-20 14:30:00'),
(2, 'Limpieza de rodillos', '2023-02-05 15:00:00', '2023-02-05 17:00:00'),
(3, 'Actualización de firmware', '2023-03-15 12:00:00', '2023-03-15 13:30:00'),
(4, 'Reparación de pantalla', '2023-04-05 09:30:00', '2023-04-05 12:15:00'),
(5, 'Reemplazo de tarjeta gráfica', '2023-04-20 14:00:00', '2023-04-20 16:45:00'),
(6, 'Actualización de sistema operativo', '2023-05-08 11:00:00', '2023-05-08 13:30:00');


-- Insertar datos en la tabla Asignaciones
INSERT INTO Asignaciones (reparacionID, tecnicoID, fechaAsignacion)
VALUES
(1, 1, '2023-01-18 11:00:00'),
(2, 2, '2023-02-03 16:30:00'),
(3, 3, '2023-03-12 14:00:00'),
(4, 1, '2023-04-07 10:00:00'),
(5, 2, '2023-04-22 15:30:00'),
(6, 3, '2023-05-10 12:00:00');
GO

--PROCEDIMIENTOS ALMACENADOS TABLA DE EQUIPOS---

CREATE PROCEDURE PcAgregarEquipo
@TipoEquipo VARCHAR(50),
@ModeloEquipo VARCHAR(50),
@UsuarioEquipo INT
AS
	BEGIN
	INSERT INTO Equipos (tipoEquipo, modelo, usuarioID) VALUES (@TipoEquipo,@ModeloEquipo, @UsuarioEquipo)
	END
GO

CREATE PROCEDURE PcConsultarEquipo
@EquipoID INT
AS
	BEGIN
	SELECT * from  Equipos WHERE equipoID = @EquipoID
	END
GO

CREATE PROCEDURE PcModificarEquipo
@EquipoID INT,
@TipoEquipo VARCHAR(50),
@ModeloEquipo VARCHAR(50),
@UsuarioEquipo INT
AS
	BEGIN
	UPDATE Equipos SET tipoEquipo = @TipoEquipo,modelo = @ModeloEquipo, usuarioID = @UsuarioEquipo WHERE equipoID = @EquipoID
	END
GO

CREATE PROCEDURE PcEliminarEquipo
@EquipoID INT
AS
	BEGIN
	DELETE from  Equipos WHERE equipoID = @EquipoID
	END
GO

--PROCEDIMIENTOS ALMACENADOS TABLA DE USUARIOS---

CREATE PROCEDURE PcAgregarUsuario
@Nombre VARCHAR(50),
@Correo VARCHAR(50),
@Telefono VARCHAR(15)
AS
	BEGIN
	INSERT INTO Usuarios (nombre, correoElectronico, telefono)VALUES (@Nombre,@Correo, @Telefono)
	END
GO

CREATE PROCEDURE PcConsultarUsuario
@UsuarioID INT
AS
	BEGIN
	SELECT * from  Usuarios WHERE usuarioID = @UsuarioID
	END
GO

CREATE PROCEDURE PcModificarUsuario
@UsuarioID INT,
@Nombre VARCHAR(50),
@Correo VARCHAR(50),
@Telefono VARCHAR(15)
AS
	BEGIN
	UPDATE Usuarios SET nombre = @Nombre,correoElectronico = @Correo, telefono = @Telefono WHERE usuarioID = @UsuarioID
	END
GO

CREATE PROCEDURE PcEliminarUsuario
@UsuarioID INT
AS
	BEGIN
	DELETE from  Usuarios WHERE usuarioID = @UsuarioID
	END
GO

--PROCEDIMIENTOS ALMACENADOS TABLA DE TECNICOS---

-- tecnicoID INT IDENTITY(1,1) PRIMARY KEY,
-- nombre VARCHAR(50) NOT NULL,
-- especialidad VARCHAR(50)

CREATE PROCEDURE PcAgregarTecnico
@Nombre VARCHAR(50),
@Especialidad VARCHAR(50)
AS
	BEGIN
	INSERT INTO Tecnicos (nombre, especialidad)VALUES (@Nombre,@Especialidad)
	END
GO

CREATE PROCEDURE PcConsultarTecnico
@TecnicoID INT
AS
	BEGIN
	SELECT * from  Tecnicos WHERE tecnicoID = @TecnicoID
	END
GO

CREATE PROCEDURE PcModificarTecnico
@TecnicoID INT,
@Nombre VARCHAR(50),
@Especialidad VARCHAR(50)
AS
	BEGIN
	UPDATE Tecnicos SET nombre = @Nombre,especialidad = @Especialidad WHERE tecnicoID = @TecnicoID
	END
GO

CREATE PROCEDURE PcEliminarTecnico
@TecnicoID INT
AS
	BEGIN
	DELETE from  Tecnicos WHERE tecnicoID = @TecnicoID
	END
GO
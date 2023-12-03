

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

CREATE TABLE systemUsers
(
userID INT IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
correoElectronico VARCHAR(50) NOT NULL,
telefono VARCHAR(15),
contrasenna VARCHAR(40) NOT NULL,
CONSTRAINT uq_correo UNIQUE(correoElectronico)
)
GO

CREATE TABLE Tecnicos
(
tecnicoID INT IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
especialidad VARCHAR(50),
idSystemUsers INT NOT NULL,
CONSTRAINT fkIdSystemUsers FOREIGN KEY(idSystemUsers) REFERENCES systemUsers(userID)
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
CONSTRAINT fkreparacionID FOREIGN KEY (reparacionID) REFERENCES Reparaciones(reparacionID)
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



INSERT INTO systemUsers (nombre, correoElectronico, telefono, contrasenna)
VALUES
('Ana García', 'ana.garcia@example.com', '555-1234', 'contrasenna1'),
('Pedro Martínez', 'pedro.martinez@example.com', '555-5678', 'contrasenna2'),
('Laura Sánchez', 'laura.sanchez@example.com', NULL, 'contrasenna3'),
('Luis Rodríguez', 'luis.rodriguez@example.com', '555-9012', 'contrasenna4'),
('Sofía Hernández', 'sofia.hernandez@example.com', '555-3456', 'contrasenna5'),
('Javier Pérez', 'javier.perez@example.com', NULL, 'contrasenna6'),
('Elena Gómez', 'elena.gomez@example.com', '555-7890', 'contrasenna7');
GO

CREATE TABLE roles
(
RolID INT IDENTITY(1,1) PRIMARY KEY,
nombreRol VARCHAR(40) CONSTRAINT uq_nombreRol UNIQUE
)
GO

CREATE TABLE usersRoles
(
idUserRol INT CONSTRAINT fk_idUser FOREIGN KEY (idUserRol) REFERENCES systemUsers(userID),
idRolUser INT CONSTRAINT fk_idRol FOREIGN KEY (idRolUser) REFERENCES roles(RolID)
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
INSERT INTO Tecnicos (nombre, especialidad, idSystemUsers)
VALUES
('Pedro Martínez', 'Hardware', 1),
('Luis Rodríguez', 'Redes', 4),
('Elena Gómez', 'Software', 7)


-- Insertar datos en la tabla Equipos
INSERT INTO Equipos (tipoEquipo, modelo, usuarioID)
VALUES
('Laptop', 'Dell XPS 13', 1),
('Impresora', 'HP LaserJet Pro', 2),
('Router', 'Linksys AC1200', 3),
('Tablet', 'Samsung Galaxy Tab S7', 4),
('Desktop', 'HP Pavilion', 5),
('Smartphone', 'iPhone 13', 6);
GO

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


--PROCEDIMIENTOS ALMACENADOS TABLA DE REPARACIONES---



SELECT
    T.nombre AS 'Nombre del tecnico',
    A.asignacionID AS 'Código de asignacion',
    A.fechaAsignacion AS 'Fecha de la asignacion',
    E.tipoEquipo AS 'Tipo de equipo',
    E.modelo AS 'Modelo de equipo',
    U.nombre AS 'Nombre de Usuario'
FROM
    Asignaciones A
INNER JOIN Tecnicos T ON A.tecnicoID = T.tecnicoID
INNER JOIN Reparaciones R ON A.reparacionID = R.reparacionID
INNER JOIN Equipos E ON R.equipoID = E.equipoID
INNER JOIN Usuarios U ON E.usuarioID = U.usuarioID;

SELECT
    T.nombre,
    A.asignacionID,
    A.fechaAsignacion,
    E.tipoEquipo,
    E.modelo,
    U.nombre
FROM
    Asignaciones A
INNER JOIN Tecnicos T ON A.tecnicoID = T.tecnicoID
INNER JOIN Reparaciones R ON A.reparacionID = R.reparacionID
INNER JOIN Equipos E ON R.equipoID = E.equipoID
INNER JOIN Usuarios U ON E.usuarioID = U.usuarioID;


SELECT
    Tecnicos.nombre,
    Asignaciones.asignacionID,
    Asignaciones.fechaAsignacion,
    Equipos.tipoEquipo ,
    Equipos.modelo,
    Usuarios.nombre
FROM
    Asignaciones
INNER JOIN Tecnicos ON Asignaciones.tecnicoID = Tecnicos.tecnicoID
INNER JOIN Reparaciones ON Asignaciones.reparacionID = Reparaciones.reparacionID
INNER JOIN Equipos ON Reparaciones.equipoID = Equipos.equipoID
INNER JOIN Usuarios ON Equipos.usuarioID = Usuarios.usuarioID;




-- Agregar roles
INSERT INTO roles (nombreRol) VALUES ('Admin'), ('Tecnico'), ('Lector');
GO
-- Asignar roles a usuarios
INSERT INTO usersRoles (idUserRol, idRolUser) VALUES
(1, 1), -- Ana García es Admin
(2, 2), -- Pedro Martínez es Tecnico
(3, 3), -- Laura Sánchez es Lector
(4, 2), -- Luis Rodríguez es Tecnico
(5, 3), -- Sofía Hernández es Lector
(6, 1), -- Javier Pérez es Admin
(7, 2); -- Elena Gómez es Tecnico
GO

CREATE PROCEDURE PCValidarUsuario
@correo varchar(50),
@clave varchar(50)
	AS
		BEGIN 
			SELECT correoElectronico, contrasenna FROM systemUsers WHERE correoElectronico=@correo AND contrasenna=@clave
		END

		GO

		EXEC PCValidarUsuario 'ana.garcia@example.com', 'contrasenna1'


--PROCEDIMIENTOS ALMACENADOS TABLA DE USUARIOS SISTEMA ---

CREATE PROCEDURE PcAgregarUsuarioSistema
@Nombre VARCHAR(50),
@Correo VARCHAR(50),
@Telefono VARCHAR(15),
@Password VARCHAR(50)
AS
	BEGIN
	INSERT INTO systemUsers(nombre, correoElectronico, telefono, contrasenna)VALUES (@Nombre,@Correo, @Telefono, @Password)
	END
GO

CREATE PROCEDURE PcModificarUsuarioSistema
@userID INT,
@Nombre VARCHAR(50),
@Correo VARCHAR(50),
@Telefono VARCHAR(15),
@Password VARCHAR(50)
AS
	BEGIN
	UPDATE systemUsers SET nombre = @Nombre,correoElectronico = @Correo, telefono = @Telefono, contrasenna = @Password WHERE userID = @userID
	END
GO

CREATE PROCEDURE PcConsultarUsuarioSistema
@UsuarioID INT
AS
	BEGIN
	SELECT * from  systemUsers WHERE userID = @UsuarioID
	END
GO

CREATE PROCEDURE PcEliminarUsuarioSistema
@UsuarioID INT
AS
	BEGIN
	DELETE from  systemUsers WHERE userID = @UsuarioID
	END
GO

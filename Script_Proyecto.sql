/* Proyecto de Conservatorio Castella
Integrantes: Maria del Mar Acón Vargas, Geiner Zúñiga Flores, Kriscia Campos Cárdenas,
			 Melany Lawson Mendez, Alfieri Mora Jiménez*/

Use Master 
go
Create Database ConservatorioCastella
--Archivo Primario
On Primary
(
Name='CoservatorioCastella_Data',
FIlename='C:\SQLData\CoservatorioCastella_Data.mdf',
size=60Mb,
maxsize=80Mb,
filegrowth=2Mb)
--Archivo de Registro
Log On
(
Name='CoservatorioCastella_Log',
FIlename='C:\SQLLOG\CoservatorioCastella_Log.ldf',
size=50Mb,
maxsize=60Mb,
filegrowth=5Mb
)
Go
---Archivo Secundario
Use Master
Go
Alter Database ConservatorioCastella
Add file
(
Name='CoservatorioCastella_sec_Data',
FIlename='C:\SQLLOG\CoservatorioCastella_sec_Data.ndf',
size=40Mb,
maxsize=50Mb,
filegrowth=4Mb
)
Go

---Creación de Filegroups
Use master
Go
Alter Database ConservatorioCastella
Add Filegroup Personas
Go

Use MAster
Go
Alter Database ConservatorioCastella
Add FIlegroup Administracion
Go

Use MAster
Go
Alter Database ConservatorioCastella
Add FIlegroup Infraestructura
Go


--Se crea el archivo de datos para el Filegroup Personas
Use Master
GO
Alter database ConservatorioCastella
Add file
(Name='Personas_Data',
Filename='C:\SQLData\Personas_Data.ndf',
Size=20Mb,
Maxsize=30Mb,
Filegrowth=4Mb
)
TO FILEGROUP Personas
GO

--Se crea el archivo de datos para el Filegroup Infraestructura
Use Master
Go
Alter database ConservatorioCastella
Add file
(Name='Infraestructura_Data',
Filename='C:\SQLData\Infraestructura.ndf',
Size=30Mb,
Maxsize=35Mb,
Filegrowth=4Mb
)
TO FILEGROUP Infraestructura
GO

--Se crea el archivo de datos para el Filegroup Administracion
Use Master
Alter database ConservatorioCastella
Add file
(Name='Administraticion_Data',
Filename='C:\SQLData\Administrativo.ndf',
Size=30Mb,
Maxsize=35Mb,
Filegrowth=4Mb
)
TO FILEGROUP Administracion
GO

--Ver el estado de la base de datos
sp_helpDb ConservatorioCastella

--Ver el estado de los Filegroups 
Use ConservatorioCastella
GO
sp_helpfilegroup


/*En este apartado se crean las tablas de la base de datos y se asignan 
al filegroup personas*/

--Creacion de la tabla Encargado
Use ConservatorioCastella
GO
Create table Encargado(
Dni_Encargado varchar(10) NOT NULL,
Nombre varchar(30) NOT NULL,
Apellido1 varchar(30) NOT NULL,
Apellido2 varchar(30) NOT NULL,
PRIMARY KEY(Dni_Encargado)
) ON Personas


--Creacion de la tabla Alumno
Create table Alumno(
Dni_Alumno varchar(10) NOT NULL,
Nombre varchar(30) NOT NULL,
Apellido1 varchar(30) NOT NULL,
Apellido2 varchar(30) NOT NULL,
FechaNacimiento date NULL,
Telefono_Contacto int NOT NULL,
Numero_Expediente varchar(10) NULL,
Estado text,
FK_Dni_Encargado varchar(10) NOT NULL,
PRIMARY KEY(Dni_Alumno),
FOREIGN KEY(FK_Dni_Encargado) REFERENCES Encargado(Dni_Encargado)
) ON Personas

Create table Profesor(
Dni_Profesor varchar(10) NOT NULL,
Nombre varchar(30) NOT NULL,
Apellido1 varchar(30) NOT NULL,
Apellido2 varchar(30) NOT NULL,
Telefono_Contacto int NOT NULL,
Estado text NOT NULL,
PRIMARY KEY(Dni_Profesor),
)ON Personas
GO


/*En este apartado se crean las tablas que se consideran parte administrativa o de interes
del conservatorio, se añaden al Filegroup Administracion*/

--Creacion de la tabla Tipo
Use ConservatorioCastella
GO
Create Table Tipo(
 Id_Tipo int NOT NULL,
 Nombre varchar(30),
 PRIMARY KEY(id_Tipo)
 )ON Administracion
 GO

 --Creacion de la tabla Instrumento
Use ConservatorioCastella
GO
Create Table Instrumento(
 Id_Instrumento int NOT NULL,
 Nombre varchar(30) NOT NULL,
 EdadRecomendada int NOT NULL,
 FK_IdTipo int NOT NULL,
 PRIMARY KEY(Id_Instrumento),
 FOREIGN KEY(FK_IdTipo) REFERENCES Tipo(Id_Tipo)

)ON Administracion
GO

--Creacion de la tabla AlumnoInstrumento
Use ConservatorioCastella
GO
Create Table AlumnoInstrumento(
Id_AlumnoInstrumento INTEGER IDENTITY(1,1) NOT NULL,
FK_DniAlumno varchar(10) NOT NULL,
FK_IdInstrumento int NOT NULL,
FechaInicioInstrumento date,
PRIMARY KEY(Id_AlumnoInstrumento),
FOREIGN KEY(FK_DniAlumno) REFERENCES Alumno(Dni_Alumno),
FOREIGN KEY(FK_IdInstrumento) REFERENCES Instrumento(Id_Instrumento)
) ON Administracion
GO



--Creacion de la tabla Asignatura Instrumental
Use ConservatorioCastella
GO
Create Table AsignaturaInstrumental(
Codigo_AsignaturaInstrumental varchar(20) NOT NULL,
Nombre varchar(30) NOT NULL,
CantidadHoras int NOT NULL,
FK_IdAulaInstrumental varchar(10)
PRIMARY KEY(Codigo_AsignaturaInstrumental)
--Falta añadir la relacion con la llave foránea 
)ON Administracion

--Creacion de la tabla Asignatura No Instrumental
Use ConservatorioCastella
GO
Create Table AsignaturaNoInstrumental(
Codigo_AsignaturaNoInstrumental varchar(20) NOT NULL,
Nombre varchar(30) NOT NULL,
CantidadHoras int NOT NULL,
FK_IdAulaMagistral varchar(10)
PRIMARY KEY(Codigo_AsignaturaNoInstrumental)
--Falta añadir la relacion con la llave foránea de Aula Magistral
)ON Administracion

Create Table AlumnoAsignaturaInstrumental(
Id_AlumnoAsignatura INTEGER IDENTITY(1,1) NOT NULL,
FK_DniAlumno varchar(10) NOT NULL,
FK_CodigoAsignaturaInstrumental varchar(20) NOT NULL,
FOREIGN KEY(FK_DniAlumno) REFERENCES Alumno(Dni_Alumno),
FOREIGN KEY(FK_CodigoAsignaturaInstrumental) REFERENCES AsignaturaInstrumental(Codigo_AsignaturaInstrumental)
) ON Administracion
GO

Create Table AlumnoAsignaturaNoInstrumental(
Id_AlumnoAsignatura INTEGER IDENTITY(1,1) NOT NULL,
FK_DniAlumno varchar(10) NOT NULL,
FK_CodigoAsignaturaNoInstrumental varchar(20) NOT NULL,
FOREIGN KEY(FK_DniAlumno) REFERENCES Alumno(Dni_Alumno),
FOREIGN KEY(FK_CodigoAsignaturaNoInstrumental) REFERENCES AsignaturaNoInstrumental(Codigo_AsignaturaNoInstrumental)
) ON Administracion
GO



/*Creacion de las tablas de Aulas y Edificios que van al filegroup de Infraestructura*/


Create Table Edificio(
Codigo_Edificio varchar(15) NOT NULL,
Calle varchar(20) NULL,
Numero int NULL,
Direccion varchar(50)
PRIMARY KEY(Codigo_Edificio)
) ON Infraestructura
GO


Create Table AulasMagistrales(
Id_AulaMagistral varchar(30) NOT NULL,
Equipada bit NOT NULL,
Nombre varchar(20),
Aforo int NOT NULL,
PRIMARY KEY(Id_AulaMagistral)
) ON Infraestructura
GO

Create Table AulasInstrumentales(
Id_AulaInstrumental varchar(30) NOT NULL,
Metros_Poseidos int NOT NULL,
Nombre varchar(20) NULL,
Aforo int NOT NULL,
FK_CodigoEdificio varchar(15) NOT NULL,
FK_CodigoAsignaturaInstrumental varchar(20) NOT NULL,
PRIMARY KEY(Id_AulaInstrumental),
FOREIGN KEY(FK_CodigoEdificio) REFERENCES Edificio(Codigo_Edificio),
FOREIGN KEY(FK_CodigoAsignaturaInstrumental) REFERENCES AsignaturaInstrumental(Codigo_AsignaturaInstrumental)
) ON Infraestructura
GO


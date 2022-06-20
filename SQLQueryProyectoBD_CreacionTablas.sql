/* Proyecto de Conservatorio Castella
Integrantes: Maria del Mar Acón Vargas, Geiner Zúñiga Flores, Kriscia Campos Cárdenas,
			 Melany Lawson Mendez, Alfieri Mora Jiménez*/


--Ver el estado de la base de datos
sp_helpDb ConservatorioCastella

--Ver el estado de los Filegroups 
Use ConservatorioCastella
GO
sp_helpfilegroup


/*En este apartado se crean las tablas de la base de datos y se asignan 
al filegroup personas*/


--Tabla ENCARGADO
Use ConservatorioCastella
GO
Create table Encargado(
Dni_Encargado varchar(10) NOT NULL,
Nombre varchar(30) NOT NULL,
Apellido1 varchar(30) NOT NULL,
Apellido2 varchar(30) NOT NULL,
Constraint PK_Encargado
PRIMARY KEY(Dni_Encargado)
) ON Personas
Go

Sp_help Encargado
go

--Tabla ALUMNO
Use ConservatorioCastella
GO
Create table Alumno(
Dni_Alumno varchar(10) NOT NULL,
Nombre varchar(30) NOT NULL,
Apellido1 varchar(30) NOT NULL,
Apellido2 varchar(30) NOT NULL,
FechaNacimiento date NULL,
Telefono_Contacto int NOT NULL,
Numero_Expediente varchar(10) NULL,
Estado text,
FK_Dni_Encargado varchar(10) NULL,
Constraint PK_Alumno
PRIMARY KEY(Dni_Alumno),
) ON Personas
Go
--Tabla PROFESOR
Use ConservatorioCastella
GO
Create table Profesor(
Dni_Profesor varchar(10) NOT NULL,
Nombre varchar(30) NOT NULL,
Apellido1 varchar(30) NOT NULL,
Apellido2 varchar(30) NOT NULL,
Telefono_Contacto int NOT NULL,
Estado text NOT NULL,
COnstraint PK_Profesor
PRIMARY KEY(Dni_Profesor),
)ON Personas
GO




/*En este apartado se crean las tablas que se consideran parte ADMINISTRATIVA o de interes
del conservatorio, se añaden al Filegroup Administracion*/

--Tabla TIPO
Use ConservatorioCastella
GO
Create Table Tipo(
 Id_Tipo int NOT NULL,
 Nombre varchar(30),
 COnstraint PK_Tipo
 PRIMARY KEY(id_Tipo)
 )ON Administracion
 GO

 --Tabla INSTRUMENTO
Use ConservatorioCastella
GO
Create Table Instrumento(
 Id_Instrumento int NOT NULL,
 Nombre varchar(30) NOT NULL,
 EdadRecomendada int NOT NULL,
 FK_IdTipo int NOT NULL,
 Constraint PK_Instrumento
 PRIMARY KEY(Id_Instrumento),
 FOREIGN KEY(FK_IdTipo) REFERENCES Tipo(Id_Tipo)

)ON Administracion
GO

--

---Tabla CURSO

Use ConservatorioCastella
GO
Create table Curso(
Año int NOT NULL,
Fecha_Inicio date NOT NULL,
Fecha_Final date NOT NULL
Constraint PK_Curso
PRIMARY KEY(Año)
) ON Administracion
GO


--Tabla ASIGNATURA INSTRUMENTAL
Use ConservatorioCastella
GO
Create Table AsignaturaInstrumental(
Codigo_AsignaturaInstrumental varchar(20) NOT NULL,
Nombre varchar(30) NOT NULL,
CantidadHoras int NOT NULL,
FK_IdAulaInstrumental varchar(30) Not Null,
Constraint PK_AsignaturaInstrumental
PRIMARY KEY(Codigo_AsignaturaInstrumental),
FOREIGN KEY(FK_IdAulaInstrumental) REFERENCES AulasInstrumentales(Id_AulaInstrumental)
)ON Administracion

go

Use ConservatorioCastella
GO
Create Table EncargadoAlumno(
Id INTEGER IDENTITY(1,1) NOT null,
FK_DniAlumno varchar(10) NOT NULL,
DniEncargado varchar(10) NOT NULL,
Constraint PK_EncargadoAlumno
PRIMARY KEY(Id),
FOREIGN KEY (FK_DniAlumno) REFERENCES Alumno(Dni_Alumno),
)On Administracion
GO


--Tabla ALUMNO INSTRUMENTO
Use ConservatorioCastella
GO
Create Table AlumnoInstrumento(
Id_AlumnoInstrumento INTEGER IDENTITY(1,1) NOT NULL,
FK_DniAlumno varchar(10) NOT NULL,
FK_IdInstrumento int NOT NULL,
FechaInicioInstrumento date,
Constraint PK_AlumnoInstrumento
PRIMARY KEY(Id_AlumnoInstrumento),
FOREIGN KEY(FK_DniAlumno) REFERENCES Alumno(Dni_Alumno),
FOREIGN KEY(FK_IdInstrumento) REFERENCES Instrumento(Id_Instrumento)
) ON Administracion
GO




--Tabla ASIGNATURA MAGISTRAL
Use ConservatorioCastella
GO
Create Table AsignaturaMagistral(
Codigo_AsignaturaMagistral varchar(20) NOT NULL,
Nombre varchar(30) NOT NULL,
CantidadHoras int NOT NULL,
FK_IdAulaMagistral varchar(30),
Constraint PK_AsignaturaNoInstrumental
PRIMARY KEY(Codigo_AsignaturaMagistral),
FOREIGN KEY(FK_IdAulaMagistral) REFERENCES AulasMagistrales(Id_AulaMagistral)

)ON Administracion
go


Use ConservatorioCastella
GO
Create Table AlumnoAsignaturaInstrumental(
Id_AlumnoAsignatura INTEGER IDENTITY(1,1) NOT NULL,
FK_DniAlumno varchar(10) NOT NULL,
FK_CodigoAsignaturaInstrumental varchar(20) NOT NULL,
FOREIGN KEY(FK_DniAlumno) REFERENCES Alumno(Dni_Alumno),
FOREIGN KEY(FK_CodigoAsignaturaInstrumental) REFERENCES AsignaturaInstrumental(Codigo_AsignaturaInstrumental)
) ON Administracion
GO


Use ConservatorioCastella
GO
Create Table AlumnoAsignaturaMagistral(
Id_AlumnoAsignatura INTEGER IDENTITY(1,1) NOT NULL,
FK_DniAlumno varchar(10) NOT NULL,
FK_CodigoAsignaturaMagistral varchar(20) NOT NULL,
FOREIGN KEY(FK_DniAlumno) REFERENCES Alumno(Dni_Alumno),
FOREIGN KEY(FK_CodigoAsignaturaMagistral) REFERENCES AsignaturaMagistral(Codigo_AsignaturaMagistral)
) ON Administracion
GO

---Tabla ENSAYO RESERVA
Use ConservatorioCastella
GO
 Create Table EnsayoReserva
 (
   Codigo_EnsayoReserva   varchar(30) Not NUll,
   Hora_Inicio            Time NUll,
   Hora_Fin               Time NUll,
   Fecha                  Date Null,
   Dni_Profesor           varchar(10) Not NUll,
   Dni_Alumno             varchar(10) Not NUll
   Constraint PK_EnsayoReserva
   Primary Key Clustered (Codigo_EnsayoReserva)
   Foreign Key (Dni_Profesor) References Profesor(Dni_Profesor),
   Foreign Key (Dni_Alumno) References Alumno (Dni_Alumno)

 )ON Administracion
 Go

 --Tabla ASIGNATURA INSTRUMENTal PROFESOR
 
Use ConservatorioCastella
GO
 Create Table AsignaturaInstrumentalProfesor(
   Id_AsignaturaInstrumentalProfesor INTEGER IDENTITY(1,1) NOT NULL,
   Fk_Codigo_AsignaturaInstrumental varchar(20) Not NULL,  
   Fk_Dni_Profesor           varchar(10) Not NUll,
   Constraint PK_AsignaturaInstrumentalProfesor
   Primary Key  (Id_AsignaturaInstrumentalProfesor),
   Foreign Key (Fk_Codigo_AsignaturaInstrumental) References AsignaturaInstrumental (Codigo_AsignaturaInstrumental),
   Foreign Key (Fk_Dni_Profesor) References Profesor(Dni_Profesor)

 )On Administracion
 GO

 Use ConservatorioCastella
GO
 Create Table AsignaturaMagistralProfesor(
  Id_AsignaturaMagistralProfesor   INTEGER IDENTITY(1,1) NOT NULL,
  FK_Codigo_AsignaturaMagistral  varchar(20) NOT NULL,
  FK_Dni_Profesor           varchar(10) Not NUll
  Constraint PK_AsignaturaMagistralProfesor
   Primary Key  (Id_AsignaturaMagistralProfesor),
   Foreign Key (FK_Codigo_AsignaturaMagistral) References AsignaturaMagistral (Codigo_AsignaturaMagistral),
   Foreign Key (Fk_Dni_Profesor) References Profesor(Dni_Profesor)

 )On Administracion
 GO





  --Tabla INSTRUMENTO PROFESOR

 Use ConservatorioCastella
GO
 Create Table  InstrumentoProfesor(
   Id_InstrumentoProfesor INTEGER IDENTITY(1,1) NOT NULL,
   Id_Instrumento         int NOT NULL,    
   Dni_Profesor           varchar(10) Not NUll
   Constraint PK_InstrumentoProfesor
   Primary Key Clustered (Id_InstrumentoProfesor)
   Foreign Key (Id_Instrumento) References Instrumento (Id_Instrumento),
   Foreign Key (Dni_Profesor) References Profesor(Dni_Profesor)

 )On Administracion
 GO


Use ConservatorioCastella
GO
 Create Table AlumnoCursoAsignaturaMagistral(
Id_CursoAsignatura  INTEGER IDENTITY(1,1) NOT NULL,
Fk_Dni_Alumno             varchar(10) Not NUll,
FK_Año                    int NOT NULL,
FK_Codigo_AsignaturaMagistral  varchar(20) NOT NULL, 
Nota           int  Null,
 Constraint PK_AlumnoCursoAsignaturas
 Primary Key (Id_CursoAsignatura),
 FOREIGN KEY(FK_Dni_Alumno) REFERENCES Alumno(Dni_Alumno),
 Foreign Key (FK_Codigo_AsignaturaMagistral) References AsignaturaMagistral (Codigo_AsignaturaMagistral),
 ) ON Administracion
 GO


Use ConservatorioCastella
GO
 Create Table AlumnoCursoAsignaturaInstrumental(
Id_CursoAsignatura  INTEGER IDENTITY(1,1) NOT NULL,
Fk_Dni_Alumno             varchar(10) Not NUll,
FK_Año                    int NOT NULL,
FK_Codigo_AsignaturaInstrumental  varchar(20) NOT NULL, 
Nota           int  Null,
 Constraint PK_AlumnoCursoAsignaturaInstrumental
 Primary Key (Id_CursoAsignatura),
 FOREIGN KEY(FK_Dni_Alumno) REFERENCES Alumno(Dni_Alumno),
 Foreign Key (FK_Codigo_AsignaturaInstrumental) References AsignaturaInstrumental (Codigo_AsignaturaInstrumental),
 ) ON Administracion
 GO


 --Nuevas Tablas

Use ConservatorioCastella
GO
Create table CursoProfesorAsignatura(
Id_CursoProfesorAsignatura INTEGER IDENTITY(1,1) NOT NULL,
FK_Dni_Profesor varchar(10) NOT NULL,
FK_Año int NOT NULL,
FK_Codigo_AsignaturaMagistral varchar(20) NOT NULL,
COnstraint PK_CursoProfesorAsignatura
PRIMARY KEY(Id_CursoProfesorAsignatura),
 FOREIGN KEY(FK_Dni_Profesor) REFERENCES Profesor(Dni_Profesor),
  FOREIGN KEY(FK_Año) REFERENCES Curso(Año),
   FOREIGN KEY(FK_Codigo_AsignaturaMagistral) REFERENCES AsignaturaMagistral(Codigo_AsignaturaMagistral), 
)ON Administracion
GO


Use ConservatorioCastella
GO
Create table ProfesorAsignatura(
Id_ProfesorAsignatura INTEGER IDENTITY(1,1) NOT NULL,
FK_Dni_Profesor varchar(10) NOT NULL,
FK_Codigo_AsignaturaMagistral varchar(20) NOT NULL,
COnstraint PK_ProfesorAsignatura
PRIMARY KEY(Id_ProfesorAsignatura),
 FOREIGN KEY(FK_Dni_Profesor) REFERENCES Profesor(Dni_Profesor),
   FOREIGN KEY(FK_Codigo_AsignaturaMagistral) REFERENCES AsignaturaMagistral(Codigo_AsignaturaMagistral), 
)ON Administracion
GO

Use ConservatorioCastella
GO
Create Table TipoInstrumento(
 Id_TipoInstrumento INTEGER IDENTITY(1,1) NOT NULL,
 FK_Id_Tipo int Not NUll,
  FK_Id_Instrumento int NOT NULL,
 COnstraint PK_TipoInstrumento
 PRIMARY KEY(Id_TipoInstrumento),
  FOREIGN KEY(FK_Id_Tipo) REFERENCES Tipo(Id_Tipo),
    FOREIGN KEY(FK_Id_Instrumento) REFERENCES Instrumento(Id_Instrumento)
 )ON Administracion
 GO






 /*Creacion de las tablas de Aulas y Edificios que van al filegroup de Infraestructura*/

Use ConservatorioCastella
GO
Create Table Edificio(
Codigo_Edificio varchar(15) NOT NULL,
Calle varchar(20) NULL,
Numero int NULL,
Direccion varchar(50)
Constraint PK_Edificio
PRIMARY KEY(Codigo_Edificio)
) ON Infraestructura
GO

Use ConservatorioCastella
GO
Create Table AulasMagistrales(
Id_AulaMagistral varchar(30) NOT NULL,
Equipada bit NOT NULL,
Nombre varchar(20),
Aforo int NOT NULL,
Constraint Pk_AulasMAgistrales
PRIMARY KEY(Id_AulaMagistral)
) ON Infraestructura
GO

Use ConservatorioCastella
GO
Create Table AulasInstrumentales(
Id_AulaInstrumental varchar(30) NOT NULL,
Metros_Poseidos int NOT NULL,
Nombre varchar(20) NULL,
Aforo int NOT NULL,
FK_Id_Instrumento int NOT NULL,
FK_CodigoEdificio varchar(15) NOT NULL,
FK_CodigoAsignaturaInstrumental varchar(20) NOT NULL,
Constraint PK_AulasInstrumentales
PRIMARY KEY(Id_AulaInstrumental),
FOREIGN KEY(FK_Id_Instrumento) REFERENCES Instrumento(Id_Instrumento),
FOREIGN KEY(FK_CodigoEdificio) REFERENCES Edificio(Codigo_Edificio),
) ON Infraestructura
GO

--Se agrega la columna Edad a Alumno para la elaboracion de un trigger
Use ConservatorioCastella
GO
Alter Table Alumno
ADD Edad int  NULL
GO




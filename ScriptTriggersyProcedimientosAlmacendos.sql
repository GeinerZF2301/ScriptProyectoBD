

USE ConservatorioCastella
GO
Create trigger TR_ValidarInsercionAlumno
On Alumno
For Insert
As
	IF(select Edad from inserted) < 18 AND (select FK_Dni_Encargado from inserted) = ''
	Begin
		ROLLBACK TRANSACTION
		PRINT 'INSERCION DENEGADA'
		PRINT 'EL ALUMNO ES MENOR DE 18 DE AÑOS'
		PRINT 'DEBE INGRESAR EL DNI DEL ENCARGADO'
		end
	ELSE
		PRINT 'ALUMNO REGISTRADO CORRECTAMENTE EN PERSONAS'
GO

--Insertar en tabla Intermediaria
Create Trigger TR_INSERTENCARGADOALUMNO
On Alumno For Insert
As
	set nocount on
	declare @DniAlumno varchar(10)
	declare @DniEncargado varchar (10)
	select @DniAlumno = Dni_Alumno from inserted
	select @DniEncargado = FK_Dni_Encargado from inserted
	insert into EncargadoAlumno values(@DniAlumno,@DniEncargado)
	PRINT 'ALUMNO REGISTRADO EN ADMINISTRACION'
	GO


	--Insertar en tabla Intermediaria
<<<<<<< HEAD
--Create Trigger TR_INSERTINSTRUMENTOPROFESOR
--On Profesor after insert AND On Instrumento after insert
--As
--	set nocount on
--	declare @DniProfesor varchar(10) = (select Dni_Profesor from inserted)

--	insert into InstrumentoProfesor values(@DniProfesor)
--	PRINT 'PROFESOR REGISTRADO EN ADMINISTRACION'
--	END
=======
	-----No me sirve
Create Trigger TR_INSERTINSTRUMENTOPROFESOR
On Profesor after insert AND On Instrumento after insert
As
	set nocount on
	declare @DniProfesor varchar(10) = (select Dni_Profesor from inserted)

	insert into InstrumentoProfesor values(@DniProfesor)
	PRINT 'PROFESOR REGISTRADO EN ADMINISTRACION'
	END
	GO
>>>>>>> e724a4bde802dccd5d23cb18a771f073f1bc5723

	------------------------------------------------------------------------------------------------

sp_Help Instrumento
go

use ConservatorioCastella
INSERT INTO Alumno (Dni_Alumno,NombreAlumno,Apellido1,Apellido2,FechaNacimiento,Telefono_Contacto,Numero_Expediente,Estado,FK_Dni_Encargado,Edad)
 values('0987','Maria','Acon','Vargas','06/06/2022','1233','00098','Activo', '90908',12)
GO

use ConservatorioCastella
INSERT INTO Alumno (Dni_Alumno,NombreAlumno,Apellido1,Apellido2,FechaNacimiento,Telefono_Contacto,Numero_Expediente,Estado,FK_Dni_Encargado,Edad)
			values('0986787','Geiner','Zuniga','Flores','06/06/2022','09678','098','Activo','0998', 10)
GO

use ConservatorioCastella
INSERT INTO Alumno (Dni_Alumno,NombreAlumno,Apellido1,Apellido2,FechaNacimiento,Telefono_Contacto,Numero_Expediente,Estado,FK_Dni_Encargado,Edad)
			values('0986787','Geiner','Zuniga','Flores','06/06/2022','09678','098','Activo','0998', 10)
GO

use ConservatorioCastella
INSERT INTO Alumno (Dni_Alumno,NombreAlumno,Apellido1,Apellido2,FechaNacimiento,Telefono_Contacto,Numero_Expediente,Estado,FK_Dni_Encargado,Edad)
			values('345345','Kriscia','Campos','Cardenas','06/06/2022','434','4534','Activo','878', 15)
GO

use ConservatorioCastella
INSERT INTO Alumno (Dni_Alumno,NombreAlumno,Apellido1,Apellido2,FechaNacimiento,Telefono_Contacto,Numero_Expediente,Estado,FK_Dni_Encargado,Edad)
			values('05958','Melany','Lawson','Mendes','06/06/2022','434','4534','Activo','03938', 15)
GO

--Valida las reservaciones de los profesores para los ensayos, si no existe una reserva a en una fecha y hora en especifico
--Registrará la reserva
<<<<<<< HEAD
=======

>>>>>>> e724a4bde802dccd5d23cb18a771f073f1bc5723
Create PROCEDURE SP_InsertReservaEnsayo(@CodigoReserva varchar(30),@HoraInicio time, @HoraFin time,
@Fecha date, @DniProfesor varchar(10),@DniAlumno varchar(10))
AS
IF Exists(Select Fecha, Hora_Inicio,Hora_Fin from EnsayoReserva WHERE Fecha = @Fecha AND Hora_Inicio = @HoraInicio 
AND Hora_Fin = @HoraFin)
BEGIN
	PRINT 'NO SE PUEDE RESERVAR UN ENSAYO EN LA FECHA Y HORA ESPECIFICADA'
	PRINT '¡YA EXISTE UNA RESERVA EN ESE HORARIO!'
	RETURN END
ELSE
BEGIN
INSERT INTO EnsayoReserva(Codigo_EnsayoReserva, Hora_Inicio,Hora_Fin, Fecha, Dni_Profesor, Dni_Alumno)
Values(@CodigoReserva,@HoraInicio, @HoraFin,@Fecha,@DniProfesor,@DniAlumno)
PRINT '¡RESERVA REGISTRADA CORRECTAMENTE!'
RETURN END
GO

Execute SP_InsertReservaEnsayo 'Cod3484', '09:00:00', '3:00:00','06/06/2022', '0987', '05958'
GO


--Valida la existencia de una aula instrumental con un nombre en edificio, si no existe 
--registra el aula
Create Procedure SP_InsertAulaInstrumental( @Id_Aula varchar(30), @MetrosPoseidos int, @Nombre varchar(20), 
@Aforo int, @IdInstrumento int, @CodigoEdificio varchar(15), @CodigoAsignatura varchar(20))
AS
If Exists(Select Nombre, FK_CodigoEdificio from AulasInstrumentales Where  Nombre = @Nombre AND FK_CodigoEdificio = @CodigoEdificio)
BEGIN
	PRINT 'NO ES POSIBLE REGISTRAR'
	PRINT '¡YA EXISTE UNA AULA CON ESE NOMBRE EN ESE EDIFICIO!'
	RETURN END
ELSE
BEGIN
	INSERT INTO AulasInstrumentales(Id_AulaInstrumental,Metros_Poseidos,Nombre,Aforo, FK_Id_Instrumento,FK_CodigoEdificio,FK_CodigoAsignaturaInstrumental)
	VALUES(@Id_Aula,@MetrosPoseidos,@Nombre,@Aforo, @IdInstrumento,@CodigoEdificio, @CodigoAsignatura)
	PRINT '¡AULA REGISTRADA CORRECTAMENTE!'
	RETURN END
	GO



	Execute SP_InsertAulaInstrumental  'AI03', 6, 'Musica', 4, 1, E02,'AS01' 

	Sp_Help AsignaturaInstrumental


<<<<<<< HEAD
Use ConservatorioCastella
Go
Alter procedure Sp_InsertarAlumno (@Dni_Alummno varchar(10), @Dni_Encargado varchar(10), @Numero_Expediente varchar(10), @NombreAlumno varchar(10), @Apellido1 varchar(10), @Apellido2 varchar(10), @FechaNacimiento date, @Telefono_Contacto int, @Estado text )
AS
IF ((@Dni_Alummno)='' or (@Dni_Encargado)='' or (@Numero_Expediente)='' or (@NombreAlumno)='' or (@Apellido1)='' or (@Apellido2)='' or (@FechaNacimiento)='' or (@Telefono_Contacto)='')
BEGIN
	PRINT '¡FAVOR REVISAR!'
=======
	--ProcedimientoAlamacenado INSERTAR
	Use ConservatorioCastella
Go
Create procedure Sp_InsertarAulasMagistrales (@Id_AulaMagistral varchar(9), @Equipada bit, @Nombre_AulaMagistral varchar(30), @Aforo int)
AS
IF ((@Id_AulaMagistral='') or (@Equipada='') or (@Nombre_AulaMagistral='') or (@Aforo=''))
BEGIN
>>>>>>> e724a4bde802dccd5d23cb18a771f073f1bc5723
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
<<<<<<< HEAD
	insert into Alumno (Dni_Alumno, FK_Dni_Encargado, Numero_Expediente, NombreAlumno, Apellido1, Apellido2, FechaNacimiento, Telefono_Contacto, Estado)
Values (@Dni_Alummno, @Dni_Encargado, @Numero_Expediente, @NombreAlumno, @Apellido1, @Apellido2, @FechaNacimiento, @Telefono_Contacto, @Estado)
=======
	insert into AulasMagistrales (Id_AulaMagistral, Equipada, Nombre_AulaMagistral, Aforo)
Values (@Id_AulaMagistral, @Equipada, @Nombre_AulaMagistral, @Aforo)
	PRINT 'El Registro se ha ingresado correctamente'
END
GO
-------------------------------------------------------------------------------------------------------------------------------------------
Use ConservatorioCastella
Go
Create procedure Sp_InsertarAsignaturaMagistral (@Codigo_AsignaturaMagistral varchar(9), @Nombre_AsignaturaMagistral varchar(30), @CantidadHoras  int, @Id_AulaMagistral varchar(30))
AS
IF ((@Codigo_AsignaturaMagistral='') or (@Nombre_AsignaturaMagistral='') or (@CantidadHoras='') or (@Id_AulaMagistral=''))
BEGIN
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into AsignaturaMagistral (Codigo_AsignaturaMagistral, Nombre_AsignaturaMagistral, CantidadHoras, FK_Id_AulaMagistral)
Values (@Codigo_AsignaturaMagistral, @Nombre_AsignaturaMagistral, @CantidadHoras, @Id_AulaMagistral)
>>>>>>> e724a4bde802dccd5d23cb18a771f073f1bc5723
	PRINT 'El Registro se ha ingresado correctamente'
END
GO


<<<<<<< HEAD
--Insertar Alumnos por procedimiento almacenado
Execute Sp_InsertarAlumno '12321', '3434', '0595', 'Geiner', 'Zuniga', 'Flores', '06/06/2022', '34323', 'Inactivo'
Execute Sp_InsertarAlumno '09585', '', '0978', 'Maria', 'Acon', 'Vargas', '2001/05/23', '34323', 'Activo'

=======
	--ProcedimientoAlamacenado ELIMINAR

	  ------1

CREATE PROC sp_EliminarAlumnoAsignaturaMagistral(@Id_AlumnoAsignatura int  NULL)	
AS
IF  NOT EXISTS (SELECT Id_AlumnoAsignaturaMagistral  FROM AlumnoAsignaturaMagistral WHERE Id_AlumnoAsignaturaMagistral = @Id_AlumnoAsignatura) 
   BEGIN
       PRINT 'NO EXISTE'
   RETURN
END
IF ((@Id_AlumnoAsignatura=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
  RETURN
END
ELSE
  BEGIN
       DELETE FROM AlumnoAsignaturaMagistral WHERE Id_AlumnoAsignaturaMagistral= Id_AlumnoAsignaturaMagistral;
       PRINT 'SE HA ELIMINADO'
  RETURN
END	
GO

---------------------------------------------------------------
------2
Use ConservatorioCastella
go
CREATE PROC sp_EliminarAsignaturaMagistral(@Codigo_AsignaturaMagistral varchar(20) )
AS
IF  NOT EXISTS (SELECT Codigo_AsignaturaMagistral  FROM AsignaturaMagistral WHERE Codigo_AsignaturaMagistral = @Codigo_AsignaturaMagistral) 
    BEGIN
	     PRINT 'NO EXISTE'
    RETURN
END
IF ((@Codigo_AsignaturaMagistral=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_Codigo_AsignaturaMagistral FROM AlumnoAsignaturaMagistral WHERE FK_Codigo_AsignaturaMagistral = @Codigo_AsignaturaMagistral) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_Codigo_AsignaturaMagistral FROM AsignaturaMagistralProfesor WHERE FK_Codigo_AsignaturaMagistral = @Codigo_AsignaturaMagistral) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_Codigo_AsignaturaMagistral FROM AlumnoCursoAsignaturaMagistral WHERE FK_Codigo_AsignaturaMagistral = @Codigo_AsignaturaMagistral) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_Codigo_AsignaturaMagistral FROM ProfesorAsignatura WHERE FK_Codigo_AsignaturaMagistral = @Codigo_AsignaturaMagistral) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
   BEGIN
       DELETE FROM AsignaturaMagistral WHERE Codigo_AsignaturaMagistral= Codigo_AsignaturaMagistral;
       PRINT 'SE HA ELIMINADO'
   RETURN
END	
Go
----------------------------------------------------------------------------------------------
-----3

CREATE PROC sp_EliminarAulaMagistral(@Id_AulaMagistral varchar(30)  NULL)
AS
IF  NOT EXISTS (SELECT Id_AulaMagistral  FROM AulasMagistrales WHERE Id_AulaMagistral = @Id_AulaMagistral) 
    BEGIN
	     PRINT 'NO EXISTE'
    RETURN
END
IF ((@Id_AulaMagistral=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
   RETURN
END
ELSE
IF EXISTS (SELECT Id_AulaMagistral FROM AulasMagistrales WHERE Id_AulaMagistral = @Id_AulaMagistral) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
   BEGIN
       DELETE FROM AulasMagistrales WHERE Id_AulaMagistral= Id_AulaMagistral;
       PRINT 'SE HA ELIMINADO'
   RETURN
END	
GO
----------------------------------------------------------------------------------------------------
-----4
CREATE PROC sp_EliminarAlumnoAsignaturaInstrumental(@Id_AlumnoAsignatura int NULL)	
AS
IF  NOT EXISTS (SELECT Id_AlumnoAsignatura  FROM AlumnoAsignaturaInstrumental WHERE Id_AlumnoAsignatura = @Id_AlumnoAsignatura) 
   BEGIN
       PRINT 'NO EXISTE'
   RETURN
END
IF ((@Id_AlumnoAsignatura=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
  RETURN
END
ELSE
  BEGIN
       DELETE FROM AlumnoAsignaturaInstrumental WHERE Id_AlumnoAsignatura= Id_AlumnoAsignatura;
       PRINT 'SE HA ELIMINADO'
  RETURN
END	
GO

-------------------------------------------------------------------
-----5

CREATE PROC sp_EliminarAsignaturaInstrumental(@Codigo_AsignaturaInstrumental varchar(20))
AS
IF  NOT EXISTS (SELECT Codigo_AsignaturaInstrumental   FROM AsignaturaInstrumental WHERE Codigo_AsignaturaInstrumental = @Codigo_AsignaturaInstrumental) 
    BEGIN
	     PRINT 'NO EXISTE'
    RETURN
END
IF ((@Codigo_AsignaturaInstrumental=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_Codigo_AsignaturaInstrumental FROM AlumnoAsignaturaInstrumental WHERE Codigo_AsignaturaInstrumental = @Codigo_AsignaturaInstrumental) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
   BEGIN
       DELETE FROM AsignaturaInstrumental WHERE Codigo_AsignaturaInstrumental= Codigo_AsignaturaInstrumental;
       PRINT 'SE HA ELIMINADO'
   RETURN
END	
GO

---6
--------------------------------------------------------------

Use ConservatorioCastella
go
CREATE PROC sp_EliminarAlumno(@Dni_Alumno varchar(10) )
AS
IF  NOT EXISTS (SELECT Dni_Alumno  FROM Alumno WHERE Dni_Alumno = @Dni_Alumno) 
    BEGIN
	     PRINT 'NO EXISTE'
    RETURN
END
IF ((@Dni_Alumno=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_Dni_Alumno FROM AlumnoAsignaturaMagistral WHERE FK_Dni_Alumno = @Dni_Alumno) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_Dni_Alumno FROM AlumnoAsignaturaInstrumental WHERE FK_Dni_Alumno = @Dni_Alumno) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_Dni_Alumno FROM AlumnoCursoAsignaturaMagistral WHERE FK_Dni_Alumno = @Dni_Alumno) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_Dni_Alumno FROM AlumnoCursoAsignaturaInstrumental WHERE FK_Dni_Alumno = @Dni_Alumno) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_DniAlumno FROM AlumnoInstrumento WHERE FK_DniAlumno = @Dni_Alumno) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
IF EXISTS (SELECT Dni_Alumno FROM EnsayoReserva WHERE Dni_Alumno = @Dni_Alumno) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
   BEGIN
       DELETE FROM Alumno WHERE Dni_Alumno= Dni_Alumno;
       PRINT 'SE HA ELIMINADO'
   RETURN
END	
Go

---7
--------------------------------------------------------------

CREATE PROC sp_EliminarAsignaturaMagistralProfesor(@Id_AsignaturaMagistralProfesor int )	
AS
IF  NOT EXISTS (SELECT Id_AsignaturaMagistralProfesor  FROM AsignaturaMagistralProfesor WHERE Id_AsignaturaMagistralProfesor = @Id_AsignaturaMagistralProfesor) 
   BEGIN
       PRINT 'NO EXISTE'
   RETURN
END
IF ((@Id_AsignaturaMagistralProfesor=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
  RETURN
END
ELSE
  BEGIN
       DELETE FROM AsignaturaMagistralProfesor WHERE Id_AsignaturaMagistralProfesor= Id_AsignaturaMagistralProfesor;
       PRINT 'SE HA ELIMINADO'
  RETURN
END	
GO

---8
--------------------------------------------------------------

CREATE PROC sp_EliminarAsignaturaInstrumentalProfesor(@Id_AsignaturaInstrumentalProfesor int )	
AS
IF  NOT EXISTS (SELECT Id_AsignaturaInstrumentalProfesor  FROM AsignaturaInstrumentalProfesor WHERE Id_AsignaturaInstrumentalProfesor = @Id_AsignaturaInstrumentalProfesor) 
   BEGIN
       PRINT 'NO EXISTE'
   RETURN
END
IF ((@Id_AsignaturaInstrumentalProfesor=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
  RETURN
END
ELSE
  BEGIN
       DELETE FROM AsignaturaInstrumentalProfesor WHERE Id_AsignaturaInstrumentalProfesor= Id_AsignaturaInstrumentalProfesor;
       PRINT 'SE HA ELIMINADO'
  RETURN
END	
GO
---9
--------------------------------------------------------------

CREATE PROC sp_EliminarAlumnoCursoAsignaturaInstrumental(@IdAlumno_CursoAsignaturaInstrumental int )	
AS
IF  NOT EXISTS (SELECT IdAlumno_CursoAsignaturaInstrumental  FROM AlumnoCursoAsignaturaInstrumental WHERE IdAlumno_CursoAsignaturaInstrumental = @IdAlumno_CursoAsignaturaInstrumental) 
   BEGIN
       PRINT 'NO EXISTE'
   RETURN
END
IF ((@IdAlumno_CursoAsignaturaInstrumental=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
  RETURN
END
ELSE
  BEGIN
       DELETE FROM AlumnoCursoAsignaturaInstrumental WHERE IdAlumno_CursoAsignaturaInstrumental= IdAlumno_CursoAsignaturaInstrumental;
       PRINT 'SE HA ELIMINADO'
  RETURN
END	
GO
---10
--------------------------------------------------------------


CREATE PROC sp_EliminarAlumnoCursoAsignaturaMagistral(@IdAlumno_CursoAsignaturaMagistral int )	
AS
IF  NOT EXISTS (SELECT IdAlumno_CursoAsignaturaMagistral  FROM AlumnoCursoAsignaturaMagistral WHERE IdAlumno_CursoAsignaturaMagistral = @IdAlumno_CursoAsignaturaMagistral) 
   BEGIN
       PRINT 'NO EXISTE'
   RETURN
END
IF ((@IdAlumno_CursoAsignaturaMagistral=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
  RETURN
END
ELSE
  BEGIN
       DELETE FROM AlumnoCursoAsignaturaMagistral WHERE IdAlumno_CursoAsignaturaMagistral= IdAlumno_CursoAsignaturaMagistral;
       PRINT 'SE HA ELIMINADO'
  RETURN
END	
GO
---11
--------------------------------------------------------------

CREATE PROC sp_EliminarAulasInstrumentales(@Id_AulaInstrumental varchar(30)  NULL)
AS
IF  NOT EXISTS (SELECT Id_AulaInstrumental  FROM AulasInstrumentales WHERE Id_AulaInstrumental = @Id_AulaInstrumental) 
    BEGIN
	     PRINT 'NO EXISTE'
    RETURN
END
IF ((@Id_AulaInstrumental=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_IdAulaInstrumental FROM AsignaturaInstrumental WHERE FK_IdAulaInstrumental = @Id_AulaInstrumental) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
   BEGIN
       DELETE FROM AulasInstrumentales WHERE Id_AulaInstrumental= Id_AulaInstrumental;
       PRINT 'SE HA ELIMINADO'
   RETURN
END	
GO
---12
--------------------------------------------------------------



CREATE PROC sp_EliminarProfesorAsignatura(@Id_ProfesorAsignatura int )	
AS
IF  NOT EXISTS (SELECT Id_ProfesorAsignatura  FROM ProfesorAsignatura WHERE Id_ProfesorAsignatura = @Id_ProfesorAsignatura) 
   BEGIN
       PRINT 'NO EXISTE'
   RETURN
END
IF ((@Id_ProfesorAsignatura=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
  RETURN
END
ELSE
  BEGIN
       DELETE FROM ProfesorAsignatura WHERE Id_ProfesorAsignatura= Id_ProfesorAsignatura;
       PRINT 'SE HA ELIMINADO'
  RETURN
END	
GO

---13
--------------------------------------------------------------




CREATE PROC sp_EliminarEdificio(@Codigo_Edificio varchar(25)  NULL)
AS
IF  NOT EXISTS (SELECT Codigo_Edificio  FROM Edificio WHERE Codigo_Edificio = @Codigo_Edificio) 
    BEGIN
	     PRINT 'NO EXISTE'
    RETURN
END
IF ((@Codigo_Edificio=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_CodigoEdificio FROM AulasInstrumentales WHERE FK_CodigoEdificio = @Codigo_Edificio) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
   BEGIN
       DELETE FROM Edificio WHERE Codigo_Edificio= Codigo_Edificio;
       PRINT 'SE HA ELIMINADO'
   RETURN
END	
GO
---14
--------------------------------------------------------------

CREATE PROC sp_EliminarCursoProfesorAsignatura(@Id_CursoProfesorAsignatura int )	
AS
IF  NOT EXISTS (SELECT Id_CursoProfesorAsignatura  FROM CursoProfesorAsignatura WHERE Id_CursoProfesorAsignatura = @Id_CursoProfesorAsignatura) 
   BEGIN
       PRINT 'NO EXISTE'
   RETURN
END
IF ((@Id_CursoProfesorAsignatura=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
  RETURN
END
ELSE
  BEGIN
       DELETE FROM CursoProfesorAsignatura WHERE Id_CursoProfesorAsignatura= Id_CursoProfesorAsignatura;
       PRINT 'SE HA ELIMINADO'
  RETURN
END	
GO
---15
--------------------------------------------------------------

CREATE PROC sp_EliminarCurso(@Año varchar(25)  NULL)
AS
IF  NOT EXISTS (SELECT Año  FROM Curso WHERE Año = @Año) 
    BEGIN
	     PRINT 'NO EXISTE'
    RETURN
END
IF ((@Año=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_Año FROM CursoProfesorAsignatura WHERE FK_Año = @Año) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
   BEGIN
       DELETE FROM Curso WHERE Año= Año;
       PRINT 'SE HA ELIMINADO'
   RETURN
END	
GO
---16
--------------------------------------------------------------



Use ConservatorioCastella
go
CREATE PROC sp_EliminarProfesor(@Dni_Profesor varchar(10) )
AS
IF  NOT EXISTS (SELECT Dni_Profesor  FROM Profesor WHERE Dni_Profesor = @Dni_Profesor) 
    BEGIN
	     PRINT 'NO EXISTE'
    RETURN
END
IF ((@Dni_Profesor=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_Dni_Profesor FROM AsignaturaMagistralProfesor WHERE FK_Dni_Profesor = @Dni_Profesor) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_Dni_Profesor FROM AsignaturaInstrumentalProfesor WHERE FK_Dni_Profesor = @Dni_Profesor) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
IF EXISTS (SELECT Dni_Profesor FROM InstrumentoProfesor WHERE Dni_Profesor = @Dni_Profesor) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_Dni_Profesor FROM CursoProfesorAsignatura WHERE FK_Dni_Profesor = @Dni_Profesor) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_Dni_Profesor FROM ProfesorAsignatura WHERE FK_Dni_Profesor = @Dni_Profesor) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
IF EXISTS (SELECT Dni_Profesor FROM EnsayoReserva WHERE Dni_Profesor = @Dni_Profesor) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
   BEGIN
       DELETE FROM Profesor WHERE Dni_Profesor= Dni_Profesor;
       PRINT 'SE HA ELIMINADO'
   RETURN
END	
Go

---17
--------------------------------------------------------------


CREATE PROC sp_EliminarEnsayoReserva(@Codigo_EnsayoReserva varchar (30) )	
AS
IF  NOT EXISTS (SELECT Codigo_EnsayoReserva  FROM EnsayoReserva WHERE Codigo_EnsayoReserva = @Codigo_EnsayoReserva) 
   BEGIN
       PRINT 'NO EXISTE'
   RETURN
END
IF ((@Codigo_EnsayoReserva=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
  RETURN
END
ELSE
  BEGIN
       DELETE FROM EnsayoReserva WHERE Codigo_EnsayoReserva= Codigo_EnsayoReserva;
       PRINT 'SE HA ELIMINADO'
  RETURN
END	
GO
---18
--------------------------------------------------------------

CREATE PROC sp_EliminarInstrumentoProfesor(@Id_InstrumentoProfesor int )	
AS
IF  NOT EXISTS (SELECT Id_InstrumentoProfesor  FROM InstrumentoProfesor WHERE Id_InstrumentoProfesor = @Id_InstrumentoProfesor) 
   BEGIN
       PRINT 'NO EXISTE'
   RETURN
END
IF ((@Id_InstrumentoProfesor=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
  RETURN
END
ELSE
  BEGIN
       DELETE FROM InstrumentoProfesor WHERE Id_InstrumentoProfesor= Id_InstrumentoProfesor;
       PRINT 'SE HA ELIMINADO'
  RETURN
END	
GO
---19
--------------------------------------------------------------
CREATE PROC sp_EliminarAlumnoInstrumento(@Id_AlumnoInstrumento int )	
AS
IF  NOT EXISTS (SELECT Id_AlumnoInstrumento  FROM AlumnoInstrumento WHERE Id_AlumnoInstrumento = @Id_AlumnoInstrumento) 
   BEGIN
       PRINT 'NO EXISTE'
   RETURN
END
IF ((@Id_AlumnoInstrumento=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
  RETURN
END
ELSE
  BEGIN
       DELETE FROM AlumnoInstrumento WHERE Id_AlumnoInstrumento= Id_AlumnoInstrumento;
       PRINT 'SE HA ELIMINADO'
  RETURN
END	
GO

---20
--------------------------------------------------------------


Use ConservatorioCastella
go
CREATE PROC sp_EliminarInstrumento(@Id_Instrumento int)
AS
IF  NOT EXISTS (SELECT Id_Instrumento  FROM Instrumento WHERE Id_Instrumento = @Id_Instrumento) 
    BEGIN
	     PRINT 'NO EXISTE'
    RETURN
END
IF ((@Id_Instrumento=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_Id_Instrumento FROM AlumnoInstrumento WHERE FK_Id_Instrumento = @Id_Instrumento) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
IF EXISTS (SELECT Id_Instrumento FROM InstrumentoProfesor WHERE Id_Instrumento = @Id_Instrumento) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_Id_Instrumento FROM TipoInstrumento WHERE FK_Id_Instrumento = @Id_Instrumento) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
IF EXISTS (SELECT FK_Id_Instrumento FROM AulasInstrumentales WHERE FK_Id_Instrumento = @Id_Instrumento) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
   BEGIN
       DELETE FROM Instrumento WHERE Id_Instrumento= Id_Instrumento;
       PRINT 'SE HA ELIMINADO'
   RETURN
END	
Go

---21
--------------------------------------------------------------
CREATE PROC sp_EliminarTipo(@Id_Tipo int )	
AS
IF  NOT EXISTS (SELECT Id_Tipo  FROM Tipo WHERE Id_Tipo = @Id_Tipo) 
   BEGIN
       PRINT 'NO EXISTE'
   RETURN
END
IF ((@Id_Tipo=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
  RETURN
END
ELSE
IF EXISTS (SELECT FK_Id_Tipo FROM TipoInstrumento WHERE FK_Id_Tipo = @Id_Tipo) 
   BEGIN
       PRINT 'EXISTE UNA RELACION, IMPOSIBLE DE ELIMINAR'
   RETURN
END
ELSE
  BEGIN
       DELETE FROM Tipo WHERE Id_Tipo= Id_Tipo;
       PRINT 'SE HA ELIMINADO'
  RETURN
END	
GO
---22
--------------------------------------------------------------
CREATE PROC sp_EliminarTipoInstrumento(@Id_TipoInstrumento int )	
AS
IF  NOT EXISTS (SELECT Id_TipoInstrumento  FROM TipoInstrumento WHERE Id_TipoInstrumento = @Id_TipoInstrumento) 
   BEGIN
       PRINT 'NO EXISTE'
   RETURN
END
IF ((@Id_TipoInstrumento=''))
   BEGIN 
       PRINT 'HO INGRESADO BIEN LOS DATOS'
  RETURN
END
ELSE
  BEGIN
       DELETE FROM TipoInstrumento WHERE Id_TipoInstrumento= Id_TipoInstrumento;
       PRINT 'SE HA ELIMINADO'
  RETURN
END	
GO
>>>>>>> e724a4bde802dccd5d23cb18a771f073f1bc5723

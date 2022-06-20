

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
--Create Trigger TR_INSERTINSTRUMENTOPROFESOR
--On Profesor after insert AND On Instrumento after insert
--As
--	set nocount on
--	declare @DniProfesor varchar(10) = (select Dni_Profesor from inserted)

--	insert into InstrumentoProfesor values(@DniProfesor)
--	PRINT 'PROFESOR REGISTRADO EN ADMINISTRACION'
--	END



sp_Help Instrumento

use ConservatorioCastella
INSERT INTO Alumno (Dni_Alumno,Nombre,Apellido1,Apellido2,FechaNacimiento,Telefono_Contacto,Numero_Expediente,Estado,FK_Dni_Encargado,Edad)
 values('0987','Maria','Acon','Vargas','06/06/2022','1233','00098','Activo', '90908',12)
GO

use ConservatorioCastella
INSERT INTO Alumno (Dni_Alumno,Nombre,Apellido1,Apellido2,FechaNacimiento,Telefono_Contacto,Numero_Expediente,Estado,FK_Dni_Encargado,Edad)
			values('0986787','Geiner','Zuniga','Flores','06/06/2022','09678','098','Activo','0998', 10)
GO

use ConservatorioCastella
INSERT INTO Alumno (Dni_Alumno,Nombre,Apellido1,Apellido2,FechaNacimiento,Telefono_Contacto,Numero_Expediente,Estado,FK_Dni_Encargado,Edad)
			values('0986787','Geiner','Zuniga','Flores','06/06/2022','09678','098','Activo','0998', 10)
GO

use ConservatorioCastella
INSERT INTO Alumno (Dni_Alumno,Nombre,Apellido1,Apellido2,FechaNacimiento,Telefono_Contacto,Numero_Expediente,Estado,FK_Dni_Encargado,Edad)
			values('345345','Kriscia','Campos','Cardenas','06/06/2022','434','4534','Activo','878', 15)
GO

use ConservatorioCastella
INSERT INTO Alumno (Dni_Alumno,Nombre,Apellido1,Apellido2,FechaNacimiento,Telefono_Contacto,Numero_Expediente,Estado,FK_Dni_Encargado,Edad)
			values('05958','Melany','Lawson','Mendes','06/06/2022','434','4534','Activo','03938', 15)
GO

--Valida las reservaciones de los profesores para los ensayos, si no existe una reserva a en una fecha y hora en especifico
--Registrará la reserva
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


Use ConservatorioCastella
Go
Alter procedure Sp_InsertarAlumno (@Dni_Alummno varchar(10), @Dni_Encargado varchar(10), @Numero_Expediente varchar(10), @NombreAlumno varchar(10), @Apellido1 varchar(10), @Apellido2 varchar(10), @FechaNacimiento date, @Telefono_Contacto int, @Estado text )
AS
IF ((@Dni_Alummno)='' or (@Dni_Encargado)='' or (@Numero_Expediente)='' or (@NombreAlumno)='' or (@Apellido1)='' or (@Apellido2)='' or (@FechaNacimiento)='' or (@Telefono_Contacto)='')
BEGIN
	PRINT '¡FAVOR REVISAR!'
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into Alumno (Dni_Alumno, FK_Dni_Encargado, Numero_Expediente, NombreAlumno, Apellido1, Apellido2, FechaNacimiento, Telefono_Contacto, Estado)
Values (@Dni_Alummno, @Dni_Encargado, @Numero_Expediente, @NombreAlumno, @Apellido1, @Apellido2, @FechaNacimiento, @Telefono_Contacto, @Estado)
	PRINT 'El Registro se ha ingresado correctamente'
END
GO


--Insertar Alumnos por procedimiento almacenado
Execute Sp_InsertarAlumno '12321', '3434', '0595', 'Geiner', 'Zuniga', 'Flores', '06/06/2022', '34323', 'Inactivo'
Execute Sp_InsertarAlumno '09585', '', '0978', 'Maria', 'Acon', 'Vargas', '2001/05/23', '34323', 'Activo'


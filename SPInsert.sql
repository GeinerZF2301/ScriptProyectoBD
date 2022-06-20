Use ConservatorioCastella
Go
Create procedure Sp_InsertarAulasMagistrales (@Id_AulaMagistral varchar(9), @Equipada bit, @Nombre_AulaMagistral varchar(30), @Aforo int)
AS
IF ((@Id_AulaMagistral='') or (@Equipada='') or (@Nombre_AulaMagistral='') or (@Aforo=''))
BEGIN
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into AulasMagistrales (Id_AulaMagistral, Equipada, Nombre_AulaMagistral, Aforo)
Values (@Id_AulaMagistral, @Equipada, @Nombre_AulaMagistral, @Aforo)
	PRINT 'El Registro se ha ingresado correctamente'
END--listo
-------------------------------------------------------------------------------------------------------------------------------------------
Use ConservatorioCastella
Go
Create procedure Sp_InsertarAsignaturaMagistral (@Codigo_AsignaturaMagistral varchar(9), @Nombre_AsignaturaMagistral varchar(30), @CantidadHoras  int, @Id_AulaMagistral varchar(9))
AS
IF ((@Codigo_AsignaturaMagistral='') or (@Nombre_AsignaturaMagistral='') or (@CantidadHoras='') or (@Id_AulaMagistral=''))
BEGIN
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into AsignaturaMagistral (Codigo_AsignaturaMagistral, Nombre_AsignaturaMagistral, CantidadHoras,FK_Id_AulaMagistral)
Values (@Codigo_AsignaturaMagistral, @Nombre_AsignaturaMagistral, @CantidadHoras, @Id_AulaMagistral)
	PRINT 'El Registro se ha ingresado correctamente'
END--listo
---------------------------------------------------------------------------------------------------------------------------------------------
Use ConservatorioCastella
Go
Create procedure Sp_InsertarAlumnoAsignaturaMagistral (@Id_AlumnoAsignaturaMagistral int, @Dni_Alumno varchar(30), @Codigo_AsignaturaMagistral  int)
AS
IF ((@Id_AlumnoAsignaturaMagistral='') or (@Dni_Alumno='') or (@Codigo_AsignaturaMagistral=''))
BEGIN
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into AlumnoAsignaturaMagistral   (Id_AlumnoAsignaturaMagistral, FK_Dni_Alumno, FK_Codigo_AsignaturaMagistral)
Values (@Id_AlumnoAsignaturaMagistral, @Dni_Alumno, @Codigo_AsignaturaMagistral)
	PRINT 'El Registro se ha ingresado correctamente'
END--listo
------------------------------------------------------------------------------------------------------------------------------------------------
Use ConservatorioCastella
Go
Create procedure Sp_InsertarAlumnoAsignaturaInstrumental (@Id_AlumnoAsignatura int, @Dni_Alumno varchar(30), @Codigo_AsignaturaInstrumental varchar(30))
AS
IF ((@Id_AlumnoAsignatura='') or (@Dni_Alumno='') or (@Codigo_AsignaturaInstrumental=''))
BEGIN
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into AlumnoAsignaturaInstrumental (Id_AlumnoAsignatura,FK_Dni_Alumno,FK_Codigo_AsignaturaInstrumental)
Values (@Id_AlumnoAsignatura, @Dni_Alumno, @Codigo_AsignaturaInstrumental)
	PRINT 'El Registro se ha ingresado correctamente'
END--listo
---------------------------------------------------------------------------------------------------------------------------------------------------
Use ConservatorioCastella
Go
Create procedure Sp_InsertarAsignaturaInstrumental (@Codigo_AsignaturaInstrumental varchar(15), @Nombre_AsignaturaInstrumental varchar(30), @CantidadHoras int, @IdAulaInstruental varchar (9))
AS
IF ((@Codigo_AsignaturaInstrumental='') or (@Nombre_AsignaturaInstrumental='') or (@CantidadHoras='') or (@IdAulaInstruental=''))
BEGIN
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into AsignaturaInstrumental (Codigo_AsignaturaInstrumental, NombreAsignaturaInstrumental, CantidadHoras, FK_IdAulaInstrumental)
Values (@Codigo_AsignaturaInstrumental, @Nombre_AsignaturaInstrumental, @CantidadHoras,@IdAulaInstruental)
	PRINT 'El Registro se ha ingresado correctamente'
END--listo
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---PROCEDIMIENTO DE ALMACENAMIENTO TABLA ALUMNO--
Use ConservatorioCastella
Go
Create procedure Sp_InsertarAlumno (@Dni_Alummno varchar(10), @Dni_Encargado varchar(10), @Numero_Expediente varchar(10), @NombreAlumno varchar(10), @Apellido1 varchar(10), @Apellido2 varchar(10), @FechaNacimiento date, @Telefono_Contacto int, @Estado text )
AS
IF ((@Dni_Alummno)='' And (@Dni_Encargado)='' And (@Numero_Expediente)='' And (@NombreAlumno)='' And (@Apellido1)='' And (@Apellido2)='' And (@FechaNacimiento)='' And (@Telefono_Contacto)='')
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
GO--listo

---PROCEDIMIENTO DE ALMACENAMIENTO TABLA ALUMNOINSTRUMENTO
Use ConservatorioCastella
Go
Create procedure Sp_InsertarAlumnoInstrumento (@Id_AlumnoInstrumento int, @Dni_Alumno varchar(10), @Id_Instrumento int, @FechaInicioInstrumento date)
AS
IF ((@Id_AlumnoInstrumento='') or (@Dni_Alumno='') or (@Id_Instrumento='') or (@FechaInicioInstrumento=''))
BEGIN
	PRINT '¡FAVOR REVISAR!'
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into AlumnoInstrumento (Id_AlumnoInstrumento, FK_DniAlumno, FK_Id_Instrumento, FechaInicioInstrumento)
Values (@Id_AlumnoInstrumento, @Dni_Alumno, @Id_Instrumento, @FechaInicioInstrumento)
	PRINT 'El Registro se ha ingresado correctamente'
END--listo

---PROCEDIMIENTO DE ALMACENAMIENTO TABLA ENSAYORESERVA----
Use ConservatorioCastella
Go
Create procedure Sp_InsertarEnsayoReserva (@Codigo_EnsayoReserva varchar(10), @Hora_Inicio time, @Hora_Fin time, @Fecha date, @Dni_Profesor varchar(10), @Dni_Alumno varchar (10))
AS
IF ((@Codigo_EnsayoReserva='') or (@Hora_Inicio='') or (@Hora_Fin='') or (@Fecha='') or (@Dni_Profesor='') or (@Dni_Alumno='') )
BEGIN
	PRINT '¡FAVOR REVISAR!'
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into EnsayoReserva (Codigo_EnsayoReserva, Hora_Inicio, Hora_Fin, Fecha, Dni_Profesor, Dni_Alumno)
Values (@Codigo_EnsayoReserva, @Hora_Inicio, @Hora_Fin, @Fecha, @Dni_Profesor, @Dni_Alumno)
	PRINT 'El Registro se ha ingresado correctamente'
END--listo

---PROCEDIMIENTO DE ALMACENAMIENTO TABLA INSTRUMENTO----
Use ConservatorioCastella
Go
Create procedure Sp_InsertarInstrumento (@Id_Instrumento int, @NombreInstrumental varchar (10), @Edad_Recomendada int)
AS
IF ((@Id_Instrumento='') or (@NombreInstrumental='') or (@Edad_Recomendada=''))
BEGIN
	PRINT '¡FAVOR REVISAR!'
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into Instrumento (Id_Instrumento, NombreInstrumental, EdadRecomendada)
Values (@Id_Instrumento, @NombreInstrumental, @Edad_Recomendada)
	PRINT 'El Registro se ha ingresado correctamente'
END--listo

---PROCEDIMIENTO DE ALMACENAMIENTO TABLA TIPOINSTRUMENTO----
Use ConservatorioCastella
Go
Create procedure Sp_InsertarTipoInstrumento (@Id_TipoInstrumento int, @Id_Instrumento varchar (10), @Id_Tipo int)
AS
IF ((@Id_TipoInstrumento='') or (@Id_Instrumento='') or (@Id_Tipo=''))
BEGIN
	PRINT '¡FAVOR REVISAR!'
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into TipoInstrumento (Id_TipoInstrumento, FK_Id_Instrumento, FK_Id_Tipo)
Values (@Id_TipoInstrumento, @Id_Instrumento, @Id_Tipo)
	PRINT 'El Registro se ha ingresado correctamente'
END--listo

---PROCEDIMIENTO DE ALMACENAMIENTO TABLA TIPO---
Use ConservatorioCastella
Go
Create procedure Sp_InsertarTipo (@Id_Tipo int, @Nombre varchar (10))
AS
IF ((@Id_Tipo='') or (@Nombre=''))
BEGIN
	PRINT '¡FAVOR REVISAR!'
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into Tipo (Id_Tipo, Nombre)
Values (@Id_Tipo, @Nombre)
	PRINT 'El Registro se ha ingresado correctamente'
END--listo
---------------------------------------------------------------------------------------------------
Use ConservatorioCastella
Go
Create procedure Sp_InsertarInstrumentoProfesor (@Id_InstrumentoProfesor int, @Id_Instrumento int, @Dni_Profesor varchar(30))
AS
IF ((@Id_InstrumentoProfesor='') or (@Id_Instrumento='') or (@Dni_Profesor=''))
BEGIN
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into InstrumentoProfesor (Id_InstrumentoProfesor, Id_Instrumento, Dni_Profesor)
Values (@Id_InstrumentoProfesor, @Id_Instrumento, @Dni_Profesor)
	PRINT 'El Registro se ha ingresado correctamente'
END--lsito
-----------------------------------------------------------------------------------------------------------------------------------------------------
--Este no funka
Use ConservatorioCastella
Go
Create procedure Sp_InsertarProfesor (@Dni_Profesor varchar(10), @NombreProfesor varchar(10), @Apellido1 varchar(10), @Apellido2 varchar(10), @Telefono_Contacto int, @Estado text )
AS
IF ((@Dni_Profesor='') or (@NombreProfesor='') or (@Apellido1='') or (@Apellido2='') or (@Telefono_Contacto='') or (@Estado) LIKE'')
BEGIN
	PRINT '¡FAVOR REVISAR!'
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into Profesor (Dni_Profesor, NombreProfesor,Apellido1, Apellido2,Telefono_Contacto, Estado)
Values (@Dni_Profesor, @NombreProfesor, @Apellido1, @Apellido2,@Telefono_Contacto, @Estado)
	PRINT 'El Registro se ha ingresado correctamente'
END
----------------------------------------------------------------------------------------------------------------------------------------------------
Use ConservatorioCastella
Go
Create procedure Sp_InsertarAsignaturaMagistralProfesor (@Id_AsignaturaMagistralProfesor int, @Codigo_AsignaturaMagistral varchar (10), @Dni_Profesor Varchar(10))
AS
IF ((@Id_AsignaturaMagistralProfesor='') or (@Codigo_AsignaturaMagistral='') or (@Dni_Profesor=''))
BEGIN
	PRINT '¡FAVOR REVISAR!'
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into AsignaturaMagistralProfesor (Id_AsignaturaMagistralProfesor, FK_Codigo_AsignaturaMagistral, FK_Dni_Profesor)
Values (@Id_AsignaturaMagistralProfesor, @Codigo_AsignaturaMagistral, @Dni_Profesor)
	PRINT 'El Registro se ha ingresado correctamente'
END--listo
------------------------------------------------------------------------------------------------------------------------------------------------------
Use ConservatorioCastella
Go
Create procedure Sp_InsertarAsignaturaInstrumentalProfesor (@Id_AsignaturaInstrumentalProfesor int, @Codigo_AsignaturaInstrumental varchar (10), @Dni_Profesor Varchar(10))
AS
IF ((@Id_AsignaturaInstrumentalProfesor='') or (@Codigo_AsignaturaInstrumental='') or (@Dni_Profesor=''))
BEGIN
	PRINT '¡FAVOR REVISAR!'
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into AsignaturaInstrumentalProfesor (Id_AsignaturaInstrumentalProfesor, Fk_Codigo_AsignaturaInstrumental, FK_Dni_Profesor)
Values (@Id_AsignaturaInstrumentalProfesor, @Codigo_AsignaturaInstrumental, @Dni_Profesor)
	PRINT 'El Registro se ha ingresado correctamente'
END--listo
-----------------------------------------------------------------------------------------------------------------------------------------------------
Use ConservatorioCastella
Go
Create procedure Sp_InsertarAlumnoCursoAsignaturaMagistral (@IdAlumno_CursoAsignaturaMagistral int, @Dni_Alumno varchar(10), @Año int, @Codigo_AsignaturaMagistral Varchar(20), @Nota int)
AS
IF ((@IdAlumno_CursoAsignaturaMagistral='') or (@Dni_Alumno='') or (@Año='') or (@Codigo_AsignaturaMagistral='') or (@Nota=''))
BEGIN
	PRINT '¡FAVOR REVISAR!'
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into AlumnoCursoAsignaturaMagistral (IdAlumno_CursoAsignaturaMagistral, Fk_Dni_Alumno,FK_Año, FK_Codigo_AsignaturaMagistral ,Nota)
Values (@IdAlumno_CursoAsignaturaMagistral, @Dni_Alumno, @Año, @Codigo_AsignaturaMagistral,@Nota)
	PRINT 'El Registro se ha ingresado correctamente'
END--listo
-------------------------------------------------------------------------------------------------------------------------------------------------------
Go
Create procedure Sp_InsertarAlumnoCursoAsignaturaInstrumental (@IdAlumno_CursoAsignaturaInstrumental int, @Dni_Alumno varchar(10), @Año int, @Codigo_AsignaturaInstrumental Varchar(20), @Nota int)
AS
IF ((@IdAlumno_CursoAsignaturaInstrumental='') or (@Dni_Alumno='') or (@Año='') or (@Codigo_AsignaturaInstrumental='') or (@Nota=''))
BEGIN
	PRINT '¡FAVOR REVISAR!'
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into AlumnoCursoAsignaturaInstrumental (IdAlumno_CursoAsignaturaInstrumental, Fk_Dni_Alumno,FK_Año,FK_Codigo_AsignaturaInstrumental,Nota)
Values (@IdAlumno_CursoAsignaturaInstrumental, @Dni_Alumno, @Año, @Codigo_AsignaturaInstrumental,@Nota)
	PRINT 'El Registro se ha ingresado correctamente'
END--listo
------------------------------------------------------------------------------------------------------------------------------------------------------
Use ConservatorioCastella
Go
Create procedure Sp_InsertarCurso (@Año int, @Fecha_Inicio date, @Fecha_Final date)
AS
IF ((@Año='') or (@Fecha_Inicio='') or (@Fecha_Final=''))
BEGIN
	PRINT '¡FAVOR REVISAR!'
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into Curso  (Año,Fecha_Inicio,Fecha_Final)
Values (@Año, @Fecha_Inicio,@Fecha_Final)
	PRINT 'El Registro se ha ingresado correctamente'
END--listo
----------------------------------------------------------------------------------------------------------------------------------------------------
Go
Create procedure Sp_InsertarAulasInstrumentales (@Id_AulasInstrumentales varchar(10), @Id_Intrumento varchar(10), @Metros_Poseidos int, @Aforo int, @Nombre varchar(10), @Codigo_Edificio varchar(10))
AS
IF ((@Id_AulasInstrumentales='') or (@Id_Intrumento='') or (@Metros_Poseidos='') or (@Aforo='') or (@Nombre='') or (@Codigo_Edificio=''))
BEGIN
	PRINT '¡FAVOR REVISAR!'
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into AulasInstrumentales (Id_AulaInstrumental,FK_Id_Instrumento,Metros_Poseidos,Aforo,Nombre,FK_CodigoEdificio)
Values (@Id_AulasInstrumentales, @Id_Intrumento, @Metros_Poseidos, @Aforo,@Nombre,@Codigo_Edificio)
	PRINT 'El Registro se ha ingresado correctamente'
END--listo
----------------------------------------------------------------------------------------------------------------------------------------------------
Use ConservatorioCastella
Go
Create procedure Sp_InsertarEdificio (@Codigo_Edificio varchar (10), @Calle varchar (10), @Numero int,@Direccion varchar (10))
AS
IF ((@Codigo_Edificio='') or (@Calle='') or (@Numero='') or (@Direccion=''))
BEGIN
	PRINT '¡FAVOR REVISAR!'
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into Edificio (Codigo_Edificio, Calle, Numero,Direccion)
Values (@Codigo_Edificio, @Calle, @Numero,@Direccion)
	PRINT 'El Registro se ha ingresado correctamente'
END--listo
-----------------------------------------------------------------------------------------------------------------------------------------------------
Use ConservatorioCastella
Go
Create procedure Sp_InsertarProfesorAsignatura(@Id_ProfesorAsignatura int, @Dni_Profesor varchar (10), @Codigo_AsignaturaMagistral varchar (10))
AS
IF ((@Id_ProfesorAsignatura='') or (@Dni_Profesor='') or (@Codigo_AsignaturaMagistral=''))
BEGIN
	PRINT '¡FAVOR REVISAR!'
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into ProfesorAsignatura (Id_ProfesorAsignatura, FK_Dni_Profesor, FK_Codigo_AsignaturaMagistral)
Values (@Id_ProfesorAsignatura, @Dni_Profesor, @Codigo_AsignaturaMagistral)
	PRINT 'El Registro se ha ingresado correctamente'
END--listo
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
Use ConservatorioCastella
Go
Create procedure Sp_InsertarCursoProfesorAsignatura (@Id_CursoProfesorAsignatura int, @Año int, @Dni_Profesor varchar (10),@Codigo_AsignaturaMagistral varchar (10))
AS
IF ((@Id_CursoProfesorAsignatura='') or (@Año='') or (@Dni_Profesor='') or (@Codigo_AsignaturaMagistral=''))
BEGIN
	PRINT '¡FAVOR REVISAR!'
	PRINT 'NO SE PUEDEN INGRENSAR VALORES NULOS'
	RETURN
END

ELSE
	BEGIN
	insert into CursoProfesorAsignatura (Id_CursoProfesorAsignatura,FK_Año,FK_Dni_Profesor,FK_Codigo_AsignaturaMagistral)
Values (@Id_CursoProfesorAsignatura, @Año, @Dni_Profesor,@Codigo_AsignaturaMagistral)
	PRINT 'El Registro se ha ingresado correctamente'
END--listo
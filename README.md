# ScriptProyectoBD

Se creó la base de datos llamada ConservatorioCastella, por su parte se procedió a crear los archivos (principales o primarios, secundarios y de registro).
También se crean 3 Filegroups "Personas" "Administración" "Infraestructura" Cada uno con su archivo de datos

Cada Filegroup tiene una intención en específico en el Filegroup persona se pretende almacenar las tablas explícitamente de Persona: Encargado, Alumno, Profesor.
El Filegroup Administración tiene la intención de almacenar toda aquella información que sea relevante administrativamente para el Conservatorio, en este FileGroup se encuentran
tablas como: AsignaturaInstrumental, AsignaturaNoIntrumental, AlumnoAsignaturaInstrumental, AlumnoAsignaturaNoInstrumental, Curso, ProfesorCurso etc etc.

Y el Filegroup Infraestructura se encuentran tablas que a grosso modo tiene que ver con los lugares físicos como:
Aulas y Edificio


Falta:  Actualmente faltan 5 tablas de construir, se debe implementar los procedimientos almacenados y triggers.

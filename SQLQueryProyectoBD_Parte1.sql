
/* Proyecto de Conservatorio Castella
Integrantes: Maria del Mar Acón Vargas, Geiner Zúñiga Flores, Kriscia Campos Cárdenas,
			 Melany Lawson Mendez, Alfieri Mora Jiménez*/



/*Creacion de la base de datos
 Creacion de Archivos Primarios, Log, Y secundarios
 Creacion de Filgroups con sus respectivos archivos secundarios*/

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

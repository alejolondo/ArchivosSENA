IF DB_ID ('DBDSBOT') IS NOT NULL
PRINT 'LA BASE DE DATOS YA EXISTE'
ELSE
create database  DBDSBOT

go
use  DBDSBOT

IF OBJECT_ID('auditorias','U') IS  NULL

CREATE TABLE auditorias (
AuditoriaId BIGINT IDENTITY (1,1),
Created DATETIME,
Data NVARCHAR (MAX) NOT NULL,
CONSTRAINT PK_auditoria PRIMARY KEY CLUSTERED (AuditoriaId)
);

IF OBJECT_ID('estadoPacienteFactor','U') IS  NULL
 CREATE TABLE estadoPacienteFactor (
EstadoPacienteFactorId INT IDENTITY (1,1),
Nombre NVARCHAR (MAX) NOT NULL,
CONSTRAINT PK_estadoPacienteFactor PRIMARY KEY CLUSTERED (EstadoPacienteFactorId)
);

IF OBJECT_ID('factores','U') IS  NULL
	CREATE TABLE factores (
	FactorId INT IDENTITY (1,1),
	Nombre NVARCHAR (MAX) NOT NULL,
	CONSTRAINT PK_factores PRIMARY KEY CLUSTERED (FactorId)
	);


IF OBJECT_ID('pacientes','U') IS  NULL
CREATE TABLE pacientes (
PacienteId BIGINT IDENTITY (1,1),
PrimerNombre NVARCHAR (MAX) NOT NULL,
SegundoNombre NVARCHAR (MAX),
PrimerApellido NVARCHAR (MAX) NOT NULL,
SegundoApellido NVARCHAR (MAX),
TipoDocumento NVARCHAR (MAX) NOT NULL,
NumeroDocumento NVARCHAR (MAX) NOT NULL,
NumeroCelular NVARCHAR (MAX) NOT NULL,
CONSTRAINT PK_pacientes PRIMARY KEY CLUSTERED (PacienteId)
);

IF OBJECT_ID('preguntas','U') IS  NULL
CREATE TABLE preguntas (
PreguntaId BIGINT IDENTITY (1,1),
Descripcion NVARCHAR (MAX) NOT NULL
CONSTRAINT PK_preguntas PRIMARY KEY  CLUSTERED (PreguntaId)
);

IF OBJECT_ID('respuestas','U') IS  NULL
CREATE TABLE respuestas (
RespuestaId INT IDENTITY (1,1),
Descripcion NVARCHAR (MAX) NOT NULL
CONSTRAINT PK_respuestas PRIMARY KEY CLUSTERED (RespuestaId)
);

IF OBJECT_ID('factorPreguntas','U') IS  NULL

CREATE TABLE factorPreguntas (
FactorPreguntaId BIGINT IDENTITY (1,1),
FactorId INT,
PreguntaId BIGINT,
Orden INT,
Activo BIT,
CONSTRAINT PK_factorPreguntas PRIMARY KEY CLUSTERED (FactorPreguntaId),
CONSTRAINT FK_factorPreguntas FOREIGN KEY (FactorId) REFERENCES factores (FactorId)
);

IF OBJECT_ID('pacientesFactores','U') IS  NULL

CREATE TABLE pacientesFactores (
PacienteFactorId BIGINT, --Sin (1,1)?
PacienteId BIGINT,
FactorId INT,
EstadoPacienteFactor INT,
CONSTRAINT PK_pacientesFactores PRIMARY KEY CLUSTERED (PacienteFactorId),
FOREIGN KEY (PacienteId) REFERENCES pacientes (PacienteId)
);

IF OBJECT_ID('preguntaRespuestas','U') IS  NULL

CREATE TABLE preguntaRespuestas (
PreguntaRespuestaId BIGINT IDENTITY (1,1),
FactorPreguntaId BIGINT,
RespuestaId INT,
SiguientePregunta INT
CONSTRAINT PK_preguntaRespuestas PRIMARY KEY CLUSTERED (PreguntaRespuestaId),
CONSTRAINT FK_preguntaRespuestas FOREIGN KEY (FactorPreguntaId) REFERENCES factorPreguntas (FactorPreguntaId)
);

IF OBJECT_ID('mensajes','U') IS  NULL

CREATE TABLE mensajes (
MensajeId BIGINT IDENTITY (1,1),
PacienteFactorId BIGINT NOT NULL,
FactorPreguntaId BIGINT NOT NULL,
Respuesta NVARCHAR (MAX),
ResultadoLuis NVARCHAR (MAX),
FechaPregunta DATETIME NOT NULL,
FechaRespuesta DATETIME
CONSTRAINT PK_mensajes PRIMARY KEY  CLUSTERED (MensajeId),
CONSTRAINT FK_mensajes FOREIGN KEY (PacienteFactorId) REFERENCES pacientesFactores (PacienteFactorId)
);

IF OBJECT_ID('preguntaRespuestaValor','U') IS NULL

CREATE TABLE preguntaRespuestaValor(
PreguntaRespuestaValorId BIGINT IDENTITY (1,1),
PreguntaRespuestaId BIGINT NOT NULL,
Valor INT NOT NULL,
CONSTRAINT PK_preguntaRespuestaValor PRIMARY KEY CLUSTERED (PreguntaRespuestaValorId),
CONSTRAINT FK_preguntaRespuestaValor FOREIGN KEY (PreguntaRespuestaId) REFERENCES PreguntaRespuestas (PreguntaRespuestaId)
);

--Merge Tabla factores
MERGE factores AS TARGET
USING (values
(1,'Ansiedad'),
(2,'Depresion')

) AS SOURCE (
[FactorId],
[Nombre]
)
   ON (TARGET.FactorId = SOURCE.[FactorId])
WHEN MATCHED  THEN
   UPDATE SET TARGET.Nombre = SOURCE.Nombre
WHEN NOT MATCHED BY TARGET THEN
   INSERT (Nombre)
   VALUES (SOURCE.Nombre)
WHEN NOT MATCHED BY SOURCE THEN
   DELETE;



--Merge Tabla preguntas

MERGE preguntas AS TARGET
USING (values
(1,'¡Hola! soy Mauricio.  Soy un chatbot de Inteligencia Artificial creado por el Programa de Salud y Bienestar del SENA TE CUIDA (Centro de Servicios de Salud - Regional Antioquia).  Recibe un Cordial Saludo, Me gustaría hacerte unas preguntas sencillas para hacerte seguimiento a partir de tu ultima atención. ¿Estás de acuerdo?'),
(2,'¿Estas tomando medicamento para tu condición de ansiedad?'),
(3,'¿Has tenido algún efecto secundario luego de iniciar el tratamiento?'),
(4,'¿Los efectos secundarios han generado la suspención del tratamiento?'),
(5,'¿Consideras que tienes excesiva preocupación?'),
(6,'¿Se te dificulta controlar la preocupación? '),
(7,'¿Tienes sensación de tener los nervios de punta?'),
(8,'¿Te sientes facilmente fatigado/a?'),
(9,'¿Tienes dificultad para concentrarte o dejar la mente en blanco?'),
(10,'¿Te sientes irritable?'),
(11,'¿Sientes tensión muscular frecuente?'),
(12,'¿Tienes problemas de sueño?'),
(13,'¿Estas tomando medicamento para tu condición de depresión?'),
(14,'Desde tu último control por el programa, ¿Sientes que estás durmiendo mal?'),
(15,'Desde tu último control por el programa, ¿Sientes que te estas alimentandote mal?'),
(16,'¿Has tenido ideas de culpa?'),
(17,'¿Has tenido ideas de muerte o suicidio?'),
(18,'¿Sientes afectada tu capacidad de tomar decisiones?'),
(19,'¿Sientes confianza en ti mismo?'),
(20,'¿Percibe cambios en tus movimientos (mayor lentitud o inquietud en su cuerpo)?'),
(21,'¿Estas disfrutando de las actividades cotidianas?'),
(22,'¿Cómo sientes tu ánimo desde la última cita médica?'),
(23,'Gracias por tu participación, si necesitas ayuda adicional puedes contactarnos directamente en el Servicio de Bienestar a los Aprendices de tu centro de formación')


) AS SOURCE (
[PreguntaId],
[Descripcion]
)
   ON (TARGET.PreguntaId = SOURCE.[PreguntaId])
WHEN MATCHED  THEN
   UPDATE SET TARGET.Descripcion = SOURCE.Descripcion
WHEN NOT MATCHED BY TARGET THEN
   INSERT (Descripcion)
   VALUES (SOURCE.Descripcion)
WHEN NOT MATCHED BY SOURCE THEN
   DELETE;



--Merge Tabla factorPreguntas

MERGE factorPreguntas AS TARGET
USING (values
(1,1,1,1,1),
(2,1,2,2,1),
(3,1,3,3,1),
(4,1,4,4,1),
(5,1,5,5,1),
(6,1,6,6,1),
(7,1,7,7,1),
(8,1,8,8,1),
(9,1,9,9,1),
(10,1,10,10,1),
(11,1,11,11,1),
(12,1,12,12,1),
(13,1,23,13,1),
(14,2,1,1,1),
(15,2,13,2,1),
(16,2,3,3,1),
(17,2,4,4,1),
(18,2,14,5,1),
(19,2,15,6,1),
(20,2,16,7,1),
(21,2,17,8,1),
(22,2,18,9,1),
(23,2,19,10,1),
(24,2,20,11,1),
(25,2,21,12,1),
(26,2,22,13,1),
(27,2,23,14,1)

) AS SOURCE (
[FactorPreguntaId],
[FactorId],
[PreguntaId],
[Orden],
[Activo]
)
   ON (TARGET.FactorPreguntaId = SOURCE.[FactorPreguntaId])
WHEN MATCHED  THEN
   UPDATE SET TARGET.FactorId = SOURCE.FactorId, TARGET.PreguntaId = SOURCE.PreguntaId, TARGET.Orden = SOURCE.Orden, TARGET.Activo = SOURCE.Activo
WHEN NOT MATCHED BY TARGET THEN
   INSERT (FactorId, PreguntaId, Orden, Activo)
   VALUES (SOURCE.FactorId, SOURCE.PreguntaId, SOURCE.Orden, SOURCE.Activo)
WHEN NOT MATCHED BY SOURCE THEN
   DELETE;


--Merge Tabla Respuestas

   MERGE respuestas AS TARGET
USING (values
(1,'Si'),
(2,'No'),
(3,'Mejor'),
(4,'Igual'),
(5,'Peor')

) AS SOURCE (
[RespuestaId],
[Descripcion]
)
   ON (TARGET.RespuestaId = SOURCE.[RespuestaId])
WHEN MATCHED  THEN
   UPDATE SET TARGET.Descripcion = SOURCE.Descripcion
WHEN NOT MATCHED BY TARGET THEN
   INSERT (Descripcion)
   VALUES (SOURCE.Descripcion)
WHEN NOT MATCHED BY SOURCE THEN
   DELETE;


   --Merge tabla preguntaRespuestas
   MERGE preguntaRespuestas AS TARGET
USING (values
(1,1,1,2),
(2,1,2,13),
(3,2,1,3),
(4,2,2,5),
(5,3,1,4),
(6,3,2,5),
(7,4,1,5),
(8,4,2,5),
(9,5,1,6),
(10,5,2,6),
(11,6,1,7),
(12,6,2,7),
(13,7,1,8),
(14,7,2,8),
(15,8,1,9),
(16,8,2,9),
(17,9,1,10),
(18,9,2,10),
(19,10,1,11),
(20,10,2,11),
(21,11,1,12),
(22,11,2,12),
(23,12,1,13),
(24,12,2,13),
(25,14,1,2),
(26,14,2,14),
(27,15,1,3),
(28,15,2,5),
(29,16,1,4),
(30,16,2,5),
(31,17,1,5),
(32,17,2,5),
(33,18,1,6),
(34,18,2,6),
(35,19,1,7),
(36,19,2,7),
(37,20,1,8),
(38,20,2,8),
(39,21,1,9),
(40,21,2,9),
(41,22,1,10),
(42,22,2,10),
(43,23,1,11),
(44,23,2,11),
(45,24,1,12),
(46,24,2,12),
(47,25,1,13),
(48,25,2,13),
(49,26,3,14),
(50,26,4,14),
(51,26,5,14)

) AS SOURCE (
[PreguntaRespuestaId],
[FactorPreguntaId],
[RespuestaId],
[SiguientePregunta]

)
   ON (TARGET.PreguntaRespuestaId = SOURCE.[PreguntaRespuestaId])
WHEN MATCHED  THEN
   UPDATE SET TARGET.FactorPreguntaId = SOURCE.FactorPreguntaId, TARGET.RespuestaId = SOURCE.RespuestaId, TARGET.SiguientePregunta = SOURCE.SiguientePregunta
WHEN NOT MATCHED BY TARGET THEN
   INSERT (FactorPreguntaId, RespuestaId, SiguientePregunta)
   VALUES (SOURCE.FactorPreguntaId, SOURCE.RespuestaId, SOURCE.SiguientePregunta )
WHEN NOT MATCHED BY SOURCE THEN
   DELETE;

   --Merge Tabla preguntaRespuestaValor
MERGE preguntaRespuestaValor AS TARGET
USING (values
(1,3,1),
(2,5,3),
(3,7,3),
(4,9,1),
(5,11,1),
(6,13,1),
(7,15,1),
(8,17,1),
(9,19,1),
(10,21,1),
(11,23,1),
(12,25,1),
(13,27,1),
(14,29,1),
(15,31,1),
(16,33,1),
(17,35,1),
(18,37,1),
(19,39,3),
(20,41,1),
(21,43,1),
(22,45,1),
(23,47,1)


) AS SOURCE (
[PreguntaRespuestaValorId],
[PreguntaRespuestaId],
[Valor]

)
   ON (TARGET.PreguntaRespuestaValorId = SOURCE.[PreguntaRespuestaValorId])
WHEN MATCHED  THEN
   UPDATE SET TARGET.PreguntaRespuestaId = SOURCE.PreguntaRespuestaId, TARGET.Valor = SOURCE.Valor
WHEN NOT MATCHED BY TARGET THEN
    INSERT (PreguntaRespuestaValorId, PreguntaRespuestaId, Valor)
   VALUES (SOURCE.PreguntaRespuestaValorId, SOURCE.PreguntaRespuestaId, SOURCE.Valor )
WHEN NOT MATCHED BY SOURCE THEN
   DELETE;

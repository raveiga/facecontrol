SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


DROP TABLE IF EXISTS configuraciones;

CREATE TABLE `configuraciones` (
  `variable` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nombre de la variable de configuración',
  `valor` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'Valor que almacenará esa variable.',
  `descripcion` varchar(200) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Texto descriptivo de la variable. Se muestra en el GRID.',
  `editable` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT 'Si editable es =1 se muestra en el GRID. Si es =0 es una variable oculta a edición.',
  PRIMARY KEY (`variable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO configuraciones VALUES ("colorEventosCalendarioGoogle","#5E783C","Color Eventos Calendario de Google","1"),
("datoscentro","Calle de las Avenidas<br>12345 Mi Localidad o Provincia<br>Telef.: 111 222 333<br>E-mail.: micorreo@dominio.com","Dirección y Teléfono del Centro","1"),
("extras","{\"diascontrol\":[\"0\",\"1\",\"2\",\"3\",\"4\"],\"mesescontrol\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"9\",\"10\",\"11\",\"12\"],\"smtp\":{\"email\":\"\",\"smtp\":\"\",\"usuario\":\"\",\"password\":\"\",\"puerto\":\"\"},\"cuentajabber\":{\"host\":\"\",\"usuario\":\"\",\"password\":\"\"}}","Parámetros de Configuraciones Adicionales para Incidencias","0"),
("fichadosconsecutivos","5","Tiempo Mínimo (minutos) entre fichados consecutivos","1"),
("maxdiassemana","5","Número máximo de dias / semana en Horario","1"),
("maxfilashorario","7","Número máximo de Filas mostradas en el Horario","1"),
("modifhorarios","1","¿Permitir modificar Horarios  0-No, 1-Si ?","1"),
("nombrecentro","Centro Educativo","Nombre del Centro","1"),
("puntualidadEstadistica","5","Puntualidad Estadísticas (5 minutos, por ejemplo)","1"),
("rangotime","00:15:00","Rango de Tiempo para Fichar en Hora. (HH:MM:SS)","1"),
("urlcentro","http://www.google.com","URL Página Web del Centro","1"),
("urlEventosCalendarioGoogle","","URL Feed Eventos Calendario Google","1"),
("urlogocentro","uploads/718ea925aa956a1f6247e9e7749278fa.jpg","URL que contiene el Logo del Centro para Informes PDF","1");


DROP TABLE IF EXISTS cursos;

CREATE TABLE `cursos` (
  `idcurso` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identificador del curso.',
  `curso` varchar(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL COMMENT 'Nombre del Curso.',
  `grupo` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nombre del Grupo.',
  `enseñanza` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL COMMENT 'Tipo de Enseñanza.',
  PRIMARY KEY (`idcurso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;;


DROP TABLE IF EXISTS cursos_modulos;

CREATE TABLE `cursos_modulos` (
  `curso` smallint(5) unsigned NOT NULL COMMENT 'Identificador del curso.',
  `modulo` smallint(5) unsigned NOT NULL COMMENT 'Identificación del módulo.',
  PRIMARY KEY (`curso`,`modulo`),
  KEY `modulo` (`modulo`),
  CONSTRAINT `cursos_modulos_ibfk_1` FOREIGN KEY (`curso`) REFERENCES `cursos` (`idcurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cursos_modulos_ibfk_2` FOREIGN KEY (`modulo`) REFERENCES `modulos` (`idmodulo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;;

DROP TABLE IF EXISTS franjas;

CREATE TABLE `franjas` (
  `idfranja` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identificación de Franja horaria.',
  `horario` smallint(5) unsigned NOT NULL COMMENT 'Identificación de horario.',
  `horainicio` time NOT NULL DEFAULT '00:00:00' COMMENT 'Hora de Inicio de esa franja horaria.',
  `horafin` time NOT NULL DEFAULT '00:00:00' COMMENT 'Hora de fin de esa franja horaria.',
  `posicion` tinyint(4) NOT NULL COMMENT 'Posición en el cuadro horario. Fila 0, Fila 1, ....',
  `diasemana` tinyint(4) NOT NULL COMMENT 'Día de la semana en el que  se imparte. El lunes es día 0.',
  `modulo` smallint(5) unsigned NOT NULL COMMENT 'Código de módulo que se imparte.',
  `zona` smallint(5) unsigned NOT NULL COMMENT 'Zona del centro dónde se imparte.',
  PRIMARY KEY (`idfranja`),
  KEY `horario` (`horario`),
  KEY `zona` (`zona`),
  KEY `modulo` (`modulo`),
  CONSTRAINT `franjas_ibfk_1` FOREIGN KEY (`horario`) REFERENCES `horarios` (`idhorario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `franjas_ibfk_2` FOREIGN KEY (`zona`) REFERENCES `zonas` (`idzona`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `franjas_ibfk_3` FOREIGN KEY (`modulo`) REFERENCES `modulos` (`idmodulo`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;;


DROP TABLE IF EXISTS horarios;

CREATE TABLE `horarios` (
  `idhorario` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identificación de Horario.',
  `curso` smallint(5) unsigned NOT NULL COMMENT 'Identificador del curso al que pertenece ese horario.',
  `usuario` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Identificador del usuario al que pertenece ese horario.',
  PRIMARY KEY (`idhorario`),
  KEY `usuario` (`usuario`),
  KEY `curso` (`curso`),
  CONSTRAINT `horarios_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuarios` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `horarios_ibfk_2` FOREIGN KEY (`curso`) REFERENCES `cursos` (`idcurso`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;;


DROP TABLE IF EXISTS mensajes;

CREATE TABLE `mensajes` (
  `idmensaje` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identificación del mensaje.',
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora de grabación del mensaje.',
  `asunto` varchar(150) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Asunto del mensaje interno.',
  `contenido` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'Contenido del mensaje interno.',
  `tipomensaje` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'n' COMMENT 'Tipo de mensaje: n=normal, i=incidencia',
  PRIMARY KEY (`idmensaje`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;;


DROP TABLE IF EXISTS mensajes_usuarios;

CREATE TABLE `mensajes_usuarios` (
  `mensaje` int(10) unsigned NOT NULL,
  `remitente` mediumint(8) unsigned NOT NULL,
  `destinatario` mediumint(8) unsigned NOT NULL,
  `leido` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `respondido` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `justificacion` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `aceptada` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `codigopermiso` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`mensaje`,`destinatario`),
  KEY `remitente` (`remitente`),
  KEY `destinatario` (`destinatario`),
  KEY `codigopermiso` (`codigopermiso`),
  CONSTRAINT `mensajes_usuarios_ibfk_1` FOREIGN KEY (`remitente`) REFERENCES `usuarios` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mensajes_usuarios_ibfk_2` FOREIGN KEY (`destinatario`) REFERENCES `usuarios` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mensajes_usuarios_ibfk_3` FOREIGN KEY (`mensaje`) REFERENCES `mensajes` (`idmensaje`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mensajes_usuarios_ibfk_4` FOREIGN KEY (`codigopermiso`) REFERENCES `permisos` (`idpermiso`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;;


DROP TABLE IF EXISTS modulos;

CREATE TABLE `modulos` (
  `idmodulo` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identificador del módulo.',
  `abreviatura` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Abreviatura del módulo.',
  `nombremodulo` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nombre completo del módulo.',
  PRIMARY KEY (`idmodulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;;


DROP TABLE IF EXISTS permisos;

CREATE TABLE `permisos` (
  `idpermiso` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identificador del permiso.',
  `permiso` varchar(150) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nombre e información de ese permiso.',
  PRIMARY KEY (`idpermiso`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO permisos VALUES ("1","art. 03 - Fallecimiento, accidente o enfermedad"),
("2","art. 04 - Traslado de domicilio"),
("3","art. 06 - Realización de exámenes finales y demás pruebas"),
("4","art. 08 - Nacimiento de hijos/as que deban permanecer hospitalizados"),
("5","art. 09 - Realizacion de examenes prenatales y técnicas preparación parto"),
("6","art. 10 - Tratamientos de Fecundación Asistida"),
("7","art. 12 - Revisiones Médicas"),
("8","art. 13 - Deber inexcusable de caracter publico o personal"),
("9","art. 14 - Asuntos personales (2 días al año)"),
("10","art. 17 - Paternidad"),
("11","art. 18 - Violencia de género sobre el personal funcionario"),
("12","art. 27 - Imprevistos (24 períodos lectivos)");


DROP TABLE IF EXISTS privilegios;

CREATE TABLE `privilegios` (
  `privilegio` tinyint(4) NOT NULL COMMENT 'Nivel de Privilegio',
  `nombre` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nombre del grupo asociado a ese nivel.',
  PRIMARY KEY (`privilegio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO privilegios VALUES ("1","Alumnos"),
("2","Cursos - Grupos"),
("3","P.A.S."),
("5","Profesores"),
("7","Dirección"),
("9","Jefes Estudios"),
("10","Administradores");


DROP TABLE IF EXISTS registros;

CREATE TABLE `registros` (
  `idregistro` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identificación del registro de acceso para fichar.',
  `usuario` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Identificador del usuario que accede.',
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha y hora del registro.',
  `ip` varchar(39) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Dirección IP desde la que accede.',
  `sensor` smallint(5) DEFAULT NULL COMMENT 'Código del sensor RFID desde el que ficha.',
  `tiporegistro` char(1) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Tipo de registro: E=Entrada, S=Salida',
  `incidencia` char(1) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Tipo de incidencia: A=Entrada con Retardo, D=Salida con adelanto, H=Falta de asistencia, ',
  `minutos` smallint(6) DEFAULT NULL COMMENT 'Minutos positivos o negativos de adelanto o retraso.',
  `franjahoraria` mediumint(8) unsigned NOT NULL COMMENT 'Código de franja horaria en la que está fichando.',
  `zonapermitida` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '1' COMMENT 'Valor =1, es una zona permitida para fichar, 0=Zona prohibida.',
  PRIMARY KEY (`idregistro`),
  KEY `usuario` (`usuario`),
  KEY `franjahoraria` (`franjahoraria`),
  CONSTRAINT `registros_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuarios` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `registros_ibfk_2` FOREIGN KEY (`franjahoraria`) REFERENCES `franjas` (`idfranja`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;;


DROP TABLE IF EXISTS registrostemp;

CREATE TABLE `registrostemp` (
  `idregistro` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identificación del registro de acceso para fichar.',
  `usuario` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Identificador del usuario que accede.',
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha y hora del registro.',
  `ip` varchar(39) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Dirección IP desde la que accede.',
  `sensor` smallint(5) DEFAULT NULL COMMENT 'Código del sensor RFID desde el que ficha.',
  `tiporegistro` char(1) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Tipo de registro: E=Entrada, S=Salida',
  `incidencia` char(1) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Tipo de incidencia: A=Entrada con Retardo, D=Salida con adelanto, H=Falta de asistencia, ',
  `minutos` smallint(6) DEFAULT NULL COMMENT 'Minutos positivos o negativos de adelanto o retraso.',
  `franjahoraria` mediumint(8) unsigned NOT NULL COMMENT 'Código de franja horaria en la que está fichando.',
  `zonapermitida` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '1' COMMENT 'Valor =1, es una zona permitida para fichar, 0=Zona prohibida.',
  PRIMARY KEY (`idregistro`),
  KEY `usuario` (`usuario`),
  KEY `franjahoraria` (`franjahoraria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;;


DROP TABLE IF EXISTS usuarios;

CREATE TABLE `usuarios` (
  `idusuario` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identificador del Usuario.',
  `logincentro` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Login de acceso en la red del centro.',
  `password` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Contraseña de acceso.',
  `passwordprov` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `fotografia` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nombre` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nombre',
  `apellidos` varchar(120) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Apellidos',
  `sexo` char(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Sexo',
  `nif` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'NIF',
  `fechanacimiento` date DEFAULT NULL COMMENT 'Fecha de Nacimiento',
  `movil` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Teléfono Móvil',
  `email` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Dirección de E-mail',
  `jabber` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Dirección Jabber',
  `direccion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Dirección',
  `tarjetarfid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Código de Tarjeta RFID asociada',
  `privilegio` tinyint(4) DEFAULT NULL COMMENT 'Asociado con tipo de usuario:',
  `importacion` tinyint(4) NOT NULL DEFAULT '-1' COMMENT 'Control de importación de datos.',
  `horario` smallint(5) NOT NULL DEFAULT '0' COMMENT 'Código de horario asociado.',
  `activo` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '1' COMMENT 'Está activada o no la cuenta.',
  `controlfaltas` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `notificacionespropias` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT 'Tiene activada la recepción de notificaciones del sistema?',
  `notificarincidenciajefatura` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT 'Si ese usuario falta, y si esta opción está activada, se nofiticará de forma instantánea a jefatura de estudios .',
  PRIMARY KEY (`idusuario`),
  KEY `nif` (`nif`),
  KEY `tarjetarfid` (`tarjetarfid`),
  KEY `privilegio` (`privilegio`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`privilegio`) REFERENCES `privilegios` (`privilegio`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO usuarios VALUES ("1","admin","$1$00172969$ShsxN6eXwd8/8UM2XOLB00","4fad76e4","","Administrador","del Sistema","V","111111111A","","","","","","","10","-1","0","1","1","1","1");


DROP TABLE IF EXISTS usuarios_cursos;

CREATE TABLE `usuarios_cursos` (
  `usuario` mediumint(8) unsigned NOT NULL COMMENT 'Código de Usuario',
  `curso` smallint(5) unsigned NOT NULL COMMENT 'Identificador de curso en el que está matriculado',
  PRIMARY KEY (`usuario`,`curso`),
  KEY `curso` (`curso`),
  CONSTRAINT `usuarios_cursos_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuarios` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usuarios_cursos_ibfk_2` FOREIGN KEY (`curso`) REFERENCES `cursos` (`idcurso`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;;


DROP TABLE IF EXISTS zonas;

CREATE TABLE `zonas` (
  `idzona` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identificador de zona.',
  `nombrezona` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nombre de la Zona.',
  `abreviatura` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Abreviatura de la zona. Recomendable sin espacios',
  `telefono` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `subnetcontrol` varchar(39) COLLATE utf8_unicode_ci NOT NULL DEFAULT '*' COMMENT 'Dirección de RED a la que pertenece esa zona.',
  PRIMARY KEY (`idzona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;;



SET FOREIGN_KEY_CHECKS=1;


CREATE TABLE IF NOT EXISTS `acregnom` (
`Id` bigint(20) NOT NULL,
  `CodUser` varchar(15) NOT NULL DEFAULT '',
  `CodMov` int(11) NOT NULL DEFAULT '0',
  `Procedencia` int(11) NOT NULL DEFAULT '0',
  `Canal` int(10) unsigned NOT NULL DEFAULT '0',
  `Mtv` int(11) NOT NULL DEFAULT '0',
  `Fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Empresa` varchar(15) NOT NULL DEFAULT '',
  `Situacion` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=248912 DEFAULT CHARSET=utf8;


INSERT INTO `acregnom` (`Id`, `CodUser`, `CodMov`, `Procedencia`, `Canal`, `Mtv`, `Fecha`, `Empresa`, `Situacion`) VALUES
(1, '1', 0, 0, 0, 0, '2015-06-12 10:54:18', '0', 0),
(2, '4', 0, 0, 0, 0, '2015-06-12 10:54:13', '0', 0),
(3, '1', 0, 0, 0, 0, '2015-06-12 10:47:47', '0', 0),
(4, '1', 0, 0, 0, 0, '2015-06-12 10:42:48', '0', 0),
(5, '1', 0, 0, 0, 0, '2015-06-12 10:34:07', '0', 0),
(6, '1', 0, 0, 0, 0, '2015-06-12 10:27:21', '0', 0),
(7, '1', 0, 0, 0, 0, '2015-06-12 10:23:03', '0', 0),
(8, '1', 0, 0, 0, 0, '2015-06-12 10:21:32', '0', 0);


ALTER TABLE `acregnom`
 ADD PRIMARY KEY (`Id`), ADD KEY `Index_2` (`CodUser`,`Fecha`);


ALTER TABLE `acregnom`
MODIFY `Id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
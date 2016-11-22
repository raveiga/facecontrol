-- phpMyAdmin SQL Dump
-- version 4.2.12deb2+deb8u1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 24-05-2016 a las 19:06:23
-- Versión del servidor: 5.5.49-0+deb8u1
-- Versión de PHP: 5.6.20-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `presencia`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acregnom`
--

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

--
-- Volcado de datos para la tabla `acregnom`
--

INSERT INTO `acregnom` (`Id`, `CodUser`, `CodMov`, `Procedencia`, `Canal`, `Mtv`, `Fecha`, `Empresa`, `Situacion`) VALUES
(1, '1', 0, 0, 0, 0, '2015-06-12 10:54:18', '0', 0),
(2, '4', 0, 0, 0, 0, '2015-06-12 10:54:13', '0', 0),
(3, '1', 0, 0, 0, 0, '2015-06-12 10:47:47', '0', 0),
(4, '1', 0, 0, 0, 0, '2015-06-12 10:42:48', '0', 0),
(5, '1', 0, 0, 0, 0, '2015-06-12 10:34:07', '0', 0),
(6, '1', 0, 0, 0, 0, '2015-06-12 10:27:21', '0', 0),
(7, '1', 0, 0, 0, 0, '2015-06-12 10:23:03', '0', 0),
(8, '1', 0, 0, 0, 0, '2015-06-12 10:21:32', '0', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `acregnom`
--
ALTER TABLE `acregnom`
 ADD PRIMARY KEY (`Id`), ADD KEY `Index_2` (`CodUser`,`Fecha`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `acregnom`
--
ALTER TABLE `acregnom`
MODIFY `Id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

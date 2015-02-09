-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 06-01-2014 a las 21:26:50
-- Versión del servidor: 5.5.31
-- Versión de PHP: 5.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `mvc`
--
CREATE DATABASE IF NOT EXISTS `mvc` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `mvc`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `SuiteResult`
--

CREATE TABLE IF NOT EXISTS `SuiteResult` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `run_date` datetime NOT NULL,
  `failed` int(11) unsigned NOT NULL,
  `incomplete` int(11) unsigned NOT NULL,
  `skipped` int(11) unsigned NOT NULL,
  `succeeded` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `TestResult`
--

CREATE TABLE IF NOT EXISTS `TestResult` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `run_date` datetime NOT NULL,
  `failed` int(11) unsigned NOT NULL,
  `incomplete` int(11) unsigned NOT NULL,
  `skipped` int(11) unsigned NOT NULL,
  `succeeded` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tests`
--

CREATE TABLE IF NOT EXISTS `tests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `estatus_nombre_unique` (`nombre`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `tests`
--

INSERT INTO `tests` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Activo', '2013-12-18 20:06:47', '2013-12-18 20:06:47'),
(2, 'Eliminado', '2013-12-18 20:06:47', '2013-12-18 20:06:47'),
(3, 'Visto', '2013-12-18 20:06:47', '2013-12-18 20:06:47'),
(4, 'No visto', '2013-12-18 20:06:47', '2013-12-18 20:06:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `user_login` varchar(45) COLLATE utf8_spanish2_ci NOT NULL DEFAULT '',
  `p_nombre` varchar(45) COLLATE utf8_spanish2_ci NOT NULL,
  `p_apellido` varchar(45) COLLATE utf8_spanish2_ci NOT NULL,
  `cedula` int(15) NOT NULL DEFAULT '0',
  `rol` varchar(15) COLLATE utf8_spanish2_ci NOT NULL,
  `password` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `psecreta` varchar(45) COLLATE utf8_spanish2_ci NOT NULL,
  PRIMARY KEY (`user_login`,`cedula`,`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `user_login`, `p_nombre`, `p_apellido`, `cedula`, `rol`, `password`, `psecreta`) VALUES
(1, 'RamonSerrano', 'Ramon Eduardo', 'Serrano Canache', 23658013, 'Administrador', '123456', 'palabra Secreta de Ramon');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
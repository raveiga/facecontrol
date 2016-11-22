<?php
require_once '../inc/config00.php';

require_once $config['ruta']['inc'].'cabecera.php';
require_once $config['ruta']['inc'].'menusuperior.php';
require_once $config['ruta']['inc'].'menuizdo.php';

// Si no se pasan parametros carga por defecto central.php
if (!isset($_GET['cargar']) || $_GET['cargar']=='index')
	$_GET['cargar']='default';

// Si el parámetro que se pasa es de un fichero incorrecto, carga central.php
if (!file_exists($config['ruta']['inc'].'central_'.$_GET['cargar'].'.php'))
	$_GET['cargar']='default';

// Carga el módulo central de la aplicación.
require $config['ruta']['inc'].'central_'.$_GET['cargar'].'.php';


require_once $config['ruta']['inc'].'pie.php';
?>
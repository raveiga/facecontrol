<?php
/**
 * Función que encripta una password utilizando SHA-512 y 10000 vueltas por defecto
 *
 * @param string $password
 * @param int $vueltas Número de vueltas, opcional. Por defecto 10000.
 * @return string
 */
function encriptar($password, $vueltas = 10000) {
    // Empleamos SHA-512 con 10000 vueltas por defecto.
    $caracteres = './ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

    // Generamos una semilla aleatoria de 10 caracteres.
    $semilla = substr(str_shuffle($caracteres), 0, 10);

    return crypt((string) $password, '$6$' . "rounds=$vueltas\$$semilla\$");

    // Forma de comprobación de contraseña en login:
    // if (crypt($passRecibidaFormulario, $passwordAlmacenadaEncriptada) == $passwordAlmacenadaEncriptada)
    // Es necesario pasarle a la función crypt la $passwordAlmacenadaEncriptada para que pueda extraer la semilla y el número de vueltas.
    //{ ... }
}


/**
 * Genera un token para el formulario para evitar CSRF.
 *
 * @param string $datos Nombre del formulario que genera el token
 * @param integer Tiempo máximo de vida del token en segundos. Si caducó se genera uno nuevo.
 */
function generarTokenCSRF($datos, $delta_time) {
    if (!empty($_SESSION['csrf'][$datos . '_token'])) {
        if ($delta_time > 0) {
            $token_age = time() - $_SESSION['csrf'][$datos . '_token']['time'];
            if ($token_age >= $delta_time) {
                // generar token de forma aleatoria
                $token = md5(uniqid(microtime(), true));

                // generar fecha de generación del token
                $token_time = time();

                // escribir la información del token en sesión para poder
                // comprobar su validez cuando se reciba un token desde un formulario
                $_SESSION['csrf'][$datos . '_token'] = array('token' => $token, 'time' => $token_time);

                return $token;
            } else {
                return $_SESSION['csrf'][$datos . '_token']['token'];
            }
        }
    } else {

        // generar token de forma aleatoria
        $token = md5(uniqid(microtime(), true));

        // generar fecha de generación del token
        $token_time = time();

        // escribir la información del token en sesión para poder
        // comprobar su validez cuando se reciba un token desde un formulario
        $_SESSION['csrf'][$datos . '_token'] = array('token' => $token, 'time' => $token_time);
        return $token;
    }
}


/**
 * Comprobación del token usado en el formulario.
 *
 * @param string $datos Nombre del formulario
 * @param string $token El Token a comprobar
 * @param integer $delta_time Tiempo máximo de validez del token.
 * @return boolean
 */
function verificarTokenCSRF($datos, $token, $delta_time = 0) {

    // comprueba si hay un token registrado en sesión para el formulario
    if (!isset($_SESSION['csrf'][$datos . '_token'])) {
        return false;
    }

    // compara el token recibido con el registrado en sesión
    if ($_SESSION['csrf'][$datos . '_token']['token'] !== $token) {
        return false;
    }

    // si se indica un tiempo máximo de validez del ticket se compara la
    // fecha actual con la de generación del ticket
    if ($delta_time > 0) {
        $token_age = time() - $_SESSION['csrf'][$datos . '_token']['time'];
        if ($token_age >= $delta_time) {
            return false;
        }
    }

    return true;
}

/**
 * Devuelve true o false. Interesante para chequear todos los campos obligatorios de un formulario
 * @param  [array] $algo [Array a chequear que todas sus casillas contengan valores.]
 * @return [boolean]     [Devuelve verdadero o falso si no contiene valores.]
 */
function contieneValores($algo)
{
    foreach($algo as $clave=>$valor)
    {
        if ($valor=='')
        {
            return false;
        }
    }

    return true;
}

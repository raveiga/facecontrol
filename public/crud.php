<?php
if (!empty($_GET['op'])) {

    // Inicializamos la carga de las configuraciones y creamos la conexión a la base de datos
    require_once '../inc/config00.php';

    switch ($_GET['op']) {

/////////////////////////////////

        case 1:
        try{
            if (verificarTokenCSRF('sistema',$_POST['tokencsrf'],1800) && contieneValores($_POST))
            {
                $stmt=$pdo->prepare('insert into configuraciones(variable,valor,descripcion) values(?,?,?)');
                $stmt->bindParam(1,trim($_POST['variable']));
                $stmt->bindParam(2,trim($_POST['valor']));
                $stmt->bindParam(3,trim($_POST['descripcion']));
                $stmt->execute();
                header('Location: sistema');

            //echo '<div class="alert alert-success">
            //<strong>!Correcto! </strong>Datos Insertados con éxito en la base de datos.!</div>';
            //echo '<a href="altas.html">Volver</a>';
            }
            else
                echo '<div class="alert alert-danger"><strong>Error código 1:</strong>Token csrf caducado o faltan datos en el formulario.';
        }
        catch(PDOException $error)
        {
            //echo $error->getMessage();
            echo '<div class="alert alert-danger"><strong>Error código 1: </strong>Acceso a base de datos.</div>';
        }
        break;

/////////////////////////////////

        case 2:
        try{

            $stmt=$pdo->prepare('select * from configuraciones where variable=?');
            $stmt->bindParam(1,trim($_POST['variable']));
            $stmt->execute();
            header('Content-Type: application/json');
            echo json_encode($stmt->fetch());
        }
        catch(PDOException $error)
        {
            //echo $error->getMessage();
            echo '<div class="alert alert-danger"><strong>Error código 2: </strong>Acceso a base de datos.</div>';
        }
        break;


/////////////////////////////////

        case 3:
        try{
            if (verificarTokenCSRF('sistema',$_POST['tokencsrf'],1800) && contieneValores($_POST))
            {
                $stmt=$pdo->prepare('update configuraciones set variable=?,valor=?,descripcion=? where variable=?');
                $stmt->bindParam(1,trim($_POST['variable']));
                $stmt->bindParam(2,trim($_POST['valor']));
                $stmt->bindParam(3,trim($_POST['descripcion']));
                $stmt->bindParam(4,trim($_POST['variablevieja']));
                $stmt->execute();

                header('Location: sistema');
            }
             else
                echo '<div class="alert alert-danger"><strong>Error código 3:</strong>Token csrf caducado o faltan datos en el formulario.';
        }
        catch(PDOException $error)
        {
            //echo $error->getMessage();
            echo '<div class="alert alert-danger"><strong>Error código 3 </strong>Acceso a base de datos.</div>';
        }
        break;


/////////////////////////////////

        case 4:
        try{

            $stmt=$pdo->prepare('delete from configuraciones where variable=?');
            $stmt->bindParam(1,trim($_POST['variable']));
            $stmt->execute();
            echo 'ok';
        }
        catch(PDOException $error)
        {
            //echo $error->getMessage();
            echo '<div class="alert alert-danger"><strong>Error código 4 </strong>Acceso a base de datos.</div>';
        }
        break;


    } // Switch
}   // if

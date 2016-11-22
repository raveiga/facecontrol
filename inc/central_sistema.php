<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
  <h2>Configuraciones del Sistema</h2>
  <form class="form-horizontal" action="crud.php?op=1" method="post">
    <div class="form-group">
      <label for="variable" class="col-sm-2 control-label">Variable</label>
      <div class="col-sm-10">
        <input type="text" class="form-control" id="variable" name="variable" placeholder="Variable sin espacios. No admite duplicados." maxlength="50" required>
      </div>
    </div>
    <div class="form-group">
      <label for="valor" class="col-sm-2 control-label">Valor</label>
      <div class="col-sm-10">
        <input type="text" class="form-control" id="valor" name="valor" placeholder="Valor" required>
      </div>
    </div>
    <div class="form-group">
      <label for="descripcion" class="col-sm-2 control-label">Descripción</label>
      <div class="col-sm-10">
        <input type="text" class="form-control" id="descripcion" name="descripcion" placeholder="Descripción" maxlength="200" required>
      </div>
    </div>
    <input type="hidden" id="tokencsrf" name="tokencsrf" value="<?php echo generarTokenCSRF('sistema',1800); ?>">

    <div class="form-group">
      <div class="col-sm-offset-2 col-sm-10">
        <button type="reset" class="btn btn-default">Limpiar</button>
        <button type="submit" class="btn btn-success">Dar de Alta</button>
      </div>
    </div>
  </form>



  <h2>Listado de Configuraciones actuales</h2>
  <?php

  try{
      // Preparamos la consulta.
    $stmt=$pdo->prepare('SELECT * from configuraciones order by variable');

      // Ejecutamos la consulta.
    $stmt->execute();

      // Imprimimos primero la cabecera de la tabla.
    echo '<table class="table"><tr><th>Variable</th><th>Valor</th><th>Descripción</th><th>Editar</th><th>Borrar</th</tr>';

      // Recorremos el array asociativo con los resultados.
    while ($fila=$stmt->fetch())
    {
      echo "<tr><td id='{$fila['variable']}'>{$fila['variable']}</td><td>{$fila['valor']}</td><td>{$fila['descripcion']}</td><td><a href='#' class='editar'>Editar</a></td><td><a href='#' class='borrar'>Borrar</a></td></tr>";
    }

      // Cerramos la tabla
    echo "</table>";

  }
  catch(PDOException $error)
  {
      // $error->getMessage()
    echo '<div class="alert alert-danger"><strong>!Error! </strong>Error consultando la base de datos.</div>';

  }
  ?>


  <!-- Modal -->
  <div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <form class="form-horizontal" action="crud.php?op=3" method="post">
          <div class="form-group">
            <label for="variable" class="col-sm-2 control-label">Variable</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="variableEd" name="variable" placeholder="Variable sin espacios. No admite duplicados." maxlength="50" required>
            </div>
          </div>
          <div class="form-group">
            <label for="valor" class="col-sm-2 control-label">Valor</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="valorEd" name="valor" placeholder="Valor" required>
            </div>
          </div>
          <div class="form-group">
            <label for="descripcion" class="col-sm-2 control-label">Descripción</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="descripcionEd" name="descripcion" placeholder="Descripción" maxlength="200" required>
            </div>
          </div>
          <input type="hidden" id="tokencsrf" name="tokencsrf" value="<?php echo generarTokenCSRF('sistema',1800); ?>">
          <input type="hidden" id="variablevieja" name="variablevieja" value="">

          <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
              <button type="submit" class="btn btn-success">Editar</button>
            </div>
          </div>
        </form>




      </div>
    </div>
  </div>



</div>
<script src='js/central_sistema.js'></script>

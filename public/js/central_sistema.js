$(document).ready(function()
{
    // Petición ajax para coger los datos de un registro para editar
    $(".editar").on("click",function()
    {
        if ( !$('#myModal').hasClass('in') )
        {
            $.post('crud.php?op=2',{variable: $(this).parent().parent().find("td").attr('id')}, function(datos)
            {
                $('#myModal').modal('show');
                $("#variableEd").val(datos.variable);
                $("#valorEd").val(datos.valor);
                $("#descripcionEd").val(datos.descripcion);
                $("#variablevieja").val(datos.variable);
            });
        }
    });


    // Petición ajax para preguntar si desea borrar un registro.
    $(".borrar").on("click",function()
    {
        if (confirm("Está seguro/a de querer borrar el registro "+$(this).parent().parent().find("td").attr('id')+"?" ))
        {
            $.post('crud.php?op=4',{variable:$(this).parent().parent().find("td").attr('id')}, function(datos)
            {
                if (datos=='ok')
                    document.location.reload();
            });
        }
    });


});

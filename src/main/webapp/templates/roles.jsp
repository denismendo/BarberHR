<%@include file="../header.jsp" %>  
<div class="container body">
    <div class="main_container">
        <div class="right_col" role="main">
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Roles</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <br />
                            <form id="form" data-parsley-validate class="form-horizontal form-label-left">

                                <div class="input-group mb-3">
                                    <input type="hidden" id="listar" name="listar" value="cargar" ></input>
                                    <input type="hidden" id="id_rol" required="required" class="form-control" name="id_rol">
                                </div>

                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Nombre <span class="required">*</span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input type="text" id="nombre" required="required" class="fa-check-circle form-control" name="nombre">
                                    </div>
                                </div>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="last-name">Descripcion <span class="required">*</span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input type="text" id="descripcion" name="descripcion" required="required" class="form-control">
                                    </div>
                                </div>                                
                                <div class="ln_solid"></div>
                                <div class="item form-group text-center">
                                    <div class="col-md-6 col-sm-6 offset-md-3 ">
                                        <button class="btn btn-primary" type="reset">Cancelar</button>
                                        <button type="button" id="boton" class="btn btn-success">Guardar</button>
                                    </div>
                                </div>
                            </form>
                            <div role="alert" id="mensaje"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">   
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Lista Roles</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="card-box table-responsive">

                                        <table id="resultado" class="table table-striped table-bordered" style="width:100%">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Nombre</th>
                                                    <th>Descripcion</th>
                                                    <th>Opciones</th>
                                                    <a class="btn btn-primary" href="../reportesJSP/reporteGeneralRoles.jsp" target="_blank">INFO GENERAL</a>
                                                
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <div class="modal" id="showModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Eliminar Rol</h5>
                            <!--<button type="button" class="close btn-danger" data-dismiss="modal" aria-label="Close"></button>-->
                        </div>
                        <div class="modal-body">
                            <h2 class="h3">Está seguro de eliminar el rol?</h2>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" id="eliminar_rol">Si</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--<script src="../vendors/validator/validator.js"></script>-->

<!--<script src="../jsp/jquery/dist/jquery-3.7.1.min.js"></script>-->

<%@include file="../footer.jsp" %>
<script>
 $(document).ready(function () {
    rellenardatos();
});

function rellenardatos() {
    $.ajax({
        data: { listar: 'listar' },
        type: 'POST',
        url: '../jsp/rolescrud.jsp',
        success: function (response) {
            $("#resultado tbody").html(response);
        }
    });
}

$("#boton").on("click", function () {
    cargarDatos();
});

const cargarDatos = () => {
    let nombre = $("#nombre").val();
    let descripcion = $("#descripcion").val();
    let listar = $("#listar").val();
    alerta = $("#mensaje");
    if (nombre.trim() === "" || descripcion.trim() === "") {
        
        alerta.addClass("red");
        alerta.text("Todos los campos son obligatorios").fadeIn();

        setTimeout(() => {
            alerta.fadeOut();
        }, 2000);
    } else {
        let datosform = $("#form").serialize();
        $.ajax({
            data: datosform,
            url: '../jsp/rolescrud.jsp',
            type: 'POST',
            success: function (response) {
                rellenardatos();
                alerta.html(response).fadeIn();

                limpiar();
                $("#nombre").focus();

                setTimeout(function () {
                    alerta.fadeOut();
                }, 2000);
                 $("#listar").val("cargar");
            }
        });
    }
};

function rellenaredit(a, b, c) {
    $('#id_rol').val(a);
    $('#nombre').val(b);
    $('#descripcion').val(c);
    $('#listar').val('modificar');
}

$("#eliminar_rol").on("click", function () {
    pk = $("#id_rol").val();
    if (pk) {
        $.ajax({
            data: { listar: "eliminar", idpk: pk },
            url: '../jsp/rolescrud.jsp',
            type: 'POST',
            success: function (response) {
                alerta = $("#mensaje");
                alerta.html(response).fadeIn();
                
                rellenardatos();
                limpiar();
                $("#listar").val("cargar");
                $("#nombre").focus();

                setTimeout(function () {
                    alerta.fadeOut();
                }, 2000);
            }
        });
    } else {
        let alerta = $("#mensaje");
        alerta.html("Error: ID no válido!").fadeIn();
        setTimeout(function () {
            alerta.fadeOut();
        }, 2000);
    }
});

const limpiar = () => {
    $("#id_rol").val("");
    $("#nombre").val("");
    $("#descripcion").val("");
};


</script>





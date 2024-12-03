<%@include file="../header.jsp" %>  
<div class="container body">
    <div class="main_container">
        <div class="right_col" role="main">
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Servicios</h2>
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
                                    <input type="hidden" id="id_servicio" required="required" class="form-control" name="id_servicio">
                                </div>

                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Nombre <span class="required">*</span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input type="text" id="nombre" required="required" class="fa-check-circle form-control" name="nombre">
                                    </div>
                                </div>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="last-name">Precio <span class="required">*</span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input type="text" id="precio" name="precio" required="required" class="form-control">
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
                                                    <th>Precio</th>
                                                    <th>Opciones</th>
                                                    <a class="btn btn-primary" href="../reportesJSP/reporteGeneralServicios.jsp" target="_blank">INFO GENERAL</a>
                                                
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
                            <button type="button" class="btn btn-primary" data-dismiss="modal" id="eliminar_servicio">Si</button>
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
//    $(document).ready(function () {
//        rellenardatos();
//    });
//
//    function rellenardatos() {
//        $.ajax({
//            data: {listar: 'listar'},
//            type: 'POST',
//            url: '../jsp/servicioscrud.jsp',
//            success: function (response) {
//                $("#resultado tbody").html(response);
//            }
//        });
//    }
//
//    $("#boton").on("click", function () {
//        cargarDatos();
//    });
//
//    const cargarDatos = () => {
//        let nombre = $("#nombre").val();
//        let precio = $("#precio").val();
//
//        let alerta = $("#mensaje").html("");
//        if (nombre.trim() === "" || precio.trim() === "") {
//            alerta.removeClass("alert alert-danger alert-success");
//            alerta.addClass("alert alert-danger");
//            alerta.text("Todos los campos son requeridos!");
//            alerta.show();
//
//            setTimeout(() => {
//                alerta.fadeOut();
//            }, 2000);
//        } else {
//            let datosform = $("#form").serialize();
//            $.ajax({
//                data: datosform,
//                url: '../jsp/servicioscrud.jsp',
//                type: 'POST',
//                success: function (response) {
//                    alerta = $("#mensaje").html(response);
//                    rellenardatos();
//                    $("#listar").val("cargar");
//                    limpiar();
//                    $("#nombre").focus();
//                    setTimeout(function () {
//                        alerta.fadeOut();
//                    }, 2000);
//                }
//            });
//        }
//    };
//
//    function rellenaredit(a, b, c) {
//        $('#id_servicio').val(a);
//        $('#nombre').val(b);
//        $('#precio').val(c);
//        $('#listar').val('modificar');
//    }
//
//    $("#eliminar_servicio").on("click", function () {
//        listar = $("#listar_eliminar").val();
//        pk = $("#id_servicio").val();
//
//        $.ajax({
//            data: {listar: "eliminar", idpk: pk},
//            url: '../jsp/servicioscrud.jsp',
//            type: 'POST',
//            success: function (response) {
//                $("#mensaje").html(response);
//                
//                rellenardatos();
//
//                limpiar();
//                $("#listar").val("cargar");
//                $("#nombre").focus();
//
//                setTimeout(function () {
//                    $("#mensaje").fadeOut();
//                }, 2000);
//            }
//        });
//    });
//
//
//    const alerta = (mensaje) => {
//        mensaje.removeClass("alert alert-danger");
//        mensaje.addClass("alert alert-success");
//        mensaje.show();
//    };
//
//    const limpiar = () => {
//        $("#id_servicio").val("");
//        $("#nombre").val("");
//        $("#precio").val("");
//    };


$(document).ready(function () {
    rellenardatos();
});

function rellenardatos() {
    $.ajax({
        data: {listar: 'listar'},
        type: 'POST',
        url: '../jsp/servicioscrud.jsp',
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
    let precio = $("#precio").val();

    let alerta = $("#mensaje").html("");
    if (nombre.trim() === "" || precio.trim() === "") {
        alerta.removeClass("alert alert-danger alert-success");
        alerta.addClass("alert alert-danger");
        alerta.text("Todos los campos son requeridos!");
        alerta.show();

        setTimeout(() => {
            alerta.fadeOut();
        }, 2000);
    } else {
        let datosform = $("#form").serialize();
        $.ajax({
            data: datosform,
            url: '../jsp/servicioscrud.jsp',
            type: 'POST',
            success: function (response) {
                $("#mensaje").html(response).show();
                rellenardatos();
                $("#listar").val("cargar");
                limpiar();
                $("#nombre").focus();
                setTimeout(function () {
                    $("#mensaje").fadeOut();
                }, 2000);
            }
        });
    }
};

function rellenaredit(a, b, c) {
    $('#id_servicio').val(a);
    $('#nombre').val(b);
    $('#precio').val(c);
    $('#listar').val('modificar');
}

$("#eliminar_servicio").on("click", function () {
    let listar = $("#listar_eliminar").val();
    let pk = $("#id_servicio").val();

    $.ajax({
        data: {listar: "eliminar", idpk: pk},
        url: '../jsp/servicioscrud.jsp',
        type: 'POST',
        success: function (response) {
            $("#mensaje").html(response);
            
            rellenardatos();

            limpiar();
            $("#listar").val("cargar");
            $("#nombre").focus();

            setTimeout(function () {
                $("#mensaje").fadeOut();
            }, 2000);
        }
    });
});

const limpiar = () => {
    $("#id_servicio").val("");
    $("#nombre").val("");
    $("#precio").val("");
};

</script>





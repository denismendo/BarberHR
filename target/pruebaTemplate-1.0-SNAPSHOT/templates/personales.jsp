<%@include file="../header.jsp" %>
<div class="container body">
    <div class="main_container">
        <div class="right_col" role="main">
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Personales</h2>
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
                                    <input type="hidden" id="id_personal" required="required" class="form-control" name="id_personal">
                                </div>

                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="ciudad">Ciudad <span class="required">*</span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 ">    

                                        <input type="hidden" id="codciudad" name="codciudad" value="0"></input>
                                        <select class="form-control" id="id_ciudad" name="id_ciudad" onchange="dividirciudad(this.value)">

                                        </select>

                                    </div>
                                </div>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="ciudad">Rol <span class="required">*</span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 ">    

                                        <input type="hidden" id="codRol" name="codRol" value="0"></input>
                                        <select class="form-control" id="id_rol" name="id_rol" onchange="dividirRol(this.value)">

                                        </select>

                                    </div>
                                </div>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Nombre <span class="required">*</span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input type="text" id="nombre" required="required" class="form-control" name="nombre">
                                    </div>
                                </div>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Apellido <span class="required">*</span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input type="text" id="apellido" required="required" class="form-control" name="apellido">
                                    </div>
                                </div>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">CI <span class="required">*</span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input type="text" id="ci" required="required" class="form-control" name="ci">
                                    </div>
                                </div>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Telefono <span class="required">*</span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input type="text" id="telefono" required="required" class="form-control" name="telefono">
                                    </div>
                                </div>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="last-name">Correo <span class="required">*</span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input type="email" id="correo" name="correo" required="required" class="form-control">
                                    </div>
                                </div>                                
                                <div class="ln_solid"></div>
                                <div class="item form-group text-center">
                                    <div class="col-md-6 col-sm-6 offset-md-3">
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
                                                    <th>Ciudad</th>
                                                    <th>Nombre</th>
                                                    <th>Apellido</th>
                                                    <th>CI</th>
                                                    <th>Telefono</th>
                                                    <th>Correo</th>
                                                    <th>Opciones</th>
                                                    <a class="btn btn-primary" href="../reportesJSP/reporteGeneralPersonales.jsp" target="_blank">INFO GENERAL</a>
                                                
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
                            <h5 class="modal-title">Eliminar Personal</h5>
                            <!--<button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>-->
                        </div>
                        <div class="modal-body">
                            <h2 class="h3">Est� seguro de eliminar el registro?</h2>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" id="eliminar_personal">Si</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="../footer.jsp" %>

<script>
    $(document).ready(function () {
        rellenardatos();
        buscarRol();
        buscarciudad();
    });

    function rellenardatos() {
        $.ajax({
            data: {listar: 'listar'},
            type: 'POST',
            url: '../jsp/personalescrud.jsp',
            success: function (response) {
                $("#resultado tbody").html(response);
            }
        });
    }
    
    function buscarciudad() {
        $.ajax({
            data: {listar: 'buscarciudad'},
            url: '../jsp/buscar.jsp',
            type: 'POST',
            beforeSend: function () {

            },
            success: function (response) {
                $("#id_ciudad").html(response);
            }
        });
    }
    function buscarRol() {
        $.ajax({
            data: {listar: 'buscarrol'},
            url: '../jsp/buscar.jsp',
            type: 'POST',
            beforeSend: function () {

            },
            success: function (response) {
                $("#id_rol").html(response);
            }
        });
    }
    function dividirciudad(a) {
        datos = a.split(",");
        $("#codciudad").val(datos[0]);
    }
    function dividirRol(a) {
        datos = a.split(",");
        $("#codRol").val(datos[0]);
    }


    $("#boton").on("click", function () {
        cargarDatos();
    });

    const cargarDatos = () => {
//        let idpersonal = $("#id_personal");
        let nombre = $("#nombre").val();
        let apellido = $("#apellido").val();
        let ci = $("#ci").val();
        let telefono = $("#telefono").val();
        let correo = $("#correo").val();

        let alerta = $("#mensaje").html("");
        if (nombre.trim() === "" || apellido.trim() === "" || ci.trim() === "" || telefono.trim() === "" || correo.trim() === "") {
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
                url: '../jsp/personalescrud.jsp',
                type: 'POST',
                success: function (response) {
//                    alerta = $("#mensaje");
                    alerta.removeClass("alert alert-danger");
                    alerta.addClass("alert alert-success");
                    alerta.html(response);
                    alerta.show();
                    rellenardatos();

                    limpiar();
                    $("#listar").val("cargar");
                    $("#nombre").focus();

                    setTimeout(function () {
                        alerta.fadeOut();
                    }, 2000);
                }
            });
        }
    };

    function rellenaredit(i,f, a, b, c, d, e) {
//        alerta = $("#mensaje");
        $('#id_personal').val(i);
        $('#id_ciudad').val(f);
        $('#nombre').val(a);
        $('#apellido').val(b);
        $('#ci').val(c);
        $('#telefono').val(d);
        $('#correo').val(e);
        $('#listar').val("modificar");

    }

    $("#eliminar_personal").on("click", function () {
        listar = $("#listar_eliminar").val();
        pk = $("#id_personal").val();

        $.ajax({
            data: {listar: "eliminar", idpk: pk},
            url: '../jsp/personalescrud.jsp',
            type: 'POST',
            success: function (response) {
                $("#mensaje").html(response);
//                alerta.html(response).fadeIn();?
                rellenardatos();
                limpiar();
                $("#listar").val("cargar");
                setTimeout(function () {
                    alerta.fadeOut();
                }, 2000);
            }
        });
    });

    const limpiar = () => {
        $("#id_personal").val("");
        $("#codciudad").val("");
        $("#nombre").val("");
        $("#apellido").val("");
        $("#ci").val("");
        $("#telefono").val("");
        $("#correo").val("");
    };




//$(document).ready(function () {
//    rellenardatos();
//});
//
//function rellenardatos() {
//    $.ajax({
//        data: {listar: 'listar'},
//        type: 'POST',
//        url: '../jsp/personalescrud.jsp',
//        success: function (response) {
//            $("#resultado tbody").html(response);
//        }
//    });
//}
//
//$("#boton").on("click", function () {
//    cargarDatos();
//});
//
//const cargarDatos = () => {
//    let idpersonal = $("#id_personal").val();
//    let nombre = $("#nombre").val();
//    let apellido = $("#apellido").val();
//    let ci = $("#ci").val();
//    let telefono = $("#telefono").val();
//    let correo = $("#correo").val();
//
//    let alerta = $("#mensaje").html("");
//    if (nombre.trim() === "" || apellido.trim() === "" || ci.trim() === "" || telefono.trim() === "" || correo.trim() === "") {
//        alerta.removeClass("alert alert-danger alert-success");
//        alerta.addClass("alert alert-danger");
//        alerta.text("Todos los campos son requeridos!");
//        alerta.show();
//
//        setTimeout(() => {
//            alerta.fadeOut();
//        }, 2000);
//    } else {
//        let datosform = $("#form").serialize();
//        $.ajax({
//            data: datosform,
//            url: '../jsp/personalescrud.jsp',
//            type: 'POST',
//            success: function (response) {
//                alerta.removeClass("alert alert-danger");
//                alerta.addClass("alert alert-success");
//                alerta.html(response);
//                alerta.show();
//                rellenardatos();
//
//                limpiar();
//                $("#nombre").focus();
//
//                setTimeout(function () {
//                    alerta.fadeOut();
//                }, 2000);
//            }
//        });
//    }
//};
//
//function rellenaredit(i, a, b, c, d, e) {
//    $('#id_personal').val(i);
//    $('#nombre').val(a);
//    $('#apellido').val(b);
//    $('#ci').val(c);
//    $('#telefono').val(d);
//    $('#correo').val(e);
//    $('#listar').val("modificar");
//    $("#mensaje").html("");
//}
//
//$("#eliminar_personal").on("click", function () {
//    let pk = $("#id_personal").val();
//    if (pk.trim() !== "") {
//        $.ajax({
//            data: {listar: "eliminar", idpk: pk},
//            url: '../jsp/personalescrud.jsp',
//            type: 'POST',
//            success: function (response) {
//                let alerta = $("#mensaje");
//                alerta.html(response).fadeIn();
//                rellenardatos();
//                limpiar();
//                $("#listar").val("cargar");
//                setTimeout(function () {
//                    alerta.fadeOut();
//                }, 2000);
//            }
//        });
//    } else {
//        let alerta = $("#mensaje");
//        alerta.removeClass("alert alert-success");
//        alerta.addClass("alert alert-danger");
//        alerta.text("Error: ID personal no puede estar vac�o");
//        alerta.show();
//    }
//});
//
//const limpiar = () => {
//    $("#id_personal").val("");
//    $("#nombre").val("");
//    $("#apellido").val("");
//    $("#ci").val("");
//    $("#telefono").val("");
//    $("#correo").val("");
//};


</script>
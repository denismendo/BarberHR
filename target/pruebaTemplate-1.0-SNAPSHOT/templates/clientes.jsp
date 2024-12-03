<%@include file="../DDBB/conexion.jsp"  %>

<%@include file="../header.jsp" %>
<div class="container body">
    <div class="main_container">
        <div class="right_col" role="main">
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Clientes</h2>
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
                                    <input type="hidden" id="id_cliente" name="id_cliente"/>
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
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="nombre">Nombre <span class="required">*</span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input type="text" id="nombre" required="required" class="fa-check-circle form-control" name="nombre">
                                    </div>
                                </div>                                
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="nombre">Apellido <span class="required">*</span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input type="text" id="apellido" required="required" class="fa-check-circle form-control" name="apellido">
                                    </div>
                                </div>                                
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="ci">CI <span class="required">*</span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input type="text" id="ci" name="ci" required="required" class="form-control">
                                    </div>
                                </div>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="telefono">Telefono <span class="required">*</span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input type="text" id="telefono" name="telefono" required="required" class="form-control">
                                    </div>
                                </div>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="correo">Correo <span class="required">*</span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input type="email" id="correo" name="correo" required="required" class="form-control">
                                    </div>
                                </div>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="clave">Clave <span class="required">*</span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input type="text" id="clave" name="clave" required="required" class="form-control">
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
                            <h2>Lista Clientes</h2>
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
                                                    <th>Clave</th>
                                                    <th>Opciones</th>
                                                    <a class="btn btn-primary" href="../reportesJSP/reporteGeneralClientes.jsp" target="_blank">INFO GENERAL</a>
                                                
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
                            <h5 class="modal-title">Eliminar Cliente</h5>
                        </div>
                        <div class="modal-body">
                            <h2 class="h3">Está seguro de eliminar el cliente?</h2>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" id="eliminar_cliente">Si</button>
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
        buscarciudad();
        rellenardatos();
        limpiar();
    });


    function buscarciudad() {
        $.ajax({
            data: {listar: 'buscarciudad'},
            url: '../jsp/buscar.jsp',
            type: 'POST',            
            success: function (response) {
                $("#id_ciudad").html(response);
            }
        });
    }

    function rellenardatos() {
        $.ajax({
            data: {listar: 'listar'},
            type: 'POST',
            url: '../jsp/clientescrud.jsp',
            success: function (response) {
                $("#resultado tbody").html(response);
            }
        });
    }


    $("#boton").click(function () {
        datosform = $("#form").serialize();
        $.ajax({
            data: datosform,
            url: '../jsp/clientescrud.jsp',
            type: 'POST',
            beforeSend: function () {

            },
            success: function (response) {
                $("#mensaje").html(response);
                rellenardatos();
            }
        });
    });

    function dividirciudad(a) {
        datos = a.split(",");
        $("#codciudad").val(datos[0]);
    }

    function rellenaredit(id, ciudad, nombre, apellido, ci, telefono, correo, clave) {

        $('#id_cliente').val(id);
        $("#id_ciudad").val(ciudad);
        $('#nombre').val(nombre);
        $('#apellido').val(apellido);
        $('#ci').val(ci);
        $('#telefono').val(telefono);
        $('#correo').val(correo);
        $('#clave').val(clave);
        $('#listar').val('modificar');
    }

    function limpiar() {
        $('#codciudad').val("");
        $('#nombre').val("");
        $('#apellido').val("");
        $('#ci').val("");
        $('#telefono').val("");
        $('#correo').val("");
        $('#clave').val("");
    }


$("#eliminar_cliente").on("click", function () {
    pk = $("#id_cliente").val();
    if (pk) {
        $.ajax({
            data: { listar: "eliminar", idpk: pk },
            url: '../jsp/clientescrud.jsp',
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


</script>

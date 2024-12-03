<%@include file="../DDBB/conexion.jsp"  %>
<%@include file="../header.jsp" %>
<div class="container body">
    <div class="main_container">
        <div class="right_col" role="main">
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Usuarios</h2>
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
                                    <input type="hidden" id="id_usuario" required="required" class="form-control" name="id_usuario">
                                </div>                                

                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Rol <span class="required">*</span></label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input type="hidden" id="codrol"></input>
                                        <select class="form-control" id="id_rol" name="id_rol" onchange="dividirrol(this.value)">

                                        </select>
                                    </div>
                                </div>                                
                                
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Personal <span class="required">*</span></label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input type="hidden" id="codpersonal"></input>
                                        <select id="id_personal" name="id_personal" class="form-control" onchange="dividirpersonal(this.value)">

                                        </select>
                                    </div>
                                </div>                              
                                
                                
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Usuario <span class="required">*</span></label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input type="text" id="usuario" required="required" class="form-control" name="usuario" placeholder="Usuario">
                                    </div>
                                </div>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Contraseña <span class="required">*</span></label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input type="password" id="clave" required="required" class="form-control" name="clave" placeholder="Contraseña">
                                    </div>
                                </div>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="last-name">Estado <span class="required">*</span></label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="estado" id="activo" value="A" 
                                                   <%                                                    if (request.getParameter("estado") == null || request.getParameter("estado").equals("A")) {
                                                           out.print("checked");
                                                       }
                                                   %>>
                                            <label class="form-check-label" for="activo">Activo</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="estado" id="inactivo" value="I" 
                                                   <%
                                                       if (request.getParameter("estado") != null && request.getParameter("estado").equals("I")) {
                                                           out.print("checked");
                                                       }
                                                   %>>
                                            <label class="form-check-label" for="inactivo">Inactivo</label>
                                        </div>
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
                            <h2>Lista Usuarios</h2>
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
                                                    <th>Rol</th>
                                                    <th>Personal</th>
                                                    <th>Usuario</th>
                                                    <th>Clave</th>
                                                    <th>Estado</th>
                                                    <th>Opciones</th>
                                                    <a class="btn btn-primary" href="../reportesJSP/reporteGeneralUsuarios.jsp" target="_blank">INFO GENERAL</a>                                                
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
                            <h5 class="modal-title">Eliminar Usuario</h5>
                            <!--<button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>-->
                        </div>
                        <div class="modal-body">
                            <input type="text" name="id_usuario" id="d_usu" />
                            <h2 class="h3">Está seguro de eliminar el registro?</h2>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" id="eliminar_usuario">Si</button>
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
        buscarpersonal();
        buscarrol();
        rellenardatos();
    });
    
    function rellenardatos() {
        $.ajax({
            data: {listar: 'listar'},
            type: 'POST',
            url: '../jsp/usuarioscrud.jsp',
            success: function (response) {
                $("#resultado tbody").html(response);
            }
        });
    }

    function buscarpersonal() {
        $.ajax({
            data: {listar: 'buscarPersonal'},
            url: '../jsp/buscar.jsp',
            type: 'POST',
            success: function (response) {
                $("#id_personal").html(response);
            }
        });
    }
    function buscarrol() {
        $.ajax({
            data: {listar: 'buscarrol'},
            url: '../jsp/usuarioscrud.jsp',
            type: 'POST',
            success: function (response) {
                $("#id_rol").html(response);
            }
        });
    } 
    
    
    function dividirpersonal(a){
        let dato = a.split(",");
        $("#codpersonal").val(dato[0]);
    }
    
    function dividirrol(a){
        let dato = a.split(",");
        $("#codrol").val(dato[0]);
    }

    

    $("#boton").on("click", function () {
        cargarDatos();
    });

    const cargarDatos = () => {
        personal = $("#id_personal").val();
        rol = $("#id_rol").val();
        usuario = $("#usuario").val();
        clave = $("#clave").val();
//        if(estado)
        estado = $("input[name='estado']:checked").val();

        let alerta = $("#mensaje").html("");
        if (!personal || !rol || !usuario.trim() || !clave.trim() || !estado) {
            alerta.removeClass("alert alert-success");
            alerta.addClass("alert alert-danger");
            alerta.text("Todos los campos son requeridos!");
            alerta.show();

            setTimeout(() => {
                alerta.fadeOut();
            }, 2000);
            return;
        } else {
            let datosform = $("#form").serialize();
            $.ajax({
                data: datosform,
                url: '../jsp/usuarioscrud.jsp',
                type: 'POST',
                success: function (response) {
//                    alerta = $("#mensaje");
                    alerta.removeClass("alert alert-danger");
                    alerta.addClass("alert alert-success");
                    alerta.html(response);
                    alerta.show();
                    rellenardatos();

//                    limpiar();
//                    $("#nombre").focus();

                    setTimeout(function () {
                        alerta.fadeOut();
                    }, 2000);
                }
            });
        }
    };
//
    function rellenaredit(idusu, rol, personal, usuario, clave, estado) {
        $('#id_usuario').val(idusu);
        $('#id_rol').val(rol);
        $('#id_personal').val(personal);
        $('#usuario').val(usuario);
        $('#clave').val(clave);
        $('#estado').val(estado);
        $('#listar').val("modificar");
    }

    $("#eliminar_usuario").on("click", function () {
        listar = $("#listar_eliminar").val();
        pk = $("#id_usuario").val();

        $.ajax({
            data: {listar: "eliminar", idpk: pk},
            url: '../jsp/usuarioscrud.jsp',
            type: 'POST',
            success: function () {
                alerta = $("#mensaje");
                alerta.removeClass("alert alert-danger alert-success");
                alerta.addClass("alert alert-success");
                alerta.text("Eliminado correctamente!");
                alerta.show();
                $("#listar").val("cargar");
                rellenardatos();
                limpiar();

                setTimeout(function () {
                    alerta.fadeOut();
                }, 2000);
            }
        });
    });

    const limpiar = () => {
        $("#id_persona").val("");
        $("#id_rol").val("");
        $("#usuario").val("");
        $("#clave").val("");
        $("#estado").val("");
        $("#id_usuario").val("");
    };
</script>
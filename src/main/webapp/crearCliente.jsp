<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--        <link rel="icon" href="../../production/images/favicon.ico" type="image/ico" />-->

        <title>JoDyMS!</title>

        <!-- Bootstrap -->
        <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <!--<link href="../../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">-->

        <!-- Custom Theme Style -->
        <!--<link href="../../build/css/custom.min.css" rel="stylesheet">-->     
        <link href="docs/css/clientes.css" rel="stylesheet">     

    </head>

    <body>
        <main class="container-lg">
            <div class="vh-100 d-flex">
                <div class="col imagen vh-100">

                </div>
                <div class="col bg-dark text-white align-content-center justify-content-center">
                    <div class="form-group">
                        <h1 class="h1 text-center">Crear Cuenta</h1>
                        <form id="form" data-parsley-validate class="form-horizontal form-label-left">

                            <div class="row justify-content-center">
                                <div class="input-group mb-3">
                                    <input type="hidden" id="listar" name="listar" value="cargar" ></input>
                                    <input type="hidden" id="id_rol" required="required" class="form-control" name="id_rol">
                                </div>
                                <div class="main-container d-flex">
                                    <div class="col-md-6 col-sm-6">
                                        <div class="item form-group">
                                            <label class="col-form-label col-md-3 col-sm-3 label-align" for="ciudad">Ciudad</label>

                                            <div class="col-md-12 col-sm-12 ">
                                                <input type="hidden" id="codciudad" name="codciudad" value="0">                                                <select class="form-control" id="id_ciudad" name="id_ciudad" onchange="dividirciudad(this.value)">
                                                    <select class="form-control" id="id_ciudad" name="id_ciudad" onchange="dividirciudad(this.value)">

                                                    </select>
                                            </div>
                                        </div>
                                        <div class="item form-group">
                                            <label class="col-form-label col-md-6 col-sm-6 label-align" for="first-name">Nombre
                                            </label>
                                            <div class="col-md-12 col-sm-12">
                                                <input type="text" id="nombre" required="required" class="fa-check-circle form-control" name="nombre" placeholder="Tu Nombre">
                                            </div>
                                        </div>
                                        <div class="item form-group">
                                            <label class="col-form-label col-md-6 col-sm-6 label-align" for="first-name">Apellido 
                                            </label>
                                            <div class="col-md-12 col-sm-12">
                                                <input type="text" id="apellido" required="required" class="fa-check-circle form-control" name="apellido" placeholder="Tu Apellido">
                                            </div>
                                        </div>
                                        <div class="item form-group">
                                            <label class="col-form-label col-md-6 col-sm-6 label-align" for="first-name">CI 
                                            </label>
                                            <div class="col-md-12 col-sm-12">
                                                <input type="text" id="ci" required="required" class="fa-check-circle form-control" name="ci" placeholder="Tu CI">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-6">
                                        <div class="item form-group">
                                            <label class="col-form-label col-md-6 col-sm-6 label-align" for="first-name">Telefono
                                            </label>
                                            <div class="col-md-12 col-sm-12">
                                                <input type="tel" id="telefono" required="required" class="fa-check-circle form-control" name="telefono" placeholder="Tu Teléfono">
                                            </div>
                                        </div>
                                        <div class="item form-group">
                                            <label class="col-form-label col-md-6 col-sm-6 label-align" for="last-name">E-mail
                                            </label>
                                            <div class="col-md-12 col-sm-12">
                                                <input type="email" id="correo" name="correo" required="required" class="form-control" placeholder="Tu E-mail">
                                            </div>
                                        </div>                                
                                        <div class="item form-group">
                                            <label class="col-form-label col-md-6 col-sm-6 label-align" for="last-name">Contraseña
                                            </label>
                                            <div class="col-md-12 col-sm-12">
                                                <input type="password" id="clave" name="clave" required="required" class="form-control" placeholder="Tu Contraseña">
                                            </div>
                                        </div>  

                                    </div>

                                </div>
                            </div>

                            <div class="ln_solid"></div>
                            <div class="item form-group text-center">
                                <div class="">
                                    <!--<button class="btn btn-primary" type="reset">Cancelar</button>-->
                                    <button type="button" id="boton" class="btn btn-primary">Crear</button>
                                </div>
                            </div>
                        </form>
                        <div role="alert" id="mensaje"></div>
                        <div class="col-12">
                            <div class="d-flex justify-content-around">
                                <label>Ya tienes una cuenta?
                                    <a class="text-white" href="loginCliente.jsp">Iniciar Sesión</a>
                                </label>
                                <a class="text-white reset_pass" href="">Olvidaste tu Contraseña?</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>    
            <div class="modal" id="showModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Registrado exitosamente!</h5>
                        <button type="button" class="close btn-danger" data-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <h2 class="h3">Inicie sesion <a href="jspCliete/loginCliente">aqui</a></h2>
                        <!--<input type="text" id="codConfirmarReserva" name="codConfirmarReserva">-->
                    </div>
                    <div class="modal-footer">
                        <!--<button type="button" class="btn btn-danger" data-dismiss="modal">No</button>-->
                        <!--<button type="button" class="btn btn-primary" data-dismiss="modal" id="confirmarReserva">Si</button>-->
                    </div>
                </div>
            </div>
        </div>
        </main>
    </body>
</html>

<script src="vendors/jquery/dist/jquery-3.7.1.min.js"></script>
<!-- Bootstrap -->
<script src="vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
<script>
    $(document).ready(function () {
        cargarCiudad();
    });
    function cargarCiudad(){
        $.ajax({
            data: {listar: 'buscarciudad'},
            type: 'POST',
            url: 'jsp/buscar.jsp',
            success: function (response) {
                        $("#id_ciudad").html(response);
                    }
        });
    }
    
    function dividirciudad(a) {
        datos = a.split(",");
        $("#codciudad").val(datos[0]);
    }
    
    $("#boton").click(function () {
        datosform = $("#form").serialize();
        $.ajax({
            data: datosform,
            url: 'jspCliente/crearCliente.jsp',
            type: 'POST',
            
            success: function (response) {
                $("#mensaje").html(response);
                limpiar();
                setTimeout(function () {
                        location.href = 'loginCliente.jsp'; // Redirige a la lista de reservas
                    }, 3000);
            },
            error: function (err) {
                console.log("Error al reservar turno" + err);
            }
        });
    });
    
    function limpiar() {
        $('#codciudad').val("");
        $('#nombre').val("");
        $('#apellido').val("");
        $('#ci').val("");
        $('#telefono').val("");
        $('#correo').val("");
        $('#clave').val("");
    }
    
</script>
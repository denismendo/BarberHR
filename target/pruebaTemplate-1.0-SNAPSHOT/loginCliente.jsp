<!DOCTYPE html>
<html lang="ES">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" href="img/logosvg.svg" type="image/ico" />

        <title>BarberHR</title>

        <!-- Bootstrap -->
        <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <!--<link href="../../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">-->

        <!-- Custom Theme Style -->
        <!--<link href="../../build/css/custom.min.css" rel="stylesheet">-->     
        <link href="docs/css/clientes.css" rel="stylesheet">     

    </head>

    <body>
        <main class="container-fluid">
            <div class="row h-auto">
                <div class="col-md imagen" style="height: 100vh;">

                </div>
                <div class="col-md bg-dark text-white align-content-center scrollspy-example">
                    <div class="form-group">
                        <h1 class="h1 text-center mt-3">Login</h1>
                        <form id="form" data-parsley-validate class="form-horizontal form-label-left">

                            <div class="input-group">
                                <!--<input type="hidden" id="listar" name="listar" value="cargar" ></input>-->
                                <!--<input type="hidden" id="id_cliente" required="required" class="form-control" name="id_rol">-->
                            </div>
                            <div class="main-container d-flex justify-item-center">
                                <div class="col-md-12 col-sm-12">
                                    <div class="mb-3 row">
                                        <label for="inputPassword" class="col-sm-2 col-form-label">E-mail</label>
                                        <div class="col-sm-8">
                                            <input
                                                class="form-control"
                                                name="correo"
                                                id="correo"
                                                placeholder="e-mail"
                                                >
                                        </div>
                                    </div>                               
                                    <div class="mb-3 row">
                                        <label for="inputPassword" class="col-sm-2 col-form-label">Contraseña</label>
                                        <div class="col-sm-8">
                                            <input
                                                type="password"
                                                class="form-control"
                                                name="clave"
                                                id="clave"
                                                placeholder="Contraseña"
                                                >
                                        </div>
                                    </div>     
                                </div>
                            </div>
                            <div class="ln_solid"></div>
                            <div class="item form-group text-center">
                                <div class="col-md-6 col-sm-6 offset-md-3 ">
                                    <!--<button class="btn btn-primary" type="reset">Cancelar</button>-->
                                    <button type="button" id="accesoCliente" class="btn btn-success mb-3">Iniciar sesion</button>
                                </div>
                            </div>
                        </form>
                        <div role="alert" id="respuesta"></div>
                        <div class="col-12">
                            <div class="d-flex justify-content-around">
                                <label>No tienes una cuenta?
                                    <a class="text-white" href="crearCliente.jsp">Crear Una</a>
                                </label>
                                <a class="text-white reset_pass" href="">Olvidé mi contraseña</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>            
        </main>
    </body>


    <script src="vendors/jquery/dist/jquery-3.7.1.min.js"></script>
    <!-- Bootstrap -->
    <script src="vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script>

        $("#accesoCliente").click(function () {
//                    alert('Accediendo');
            $("#respuesta").fadeIn();
            if ($("#correo").val() === "" || $("#clave").val() === "") {
                $("#respuesta").html("Ingrese correo y contraseña");
                $("#respuesta").addClass("alert alert-danger");
                setTimeout(() => {
                    $("#respuesta").fadeOut();

                }, 3000);

            } else {
                let datosform = $("#form").serialize();
                $.ajax({
                    data: datosform,
                    url: 'jspCliente/loginCliente.jsp',
                    type: 'POST',
                    success: function (response) {
//                        alert('Datos enviados');?
                        $("#respuesta").html(response);
                        setTimeout(() => {
                            $("#respuesta").fadeOut();
                        }, 3000);
                    }
//
                });

            }

        });

    </script>
</html>


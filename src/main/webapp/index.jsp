<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>JoDyMS!</title>

        <!-- Bootstrap -->
        <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
        <!-- NProgress -->
        <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
        <!-- Animate.css -->
        <link href="vendors/animate.css/animate.min.css" rel="stylesheet">

        <!-- Custom Theme Style -->
        <link href="build/css/custom.min.css" rel="stylesheet">
    </head>

    <body class="login">
        <div>
            <a class="hiddenanchor" id="signup"></a>
            <a class="hiddenanchor" id="signin"></a>

            <div class="login_wrapper">
                <div class="animate form login_form">
                    <section class="login_content">
                        <form method="POST" id="form" action="">
                            <h1>Acceso</h1>
                            <div>
                                <input type="text" id="usuario" name="usuario" class="form-control" placeholder="Username" required />
                            </div>
                            <div>
                                <input type="password" id="clave" name="clave" class="form-control" placeholder="Password" required />
                            </div>

                            <div>
                                <button type="button" class="btn btn-primary" id="acceso">Acceder</button>
                            </div>

                            <div class="clearfix"></div>

                            <div class="separator">

                                <div class="clearfix"></div>
                                <br />

                                <div class="footer">
                                    <h1><i class=""></i> JoDyMS!</h1>
                                    <p>©2024 Todos los Derechos Reservados. JoDyMS!</p>
                                </div>
                            </div>
                        </form>
                        <div id="respuesta"></div>
                        <div id="mensaje"></div>
                    </section>
                </div>
            </div>
        </div>
        <script src="vendors/jquery/dist/jquery.min.js"></script>
        <script src="vendors/iCheck/icheck.min.js"></script>
        <script src="vendors/jquery/dist/jquery-3.7.1.min.js"></script>
        <script src="vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <!--<script src="vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>-->
        <!--<script src="build/js/bootstrap.min.css"></script>-->
        <script>

            $("#acceso").click(function () {
//                    alert('Accediendo');
                $("#respuesta").fadeIn();
                if ($("#usuario").val() === "" || $("#clave").val() === "") {
                    $("#respuesta").html("Ingrese usuario y contraseña");
                    $("#respuesta").addClass("alert alert-danger");
                    setTimeout(() => {
                        $("#respuesta").fadeOut();

                    }, 3000);

                } else {
                    let datosform = $("#form").serialize();
                    $.ajax({
                        data: datosform,
                        url: 'jsp/login.jsp',
                        type: 'POST',
                        success: function (response) {
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
    </body>
</html>
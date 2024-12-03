<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // Obtener la fecha actual
    Date fechaActual = new Date();

    // Crear un formateador de fecha
    SimpleDateFormat formateadorFecha = new SimpleDateFormat("dd-MM-yyyy");

    // Formatear la fecha
    String fechaFormateada = formateadorFecha.format(fechaActual);
%>

<%
    HttpSession sesion = request.getSession();

    if (sesion.getAttribute("logoutCliente") == null || sesion.getAttribute("logoutCliente").equals("0")) {
%>
<script>location.href = "loginCliente.jsp";alert('Ud. debe de identificarse..!!');</script>	
<% } %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--Meta, title, CSS, favicons, etc.--> 
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" href="../../production/images/favicon.ico" type="image/ico" />

        <title>JoDyMS!</title>

        <!--Bootstrap--> 
        <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
        <!--Font Awesome--> 
        <link href="../../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">

        <!--Custom Theme Style--> 
        <link href="../../build/css/custom.min.css" rel="stylesheet">     
        <link href="docs/css/reserva.css" rel="stylesheet">   


    </head>

    <body>
        <main class="container-fluid">
            <div class="col-sm-8 m-auto">
                <ul class="d-flex justify-content-end">
                    <li class="nav-item dropdown open mt-2 font-weight-bold" style="padding-left: 15px; list-style: none;">
                        <a href="javascript:;" class="user-profile dropdown-toggle" aria-haspopup="true" id="navbarDropdown" data-toggle="dropdown" aria-expanded="false" style="">

                            <img><% out.print(sesion.getAttribute("nombreCliente"));%>
                        </a>
                        <div class="dropdown-menu dropdown-usermenu pull-right" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item"  href="javascript:;"> Perfil</a>
                            <a class="dropdown-item"  href="javascript:;">
                                <!--<span class="badge bg-red pull-right">50%</span>?-->
                                <!--<span>Settings</span>-->
                            </a>
                            <!--<a class="dropdown-item" href="javascritp";>Help</a>-->
                            <a class="dropdown-item" href="jspCliente/logoutCliente.jsp" id="logout">Cerrar sesion</a>
                        </div>
                    </li>
                </ul>

                <div class="row imagen">

                </div>
                <div class="row mb-4">
                    <div class="col-sm-12 mt-2 mb-2">
                        <h1 class="h1 mt-3">Barberia HR</h1>
                        <h4 class="h5 mt-3">Asuncion, Capiata km 21</h4>

                        <div class="mt-3 mb-2">
                            <ul class="nav nav-tabs">
                                <li class="nav-item" >
                                    <a href="#" class="nav-link active-link" data-target="container1">Reserva</a>
                                </li>
                                <li class="nav-item">
                                    <a href="#" class="nav-link" data-target="container2">Resenhas</a>
                                </li>
                                <li class="nav-item">
                                    <a href="#" class="nav-link" data-target="container3">Portafolio</a>
                                </li>
                                <li class="nav-item">
                                    <a href="#" class="nav-link" data-target="container4">Detalles</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="form-group col-sm-12 container" id="container1">
                        <form action="#" id="form" enctype="multipart/form-data" method="POST" role="form" class="form-horizontal form-groups-bordered">
                            <input type="hidden" id="listar" name="listar" value="cargar"/>
                            <input type="hidden" value="<% out.print(sesion.getAttribute("cliente"));%>" id="codCliente" name="codCliente">
                            <div class="row">
                                <h5>RESERVAR CITA</h5>
                            </div>
                            <!--<div class="row">?-->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">

                                        <label for="field-12" class="control-label">Estilista</label>
                                        <input type="hidden" value="0" id="codPersonal" name="codPersonal">
                                        <select class="form-control" name="id_rol" id="id_rol" onchange="dividirEstilista(this.value)">

                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="field-12" class="control-label">Fecha:</label>
                                        <input class="form-control" type="text" name="fecharegistro" id="fecharegistro" onKeyUp="" autocomplete="off" placeholder="Ingrese Fecha" value="<%= fechaFormateada%>" readonly>

                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="field-2" class="control-label">Fecha de Reserva: <span class="symbol required"></span></label>
                                        <input class="form-control number" value="0" type="date" name="fecha_reserva" id="fecha_reserva" onKeyUp="this.value = this.value.toUpperCase();" autocomplete="off" >
                                    </div>                                        
                                    <div class="form-group">
                                        <input type="hidden" id="hora" name="hora" value="0" />
                                        <span>Seleccione la hora</span>
                                        <select class="form-control" id="hora_reserva" onchange="dividirHora(this.value)">
                                            <!--<option value="0"></option>?-->
                                        </select>
                                    </div>
                                </div>
                                <div class="font-weight-bold pl-3" id="respuesta"></div>
                            </div>
                            <div align="center">
                                <button type="button" name="agregar" value="agregar" id="AgregarReserva" class="btn btn-primary" onclick=""><span class="fa fa-shopping"></span> Reservar</button>
                            </div>
                        </form>
                        <div role="alert" id="mensaje"></div>                
                    </div>
                    <div class="form-group col-sm-12 container" id="container2">
                        <h1>Resenhas</h1>
                    </div>
                    <div class="form-group col-sm-12 container" id="container3">
                        <h1>Portafolio</h1>
                    </div>
                    <div class="form-group col-sm-12 container" id="container4">
                        <form action="#" id="form" enctype="multipart/form-data" method="POST" role="form" class="form-horizontal form-groups-bordered">
                            <input type="hidden" id="listar" name="listar" value="cargar"/>
                            <div class="row">
                                <h5>DETALLES RESERVA</h5>
                            </div>
                            <!--<div class="row">?-->
                            <div class="row">
                                <div class="card-box table-responsive">
                                    <table id="detalleReserva" class="table table-striped table-bordered" style="width:100%">
                                        <thead>
                                            <tr>                                                
                                                <th>Fecha Registro</th>
                                                <th>Hora</th>
                                                <th>Fecha Reserva</th>
                                                <th>Estilista</th>
                                                <th>Opciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="modal" id="cancelarReservaModal" tabindex="-1">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Cancelar Reservas</h5>
                                    <button type="button" class="close btn-danger" data-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <h2 class="h3">¿Está seguro de cancelar esta reserva?</h2>
                                    <input type="text" id="codCancelarReserva" name="codCancelarReserva">
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="cancelarReserva">Si</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        </main>
        <footer class="footer d-flex justify-content-center bg-dark">
            <div class="align-items-center">
                <p class="pt-3" style="font-size: 20px; color: #fff; height: 100%">Todos los derechos reservados @JoDyMS</p>
            </div>
        </footer>
        <script>
            // Selecciona todos los enlaces y contenedores
            const links = document.querySelectorAll('.nav-link');
            const containers = document.querySelectorAll('.container');

            // Función para mostrar el contenedor correspondiente
            function showContainer(event) {
                event.preventDefault(); // Evita el comportamiento predeterminado del enlace

                // Quita la clase 'active-link' de todos los enlaces
                links.forEach(link => link.classList.remove('active-link'));
                // Agrega la clase 'active-link' al enlace clicado
                event.target.classList.add('active-link');

                // Oculta todos los contenedores
                containers.forEach(container => container.style.display = 'none');

                // Muestra el contenedor correspondiente
                const targetContainer = document.getElementById(event.target.dataset.target);
                targetContainer.style.display = 'block';
            }

            // Agrega un evento de clic a cada enlace
            links.forEach(link => link.addEventListener('click', showContainer));
        </script>
    </body>

    <script src="vendors/jquery/dist/jquery-3.7.1.min.js"></script>
    <script src="vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
</html>
<script>
            $(document).ready(function () {
                buscarEstilista();
                listarreservas();

                var fechaActual = new Date();
                var dd = String(fechaActual.getDate()).padStart(2, '0');
                var mm = String(fechaActual.getMonth() + 1).padStart(2, '0'); // Enero es 0
                var yyyy = fechaActual.getFullYear();

                var fechaMaxima = new Date();
                fechaMaxima.setDate(fechaMaxima.getDate() + 30);

                var ddMax = String(fechaMaxima.getDate()).padStart(2, '0');
                var mmMax = String(fechaMaxima.getMonth() + 1).padStart(2, '0'); // Enero es 0
                var yyyyMax = fechaMaxima.getFullYear();

                var fechaActualStr = yyyy + '-' + mm + '-' + dd;
                var fechaMaximaStr = yyyyMax + '-' + mmMax + '-' + ddMax;

                $('#fecha_reserva').attr('min', fechaActualStr);
                $('#fecha_reserva').attr('max', fechaMaximaStr);

            });


            function setCodR(idReserva) {
                // Asignar el valor del id_reserva al input del modal
                $("#codCancelarReserva").val(idReserva);
//        buscarmetodopago();
//        dividirmetodopago();?
            }

            function buscarEstilista() {
                $.ajax({
                    data: {listar: 'buscarEstilista'},
                    type: 'POST',
                    url: 'jsp/buscar.jsp',
                    success: function (response) {
                        $("#id_rol").html(response);
                    }
                });
            }
            function dividirEstilista(a) {
                datos = a.split(',');
                $("#codPersonal").val(datos[0]);
            }

            function listarreservas() {
                let pk = $("#codCliente").val();
                $.ajax({
                    data: {listar: 'listarReserva', idpk: pk},
                    url: 'jspCliente/reservacion.jsp',
                    type: 'POST',
                    success: function (response) {
                        $("#detalleReserva tbody").html(response);
                    },
                    error: function (error) {
                        console.error("Error al cargar los detalles: " + error);
                    }
                });
            }


            function dividirHora(a) {
                datos = a.split(',');
                $("#hora").val(datos[0]);
            }

            function dividirCliente(a) {
                datos = a.split(',');
                $("#codCliente").val(datos[0]);
            }



            function generarHorarios() {
                let horaInicio = 9; // 9:00 AM
                let horaFin = 18; // 6:00 PM
                let intervalMinutes = 30; // Intervalo de 30 minutos
                let horarios = [];

                for (let hora = horaInicio; hora < horaFin; hora++) {
                    for (let min = 0; min < 60; min += intervalMinutes) {
                        let horario = ('0' + hora).slice(-2) + ':' + ('0' + min).slice(-2); // Formato HH:mm

                        if (!(hora === 11 && min > 30 || hora === 12 && min < 30)) {
                            horarios.push(horario);

                        }


                    }
                }

                let selectHorarios = $("#hora_reserva");
                horarios.forEach(function (hora) {
                    selectHorarios.append(new Option(hora, hora));
                });
            }


            function generarHorarios() {
                let horaInicio = 8; // 8:00 AM
                let horaFin = 18;   // 6:00 PM
                let interval = 30;  // Intervalo de 30 minutos
                let horarios = [];

                for (let hora = horaInicio; hora < horaFin; hora++) {
                    for (let min = 0; min < 60; min += interval) {
                        let formatoHora = ('0' + hora).slice(-2) + ':' + ('0' + min).slice(-2);
                        horarios.push(formatoHora);
                    }
                }
                return horarios;
            }

            // Cargar horarios en el select
            function cargarHorarios() {
                let horarios = generarHorarios();
                let $select = $('#hora_reserva');
                $select.empty();

                horarios.forEach(horario => {
                    $select.append(new Option(horario, horario));
                });
            }

            // Deshabilitar horarios ocupados
            function deshabilitarHorariosOcupados(fecha, estilistaId) {
                $.ajax({
                    data: {listar: "horariosOcupados", fecha_reserva: fecha, codPersonal: estilistaId},
                    url: 'jspCliente/reservacion.jsp',
                    type: 'post',
                    success: function (response) {
                        try {
                            var data = JSON.parse(response);
                            if (data.error) {
                                console.error("Error del servidor:", data.error);
                            } else {
                                // Aquí procesas el array `data` con los horarios ocupados.
                                console.log(data);  // Verifica los horarios ocupados en la consola
                            }
                        } catch (error) {
                            console.error("Error al parsear JSON:", error);
                        }
                    }

                });
            }

            // Ejecutar al cambiar la fecha o estilista
            $('#fecha_reserva, #codPersonal').on('change', function () {
                let fecha = $('#fecha_reserva').val();
                let estilistaId = $('#codPersonal').val();
                if (fecha && estilistaId) {
                    cargarHorarios(); // Cargar los horarios disponibles primero
                    deshabilitarHorariosOcupados(fecha, estilistaId); // Luego deshabilitar los ocupados
                }
            });


            $("#AgregarReserva").click(function () {
                let datosform = $("#form").serialize();
                let estilista = $("#codPersonal").val();
                let fechaReserva = $("#fecha_reserva").val();
                let horaReserva = $("#hora").val();
                let mensaje = $("#respuesta");

                // Validar campos vacíos
                if (!estilista || estilista === 'Seleccionar' || !fechaReserva || !horaReserva) {
                    mensaje.addClass("text-danger");
                    mensaje.html("Todos los campos son obligatorios.");
                    mensaje.show();
                    setTimeout(() => {
                        mensaje.fadeOut();
                    }, 3000);
                    return;
                }

                // Enviar datos al servidor
                $.ajax({
                    data: datosform,
                    url: 'jspCliente/reservacion.jsp',
                    type: 'post',
                    dataType: 'json',
                    success: function (response) {
                        if (response.status === "success") {
                            mensaje.removeClass("text-danger").addClass("text-success");
                            mensaje.html(response.message);
                            limpiarFomulario();
                            listarreservas();
                        } else {
                            mensaje.removeClass("text-success").addClass("text-danger");
                            mensaje.html(response.message);
                        }
                        mensaje.show();
                        setTimeout(() => {
                            mensaje.fadeOut();
                            limpiarFomulario();
                        }, 3000);
                    },
                    error: function (err) {
                        mensaje.addClass("text-danger");
                        mensaje.html("Error al reservar turno: " + err.statusText);
                        mensaje.show();
                        setTimeout(() => {
                            mensaje.fadeOut();
                        }, 3000);
                    }
                });
            });



            function limpiarFomulario() {
//                $("#codCliente").val('0');
                $("#id_rol").val('Seleccionar');
                $("#fecha_reserva").val('');
                $("#hora_reserva").val('');
                $("#codPersonal").val('0');
                $("#hora").val('0');
//                $("#").val();?
            }

</script>






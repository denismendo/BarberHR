<%@page import="java.util.List"%>
<%@include file="../header.jsp" %>
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
<div class="container body">
    <div class="main_container">
        <div class="right_col" role="main">
            <div class="row">
                <div class="col-md-12 col-sm-6 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Reservas</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <form action="#" id="form" enctype="multipart/form-data" method="POST" role="form" class="form-horizontal form-groups-bordered">
                                <input type="hidden" id="listar" name="listar" value="cargar"/>
                                <div class="row">
                                    <h5>DATOS DE LA RESERVA</h5>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <!--COMPLETED ACTIONS DONUTS CHART-->
                                        <div class="form-group">
                                            <label for="field-12" class="control-label">Cliente</label>

                                            <select class="form-control" name="id_cliente" id="id_cliente" onchange="dividircliente(this.value)">

                                            </select>
                                        </div>


                                        <div class="form-group">
                                            <label for="field-12" class="control-label">Documento</label>
                                            <input type="hidden" id="codcliente" name="codcliente">                                                                           

                                            <input class="form-control" type="text" value="" name="ci" id="ci" onKeyUp="this.value = this.value.toUpperCase();" autocomplete="off" placeholder="Cedula" readonly="readonly" required><small><span class="symbol required"></span> </small>
                                        </div>

                                        <div class="form-group">
                                            <label for="field-12" class="control-label">Fecha:</label>
                                            <input class="form-control" type="text" name="fecharegistro" id="fecharegistro" onKeyUp="" autocomplete="off" placeholder="Ingrese Fecha" value="<%= fechaFormateada%>" readonly>

                                        </div>
                                    </div>
                                    <!-- /col-lg-3 -->

                                    <div class="col-lg-6">

                                        <!--<div class="row">-->
                                        <!-- TWITTER PANEL -->

                                        <!--<div class="col-lg-12">-->
                                        <div class="panel panel-border panel-warning widget-s-1">
                                            <div class="panel-heading">
                                                <!--<h4 class="mb"><i class="fa fa-archive"></i> <strong>Detalle De La Reserva</strong> </h4>-->
                                            </div>
                                            <div class="panel-body">


                                                <div class="form-group">
                                                    <label for="field-12" class="control-label">Estilista</label>
                                                    <input type="hidden" value="0" id="codPersonal" name="codPersonal">
                                                    <select class="form-control" name="id_rol" id="id_rol" onchange="dividirEstilista(this.value)">

                                                    </select>
                                                </div>


                                                <div class="col-md-8">
                                                    <div class="form-group">
                                                        <label for="field-2" class="control-label">Fecha de Reserva: <span class="symbol required"></span></label>
                                                        <input class="form-control number" value="" type="date" name="fecha_reserva" id="fecha_reserva" onKeyUp="this.value = this.value.toUpperCase();" autocomplete="off" >
                                                    </div>
                                                </div>                                       


                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <input type="hidden" id="hora" name="hora" />
                                                        <span>Seleccione la hora</span>
                                                        <select class="form-control" id="hora_reserva" onchange="dividirHora(this.value)">
                                                            <option value=""></option>
                                                        </select>
                                                    </div>

                                                    <!--                                                        <label for="field-2" class="control-label">Hora de Reserva: <span class="symbol required"></span></label>
                                                                                                            <input class="form-control number" value="" type="time" name="hora" id="hora_reserva" onKeyUp="this.value = this.value.toUpperCase();" autocomplete="off" placeholder="Cantidad">
                                                                                                            <div role="alert" id="mensaje"></div>-->
                                                </div>
                                            </div>
                                        </div>
                                        <!--</div>-->
                                    </div>
                                    <div align="right">
                                        <button type="button" name="agregar" value="agregar" id="AgregarReserva" class="btn btn-primary" onclick=""><span class="fa fa-shopping"></span> Reservar</button>
                                    </div>
                                    <div class="col-md-6" id="respuesta"></div>
                                </div>
                            </form>
                            <div class="modal" id="showModal" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Eliminar Detalle</h5>
                                            <!--<button type="button" class="close btn-danger" data-dismiss="modal" aria-label="Close"></button>-->
                                        </div>
                                        <div class="modal-body">
                                            <h2 class="h3">Está seguro de eliminar el registro?</h2>
                                            <input type="hidden" id="id_detalle">
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                                            <button type="button" class="btn btn-primary" data-dismiss="modal" id="eliminar_detalle">Si</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Inicio Cancelar Reserva Modal -->
                            <div class="modal" id="cancelarReserva" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Cancelar Reserva</h5>
                                            <!--<button type="button" class="close btn-danger" data-dismiss="modal" aria-label="Close"></button>-->
                                        </div>
                                        <div class="modal-body">
                                            <h2 class="h3">Está seguro de Cancelar esta Reserva?</h2>
                                            <input type="hidden" id="id_reserva">
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                                            <button type="button" class="btn btn-primary" data-dismiss="modal" id="cancelarR">Si</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Fin Cancelar Reserva Modal -->

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
        buscarEstilista();
        buscarcliente();
        generarHorarios();
        buscarservicio();
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
    function buscarcliente() {
        $.ajax({
            data: {listar: 'buscarcliente'},
            url: '../jsp/buscar.jsp',
            type: 'post',
            success: function (response) {
                $("#id_cliente").html(response);
            }
        });
    }


    function actualizarTotal() {
        let total = 0;

        // Recorre cada fila del tbody que tiene los servicios
        $("#resultado tbody tr").each(function () {
            // Extrae el precio de cada servicio (asume que está en la segunda columna)
            let precio = parseFloat($(this).find("td:eq(1)").text());
            if (!isNaN(precio)) {
                total += precio; // Suma el precio al total
            }
        });

        // Actualiza el total en el DOM
        $("#txtTotal").text(total.toFixed(2));  // Formato con 2 decimales
    }

    $("#resultado").on('DOMSubtreeModified', function () {
        actualizarTotal();
    });

    $("#cancelar").click(function () {
        $("#txtTotal").val("0.00");  // Reinicia el total al cancelar
    });

//
//    $("#id_cliente").on('change', function () {
//        if ($(this).val() !== "") {
//            // Deshabilitar el selector de cliente para evitar cambios
//            $(this).prop('disabled', true);
//        }
//    });


    function buscarservicio() {
        $.ajax({
            data: {listar: 'buscarservicio'},
            url: '../jsp/buscar.jsp',
            type: 'post',
            success: function (response) {
                $("#id_servicio").html(response);
            }
        });
    }

    function buscarEstilista() {
        $.ajax({
            data: {listar: 'buscarEstilista'},
            type: 'POST',
            url: '../jsp/buscar.jsp',
            success: function (response) {
                $("#id_rol").html(response);
            }
        });
    }


    function dividircliente(a) {
        datos = a.split(',');
        $("#codcliente").val(datos[0]);
        $("#ci").val(datos[1]);
    }
    function dividirHora(a) {
        datos = a.split(',');
        $("#hora").val(datos[0]);
    }
    function dividirEstilista(a) {
        datos = a.split(',');
        $("#codPersonal").val(datos[0]);
    }

    function dividirservicio(a) {
        datos = a.split(',');
        $("#codservicio").val(datos[0]);
        $("#precio").val(datos[1]);
    }



    $("#AgregarReserva").click(function () {
        let datosform = $("#form").serialize();
        $.ajax({
            data: datosform,
            url: '../jsp/reservarcrud.jsp',
            type: 'post',
            beforeSend: function () {
                // Puedes mostrar un mensaje de carga si lo deseas
                // $("#resultado").html("Procesando, espere por favor...");
            },
            success: function (response) {
                let codcliente = $("#codcliente").val();
                let fecharegistro = $("#fecharegistro").val();
                let fechareserva = $("#fecha_reserva").val();
                let hora = $("#hora").val();
                let personal = $("#codPersonal").val();

                $("#respuesta").removeClass("alert alert-danger alert-success");

                if (codcliente === "" && codcliente === 'Seleccionar' || fecharegistro === "" || fechareserva === "" || hora === "" || personal === "" && personal === 'Seleccionar') {
                    $("#respuesta").html("Por favor, complete todos los campos.");
                    $("#respuesta").addClass("alert alert-danger");
                    $("#respuesta").show();
//                    return false; // Detener la ejecución
                }
                // Verificamos la respuesta del servidor
                else if (response.includes("error")) {
                    // Si la respuesta contiene "error", es un mensaje de error
                    $("#respuesta").html(response.replace("error: ", ""));
                    $("#respuesta").addClass("alert alert-danger");
                    $("#respuesta").show();
                } else {
                    // Si es un mensaje de éxito
                    $("#respuesta").html(response.replace("success: ", ""));
                    $("#respuesta").addClass("alert alert-success");
                    $("#respuesta").show();

                    // Redirigir después de 3 segundos
                    setTimeout(function () {
                        location.href = 'listareservas.jsp'; // Redirige a la lista de reservas
                    }, 3000);
                }

                // Desaparece el mensaje después de 3 segundos
                setTimeout(function () {
                    $("#respuesta").fadeOut();
                }, 3000);
            },
            error: function (err) {
                alert("No se pudo reservar el turno.");
            }
        });
    });



    // Función para generar horarios en intervalos de 30 minutos
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
            url: '../jsp/reservarcrud.jsp',
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


//
//    $("#confirmar").click(function () {
//        $.ajax({
//            data: {listar: 'reservaconfirmado'},
//            url: '../jsp/reservarcrud.jsp',
//            type: 'post',
//            success: function () {
//            },
//            error: function (err) {
//                console.error("Error al cargar los detalles: " + err);
//            }
//        });
//    });

    function cargardetalle() {
        $.ajax({
            data: {listar: 'listar'},
            url: '../jsp/reservarcrud.jsp',
            type: 'post',
            success: function (response) {
//                console.log(response);
                $("#resultado tbody").html(response);
            },
            error: function (xhr, status, error) {
                console.error("Error al cargar los detalles: " + error);
            }
        });
    }



    $('#fecha_reserva').on('change', function () {
        var fechaSeleccionada = new Date(this.value);
        var dia = fechaSeleccionada.getUTCDay();
        let alerta = $("#respuesta");
        if (dia === 0) { // Si es domingo
            alerta.addClass("alert alert-danger");
            alerta.text('Las reservas no están disponibles los domingos. Por favor, elija otro día.');
            alerta.show();
            this.value = '';

            setTimeout(() => {
                alerta.fadeOut();
            }, 2000);
            this.value = '';
        }
    });

    $('#hora_reserva').on('change', function () {
        let hora = this.value;
        let horas = parseInt(hora.split(':')[0]);
        let alerta = $("#respuesta");
        if (horas < 8 || horas > 18) {
            alerta.addClass("alert alert-danger");
            alerta.text('La hora de reserva debe ser entre las 8:00 y las 18:00.');
            alerta.show();
            setTimeout(() => {
                alerta.fadeOut();
            }, 2000);
            this.value = '';
        }
    });

    

    $("#eliminar_detalle").on("click", function () {
        pk = $("#id_detalle").val();

        $.ajax({
            data: {listar: "eliminardetalle", idpk: pk},
            url: '../jsp/reservarcrud.jsp',
            type: 'POST',
            success: function (response) {
                $("#mensaje").html(response);
                cargardetalle();
                $("#listar").val("cargar");

                setTimeout(function () {
                    $("#mensaje").fadeOut();
                }, 2000);
            }
        });
    });



</script>

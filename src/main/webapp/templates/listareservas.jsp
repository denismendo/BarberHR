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
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Lista Reservas</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">
                                <!--<input type="text" id="listar" name="listar" value="cargar"/>-->
                                <div class="col-sm-12">
                                    <div class="card-box table-responsive">
                                        <table id="resultado" class="table table-striped table-bordered" style="width:100%">
                                            <thead>
                                                <tr>
                                                    <th>Codigo</th>
                                                    <th>Cliente</th>
                                                    <th>Fecha Registro</th>
                                                    <th>Hora</th>
                                                    <th>Estado</th>
                                                    <th>Fecha Reserva</th>
                                                    <th>Estilista</th>
                                                    <th>Opciones</th>
                                            <a class="btn btn-primary" href="../reportesJSP/reporteGeneralReservas.jsp" target="_blank">INFO GENERAL</a>
                                            <!--<a class="btn btn-primary" href="../reportesJSP/reporteGeneralCiudades.jsp" target="_blank">INFO GENERAL</a>-->
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
        </div>
<!--        <div class="modal" id="pagoModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <input type="hidden" id="listar" name="listar" value="realizarCobro"/>

                    <div class="modal-header">
                        <h5 class="modal-title">Cobro</h5>
                        <button type="button" class="close btn-danger" data-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-lg-12 ds">
                                COMPLETED ACTIONS DONUTS CHART                                
                                <div class="form-group">
                                    <label for="id_reserva" class="control-label">Código de Reserva:</label>
                                    <input type="text" id="id_reserva" name="id_reserva" class="form-control" readonly>

                                    <label for="field-12" class="control-label">Fecha:</label>
                                    <input class="form-control" type="text" name="fechapago" id="fechapago" onKeyUp="" autocomplete="off" placeholder="Ingrese Fecha" value="<%= fechaFormateada%>" readonly>

                                </div>
                                <div class="form-group">
                                    <label for="field-5" class="control-label">Metodo de Pago <span class="symbol required"></span></label>
                                    <input type="text" id="codmetodopago" name="codmetodopago">
                                    <select class="form-control" name="id_metodopago" id="id_metodopago" onchange="dividirmetodopago(this.value)">

                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="field-12" class="control-label">Total a Cobrar</label>
                                    <input type="text" class="form-control" name="totalCobro" id="totalCobro" required><small><span class="symbol required"></span> </small>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="confirmarCobro">Confirmar Pago</button>
                                </div>
                                </div>
                                 /col-lg-3 

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>-->
        <div class="modal" id="confirmarReservaModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Confirmar Reserva</h5>
                        <button type="button" class="close btn-danger" data-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <h2 class="h3">¿Confirmar?</h2>
                        <input type="text" id="codConfirmarReserva" name="id_reserva">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="confirmarReserva">Si</button>
                    </div>
                </div>
            </div>
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
                        <input type="hidden" id="codCancelarReserva" name="codCancelarReserva">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="cancelarReserva">Si</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="../footer.jsp" %>

<script>
    $(document).ready(function () {
        listarreservas();
    });


    function listarreservas() {
        $.ajax({
            data: {listar: 'listarreservas'},
            url: '../jsp/reservarcrud.jsp',
            type: 'POST',
            success: function (response) {
                $("#resultado tbody").html(response);
            },
            error: function (error) {
                console.error("Error al cargar los detalles: " + error);
            }
        });
    }

    function buscarmetodopago() {
        $.ajax({
            data: {listar: 'buscarmetodopago'},
            url: '../jsp/buscar.jsp',
            type: 'POST',
            success: function (response) {
                $("#id_metodopago").html(response);
            }
        });
    }

    function dividirmetodopago(a) {
        dato = a.split(",");
        $("#codmetodopago").val(dato[0]);
    }

//    function (idReserva) {
//        // Asignar el valor del id_reserva al input del modal
//        document.getElementById("codreserva").value = idReserva;
//        buscarmetodopago();
////        dividirmetodopago();?
////    }
//    function setCodR(idReserva) {
//        // Asignar el valor del id_reserva al input del modal
//        $("#codCancelarReserva").val(idReserva);
////        buscarmetodopago();
////        dividirmetodopago();?
//    }
    function setConR(idReserva) {
        // Asignar el valor del id_reserva al input del modal
        $("#codConfirmarReserva").val(idReserva);
//        buscarmetodopago();
//        dividirmetodopago();?
    }


//
//function cargardetalle() {
//        $.ajax({
//            data: {listar: 'listar'},
//            url: '../jsp/reservarcrud.jsp',
//            type: 'post',
//            success: function (response) {
////                console.log(response);
//                $("#resultado tbody").html(response);
//            },
//            error: function (xhr, status, error) {
//                console.error("Error al cargar los detalles: " + error);
//            }
//        });
//    }




    $("#cancelarReserva").on("click", function () {
        pk = $("#codCancelarReserva").val();
        $.ajax({
            data: {listar: "cancelarreserva", idpk: pk},
            url: '../jsp/reservarcrud.jsp',
            type: 'POST',
            success: function (response) {
                listarreservas();
                setTimeout(function () {
                    //  $("#codCancelarReserva").fadeOut();
                }, 2000);
            }
        });
    });
//
//    $("#confirmarReserva").on("click", function () {
////        alert(" ho");??
//        pk = $("#codConfirmarReserva").val();
//        $.ajax({
//            data: {listar: "confirmarReserva", idpk: pk},
//            url: '../jsp/reservarcrud.jsp',
//            type: 'POST',
//            success: function (response) {
//                listarreservas();
//                alert(response);
//                location.href = 'facturacion.jsp';
////                setTimeout(function () {
////                }, 2000);
//            }
//        });
//    });
//    


    // Confirmar reserva y redirigir a la página de facturación
    $("#confirmarReserva").click(function () {
        var pk = $("#codConfirmarReserva").val(); // Obtener valor desde el modal

        $.ajax({
            data: {listar: 'confirmarReserva', idpk: pk}, // Indicador para identificar la acción en el servidor
            url: '../jsp/reservarcrud.jsp',
            type: 'POST',
            success: function (response) {
                alert(response); // Mostrar mensaje del servidor
                if (response.includes("Reserva confirmada")) {
                    location.href = "facturacion.jsp?id_reserva=" + pk;
                } else if (response.includes("Ya existe una factura pendiente")) {
                    alert("No se puede confirmar la reserva: " + response);
                }
            },
            error: function (error) {
                console.error("Error en la solicitud AJAX: ", error);
                alert("Error al confirmar la reserva.");
            }
        });
    });





</script>
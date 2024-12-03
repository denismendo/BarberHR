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
                            <h2>Lista Cobros</h2>
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
                                                    <th>Metodo Pago</th>
                                                    <th>Cliente</th>
                                                    <th>Fecha</th>
                                                    <th>Estado</th>
                                                    <th>Total</th>
                                                    <th>Opciones</th>
                                            <!--<a class="btn btn-primary" href="#" onclick="generarInforme()">INFO GENERAL</a>-->
                                            <a class="btn btn-primary" href="../reportesJSP/reporteGeneralFacturas.jsp" target="_blank">INFO GENERAL</a>
                                            <label class="ml-2 mr-2">
                                                <strong>Fecha Inicio</strong>
                                                <input  class="form-control" type="date" id="fechaInicio">

                                            </label>
                                            <label>
                                                <strong>Fecha Fin</strong>
                                                <input class="form-control" type="date" id="fechaFin">

                                            </label>
                                            <script>
                                                function generarInforme() {
                                                    let inicioFecha = document.getElementById("fechaInicio").value;
                                                    let finFecha = document.getElementById("fechaFin").value;

                                                    console.log("Fecha Inicio:", inicioFecha);
                                                    console.log("Fecha Fin:", finFecha);

                                                    if (inicioFecha && finFecha) {
                                                        // Si ambas fechas están seleccionadas, redirige al informe
                                                        window.open(`../reportesJSP/reporteGeneralFacturas.jsp?inicioFecha=${inicioFecha}&finFecha=${finFecha}`, '_blank');
                                                    } else {
                                                        alert("Por favor, selecciona ambas fechas.");
                                                    }
                                                }
                                            </script>

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
        <div class="modal" id="cobroFacturaModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <input type="text" id="listar" name="listar" value="realizarCobro"/>

                    <div class="modal-header">
                        <h5 class="modal-title">Cobro</h5>
                        <!--<button type="button" class="close btn-danger" data-dismiss="modal" aria-label="Close"></button>-->
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-lg-6 ds">
                                <!--COMPLETED ACTIONS DONUTS CHART-->                                
                                <div class="form-group">
                                    <!--<label for="codCobrarFactura" class="control-label">Código de Reserva:</label>-->
                                    <input type="text" id="codCobrarFactura" name="codCobrarFactura" class="form-control">

                                    <label for="field-12" class="control-label">Fecha:</label>
                                    <input class="form-control" type="text" name="fechapago" id="fechapago" onKeyUp="" autocomplete="off" placeholder="Ingrese Fecha" value="<%= fechaFormateada%>" readonly>

                                </div>
                                <div class="form-group" id="activarTarjetas" style="display: none;">
                                    <label for="field-5" class="control-label">Tarjeta <span class="symbol required"></span></label>
                                    <input type="text" id="codTarjeta" name="codTarjeta">
                                    <select class="form-control" name="id_tarjeta" id="id_tarjeta" onchange="dividirTarjeta(this.value)">

                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="field-12" class="control-label">Monto</label>
                                    <input type="text" class="form-control" name="totalCobro" id="totalCobro" oninput="calcularBalance()" required>
                                </div>
                            </div>
                            <div class="col-lg-6 ds">
                                <div class="form-group">
                                    <label for="field-5" class="control-label">Metodo de Pago <span class="symbol required"></span></label>
                                    <input type="text" id="codmetodopago" name="codmetodopago">
                                    <select class="form-control" name="id_metodopago" id="id_metodopago" onchange="dividirmetodopago(this.value)">

                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="field-12" class="control-label">Importe</label>
                                    <input type="text" class="form-control" name="totalImporte" id="totalImporte" readonly="readonly" required><small><span class="symbol required"></span> </small>
                                </div>
                                <div class="form-group">
                                    <label for="field-12" class="control-label">Balance</label>
                                    <input type="text" class="form-control" name="totlaBalance" id="totlaBalance" required><small><span class="symbol required"></span> </small>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                <button type="button" class="btn btn-primary" data-dismiss="modal" id="confirmarCobro">Confirmar Pago</button>
                            </div>
                            <!--</div>-->
                            <!-- /col-lg-3 -->

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--        <div class="modal" id="confirmarReservaModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Cancelar Reservas</h5>
                            <button type="button" class="close btn-danger" data-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <h2 class="h3">¿Está seguro de cancelar esta reserva?</h2>
                            <input type="text" id="codConfirmarReserva" name="codConfirmarReserva">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" id="confirmarReserva">Si</button>
                        </div>
                    </div>
                </div>
            </div>-->
    <div class="modal" id="anularFacturaModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Cancelar Reservas</h5>
                    <button type="button" class="close btn-danger" data-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h2 class="h3">¿Está seguro de cancelar esta Factura?</h2>
                    <input type="text" id="codAnularFactura" name="codAnularFactura">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="anularFactura">Si</button>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<%@include file="../footer.jsp" %>

<script>
    $(document).ready(function () {
        listarCobros();
    });





    function listarCobros() {
        $.ajax({
            data: {listar: 'listarCobros'},
            url: '../jsp/facturacioncrud.jsp',
            type: 'POST',
            success: function (response) {
                $("#resultado tbody").html(response);
            },
            error: function (xhr, status, error) {
                console.error("Error al cargar los detalles: " + error);
            }
        });
    }


    $("#anularCobro").on("click", function () {

        pk = $("#codAnularFactura").val();
        $.ajax({
            data: {listar: "anularFactura", idpk: pk},
            url: '../jsp/facturacion.jsp',
            type: 'POST',
            success: function (response) {
                listarFacturas();
                setTimeout(function () {
                    //  $("#codCancelarReserva").fadeOut();
                }, 2000);
            }
        });
    });
//    
//    $("#anularFactura").on("click", function () {
//        
//        pk = $("#codAnularFactura").val();
//        $.ajax({
//            data: {listar: "anularFactura", idpk: pk},
//            url: '../jsp/facturacion.jsp',
//            type: 'POST',
//            success: function (response) {
//                listarFacturas();
//
//                setTimeout(function () {
//                    //  $("#codCancelarReserva").fadeOut();
//                }, 2000);
//            }
//        });
//    });


</script>
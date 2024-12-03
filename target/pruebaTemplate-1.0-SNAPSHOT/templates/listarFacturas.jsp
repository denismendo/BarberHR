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
                            <h2>Lista Facturas</h2>
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
                                                    <th>Fecha Registro</th>
                                                    <th>Cliente</th>
                                                    <th>Servicio</th>
                                                    <th>Estado</th>
                                                    <th>Total</th>
                                                    <th>Opciones</th>
                                                    <!--<a class="btn btn-primary" href="#" onclick="generarInforme()">INFO GENERAL</a>-->
                                                    <!--<a class="btn btn-primary" href="../reportesJSP/reporteGeneralFacturas.jsp" target="_blank">INFO GENERAL</a>-->
                                                    <!--                                            <label class="ml-2 mr-2">
                                                                                                    <strong>Fecha Inicio</strong>
                                                                                                    <input  class="form-control" type="date" name="fecha_inicio" id="fecha_inicio">
                                                    
                                                                                                </label>
                                                                                                <label>
                                                                                                    <strong>Fecha Fin</strong>
                                                                                                    <input class="form-control" type="date" name="fecha_fin" id="fecha_fin">
                                                    
                                                                                                </label>
                                                                                                <script>
                                                                                                    function generarInforme() {
                                                                                                        let fecha_inicio = document.getElementById("fecha_inicio").value;
                                                                                                        let fecha_fin = document.getElementById("fecha_fin").value;
                                                    
                                                                                                        console.log("Fecha Inicio:", fecha_inicio);
                                                                                                        console.log("Fecha Fin:", fecha_fin);
                                                    
                                                                                                        if (inicioFecha && finFecha) {
                                                                                                            // Si ambas fechas están seleccionadas, redirige al informe
                                                                                                            window.open(`../reportesJSP/reporteGeneralFacturas.jsp?fecha_inicio=${fecha_inicio}&fecha_fin=${fecha_fin}`, '_blank');
                                                                                                        } else {
                                                                                                            alert("Por favor, selecciona ambas fechas.");
                                                                                                        }
                                                                                                    }
                                                                                                </script>-->





                                                    <!--                                            <form action="../reportesJSP/reporteGeneralFacturas.jsp" method="GET">
                                                                                                    <label for="fecha_inicio">Fecha de inicio:</label>
                                                                                                    <input type="date" id="fecha_inicio" name="fecha_inicio" required>
                                                    
                                                                                                    <label for="fecha_fin">Fecha de fin:</label>
                                                                                                    <input type="date" id="fecha_fin" name="fecha_fin" required>
                                                    
                                                                                                    <button type="submit">Generar informe</button>
                                                                                                </form>-->

                                                    <!--<a class="btn btn-primary" href="../reportesJSP/reporteGeneralCiudades.jsp" target="_blank">INFO GENERAL</a>-->
                                            <form action="../reportesJSP/reporteGeneralFacturas.jsp" method="post" target="_blank">
                                                <label for="fecha_inicio">Fecha de inicio:</label>
                                                <input type="date" id="fecha_inicio" name="fecha_inicio" required>

                                                <label for="fecha_fin">Fecha de fin:</label>
                                                <input type="date" id="fecha_fin" name="fecha_fin" required>

                                                <button type="submit">Generar informe</button>
                                            </form>
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
        listarFacturas();
        buscarmetodopago();
        buscarTarjetas();
    });





    function listarFacturas() {
        $.ajax({
            data: {listar: 'listarFacturas'},
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
        let dato = a.split(",");
        $("#codmetodopago").val(dato[0]); // Asigna el valor al input

        if ($("#codmetodopago").val() === '2') {
            // Muestra el elemento activando las tarjetas
            $("#activarTarjetas").css("display", "block");
        } else {
            // Oculta el elemento si no es el método de pago 2
            $("#activarTarjetas").css("display", "none");
        }
    }


    function buscarTarjetas() {
        $.ajax({
            data: {listar: 'buscarTarjetas'},
            url: '../jsp/buscar.jsp',
            type: 'POST',
            success: function (response) {
                $("#id_tarjeta").html(response);
            }
        });
    }

    function dividirTarjeta(a) {
        dato = a.split(",");
        $("#codTarjeta").val(dato[0]);
    }

//    function (idReserva) {
//        // Asignar el valor del id_reserva al input del modal
//        document.getElementById("codreserva").value = idReserva;
//        buscarmetodopago();
////        dividirmetodopago();?
//    }
    function setIdFactura(idFactura) {
        // Asignar el valor del id_reserva al input del modal
        $("#codAnularFactura").val(idFactura);
//        buscarmetodopago();
//        dividirmetodopago();?
    }
    function getIdFactura(a) {
        dato = a.split(",");
        $("#codCobrarFactura").val(dato[0]);
        $("#totalImporte").val(dato[1]);
    }

    function calcularBalance() {
        // Obtén los valores de totalImporte y totalCobro
        let totalCobro = parseFloat(document.getElementById("totalCobro").value) || 0;
        let totalImporte = parseFloat(document.getElementById("totalImporte").value) || 0;

        // Calcula la diferencia
        let balance = totalImporte - totalCobro;

        // Actualiza el campo totlaBalance con el resultado sin decimales
        document.getElementById("totlaBalance").value = Math.round(balance); // Redondea si es necesario
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


    /*    $("#realizarCobro").on("click", function () {
     pk = $("#id_reserva").val();
     alert(pk);
     $.ajax({
     data: {listar: "realizarCobro", pkpago: pk},
     url: '../jsp/cobroscrud.jsp',
     type: 'POST',
     success: function (response) {
     alert(pk);
     $("#codreserva").html(response);
     //                cargardetalle();
     //                $("#listar").val("cargar");
     
     //                setTimeout(function () {
     //                    $("#mensaje").fadeOut();
     //                }, 2000);
     }
     });
     });
     * 
     * 
     */

//    $("#realizarCobro").on("click", function () {
//        alert("desde aqui");
//        pk = $("#id_reserva").val();
//        alert(pk);
//        $.ajax({
//            data: {listar: "realizarCobro", pkpago: pk},
//            url: '../jsp/cobroscrud.jsp',
//            type: 'POST',
//            success: function (response) {
//                alert(pk);
//                $("#codreserva").html(response);
//
//            }
//        });
//    });

    $("#confirmarCobro").on("click", function (event) {
        event.preventDefault(); // Evita el comportamiento predeterminado del botón

        const idFactura = $("#codCobrarFactura").val();
        const idMetodoPago = $("#codmetodopago").val();
        const monto = $("#totalCobro").val();
        const fechaCobro = $("#fechapago").val();
        const idTarjeta = $("#codTarjeta").val();
        const numeroTransaccion = idMetodoPago === "Tarjeta" ? $("#codTarjeta").val() : null;

        if (!idFactura || !idMetodoPago || !monto || !fechaCobro) {
            alert("Por favor, completa todos los campos obligatorios.");
            return;
        }

        $.ajax({
            data: {
                listar: "realizarCobro",
                idFactura: idFactura,
                idMetodoPago: idMetodoPago,
                monto: monto,
                fechaCobro: fechaCobro,
                idTarjeta: idTarjeta,
                numeroTransaccion: numeroTransaccion
            },
            url: '../jsp/facturacioncrud.jsp',
            type: 'POST',
            success: function (response) {
                console.log(response); // Verifica la respuesta del servidor
                if (response.includes("Cobro registrado con éxito")) {
                    alert("Cobro registrado con éxito.");
                    location.reload(); // Recargar solo si el cobro es exitoso
                } else {
                    alert("Error: " + response); // Muestra el error del servidor
                }
            },
            error: function (xhr, status, error) {
                console.error("Error de comunicación:", error);
                alert("Error de comunicación con el servidor.");
            }
        });
    });





    $("#anularFactura").on("click", function () {

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
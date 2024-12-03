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
                            <h2>facturacioncrud</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <form action="#" id="form" enctype="multipart/form-data" method="POST" role="form" class="form-horizontal form-groups-bordered">
                                <h5>DATOS DE LA FACTURA</h5>
                                <div class="row d-flex">
                                    <input type="hidden" id="listar" name="listar" value="cargar"/>
                                    <div class="col-lg-6">
                                        <!--COMPLETED ACTIONS DONUTS CHART-->
                                        <div class="form-group">
                                            <input type="hidden" id="id_reserva" name="id_reserva"/>
                                            <input type="hidden" id="idFactura" name="idFactura"/>
                                            <label for="field-12" class="control-label">Cliente</label>
                                            <input class="form-control" type="text" id="nombre" name="nombre" readonly/>
                                            <!--<select class="form-control" name="id_cliente" id="idCliente" onchange="dividirReserva(this.value)">-->

                                            <!--</select>-->
                                        </div>
                                        <div class="form-group">
                                            <label for="field-12" class="control-label">Documento</label>
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

                                                <div id="error">
                                                    <!--error will be shown here !--> 
                                                </div>                                                        

                                                <div class="form-group">
                                                    <input type="hidden" id="codServicio" name="codServicio"/>
                                                    <label for="field-12" class="control-label">Servicio</label>
                                                    <select class="form-control" name="id_servicio" id="id_servicio" onchange="dividirServicio(this.value)">

                                                    </select>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="field-2" class="control-label">Precio <span class="symbol required"></span></label>
                                                        <input class="form-control number" value="0" type="text" name="precio" id="precio" readonly="readonly">
                                                    </div>
                                                    <div role="alert" id="mensaje"></div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div align="right">
                                    <button type="button" name="agregarDetalle" value="agregar" id="agregarDetalle" class="btn btn-primary" onclick=""><span class="fa fa-shopping"></span> Agregar</button>
                                    <div id="respuesta"></div>
                                </div>
                                <div class="row">
                                    <div class="x_title">
                                        <h2>DETALLE DE LA FACTURA</h2>
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
                                                                <th>#</th>
                                                                <th>SERVICIO</th>
                                                                <th>PRECIO</th>
                                                                <th>Opciones</th>
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
                                <div align="right">
                                    <button type="button" name="cancelarFactura" id="cancelarFactura" class="btn btn-danger" onclick=""><span class="fa fa-shopping"></span> Cancelar</button>
                                    <button type="button" name="cancelarFactura" id="registrarFactura" class="btn btn-primary" onclick=""><span class="fa fa-shopping"></span> Registrar</button>

                                </div>

                            </form>
                            <div class="modal" id="cobroFacturaModal" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <input type="hidden" id="listar" name="listar" value="realizarCobro"/>

                                        <div class="modal-header">
                                            <h5 class="modal-title">Cobro Factura</h5>
                                            <button type="button" class="close btn-danger" data-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="col-lg-12 ds">
                                                    COMPLETED ACTIONS DONUTS CHART                                
                                                    <div class="form-group">
                                                        <label for="codReserva" class="control-label">Código de Reserva:</label>
                                                        <input type="text" id="idReservaPago" name="idReservaPago" class="form-control" readonly>

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
                        </div>
                        <div class="modal" id="confirmarReservaModal" tabindex="-1">
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
                        </div>
                        <div class="modal" id="modalEliminarDetalle" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Cancelar Reservas</h5>
                                        <button type="button" class="close btn-danger" data-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <h2 class="h3">¿Está seguro de cancelar esta reserva?</h2>
                                        <input type="text" id="idDetalle" name="idDetalle">
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="eliminarDetalle">Si</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--Inicio Cancelar Reserva Modal--> 
                        <div class="modal" id="cancelarReserva" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Cancelar Reserva</h5>
                                        <button type="button" class="close btn-danger" data-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <h2 class="h3">Está seguro de Cancesar esta Reserva?</h2>
                                        <input type="text" id="idReservaCancelar">
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="cancelarR">Si</button>
                                    </div>
                                </div>
                            </div>
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
        cargarFacturaPendiente();
        buscarServicio();
        listarDetalles();
//        dividirReservaId();
    });
//    $("#AgregarReserva").on("click", function () {
//        alert("haz echo click");
//    });
//
    function cargarFacturaPendiente() {
        $.ajax({
            data: {listar: 'facturaPendiente'},
            type: 'POST',
            url: '../jsp/facturacioncrud.jsp',
            success: function (response) {
                if (response.id_factura) { // Verifica si el JSON tiene datos
                    $("#idFactura").val(response.id_factura);
                    $("#id_reserva").val(response.id_reserva);
                    $("#nombre").val(response.nombre);
                    $("#ci").val(response.ci);
                } else {
                    console.log("No hay facturas pendientes");
                }
            },
            error: function (err) {
                console.error("Error al cargar los datos de la factura pendiente:", err);
            }
        });
    }

//
//    function dividirReservaId(a) {
//        dato = a.split();
//        $("#codReserva").val(dato[0]);
//        $("#nombre").val(dato[1]);
//        $("#ci").val(dato[2]);
//    }


//    $("#agregarFactura").on("click", function cargarFactura() {
//        if ($("#codReserva").val() === "" && $("#codServicio").val() === "") {
//            alert("Todos los campos son obligatorios");
//        } else {
//            datosform = $("#form").serialize();
//            $.ajax({
//                data: datosform,
//                type: "POST",
//                url: "../jsp/facturacioncrud.jsp",
//                success: function (response) {
//                    //                    alert("Factura");
//                    $("#resultado tbody").html(response);
//                    listarDetalles();
//                }
//            });
//        }
//
//    });

    function listarDetalles() {
        $.ajax({
            data: {listar: 'listarDetalles'},
            type: 'POST',
            url: '../jsp/facturacioncrud.jsp',
            success: function (data) {
                $("#resultado tbody").html(data);
            }
        });
    }


    function buscarServicio() {
        $.ajax({
            data: {listar: 'buscarservicio'},
            type: 'POST',
            url: '../jsp/buscar.jsp',
            success: function (response) {
                $("#id_servicio").html(response);
            }
        });
    }
//
//    function dividirReserva(a) {
//        dato = a.split(",");
//        $("#codReserva").val(dato[0]);
//        $("#ci").val(dato[1]);
//    }

    function dividirServicio(e) {
        dato = e.split(",");
        $("#codServicio").val(dato[0]);
        $("#precio").val(dato[1]);
    }

    function setIdDetalle(idDetalle) {

        // Asignar el valor del id_reserva al input del modal
        $("#idDetalle").val(idDetalle);
        //        buscarmetodopago();
        //        dividirmetodopago();?
    }

    $("#eliminarDetalle").on("click", function () {
        pk = $("#idDetalle").val();
        $.ajax({
            data: {listar: 'eliminarDetalle', idpk: pk},
            type: 'POST',
            url: '../jsp/facturacioncrud.jsp',
            success: function (response) {
                listarDetalles();
                //$("#respuesta").html(response);
            }
        });
    });


    $("#agregarDetalle").on('click', function () {
        const idFactura = $("#idFactura").val();
        const idServicio = $("#codServicio").val();
        const precio = $("#precio").val();

        if (!idFactura || !idServicio || !precio) {
            alert("Todos los campos son obligatorios.");
            return;
        }

        $.ajax({
            url: '../jsp/facturacioncrud.jsp',
            type: 'POST',
            data: {
                listar: 'cargarDetalle',
                idFactura: idFactura,
                id_servicio: idServicio,
                precio: precio
            },
            success: function (response) {
                listarDetalles(); // Mostrar mensaje del servidor
            },
            error: function (err) {
                console.error("Error al agregar detalle:", err);
                alert("Error al agregar detalle. Revisa la consola para más información.");
            }
        });
    });




    $("#registrarFactura").on('click', function () {
        let pk = $("#id_factura").val();
        $.ajax({
            data: {listar: 'registrarFactura', pkFactura: pk},
            type: 'POST',
            url: '../jsp/facturacioncrud.jsp',
            success: function (response) {
//                location.href = 'listarFacturas.jsp';?
            },
            error: function (err) {
                console.log("Error al reservar turno" + err);
            }
        });
    });



    $("#cancelarFactura").on('click', function () {
        $.ajax({
            data: {listar: 'cancelarFactura'},
            type: 'POST',
            url: '../jsp/facturacioncrud.jsp',
            success: function (response) {
                listarDetalles();

            }
        });
    });




</script>
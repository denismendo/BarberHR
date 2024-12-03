<%--
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
                            <h2>Detalle de Cobro</h2>
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
                                    <div class="col-lg-6 ds">
                                        <!--COMPLETED ACTIONS DONUTS CHART-->
                                        

                                        <div class="form-group">
                                            <label for="field-12" class="control-label">Cod Reserva</label>
                                            <input type="text" class="form-control" readonly="readonly" id="codreserva" name="codreserva"/>                                           
                                        </div>


                                        <div class="form-group">
                                            <label for="field-12" class="control-label">Cliente</label>
                                            <input type="text" class="form-control" name="codcliente" id="codcliente" onKeyUp="this.value = this.value.toUpperCase();" autocomplete="off" placeholder="Cliente" readonly="readonly" required><small><span class="symbol required"></span> </small>
                                        </div>
                                        <div class="form-group">
                                            <label for="field-12" class="control-label">CI</label>
                                            <input type="text" class="form-control" name="cicliente" id="cicliente" onKeyUp="this.value = this.value.toUpperCase();" autocomplete="off" placeholder="Cedula" readonly="readonly" required><small><span class="symbol required"></span> </small>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 ds">
                                        <div class="form-group">
                                            <label for="field-12" class="control-label">Fecha:</label>
                                            <input class="form-control" type="text" name="fechapago" id="fechapago" onKeyUp="" autocomplete="off" placeholder="Ingrese Fecha" value="<%= fechaFormateada%>" readonly>

                                        </div>
                                        <div class="form-group">
                                            <label for="field-12" class="control-label">Total a Cobrar</label>
                                            <input type="text" class="form-control" name="totalCobro" id="totalCobro" onKeyUp="this.value = this.value.toUpperCase();" autocomplete="off" placeholder="0.0" readonly="readonly" required><small><span class="symbol required"></span> </small>
                                        </div>

                                        <div class="form-group">
                                            <label for="field-5" class="control-label">Metodo de Pago <span class="symbol required"></span></label>
                                            <input type="text" id="codmetodopago" name="codmetodopago">
                                            <select class="form-control" name="id_metodopago" id="id_metodopago" onchange="dividirmetodopago(this.value)">

                                            </select>
                                        </div>
                                        <div class="form-group mr-0">
                                            <button type="button" class="btn btn-danger">Cancelar Pago</button>
                                            <button type="button" class="btn btn-success">Confirmar Pago</button>                                                
                                        </div>
                                    </div>
                                    <!-- /col-lg-3 -->
                                    <div class="modal" id="showModal" tabindex="-1">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Eliminar Detalle</h5>
                                                    <!--<button type="button" class="close btn-danger" data-dismiss="modal" aria-label="Close"></button>-->
                                                </div>
                                                <div class="modal-body">
                                                    <h2 class="h3">Está seguro de eliminar el registro?</h2>
                                                    <input type="text" id="id_detalle">
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                                                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="eliminar_detalle">Si</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
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
        buscarreserva();
        dividirreserva();
    });
    function buscarreserva() {
        $.ajax({
            data: {listar: 'buscarreserva'},
            url: '../jsp/buscar.jsp',
            type: 'post',
            success: function (response) {
                $("#id_reserva").html(response);
//                alert(response);
            }
        });
    }

    function dividirreserva(a) {
        dato = a.split(",");
        alert($("#codreserva").val(dato[0]));
        alert($("#codcliente").val(dato[1]));
        alert($("#codmetodopago").val(dato[2]));
    }
    
    
</script>
--%>
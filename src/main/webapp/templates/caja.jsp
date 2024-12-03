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
                            <h2>Cajas</h2>
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
                                            <button class="btn btn-primary" id="abrirCaja">Abrir Caja</button>
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
        <!-- Modal -->
        <div class="modal fade" id="cajaModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Confirmar Apertura</h5>
                        <button type="button" class="close btn-danger" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <h2 class="h3">Monto</h2>
                        <input type="text" id="monto" name="monto" class="form-control" placeholder="Ingrese el monto de apertura">
                        <input type="text" id="id_usuario" name="id_usuario" value="<%=session.getAttribute("admin")%>">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-primary" id="confirmarApertura">Abrir Caja</button>
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
        // Mostrar el modal al hacer clic en "Abrir Caja"
        $("#abrirCaja").on("click", function () {
            $("#cajaModal").modal("show");
        });

        // Confirmar la apertura de caja
        $("#confirmarApertura").on("click", function () {
            let monto = $("#monto").val();
            let idUsuario = $("#id_usuario").val();

            if (!monto || isNaN(monto)) {
                alert("Por favor, ingrese un monto válido.");
                return;
            }

            // Petición AJAX para abrir caja
            $.ajax({
                data: {accion: "abrir", monto: monto, id_usuario: idUsuario},
                type: "POST",
                url: "cajacrud.jsp",
                dataType: "json", // Especificamos que esperamos un JSON como respuesta
                success: function (response) {
                    if (response.success) {
                        alert(response.message); // Mensaje exitoso
                        $("#cajaModal").modal("hide");
                        location.reload(); // Recargar la página si es necesario
                    } else {
                        alert(response.message); // Mostrar error específico
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Error en la solicitud:", error);
                    alert("Ocurrió un error inesperado. Por favor, intenta nuevamente.");
                }
            });
        });
    });

</script>


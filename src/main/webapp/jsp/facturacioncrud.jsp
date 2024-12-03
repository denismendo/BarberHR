<%@page import="java.text.SimpleDateFormat"%>
<%@include file="../DDBB/conexion.jsp" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%    if (request.getParameter("listar").equals("facturaPendiente")) {
        response.setContentType("application/json");

        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT F.id_factura, F.id_reserva, C.nombre, C.apellido, C.ci FROM facturacion F JOIN reservas R ON F.id_reserva = R.id_reserva JOIN clientes C ON R.id_cliente = C.id_cliente WHERE F.estado='Pendiente' LIMIT 1");

        Map<String, String> facturaPendiente = new HashMap<>();

        if (rs.next()) {
            facturaPendiente.put("id_factura", rs.getString("id_factura"));
            facturaPendiente.put("id_reserva", rs.getString("id_reserva"));
            facturaPendiente.put("nombre", rs.getString("nombre") + " " + rs.getString("apellido"));
            facturaPendiente.put("ci", rs.getString("ci"));
        }

        Gson gson = new Gson();
        out.print(gson.toJson(facturaPendiente)); // Utiliza directamente `out` sin redefinirlo
    } else if (request.getParameter("listar").equals("cargarDetalle")) {
        int idFactura = Integer.parseInt(request.getParameter("idFactura"));
        int idServicio = Integer.parseInt(request.getParameter("id_servicio"));
        int precio = Integer.parseInt(request.getParameter("precio"));

        PreparedStatement psInsertDetalle = null;
        PreparedStatement psUpdateTotal = null;

        try {
            // Inserción del detalle
            String queryInsertDetalle = "INSERT INTO detalle_factura (id_factura, id_servicio, precio) VALUES (?, ?, ?)";
            psInsertDetalle = conn.prepareStatement(queryInsertDetalle);
            psInsertDetalle.setInt(1, idFactura);
            psInsertDetalle.setInt(2, idServicio);
            psInsertDetalle.setInt(3, precio);

            int rowsInserted = psInsertDetalle.executeUpdate();

            if (rowsInserted > 0) {
                // Actualización del total en la factura
                String queryUpdateTotal = "UPDATE facturacion SET total = total + ? WHERE id_factura = ?";
                psUpdateTotal = conn.prepareStatement(queryUpdateTotal);
                psUpdateTotal.setInt(1, precio);
                psUpdateTotal.setInt(2, idFactura);

                int rowsUpdated = psUpdateTotal.executeUpdate();

                if (rowsUpdated > 0) {
                    out.print("Detalle agregado con éxito y total actualizado.");
                } else {
                    out.print("Detalle agregado, pero no se pudo actualizar el total.");
                }
            } else {
                out.print("Error al agregar detalle.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("Error en el servidor: " + e.getMessage());
        } finally {
            // Cerrar recursos
            if (psInsertDetalle != null) {
                psInsertDetalle.close();
            }
            if (psUpdateTotal != null) {
                psUpdateTotal.close();
            }
        }
    } else if (request.getParameter("listar").equals("buscarCliente")) {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM clientes");

        /*        
SELECT R.id_reserva, C.id_cliente, C.nombre, C.ci "
        + "FROM reservas R"
        + "INNER JOIN clientes C"
        + "ON R.id_cliente = C.id_cliente"
        + " WHERE estado = 'Confirmado'
         */
    } else if (request.getParameter("listar").equals("listarDetalles")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            ResultSet pk = null;

            st = conn.createStatement();
            // Si hay una factura pendiente, seleccionarla
            pk = st.executeQuery("SELECT id_factura FROM facturacion WHERE estado = 'Pendiente'");

            if (pk.next()) {
                String idFactura = pk.getString(1);
                double totalFactura = 0;

                // Obtener los detalles de la factura y sumar los precios
                rs = st.executeQuery("SELECT DF.id_detalle, S.nombre, S.precio FROM detalle_factura DF, servicios S WHERE DF.id_servicio = S.id_servicio AND DF.id_factura = '" + idFactura + "'");

                while (rs.next()) {
                    double precio = rs.getDouble(3);
                    totalFactura += precio;
%>
<tr>
    <td><%= rs.getString(1)%></td>
    <td><%= rs.getString(2)%></td>
    <td><%= (int) precio%></td>
    <td>
        <i class="btn btn-danger fa fa-times" title="Quitar Servicio" data-toggle="modal" data-target="#modalEliminarDetalle" onclick="setIdDetalle('<%= rs.getString(1)%>')"></i>
    </td>
</tr>
<%
    }
%>
<!-- Campo de tipo number para mostrar el total acumulado -->
<tr>
    <td colspan="3" style="text-align:right;">Total:</td>
    <td><input type="number" class="form-control" id="totalFactura" value="<%= totalFactura%>" readonly></td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("Error PSQL: " + e);
    }
} else if (request.getParameter("listar").equals("eliminarDetalle")) {
    String pk = request.getParameter("idpk");
    try {
        Statement st = conn.createStatement();
        ResultSet rs = null;

        rs = st.executeQuery("SELECT precio, id_factura FROM detalle_factura WHERE id_detalle =" + pk);

        if (rs.next()) {
            double precioServicio = rs.getDouble("precio");
            String idFactura = rs.getString("id_factura");

            st.executeUpdate("UPDATE facturacion SET total = total - " + precioServicio + " WHERE id_factura =" + idFactura);

            st.executeUpdate("DELETE FROM detalle_factura WHERE id_detalle = " + pk);

            out.print("<script>document.getElementById('txtTotal').value -= " + rs.getDouble("precio") + ";</script>");
        }
    } catch (Exception e) {
    }
} else if (request.getParameter("listar").equals("cancelarFactura")) {

    try {
        Statement st = null;
        ResultSet pk = null;
        st = conn.createStatement();
        pk = st.executeQuery("SELECT id_factura FROM facturacion WHERE estado='Pendiente';");
        pk.next();
        st.executeUpdate("UPDATE facturacion SET estado='Cancelado' WHERE id_factura=" + pk.getString(1));
    } catch (Exception e) {
        out.println("error PSQL: " + e);
    }
} else if (request.getParameter("listar").equals("registrarFactura")) {
    String pkReserva = request.getParameter("pkReserva");
    try {
        Statement st = conn.createStatement();
        ResultSet pk = null;

        pk = st.executeQuery("SELECT id_factura FROM facturacion WHERE estado='Pendiente'");

        if (pk.next()) {
            int idFactura = pk.getInt(1);
            st.executeUpdate("UPDATE facturacion SET estado='Finalizado' WHERE id_factura=" + idFactura);
            st.executeUpdate("UPDATE reservas SET estado='Finalizado' WHERE id_reserva=" + pkReserva);
        } else {
            out.println("No hay facturas pendientes");
        }

    } catch (Exception e) {
        out.print("Error SQL: " + e);
    }
} else if (request.getParameter("listar").equals("listarFacturas")) {
    try {
        Statement st = null;
        ResultSet rs = null;

        st = conn.createStatement();
        //si hay un estado pendiente que lo seleccione 
        rs = st.executeQuery("SELECT F.id_factura, TO_CHAR(F.fecha_factura, 'dd-mm-YYYY') AS fecha_factura, C.nombre AS cliente_nombre, C.apellido AS cliente_apellido, "
                + "STRING_AGG(S.nombre, ', ') AS servicios, F.estado, F.total "
                + "FROM facturacion F "
                + "JOIN reservas R ON F.id_reserva = R.id_reserva "
                + "JOIN clientes C ON R.id_cliente = C.id_cliente "
                + "JOIN detalle_factura DT ON F.id_factura = DT.id_factura "
                + "JOIN servicios S ON DT.id_servicio = S.id_servicio "
                + "WHERE F.estado = 'Finalizado' "
                + "GROUP BY F.id_factura, F.fecha_factura, C.nombre, C.apellido, F.estado ORDER BY F.id_factura ASC");

        // sin el while no funciona no toque     
        while (rs.next()) {

%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(3)); %> <% out.print(rs.getString(4)); %></td>
    <td><% out.print(rs.getString(5)); %></td> 
    <td><% out.print(rs.getString(6)); %></td>
    <td><% out.print(rs.getString(7)); %></td>
    <td>
        <i class="btn btn-danger fa fa-trash" title="Anular" data-toggle="modal" data-target="#anularFacturaModal" onclick="setIdFactura('<% out.print(rs.getString(1));%>')"></i>
        <i class="btn btn-success fa fa-money" title="Cobrar" data-toggle="modal" data-target="#cobroFacturaModal" onclick="getIdFactura('<% out.print(rs.getString(1));%>,<% out.print(rs.getString(7));%>')"></i>
        <a class="btn btn-dark fa fa-eye" href="../reportesJSP/reporteFactura.jsp?factura=<%= rs.getString("id_factura")%>" target="_blank" class="btn btn-info">
            <!--<span><i ></i></span>-->
        </a>
    </td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("error PSQL: " + e);
    }
} else if (request.getParameter("listar").equals("anularFactura")) {

    try {
        Statement st = null;
        ResultSet pk = null;
        st = conn.createStatement();
        st.executeUpdate("UPDATE facturacion SET estado='Anulado' WHERE id_factura=" + request.getParameter("idpk"));
    } catch (Exception e) {
        out.println("error PSQL: " + e);
    }
} else if (request.getParameter("listar").equals("realizarCobro")) {
    String idFactura = request.getParameter("idFactura");
    String idMetodoPago = request.getParameter("idMetodoPago");
    String monto = request.getParameter("monto");
    String fechaCobro = request.getParameter("fechaCobro");
    String idTarjeta = request.getParameter("idTarjeta");
    String numeroTransaccion = request.getParameter("numeroTransaccion");

    try {
        if (idFactura == null || idMetodoPago == null || monto == null || fechaCobro == null) {
            out.println("Error: Faltan datos obligatorios.");
            return;
        }

        // Formatear la fecha a 'YYYY-MM-DD'
//        SimpleDateFormat inputFormat = new SimpleDateFormat("dd-MM-yyyy");
//        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
//        String fechaFormateada = outputFormat.format(inputFormat.parse(fechaCobro));
        Statement st = conn.createStatement();

        // Preparar valores opcionales
        String tarjetaValue = (idTarjeta != null && !idTarjeta.isEmpty()) ? idTarjeta : "NULL";
        String transaccionValue = (numeroTransaccion != null && !numeroTransaccion.isEmpty()) ? "'" + numeroTransaccion + "'" : "NULL";

        // Insertar el nuevo cobro
        String query = "INSERT INTO cobros (id_factura, id_metodopago, monto, estado, numero_transaccion, id_tarjeta,fecha_cobro) "
                + "VALUES (" + idFactura + ", " + idMetodoPago + ", " + monto + ", 'Cobrado', "
                + transaccionValue + ", " + tarjetaValue + ", '" + fechaCobro + "')";
        System.out.println("Query Ejecutada: " + query); // Para depuración
        st.executeUpdate(query);

        // Actualizar el estado de la factura
        st.executeUpdate("UPDATE facturacion SET estado = 'Cobrado' WHERE id_factura = " + idFactura);

        out.println("Cobro registrado con éxito.");

    } catch (Exception e) {
        System.err.println("Error SQL: " + e.getMessage());
        out.print("Error SQL: " + e.getMessage());
    }
} else if (request.getParameter("listar").equals("listarCobros")) {
    try {
        Statement st = null;
        ResultSet rs = null;

        st = conn.createStatement();
        //si hay un estado pendiente que lo seleccione 
        rs = st.executeQuery("SELECT C.id_cobro, MP.nombre AS metodo_pago, CL.nombre AS cliente_nombre, " 
+" CL.apellido AS cliente_apellido, TO_CHAR(C.fecha_cobro, 'dd-mm-YYYY') AS fecha_cobro, C.estado, C.monto "
+ "FROM cobros C JOIN metodopago MP ON C.id_metodopago = MP.id_metodopago "
+ "JOIN facturacion F ON C.id_factura = F.id_factura JOIN reservas R ON F.id_reserva = R.id_reserva "
+ "JOIN clientes CL ON R.id_cliente = CL.id_cliente WHERE C.estado = 'Cobrado';");

        // sin el while no funciona no toque     
        while (rs.next()) {

%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(3)); %> <% out.print(rs.getString(4)); %></td>
    <td><% out.print(rs.getString(5)); %></td>
    <td><% out.print(rs.getString(6)); %></td>
    <td><% out.print(rs.getString(7)); %></td>
    <td><%--
        <i class="btn btn-danger fa fa-trash" title="Anular" data-toggle="modal" data-target="#anularFacturaModal" onclick="setIdFactura('<% out.print(rs.getString(1));%>')"></i>--%>
        <i class="btn btn-success fa fa-eye" title="Cobrar" data-toggle="modal" data-target="#cobroFacturaModal" onclick="getIdFactura('<% out.print(rs.getString(1));%>,<% out.print(rs.getString(7));%>')"></i>
        <a class="btn btn-dark fa fa-eye" href="../reportesJSP/reporteFactura.jsp?factura=<%= rs.getString("id_factura")%>" target="_blank" class="btn btn-info">
            <!--<span><i ></i></span>-->
        </a>
    </td>
</tr>
<%
            }
        } catch (Exception e) {
            out.println("error PSQL: " + e);
        }
    }

%>



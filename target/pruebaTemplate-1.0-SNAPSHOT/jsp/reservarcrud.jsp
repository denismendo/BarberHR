<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.*"%>
<%@include file="../DDBB/conexion.jsp"%>
<%    if (request.getParameter("listar").equals("cargar")) {

        /* DATOS PARA LA RESERVA */
        String codcliente = request.getParameter("codcliente");
        String fecharegistro = request.getParameter("fecharegistro");
        String fechareserva = request.getParameter("fecha_reserva");
        String hora = request.getParameter("hora");
        String personal = request.getParameter("codPersonal");

        try {
            Statement st = conn.createStatement();

            // Consulta para verificar si el cliente ya tiene una reserva pendiente
            String queryCheckClientReservation = "SELECT COUNT(*) AS total_reservas_cliente FROM reservas "
                    + "WHERE id_cliente = '" + codcliente + "' "
                    + "AND estado = 'Pendiente'";
            ResultSet rsClient = st.executeQuery(queryCheckClientReservation);

            int totalReservasCliente = 0;
            if (rsClient.next()) {
                totalReservasCliente = rsClient.getInt("total_reservas_cliente");
            }

            // Si el cliente ya tiene una reserva pendiente, no permitir la nueva reserva
            if (totalReservasCliente > 0) {
                out.print("error: El cliente ya tiene una reserva pendiente. No puede realizar otra reserva.");
            } else {
                // Consulta para verificar si hay reservas en la fecha, hora y para el estilista
                String queryCheckAvailability = "SELECT COUNT(*) AS total_reservas FROM reservas "
                        + "WHERE fecha_reserva = TO_DATE('" + fechareserva + "', 'YYYY-MM-DD') "
                        + "AND hora = '" + hora + "' "
                        + "AND id_personal = '" + personal + "'";
                ResultSet rs = st.executeQuery(queryCheckAvailability);

                int totalReservas = 0;
                if (rs.next()) {
                    totalReservas = rs.getInt("total_reservas");
                }

                // Permite la inserción de la reserva solo si no hay reservas en ese horario para el estilista
                if (totalReservas == 0) {
                    String insertQuery = "INSERT INTO reservas (id_cliente, fecharegistro, hora, fecha_reserva, id_personal, estado) "
                            + "VALUES ('" + codcliente + "', TO_DATE('" + fecharegistro + "', 'DD-MM-YYYY'), '" + hora + "', "
                            + "TO_DATE('" + fechareserva + "', 'YYYY-MM-DD'), '" + personal + "', 'Pendiente')";
                    st.executeUpdate(insertQuery);
                    out.print("success: Cita reservada con éxito!");
                } else {
                    // Mensaje de error si el estilista ya tiene una reserva en ese horario
                    out.print("error: El estilista ya tiene una reserva en este horario. Intente con otro horario.");
                }
                rs.close();
            }

            rsClient.close();
            st.close();

        } catch (Exception e) {
            out.println("error: Error PSQL: " + e.getLocalizedMessage());
        }
    } else if (request.getParameter("listar").equals("listarreservas")) {
        try {
            Statement st = null;
            ResultSet rs = null;

            st = conn.createStatement();
            //si hay un estado pendiente que lo seleccione 
            rs = st.executeQuery("SELECT R.id_reserva, C.nombre, C.apellido, R.fecharegistro, R.hora, R.estado, R.fecha_reserva, P.nombre "
                    + "FROM reservas R "
                    + "INNER JOIN clientes C "
                    + "ON R.id_cliente = C.id_cliente "
                    + "INNER JOIN personales P "
                    + "ON R.id_personal = P.id_Personal "
                    + " WHERE estado = 'Pendiente' ORDER BY id_reserva");// sin el while no funciona no toque     
            while (rs.next()) {

%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %> <% out.print(rs.getString(3)); %></td>
    <td><% out.print(rs.getString(4)); %></td>
    <td><% out.print(rs.getString(5)); %></td>
    <td><% out.print(rs.getString(6)); %></td>
    <td><% out.print(rs.getString(7)); %></td>
    <td><% out.print(rs.getString(8)); %></td>
    <td>
        <i class="btn btn-success fa fa-check" title="Confirmar Reserva" data-toggle="modal" data-target="#confirmarReservaModal" onclick="setConR('<% out.print(rs.getString(1)); %>')"></i>
        <i class="btn btn-danger fa fa-times" title="Cancelar Reserva" data-toggle="modal" data-target="#cancelarReservaModal" onclick="setCodR('<% out.print(rs.getString(1)); %>')"></i>

    </td>

</tr>
<%
            }
        } catch (Exception e) {
            out.println("error PSQL: " + e);
        }
    } else if (request.getParameter("listar").equals("confirmarReserva")) {
    String idReserva = request.getParameter("idpk");
    out.print("ID de reserva recibido: " + idReserva); // Depuración

    if (idReserva != null && !idReserva.isEmpty()) {
        try {
            Statement st = conn.createStatement();

            // Verificar si ya existe una factura pendiente para la reserva
            String queryFacturaPendiente = "SELECT id_factura FROM facturacion WHERE id_reserva = " 
                                           + idReserva + " AND estado = 'Pendiente'";
            System.out.println("Ejecutando consulta: " + queryFacturaPendiente); // Depuración
            ResultSet rsFactura = st.executeQuery(queryFacturaPendiente);

            if (rsFactura.next()) {
                // Si ya existe una factura pendiente, enviar mensaje al cliente
                out.print("Ya existe una factura pendiente para esta reserva.");
            } else {
                // Validar que la reserva existe y está pendiente
                String queryReserva = "SELECT r.id_reserva, r.id_cliente, r.fecharegistro, r.hora, r.estado, r.fecha_reserva, r.id_personal "
                                    + "FROM reservas r WHERE r.estado = 'Pendiente' AND r.id_reserva = " + idReserva;
                System.out.println("Ejecutando consulta: " + queryReserva); // Depuración
                ResultSet rs = st.executeQuery(queryReserva);

                if (rs.next()) {
                    // Procesar datos de la reserva
                    String codCliente = rs.getString("id_cliente");
                    String fechaRegistro = rs.getString("fecharegistro");
                    String fechaReserva = rs.getString("fecha_reserva");
                    String horaReserva = rs.getString("hora");
                    String personalId = rs.getString("id_personal");

                    // Crear la factura
                    String insertFactura = "INSERT INTO facturacion (id_reserva, fecha_factura, estado, total) "
                                          + "VALUES (" + idReserva + ", CURRENT_DATE, 'Pendiente', 0)";
                    st.executeUpdate(insertFactura);

                    // Cambiar estado de la reserva
                    String updateReserva = "UPDATE reservas SET estado = 'Confirmado' WHERE id_reserva = " + idReserva;
                    st.executeUpdate(updateReserva);

                    out.print("Reserva confirmada y factura creada.");
                } else {
                    out.print("No se encontró la reserva.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("Error al procesar la solicitud: " + e.getMessage());
        }
    } else {
        out.print("El ID de la reserva no es válido.");
    }
}
 // Confirmar la reserva
     else if (request.getParameter("insertarDetalleFactura") != null) {
        String idFactura = request.getParameter("id_factura");
        String[] servicios = request.getParameterValues("id_servicio"); // Servicios seleccionados
        String[] precios = request.getParameterValues("precio"); // Precios de los servicios

        try {
            Statement st = conn.createStatement();
            for (int i = 0; i < servicios.length; i++) {
                String insertDetalle = "INSERT INTO detalle_factura (id_factura, id_servicio, precio) "
                        + "VALUES (" + idFactura + ", " + servicios[i] + ", " + precios[i] + ")";
                st.executeUpdate(insertDetalle);
            }

            // Actualizar el estado de la factura a "Finalizado"
            String updateFactura = "UPDATE facturacion SET estado = 'Finalizado' WHERE id_factura = " + idFactura;
            st.executeUpdate(updateFactura);

            out.print("Factura finalizada.");
        } catch (Exception e) {
            out.print("Error: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("cancelarreserva")) {
        String pk = request.getParameter("idpk");
        //String sql = "SELECT * FROM reservas WHERE estado='Confirmado'";

        try {
            //ResultSet rs = null;            
            //st.executeQuery("SELECT id_reserva FROM reservas WHERE estado = 'Pendiente';");
            Statement st = conn.createStatement();

            st.executeUpdate("UPDATE reservas set estado = 'Cancelado' WHERE id_reserva = " + pk);
//            out.println("<div class='alert alert-success' role='alert'>Reserva Anulado!</div>");
        } catch (SQLException e) {
            out.println("Error PSQL: " + e.getMessage());
        }
    }

    if (request.getParameter("listar").equals("horariosOcupados")) {
        String fechaReserva = request.getParameter("fecha_reserva");
        String idPersonal = request.getParameter("codPersonal");

        List<String> horariosOcupados = new ArrayList<>();
        try {
            String query = "SELECT hora FROM reservas WHERE fecha_reserva = TO_DATE('" + fechaReserva + "', 'YYYY-MM-DD') AND id_personal = '" + idPersonal + "'";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);

            while (rs.next()) {
                horariosOcupados.add(rs.getString("hora"));
            }

            rs.close();
            st.close();

            out.print(new Gson().toJson(horariosOcupados)); // Retorna el array en formato JSON
        } catch (Exception e) {
            out.println("Error: " + e.getLocalizedMessage());
        }
    }


%>

<%--

//        Seleccionar la reserva pendiente
//        
//        if (rs.next()) {
//            // Actualizar el detalle y sumar el precio al total en la cabecera
//            String idReserva = rs.getString("id_reserva");
//            double totalActual = rs.getDouble("total");
////            double nuevoTotal = totalActual + Double.parseDouble(precio);
//            
//            // Insertar el detalle de la reserva
//            st.executeUpdate("INSERT INTO detalle_reserva (id_reserva, id_servicio, fecha_reserva, precio, hora) " +
//                             "VALUES ('" + idReserva + "', '" + codservicio + "', '" + fecha_reserva + "', '" + precio + "', '" + hora + "')");
//            
//            // Actualizar el total de la cabecera
//            st.executeUpdate("UPDATE reservas SET WHERE id_reserva = '" + idReserva + "'");
//        } else {
//            // Si no existe una cabecera pendiente, crear una nueva
//            
//            // Recuperar la reserva creada
//            pk = st.executeQuery("SELECT id_reserva FROM reservas WHERE estado = 'Pendiente';");
//            pk.next();
//            String idReserva = pk.getString("id_reserva");
//            
//            // Insertar el detalle de la reserva
//            st.executeUpdate("INSERT INTO detalle_reserva (id_reserva, id_servicio, fecha_reserva, precio, hora) " +
//                             "VALUES ('" + idReserva + "', '" + codservicio + "', '" + fecha_reserva + "', '" + precio + "', '" + hora + "')");
//        }

else if (request.getParameter("listar").equals("listar")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        ResultSet pk = null;
        st = conn.createStatement();
        
        // Selecciona la reserva pendiente
        pk = st.executeQuery("SELECT id_reserva FROM reservas where estado='Pendiente';");
        pk.next();
        
        // Consulta los detalles de la reserva
        rs = st.executeQuery("SELECT R.id_reserva, C.nombre, R.fecharegistro, R.hora, R.estado, R.fecha_reserva "
                            + "FROM reservas R, clientes C "
                            + "WHERE R.id_cliente = C.id_cliente AND R.id_reserva = '" + pk.getString(1) + "'");
        
        // Variable para almacenar el total
        Double totalPrecio = 0.0;
        Integer cantidad = 0;
        
        while (rs.next()) {
            cantidad++;  // Incrementa la cantidad de servicios
            Double precioServicio = rs.getDouble(4);  // Columna del precio
            totalPrecio += precioServicio;  // Suma los precios
            
            // Mostrar cada detalle en la tabla
            out.print("<tr>");
            out.print("<td>" + rs.getString(1) + "</td>");  // id_detalle
            out.print("<td>" + rs.getString(2) + "</td>");  // nombre del servicio
            out.print("<td>" + rs.getString(3) + "</td>");  // fecha de la reserva
            out.print("<td>" + rs.getString(4) + "</td>");  // precio del servicio
            out.print("<td>" + rs.getString(5) + "</td>");  // hora de la reserva
            out.print("<td><i class='btn btn-danger fa fa-trash' data-target='#showModal' "
                     + "data-toggle='modal' onclick='$(\"#id_detalle\").val(" + rs.getString(1) + ")'></i></td>");
            out.print("</tr>");
        }
        
        // Mostrar el total calculado
        out.print("<script>document.getElementById('txtTotal').value = '" + totalPrecio + "';</script>");

        
    } catch (Exception e) {
        out.println("Error PSQL: " + e.getMessage());
    }
}





 else if (request.getParameter("listar").equals("eliminardetalle")) {

    String pk = request.getParameter("idpk");  // ID del detalle a eliminar
    try {
        Statement st = conn.createStatement();
        ResultSet rs = null;
        
        // Primero obtenemos el precio del detalle antes de eliminarlo
        rs = st.executeQuery("SELECT precio, id_reserva FROM detalle_reserva WHERE id_detalle=" + pk);
        
        if (rs.next()) {
            // Obtener el precio y la reserva correspondiente
            double precioServicio = rs.getDouble("precio");
            String idReserva = rs.getString("id_reserva");
            
            // Restar el precio del total en la cabecera de la reserva
            st.executeUpdate("UPDATE reservas SET total = total - " + precioServicio + " WHERE id_reserva=" + idReserva);
            
            // Eliminar el detalle del servicio
            st.executeUpdate("DELETE FROM detalle_reserva WHERE id_detalle=" + pk);
        }
        
        // Actualizar el total en la interfaz de usuario
        out.print("<script>document.getElementById('txtTotal').value -= " + rs.getDouble("precio") + ";</script>");

    } catch (Exception e) {
        out.println("error PSQL: " + e);
    }
}






 else if (request.getParameter("listar").equals("cancelarreservas")) {

    try {
        Statement st = null;
        ResultSet pk = null;
        st = conn.createStatement();
        pk = st.executeQuery("SELECT id_reserva FROM reservas WHERE estado='Confirmado';");
        pk.next();
        st.executeUpdate("UPDATE reservas SET estado='Cancelado' WHERE id_reserva=" + pk.getString(1));
    } catch (Exception e) {
        out.println("error PSQL: " + e);
    }
}





else if (request.getParameter("listar").equals("reservaconfirmado")) {

    try {
        Statement st = null;
        ResultSet pk = null;
        st = conn.createStatement();
        pk = st.executeQuery("SELECT id_reserva FROM reservas WHERE estado='Pendiente'");

        if (pk.next()) {
            int idreserva = pk.getInt(1);
//            int idcliente = pk.getInt(2);
//            int total = pktotal.getInt(3);
            st.executeUpdate("UPDATE reservas SET estado='Confirmado' WHERE id_reserva=" + idreserva);

            String insertPago = "INSERT INTO pagos (id_reserva, metodo_pago, monto, estado_pago) "
                    + "VALUES (" + idreserva + ", 'Por definir', 0, 'Pendiente')";
            st.executeUpdate(insertPago);
            out.println("Reserva confirmada y pago en estado pendiente registrado para la reserva ID: " + idreserva);

        } else {
            out.println("No hay Reservas Pendientes");
        }
    } catch (Exception e) {
        out.println("error PSQL: " + e);
    }
}






--%>
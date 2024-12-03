<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.*"%>
<%@include file="../DDBB/conexion.jsp"%>
<%    if (request.getParameter("listar").equals("cargar")) {

    String codcliente = request.getParameter("codCliente");
    String fecharegistro = request.getParameter("fecharegistro");
    String fechareserva = request.getParameter("fecha_reserva");
    String hora = request.getParameter("hora");
    String personal = request.getParameter("codPersonal");

    response.setContentType("application/json");
//    PrintWriter out = response.getWriter();

    try {
        Statement st = conn.createStatement();

        // Verificar si el cliente ya tiene una reserva pendiente
        String queryCheckCliente = "SELECT COUNT(*) AS total FROM reservas "
                + "WHERE id_cliente = '" + codcliente + "' AND estado = 'Pendiente'";
        ResultSet rsCliente = st.executeQuery(queryCheckCliente);

        int totalPendientes = 0;
        if (rsCliente.next()) {
            totalPendientes = rsCliente.getInt("total");
        }

        if (totalPendientes > 0) {
            // Mensaje de error si el cliente ya tiene una reserva pendiente
            out.print("{\"status\":\"error\",\"message\":\"Ya tiene una reserva pendiente. Termine esa antes de crear otra.\"}");
            return;
        }

        // Verificar si el estilista ya tiene reservas en el mismo horario
        String queryCheckAvailability = "SELECT COUNT(*) AS total_reservas FROM reservas "
                + "WHERE fecha_reserva = TO_DATE('" + fechareserva + "', 'YYYY-MM-DD') "
                + "AND hora = '" + hora + "' "
                + "AND id_personal = '" + personal + "'";
        ResultSet rsHorario = st.executeQuery(queryCheckAvailability);

        int totalReservas = 0;
        if (rsHorario.next()) {
            totalReservas = rsHorario.getInt("total_reservas");
        }

        if (totalReservas > 0) {
            // Mensaje de error si el estilista ya tiene una reserva en este horario
            out.print("{\"status\":\"error\",\"message\":\"El estilista ya tiene una reserva en este horario. Intente con otro horario.\"}");
            return;
        }

        // Insertar la nueva reserva
        String insertQuery = "INSERT INTO reservas (id_cliente, fecharegistro, hora, fecha_reserva, id_personal, estado) "
                + "VALUES ('" + codcliente + "', TO_DATE('" + fecharegistro + "', 'DD-MM-YYYY'), '" + hora + "', "
                + "TO_DATE('" + fechareserva + "', 'YYYY-MM-DD'), '" + personal + "', 'Pendiente')";
        st.executeUpdate(insertQuery);

        // Mensaje de éxito
        out.print("{\"status\":\"success\",\"message\":\"Reserva creada con éxito.\"}");
        
    } catch (Exception e) {
        e.printStackTrace();
        out.print("{\"status\":\"error\",\"message\":\"Error en el servidor: " + e.getLocalizedMessage() + "\"}");
    }
}
 else if (request.getParameter("listar").equals("horariosOcupados")) {
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
    }else if(request.getParameter("listar").equals("listarReserva")){
//    if ("detalleReserva".equals(request.getParameter("listar"))) {
//        HttpSession session = request.getSession();
        String clienteID = request.getParameter("idpk");

            try {
                Statement st = conn.createStatement();
                String query = "SELECT R.fecharegistro, R.hora, R.fecha_reserva, P.nombre FROM reservas R "
                + "INNER JOIN clientes C ON R.id_cliente = C.id_cliente INNER JOIN personales P ON R.id_personal = P.id_Personal "
                + "WHERE C.id_cliente = '" + clienteID +"' AND R.estado = 'Pendiente'";

                ResultSet rs = st.executeQuery(query);
                while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString("fecharegistro")); %></td>
    <td><% out.print(rs.getString("hora")); %></td>
    <td><% out.print(rs.getString("fecha_reserva")); %></td>
    <td><% out.print(rs.getString("nombre")); %></td>
    <td>
        <i class="btn btn-danger fa fa-times" title="Cancelar Reserva" data-toggle="modal" data-target="#cancelarReservaModal" onclick="setCodR('<% out.print(rs.getString(1)); %>')"></i>
    </td>
</tr>
<%
                }
                rs.close();
                st.close();
            } catch (Exception e) {
                out.println("Error PSQL: " + e);
            }
        } 
    

%>








<%--<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.*"%>
<%@include file="../DDBB/conexion.jsp"%>

<%
    String action = request.getParameter("listar");
    Gson gson = new Gson();

    if ("cargar".equals(action)) {
        String codCliente = request.getParameter("codCliente");
        String fechaRegistro = request.getParameter("fecharegistro");
        String fechaReserva = request.getParameter("fecha_reserva");
        String hora = request.getParameter("hora");
        String personal = request.getParameter("codPersonal");

        try {
            Statement st = conn.createStatement();

            // Consulta para verificar si hay reservas en la fecha, hora y para el estilista
            String queryCheckAvailability = "SELECT COUNT(*) AS total_reservas FROM reservas "
                    + "WHERE fecha_reserva = TO_DATE('" + fechaReserva + "', 'YYYY-MM-DD') "
                    + "AND hora = '" + hora + "' "
                    + "AND id_personal = '" + personal + "'";
            ResultSet rs = st.executeQuery(queryCheckAvailability);

            int totalReservas = 0;
            if (rs.next()) {
                totalReservas = rs.getInt("total_reservas");
            }

            if (totalReservas == 0) {
                // Inserta la reserva solo si el horario está disponible
                String insertQuery = "INSERT INTO reservas (id_cliente, fecharegistro, hora, fecha_reserva, id_personal) "
                        + "VALUES ('" + codCliente + "', TO_DATE('" + fechaRegistro + "', 'DD-MM-YYYY'), '" + hora + "', "
                        + "TO_DATE('" + fechaReserva + "', 'YYYY-MM-DD'), '" + personal + "')";
                st.executeUpdate(insertQuery);
                out.print("Reserva realizada con éxito.");
            } else {
                out.print("Error: El estilista ya tiene una reserva en este horario.");
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            out.print("Error en la reserva: " + e.getLocalizedMessage());
        }
    } else if ("horariosOcupados".equals(action)) {
        // Lista de horarios ocupados
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

            out.print(gson.toJson(horariosOcupados));
        } catch (Exception e) {
            out.print("Error: " + e.getLocalizedMessage());
        }
    }
%>--%>









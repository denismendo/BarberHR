
<%@include file="../DDBB/conexion.jsp"  %>
<%    if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;

            st = conn.createStatement();
            rs = st.executeQuery("SELECT c.id_cliente, c.id_ciudad, c.nombre, c.apellido, c.ci, c.telefono, c.correo, c.clave FROM clientes c LEFT JOIN ciudades ci ON c.id_ciudad = ci.id_ciudad ORDER BY c.id_cliente");
            while (rs.next()) {
%>
<tr>


<!--<i class="bi bi-pencil-square" onclick="rellenaredit('<%out.print(rs.getString(1));%>','<%out.print(rs.getString(2));%>','<%out.print(rs.getString(4));%>','<%out.print(rs.getString(3));%>')"></i> <i class="bi bi-x-circle" data-bs-toggle="modal" data-bs-target="#basicModal" onclick="$('#idusuario').val('<%out.print(rs.getString(1));%>')"></i>-->



    <td><%out.print(rs.getString(1));%></td>
    <td><%out.print(rs.getString(2));%></td>
    <td><%out.print(rs.getString(3));%></td>
    <td><%out.print(rs.getString(4));%></td>
    <td><%out.print(rs.getString(5));%></td>
    <td><%out.print(rs.getString(6));%></td>
    <td><%out.print(rs.getString(7));%></td>
    <td><%out.print(rs.getString(8));%></td>
    <td style="text-align: center; margin-right: 10px;">
        <i style="cursor: pointer;" class="btn btn-danger" data-target="#showModal" data-toggle="modal" onclick="$('#id_cliente').val('<%out.print(rs.getString(1));%>')">Borrar</i>
        <i style="cursor: pointer;" class="btn btn-secondary" onclick="rellenaredit('<%out.print(rs.getString(1));%>', '<%out.print(rs.getString(2));%>', '<%out.print(rs.getString(3));%>', '<%out.print(rs.getString(4));%>', '<%out.print(rs.getString(5));%>', '<%out.print(rs.getString(6));%>', '<%out.print(rs.getString(7));%>', '<%out.print(rs.getString(8));%>')">Editar</i>
        <a href="../reportesJSP/reporteCliente.jsp?cliente=<%= rs.getString("id_cliente")%>" target="_blank" class="btn btn-info">
            <span>Info</span>
        </a>
    </td>
</tr>
<% }

        } catch (Exception err) {
            out.println("Error PSLQ " + err);
        }
    } else if (request.getParameter("listar").equals("cargar")) {
        String ciudad = request.getParameter("id_ciudad");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String ci = request.getParameter("ci");
        String telefono = request.getParameter("telefono");
        String correo = request.getParameter("correo");
        String clave = request.getParameter("clave");

        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM clientes WHERE LOWER(ci) = LOWER('" + ci + "')");
            rs.next();
            int count = rs.getInt(1);

            if (count > 0) {
                out.println("<div class='alert alert-danger' role='alert'>El cliente ya existe!</div>");
            } else {
                st.executeUpdate("INSERT INTO clientes (id_ciudad, nombre, apellido, ci, telefono, correo, clave) VALUES ('" + ciudad + "', '" + nombre + "', '" + apellido + "', '" + ci + "', '" + telefono + "', '" + correo + "', '" + clave + "')");
                out.println("<div class='alert alert-success' role='alert'>Datos insertados con éxito!</div>");
            }
        } catch (SQLException e) {
            out.println("Error PSQL: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("modificar")) {
        String ciudad = request.getParameter("id_ciudad");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String ci = request.getParameter("ci");
        String telefono = request.getParameter("telefono");
        String correo = request.getParameter("correo");
        String clave = request.getParameter("clave");
        String idcliente = request.getParameter("id_cliente");

        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM clientes WHERE LOWER(ci) = LOWER('" + ci + "') AND id_cliente != '" + idcliente + "'");
            rs.next();
            int count = rs.getInt(1);

            if (count > 0) {
                out.println("<div class='alert alert-danger' role='alert'>El CI del cliente ya existe!</div>");
            } else {
                st.executeUpdate("UPDATE clientes SET id_ciudad = '" + ciudad + "', nombre = '" + nombre + "', apellido = '" + apellido + "', ci = '" + ci + "', telefono = '" + telefono + "', correo = '" + correo + "', clave = '" + clave + "' WHERE id_cliente = '" + idcliente + "'");
                out.println("<div class='alert alert-success' role='alert'>Datos modificados con éxito!</div>");
            }
        } catch (SQLException e) {
            out.println("Error PSQL: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("eliminar")) {
        String pk = request.getParameter("idpk");

        try {
            Statement st = conn.createStatement();
            st.executeUpdate("DELETE FROM clientes WHERE id_cliente = " + pk);
            out.println("<div class='alert alert-success' role='alert'>Registro eliminado correctamente!</div>");
        } catch (SQLException e) {
            out.println("Error PSQL: " + e.getMessage());
        }
    }
%>

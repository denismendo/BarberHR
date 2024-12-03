<%@include file="../DDBB/conexion.jsp"  %>
<%    String action = request.getParameter("listar");
    if (action != null) {
        try {
            Statement st = conn.createStatement();
            if (action.equals("listar")) {
                ResultSet rs = st.executeQuery("SELECT P.id_personal, C.id_ciudad, P.nombre, P.apellido, P.ci, P.telefono, P.correo FROM personales P INNER JOIN ciudades C ON P.id_ciudad = C.id_ciudad ORDER BY id_personal");
                while (rs.next()) {
%>
<tr>
    <td><%= rs.getString(1)%></td>
    <td><%= rs.getString(2)%></td>
    <td><%= rs.getString(3)%></td>
    <td><%= rs.getString(4)%></td>
    <td><%= rs.getString(5)%></td>
    <td><%= rs.getString(6)%></td>
    <td><%= rs.getString(7)%></td>
    <td style="text-align: center; margin-right: 10px;">
        <!--<i class="fab fa-whatsapp"></i>-->
        <i style="cursor: pointer;" class="btn btn-secondary" onclick="rellenaredit('<%= rs.getString(1)%>', '<%= rs.getString(2)%>', '<%= rs.getString(3)%>', '<%= rs.getString(4)%>', '<%= rs.getString(5)%>', '<%= rs.getString(6)%>', '<%= rs.getString(7)%>')">Editar</i>
        <i style="cursor: pointer;" class="btn btn-danger" data-target="#showModal" data-toggle="modal" onclick="$('#id_personal').val('<%= rs.getString(1)%>')">Borrar</i>
        <a href="../reportesJSP/reportePersonal.jsp?personal=<%= rs.getString("id_personal")%>" target="_blank" class="btn btn-info">
            <span>Info</span>
        </a> 
    </td>
</tr>
<%
                }
            } else if (action.equals("cargar")) {
                String ciudad = request.getParameter("id_ciudad");
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String ci = request.getParameter("ci");
                String telefono = request.getParameter("telefono");
                String correo = request.getParameter("correo");
                String rol = request.getParameter("id_rol");

                ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM personales WHERE ci = '" + ci + "' OR correo = '" + correo + "'");
                rs.next();
                int count = rs.getInt(1);

                if (count > 0) {
                    out.println("<div class='alert alert-danger' role='alert'>CI o Email ya existe!</div>");
                } else {
                    st.executeUpdate("INSERT INTO personales (id_ciudad, nombre, apellido, ci, telefono, correo, id_rol) VALUES ('" + ciudad + "', '" + nombre + "', '" + apellido + "', '" + ci + "', '" + telefono + "', '" + correo + "', '" + rol + "')");
                    out.println("<div class='alert alert-success' role='alert'>Datos insertados con éxito!</div>");
                }
            } else if (action.equals("modificar")) {
                String ciudad = request.getParameter("id_ciudad");
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String ci = request.getParameter("ci");
                String telefono = request.getParameter("telefono");
                String correo = request.getParameter("correo");
                String idpersonal = request.getParameter("id_personal");
                String idRol = request.getParameter("id_rol");

                ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM personales WHERE (ci = '" + ci + "' OR correo = '" + correo + "') AND id_personal != '" + idpersonal + "'");
                rs.next();
                int count = rs.getInt(1);

                if (count > 0) {
                    out.println("<div class='alert alert-danger' role='alert'>Error: CI o Email ya existe!</div>");
                } else {
                    st.executeUpdate("UPDATE personales SET id_ciudad = '" + ciudad + "', nombre = '" + nombre + "', apellido = '" + apellido + "', ci = '" + ci + "', telefono = '" + telefono + "', correo = '" + correo + "', id_rol = '" + idRol + "' WHERE id_personal = '" + idpersonal + "'");
                    out.println("<div class='alert alert-success' role='alert'>Datos modificados con éxito!</div>");
                }
            } else if (action.equals("eliminar")) {
                String pk = request.getParameter("idpk");

                st.executeUpdate("DELETE FROM personales WHERE id_personal = " + pk + "");
                out.println("<div class='alert alert-success' role='alert'>Registro eliminado correctamente!</div>");
            }
        } catch (SQLException e) {
            out.println("Error PSQL: " + e.getMessage());
        }
//Error PSQL: ERROR: syntax error at or near "'personal1'" Position: 37

    }
%>

<%--<%@include file="../DDBB/conexion.jsp"  %>
<%
    String action = request.getParameter("listar");
    if (action != null) {
        try {
            Statement st = conn.createStatement();
            if (action.equals("listar")) {
                ResultSet rs = st.executeQuery("SELECT * FROM personales ORDER BY id_personal");
                while (rs.next()) {
%>
<tr>
    <td><%= rs.getString(1) %></td>
    <td><%= rs.getString(2) %></td>
    <td><%= rs.getString(3) %></td>
    <td><%= rs.getString(4) %></td>
    <td><%= rs.getString(5) %></td>
    <td><%= rs.getString(6) %></td>
    <td style="text-align: center; margin-right: 10px;">
        <i style="cursor: pointer;" class="btn btn-secondary" onclick="rellenaredit('<%= rs.getString(1) %>', '<%= rs.getString(2) %>', '<%= rs.getString(3) %>', '<%= rs.getString(4) %>', '<%= rs.getString(5) %>', '<%= rs.getString(6) %>')">Editar</i>
        <i style="cursor: pointer;" class="btn btn-danger" data-target="#showModal" data-toggle="modal" onclick="$('#id_personal').val('<%= rs.getString(1) %>')">Borrar</i>
    </td>
</tr>
<%
                }
            } else if (action.equals("cargar")) {
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String ci = request.getParameter("ci");
                String telefono = request.getParameter("telefono");
                String correo = request.getParameter("correo");

                ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM personales WHERE ci = '" + ci + "' OR correo = '" + correo + "'");
                rs.next();
                int count = rs.getInt(1);

                if (count > 0) {
                    out.println("<div class='alert alert-danger' role='alert'>Error: CI o Email ya existe!</div>");
                } else {
                    st.executeUpdate("INSERT INTO personales (nombre, apellido, ci, telefono, correo) VALUES ('" + nombre + "', '" + apellido + "', '" + ci + "', '" + telefono + "', '" + correo + "')");
                    out.println("<div class='alert alert-success' role='alert'>Datos insertados con éxito!</div>");
                }
            } else if (action.equals("modificar")) {
                String idpersonal = request.getParameter("id_personal");
                if (idpersonal != null && !idpersonal.trim().isEmpty()) {
                    String nombre = request.getParameter("nombre");
                    String apellido = request.getParameter("apellido");
                    String ci = request.getParameter("ci");
                    String telefono = request.getParameter("telefono");
                    String correo = request.getParameter("correo");

                    ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM personales WHERE (ci = '" + ci + "' OR correo = '" + correo + "') AND id_personal != '" + idpersonal + "'");
                    rs.next();
                    int count = rs.getInt(1);

                    if (count > 0) {
                        out.println("<div class='alert alert-danger' role='alert'>Error: CI o Email ya existe!</div>");
                    } else {
                        st.executeUpdate("UPDATE personales SET nombre = '" + nombre + "', apellido = '" + apellido + "', ci = '" + ci + "', telefono = '" + telefono + "', correo = '" + correo + "' WHERE id_personal = " + Integer.parseInt(idpersonal));
                        out.println("<div class='alert alert-success' role='alert'>Datos modificados con éxito!</div>");
                    }
                } else {
                    out.println("<div class='alert alert-danger' role='alert'>Error: ID personal no puede estar vacío</div>");
                }
            } else if (action.equals("eliminar")) {
                String pk = request.getParameter("idpk");
                if (pk != null && !pk.trim().isEmpty()) {
                    st.executeUpdate("DELETE FROM personales WHERE id_personal = " + Integer.parseInt(pk));
                    out.println("<div class='alert alert-success' role='alert'>Registro eliminado correctamente!</div>");
                } else {
                    out.println("<div class='alert alert-danger' role='alert'>Error: ID personal no puede estar vacío</div>");
                }
            }
        } catch (SQLException e) {
            out.println("Error PSQL: " + e.getMessage());
        }
    }
%>--%>

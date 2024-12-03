<%@include file="../DDBB/conexion.jsp" %>

<%    if (request.getParameter("listar").equals("cargar")) {
        String nombre = request.getParameter("nombre");

        PreparedStatement ps = null;
        try {
            String agregar = "INSERT INTO tarjetas(nombre)VALUES(?)";
            ps = conn.prepareStatement(agregar);
            ps.setString(1, nombre);

            int filas = ps.executeUpdate();
            if (filas > 0) {
                out.print("Insertado correctamente!");

            } else {
                out.print("No se pudo insertar el registro");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // cerrar el ps
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {

            }
        }

    } else if (request.getParameter("listar").equals("listarTarjetas")) {
        String idTarjeta = request.getParameter("id_tarjeta");
        String descripcion = request.getParameter("nombre");

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Construir la consulta con parámetros si se necesitan
            String consulta = "SELECT * FROM tarjetas";
            if (idTarjeta != null && !idTarjeta.isEmpty() || descripcion != null && !descripcion.isEmpty()) {
                consulta += " WHERE";
                if (idTarjeta != null && !idTarjeta.isEmpty()) {
                    consulta += " id_tarjeta = ?";
                }
                if (descripcion != null && !descripcion.isEmpty()) {
                    if (consulta.contains("?")) {
                        consulta += " AND";
                    }
                    consulta += " nombre = ?";
                }
            }

            ps = conn.prepareStatement(consulta);

            // Asignar parámetros si hay marcadores
            int paramIndex = 1;
            if (idTarjeta != null && !idTarjeta.isEmpty()) {
                ps.setString(paramIndex++, idTarjeta);
            }
            if (descripcion != null && !descripcion.isEmpty()) {
                ps.setString(paramIndex++, descripcion);
            }

            // Ejecutar la consulta
            rs = ps.executeQuery();

            // Construir el HTML dinámicamente
            while (rs.next()) {%>
<tr>
    <td><%= rs.getString("id_tarjeta")%></td>
    <td><%= rs.getString("nombre")%></td>
    <td style="text-align: center; margin-right: 10px;">
        <i style="cursor: pointer;" class="btn btn-secondary" onclick="rellenaredit('<%out.print(rs.getString(1));%>', '<%out.print(rs.getString(2));%>')">Editar</i> <i style="cursor: pointer;" class="btn btn-danger" data-target="#showModal" data-toggle="modal" onclick="$('#id_ciudad').val('<%out.print(rs.getString(1));%>')">Borrar</i>
        <a href="../reportesJSP/reporteTarjetas.jsp?tarjeta=<%= rs.getString("id_tarjeta")%>" target="_blank" class="btn btn-info">
            <span><i class="fa fa-eye"></i></span>
        </a>
    </td>
</tr>
<% }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

%>
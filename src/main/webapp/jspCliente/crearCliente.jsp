<%@include file="../DDBB/conexion.jsp"  %>
<%
if (request.getParameter("listar").equals("cargar")) {
    String ciudadStr = request.getParameter("id_ciudad");
    String nombre = request.getParameter("nombre");
    String apellido = request.getParameter("apellido");
    String ci = request.getParameter("ci");
    String telefono = request.getParameter("telefono");
    String correo = request.getParameter("correo");
    String clave = request.getParameter("clave");

    try {
        // Comprobar si el cliente ya existe
         int ciudad = Integer.parseInt(ciudadStr);
        
        String query = "SELECT COUNT(*) FROM clientes WHERE LOWER(ci) = LOWER(?)";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, ci);
        ResultSet rs = ps.executeQuery();
        rs.next();
        int count = rs.getInt(1);

        if (count > 0) {
            out.println("<div class='alert alert-danger' role='alert'>El cliente ya existe!</div>");
        } else {
            // Crear un nuevo PreparedStatement para la inserción
            String insertarCliente = "INSERT INTO clientes (id_ciudad, nombre, apellido, ci, telefono, correo, clave) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement psInsert = conn.prepareStatement(insertarCliente);
            psInsert.setInt(1, ciudad);
            psInsert.setString(2, nombre);
            psInsert.setString(3, apellido);
            psInsert.setString(4, ci);
            psInsert.setString(5, telefono);
            psInsert.setString(6, correo);
            psInsert.setString(7, clave);
            psInsert.executeUpdate();
            psInsert.close();

            out.println("<div class='alert alert-success' role='alert'>Cuenta creada con éxito!</div>");
        }

        ps.close();
        rs.close();
    } catch (SQLException e) {
        out.println("Error PSQL: " + e.getMessage());
    }
}
%>

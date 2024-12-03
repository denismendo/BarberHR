
<%@include file="../DDBB/conexion.jsp"  %>
<%

if(request.getParameter("listar").equals("listar")){
    try{
        Statement st = null;
        ResultSet rs = null;
    
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM horarios ORDER BY id_horario");
        while(rs.next()){%>
<tr>
    <td><%out.print(rs.getString(1));%></td>
    <td><%out.print(rs.getString(2));%></td>
    <td style="text-align: center; margin-right: 10px;"><i style="cursor: pointer;" class="btn btn-secondary" onclick="rellenaredit('<%out.print(rs.getString(1));%>', '<%out.print(rs.getString(2));%>')">Editar</i> <i style="cursor: pointer;" class="btn btn-danger" data-target="#showModal" data-toggle="modal" onclick="$('#id_horario').val('<%out.print(rs.getString(1));%>')">Borrar</i></td>
</tr>
<% }

 }catch(Exception err){
     out.println("Error PSLQ " + err);
 }
}else if(request.getParameter("listar").equals("cargar")){
    String nombre = request.getParameter("nombre");
    String hora = request.getParameter("hora");

    try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM horarios WHERE LOWER(hora) = LOWER('" + hora + "')");
        rs.next();
        int count = rs.getInt(1);

        if (count > 0) {
            out.println("<div class='alert alert-danger' role='alert'>La hora ya existe!</div>");
        } else {
            st.executeUpdate("INSERT INTO horarios (hora) VALUES ('" + hora + "')");
            out.println("<div class='alert alert-success' role='alert'>Datos insertados con éxito!</div>");
        }
    } catch (SQLException e) {
        out.println("Error PSQL: " + e.getMessage());
    }
}else if(request.getParameter("listar").equals("modificar")){
    String idhorario = request.getParameter("id_horario");
    String nombre = request.getParameter("nombre");
    String hora = request.getParameter("hora");

    try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM horarios WHERE LOWER(nombre) = LOWER('" + nombre + "') AND id_horario != '" + idhorario + "'");
        rs.next();
        int count = rs.getInt(1);

        if (count > 0) {
            out.println("<div class='alert alert-danger' role='alert'>El horario ya existe!</div>");
        } else {
            st.executeUpdate("UPDATE horarios SET nombre = '" + nombre + "' WHERE id_horario = '" + idhorario + "'");
            out.println("<div class='alert alert-success' role='alert'>Datos modificados con éxito!</div>");
        }
    } catch (SQLException e) {
        out.println("Error PSQL: " + e.getMessage());
    }
}else if(request.getParameter("listar").equals("eliminar")){
    String pk = request.getParameter("idpk");

    try {
        Statement st = conn.createStatement();
        st.executeUpdate("DELETE FROM horario WHERE id_horario = " + pk);
        out.println("<div class='alert alert-success' role='alert'>Registro eliminado correctamente!</div>");
    } catch (SQLException e) {
        out.println("Error PSQL: " + e.getMessage());
    }
}
%>

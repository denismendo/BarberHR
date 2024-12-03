<%@include file="../DDBB/conexion.jsp"  %>
<%    if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;

            st = conn.createStatement();
            rs = st.executeQuery("SELECT U.id_usuario, R.id_rol, P.id_personal, U.usuario, U.clave, U.estado FROM usuarios U LEFT JOIN personales P ON U.id_personal = P.id_personal LEFT JOIN roles R ON U.id_rol = R.id_rol ORDER BY id_usuario;");
//            rs = st.executeQuery("SELECT * FROM usuarios;");
            while (rs.next()) {%>
<tr>
    <td><%out.print(rs.getString(1));%></td>
    <td><%out.print(rs.getString(2));%></td>
    <td><%out.print(rs.getString(3));%></td>
    <td><%out.print(rs.getString(4));%></td>
    <td><%out.print(rs.getString(5));%></td>
    <td><%out.print(rs.getString(6));%></td>
    <td style="text-align: center; margin-right: 10px;">
        <i style="cursor: pointer;" class="btn btn-secondary" onclick="rellenaredit('<%out.print(rs.getString(1));%>', '<%out.print(rs.getString(2));%>', '<%out.print(rs.getString(3));%>', '<%out.print(rs.getString(4));%>', '<%out.print(rs.getString(5));%>', '<%out.print(rs.getString(6));%>')">Editar</i>
        <i style="cursor: pointer;" class="btn btn-danger" data-target="#showModal" data-toggle="modal" onclick="$('#id_usuario').val('<%out.print(rs.getString(1));%>')">Borrar</i>
        <a href="../reportesJSP/reporteUsuario.jsp?usuario=<%= rs.getString("id_usuario")%>" target="_blank" class="btn btn-info">
            <span>Info</span>
        </a> 
    </td>
</tr>
<% }

        } catch (Exception err) {
            out.println("Error PSLQ " + err);
        }
    } else if (request.getParameter("listar").equals("cargar")) {
        String rol = request.getParameter("id_rol");
        String personal = request.getParameter("id_personal");
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");
        String estado = request.getParameter("estado");

        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("INSERT INTO usuarios (id_rol, id_personal, usuario,clave,estado)VALUES('" + rol + "', '" + personal + "', '" + usuario + "', '" + clave + "', '" + estado + "')");
            out.println("<div class='alert-success' role = 'alert'> Datos insertados con exito!</div>");

        } catch (SQLException err) {
            out.println("Error PSLQ " + err);
        }
    } else if (request.getParameter("listar").equals("modificar")) {
        String rol = request.getParameter("id_rol");
        String personal = request.getParameter("id_personal");
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");
        String estado = request.getParameter("estado");
        String idusuario = request.getParameter("id_usuario");

        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("UPDATE usuarios set id_rol = '" + rol + "', id_personal = '" + personal + "', usuario = '" + usuario + "', clave = '" + clave + "', estado = '" + estado + "' WHERE id_usuario = '" + idusuario + "'");
            out.print("<div class='alert alert-success' role='alert'> Datos modificados con exito!</div>");
        } catch (Exception e) {
            out.println("Error PSQL" + e);
        }
    } else if (request.getParameter("listar").equals("eliminar")) {
        String pk = request.getParameter("idpk");

        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("DELETE FROM usuarios WHERE id_usuario = '" + pk + "'");
        } catch (SQLException e) {
            out.println("Error PSQL" + e);
        }
    }else if(request.getParameter("listar").equals("buscarrol")){
    try{
        Statement st = null;
        ResultSet rs = null;    
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM roles WHERE nombre!='Estilista';");
        
        %>
        <option>Seleccionar</option>
        <%
        
        while(rs.next()){%>       
        
        <option value="<%out.print(rs.getInt(1));%>"><%out.print(rs.getString(2));%></option>

<% }

 }catch(Exception err){
     out.println("Error PSLQ " + err);
 }
}
%>
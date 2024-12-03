<%@include file="../DDBB/conexion.jsp"  %>
<%
    
    if(request.getParameter("listar").equals("listar")){
        try{
            Statement st = null;
            ResultSet rs = null;
        
            st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM roles ORDER BY id_rol");
            while(rs.next()){%>
<tr>
    <td><%out.print(rs.getInt(1));%></td>
    <td><%out.print(rs.getString(2));%></td>
    <td><%out.print(rs.getString(3));%></td>  
    <td style="text-align: center; margin-right: 10px;">
        <i style="cursor: pointer;" class="btn btn-secondary" onclick="rellenaredit('<%out.print(rs.getInt(1));%>', '<%out.print(rs.getString(2));%>', '<%out.print(rs.getString(3));%>')">Editar</i> <i style="cursor: pointer;" class="btn btn-danger" data-target="#showModal" data-toggle="modal" onclick="$('#id_rol').val('<%out.print(rs.getString(1));%>')">Borrar</i>
        <a href="../reportesJSP/reporteRoles.jsp?rol=<%= rs.getString("id_rol")%>" target="_blank" class="btn btn-info">
            <span>Info</span>
        </a> 
    </td>

</tr>
<% }

 }catch(Exception err){
     out.println("Error PSLQ " + err);
 }
}else if(request.getParameter("listar").equals("cargar")){
String nombre = request.getParameter("nombre");
String descripcion = request.getParameter("descripcion");

try{
Statement st = null;
st = conn.createStatement();
st.executeUpdate("INSERT INTO roles (nombre, descripcion)VALUES('"+nombre+"', '"+descripcion+"')");
out.println("<div class='alert alert-success' role = 'alert'> Datos guardados con exito!</div>");
}catch(Exception err){
 out.println("Error PSLQ " + err);
}
}else if(request.getParameter("listar").equals("modificar")){
String nombre = request.getParameter("nombre");
String descripcion = request.getParameter("descripcion");
String idrol = request.getParameter("id_rol");

try{
    Statement st = null;    
    st = conn.createStatement();
    st.executeUpdate("UPDATE roles set nombre = '"+nombre+"', descripcion = '"+descripcion+"' WHERE id_rol = '"+idrol+"'");
    out.print("<div class='alert alert-success' role='alert'> Datos modificados con exito!</div>");
//$("#mensaje").text("Modificados correctamente!");
}catch(Exception e){
    out.println("Error PSQL" + e);
}
}else if(request.getParameter("listar").equals("eliminar")){
    String pk = request.getParameter("idpk");

    try{
        Statement st = null;
        st = conn.createStatement();
        st.executeUpdate("DELETE FROM roles WHERE id_rol = " +pk+ "");
        out.print("<div class='alert alert-success' role='alert'> Registro eliminado correctamente!</div>");
    }catch(SQLException e){
        out.println("Error PSQL" + e);
}
}
%>
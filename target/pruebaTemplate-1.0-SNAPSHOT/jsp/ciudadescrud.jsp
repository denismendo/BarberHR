<%--
<%@include file="../DDBB/conexion.jsp"  %>
<%
    
    if(request.getParameter("listar").equals("listar")){
        try{
            Statement st = null;
            ResultSet rs = null;
        
            st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM ciudades ORDER BY id_ciudad");
            while(rs.next()){%>
<tr>
    <td><%out.print(rs.getString(1));%></td>
    <td><%out.print(rs.getString(2));%></td>
    <td style="text-align: center; margin-right: 10px;"><i style="cursor: pointer;" class="btn btn-secondary" onclick="rellenaredit('<%out.print(rs.getString(1));%>', '<%out.print(rs.getString(2));%>')">Editar</i> <i style="cursor: pointer;" class="btn btn-danger" data-target="#showModal" data-toggle="modal" onclick="$('#id_ciudad').val('<%out.print(rs.getString(1));%>')">Borrar</i></td>
    <!--<td><button id="btn_click" onclick="#btn_click">click</button></td>-->

</tr>
<% }

 }catch(Exception err){
     out.println("Error PSLQ " + err);
 }
}else if(request.getParameter("listar").equals("cargar")){
String nombre = request.getParameter("nombre");

try{
Statement st = null;
st = conn.createStatement();
st.executeUpdate("INSERT INTO ciudades (nombre)VALUES('"+nombre+"')");
out.println("<div class='alert-success' role = 'alert'> Datos insertados con exito!</div>");
}catch(Exception err){
 out.println("Error PSLQ " + err);
}
}else if(request.getParameter("listar").equals("modificar")){
String nombre = request.getParameter("nombre");
String idciudad = request.getParameter("id_ciudad");

try{
    Statement st = null;    
    st = conn.createStatement();
    st.executeUpdate("UPDATE ciudades set nombre = '"+nombre+"' WHERE id_ciudad = '"+idciudad+"'");
    out.print("<div class='alert alert-access' role='alert'> Datos modificados con exito!</div>");
//$("#mensaje").text("Modificados correctamente!");
}catch(Exception e){
    out.println("Error PSQL" + e);
}
}else if(request.getParameter("listar").equals("eliminar")){
    String pk = request.getParameter("idpk");

    try{
        Statement st = null;
        st = conn.createStatement();
        st.executeUpdate("DELETE FROM ciudades WHERE id_ciudad = " +pk+ "");
        out.print("<div class='alert alert-success' role='alert'> Registro eliminado correctamente!</div>");
    }catch(SQLException e){
        out.println("Error PSQL" + e);
}
}
%>
--%>

<%@include file="../DDBB/conexion.jsp"  %>
<%

if(request.getParameter("listar").equals("listar")){
    try{
        Statement st = null;
        ResultSet rs = null;
    
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM ciudades ORDER BY id_ciudad");
        while(rs.next()){%>
<tr>
    <td><%out.print(rs.getString(1));%></td>
    <td><%out.print(rs.getString(2));%></td>
    <td style="text-align: center; margin-right: 10px;">
        <i style="cursor: pointer;" class="btn btn-secondary" onclick="rellenaredit('<%out.print(rs.getString(1));%>', '<%out.print(rs.getString(2));%>')">Editar</i> <i style="cursor: pointer;" class="btn btn-danger" data-target="#showModal" data-toggle="modal" onclick="$('#id_ciudad').val('<%out.print(rs.getString(1));%>')">Borrar</i>
        <a href="../reportesJSP/reporteCiudades.jsp?ciudad=<%= rs.getString("id_ciudad") %>" target="_blank" class="btn btn-info">
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

    try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM ciudades WHERE LOWER(nombre) = LOWER('" + nombre + "')");
        rs.next();
        int count = rs.getInt(1);

        if (count > 0) {
            out.println("<div class='alert alert-danger' role='alert'>La ciudad ya existe!</div>");
        } else {
            st.executeUpdate("INSERT INTO ciudades (nombre) VALUES ('" + nombre + "')");
            out.println("<div class='alert alert-success' role='alert'>Datos insertados con éxito!</div>");
        }
    } catch (SQLException e) {
        out.println("Error PSQL: " + e.getMessage());
    }
}else if(request.getParameter("listar").equals("modificar")){
    String nombre = request.getParameter("nombre");
    String idciudad = request.getParameter("id_ciudad");

    try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM ciudades WHERE LOWER(nombre) = LOWER('" + nombre + "') AND id_ciudad != '" + idciudad + "'");
        rs.next();
        int count = rs.getInt(1);

        if (count > 0) {
            out.println("<div class='alert alert-danger' role='alert'>El nombre de la ciudad ya existe!</div>");
        } else {
            st.executeUpdate("UPDATE ciudades SET nombre = '" + nombre + "' WHERE id_ciudad = '" + idciudad + "'");
            out.println("<div class='alert alert-success' role='alert'>Datos modificados con éxito!</div>");
        }
    } catch (SQLException e) {
        out.println("Error PSQL: " + e.getMessage());
    }
}else if(request.getParameter("listar").equals("eliminar")){
    String pk = request.getParameter("idpk");

    try {
        Statement st = conn.createStatement();
        st.executeUpdate("DELETE FROM ciudades WHERE id_ciudad = " + pk);
        out.println("<div class='alert alert-success' role='alert'>Registro eliminado correctamente!</div>");
    } catch (SQLException e) {
        out.println("Error PSQL: " + e.getMessage());
    }
}
%>

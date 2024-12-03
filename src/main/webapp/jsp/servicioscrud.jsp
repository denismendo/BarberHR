<%--<%@include file="../DDBB/conexion.jsp"  %>
<%
    
    if(request.getParameter("listar").equals("listar")){
        try{
            Statement st = null;
            ResultSet rs = null;
        
            st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM servicios ORDER BY id_servicio");
            while(rs.next()){%>
<tr>
    <td><%out.print(rs.getString(1));%></td>
    <td><%out.print(rs.getString(2));%></td>
    <td><%out.print(rs.getString(3));%></td>  
    <td style="text-align: center; margin-right: 10px;"><i style="cursor: pointer;" class="btn btn-secondary" onclick="rellenaredit('<%out.print(rs.getString(1));%>', '<%out.print(rs.getString(2));%>', '<%out.print(rs.getString(3));%>')">Editar</i> <i style="cursor: pointer;" class="btn btn-danger" data-target="#showModal" data-toggle="modal" onclick="$('#id_servicio').val('<%out.print(rs.getString(1));%>')">Borrar</i></td>
    <!--<td><button id="btn_click" onclick="#btn_click">click</button></td>-->

</tr>
<% }

 }catch(Exception err){
     out.println("Error PSLQ " + err);
 }
}else if(request.getParameter("listar").equals("cargar")){
String nombre = request.getParameter("nombre");
String precio = request.getParameter("precio");

try{
Statement st = null;
st = conn.createStatement();
st.executeUpdate("INSERT INTO servicios (nombre, precio)VALUES('"+nombre+"', '"+precio+"')");
out.println("<div class='alert alert-success' role = 'alert'> Datos insertados con exito!</div>");
}catch(Exception err){
 out.println("Error PSLQ " + err);
}
}else if(request.getParameter("listar").equals("modificar")){
String nombre = request.getParameter("nombre");
String precio = request.getParameter("precio");
String idservicio = request.getParameter("id_servicio");

try{
    Statement st = null;    
    st = conn.createStatement();
    st.executeUpdate("UPDATE servicios set nombre = '"+nombre+"', precio = '"+precio+"' WHERE id_servicio = '"+idservicio+"'");
    out.print("<div class='alert alert-success' role='alert'> Datos modificados con exito!</div>");
}catch(Exception e){
    out.println("Error PSQL" + e);
}
}else if(request.getParameter("listar").equals("eliminar")){
    String pk = request.getParameter("idpk");

    try{
        Statement st = null;
        st = conn.createStatement();
        st.executeUpdate("DELETE FROM servicios WHERE id_servicio = " +pk+ "");
        out.print("<div class='alert alert-success' role='alert'> Registro eliminado correctamente!</div>");
    }catch(SQLException e){
        out.println("Error PSQL" + e);
}
}
%>--%>

<%@include file="../DDBB/conexion.jsp"  %>
<%    if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;

            st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM servicios ORDER BY id_servicio");
            while (rs.next()) {%>
<tr>
    <td><%out.print(rs.getString(1));%></td>
    <td><%out.print(rs.getString(2));%></td>
    <td><%out.print(rs.getString(3));%></td>  
    <td style="text-align: center; margin-right: 10px;"><i style="cursor: pointer;" class="btn btn-secondary" onclick="rellenaredit('<%out.print(rs.getString(1));%>', '<%out.print(rs.getString(2));%>', '<%out.print(rs.getString(3));%>')">Editar</i> <i style="cursor: pointer;" class="btn btn-danger" data-target="#showModal" data-toggle="modal" onclick="$('#id_servicio').val('<%out.print(rs.getString(1));%>')">Borrar</i>
    
    <a href="../reportesJSP/reporteServicio.jsp?servicio=<%= rs.getString("id_servicio")%>" target="_blank" class="btn btn-info">
        <span>Info</span>
    </a> 
    
    </td>


</tr>
<% }

        } catch (Exception err) {
            out.println("Error PSLQ " + err);
        }
    } else if (request.getParameter("listar").equals("cargar")) {
        String nombre = request.getParameter("nombre");
        String precio = request.getParameter("precio");

        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM servicios WHERE LOWER(nombre) = LOWER('" + nombre + "')");
            rs.next();
            int count = rs.getInt(1);

            if (count > 0) {
                out.println("<div class='alert alert-danger' role='alert'>El Servicio ya existe!</div>");
            } else {
                st.executeUpdate("INSERT INTO servicios (nombre, precio) VALUES ('" + nombre + "', '" + precio + "')");
                out.println("<div class='alert alert-success' role='alert'>Datos insertados con éxito!</div>");
            }
        } catch (SQLException e) {
            out.println("Error PSQL: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("modificar")) {
        String nombre = request.getParameter("nombre");
        String precio = request.getParameter("precio");
        String idservicio = request.getParameter("id_servicio");

        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM servicios WHERE LOWER(nombre) = LOWER('" + nombre + "') AND id_servicio != '" + idservicio + "'");
            rs.next();
            int count = rs.getInt(1);

            if (count > 0) {
                out.println("<div class='alert alert-danger' role='alert'>El nombre del servicio ya existe!</div>");
            } else {
                st.executeUpdate("UPDATE servicios SET nombre = '" + nombre + "', precio = '" + precio + "' WHERE id_servicio = '" + idservicio + "'");
                out.println("<div class='alert alert-success' role='alert'>Datos modificados con éxito!</div>");
            }
        } catch (SQLException e) {
            out.println("Error PSQL: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("eliminar")) {
        String pk = request.getParameter("idpk");

        try {
            Statement st = conn.createStatement();
            st.executeUpdate("DELETE FROM servicios WHERE id_servicio = " + pk);
            out.println("<div class='alert alert-success' role='alert'>Registro eliminado correctamente!</div>");
        } catch (SQLException e) {
            out.println("Error PSQL: " + e.getMessage());
        }
    }
%>

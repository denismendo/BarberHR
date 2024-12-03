    <%--
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%@include file="../DDBB/conexion.jsp"%>



<%                                   
Statement st = null;
ResultSet rs = null;

if (request.getParameter("acceso") != null) {

/*Tomamos los parametros del HTML*/
String usuario = request.getParameter("usuario");
String clave = request.getParameter("clave");
//out.println(usuario + ',' + clave);

/*Instanciamos para crear nuestras sesiones*/
HttpSession sesion = request.getSession();

try {                                           
st = conn.createStatement();
rs = st.executeQuery("SELECT * FROM usuarios  where usuario='" + usuario + "' and clave='" + clave + "';");
while (rs.next()) {
sesion.setAttribute("logueado", "1");
sesion.setAttribute("id", rs.getString("id_usuario"));
sesion.setAttribute("usuario", rs.getString("usuario"));
sesion.setAttribute("rol", rs.getString("id_rol"));
sesion.setAttribute("personal", rs.getString("id_personal"));
response.sendRedirect("pruebaTemplate/templates/dashboard.jsp");
}
out.println("<div class=\"alert alert-danger\" role=\"alert\">Usuario no valido</div>");
} catch (Exception e) {
out.print(e.getMessage());
}
}
%>  --%>


<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%@include file="../DDBB/conexion.jsp"%>
<%    
    String user = request.getParameter("usuario");
    String password = request.getParameter("clave");

    HttpSession sesion = request.getSession();
    Statement st = null;
    ResultSet rs = null;
    boolean usuarioValido = false;
    try {

        st = conn.createStatement();
        rs = st.executeQuery("SELECT U.id_usuario, R.nombre nombrerol, P.nombre personal, U.usuario,U.clave FROM usuarios U INNER JOIN personales P ON U.id_personal=P.id_personal INNER JOIN roles R ON U.id_rol = R.id_rol WHERE usuario='" + user + "' and clave='" + password + "';");
        if (rs.next()) {
            usuarioValido = true;
            sesion.setAttribute("logout", "1");
            sesion.setAttribute("admin", rs.getString("id_usuario"));
            sesion.setAttribute("user", rs.getString("usuario"));
            sesion.setAttribute("rol", rs.getString("nombrerol"));
            sesion.setAttribute("personal", rs.getString("personal"));
            
            
            %>
            <script>location.href='templates/dashboard.jsp';</script>
                
            <%
        }
        if(!usuarioValido){
out.println("<div class=\"alert alert-danger\" role=\"alert\">Usuario no válido</div>");
}
        
    } catch (Exception e) {
        out.print(e.getMessage());
    }
%>








 <!--MI CODIGO-->

<%--
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%@include file="../DDBB/conexion.jsp"%>

<%
Statement st = null;
ResultSet rs = null;

if (request.getParameter("acceso") != null ) {

    String usuario = request.getParameter("usuario");
    String clave = request.getParameter("clave");

    HttpSession sesion = request.getSession();
    boolean usuarioValido = false;

    try {
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM usuarios WHERE usuario='" + usuario + "' AND clave='" + clave + "';");
        
        if (rs.next()) {
            usuarioValido = true;
            sesion.setAttribute("logueado", "1");
            sesion.setAttribute("id", rs.getString("id_usuario"));
            sesion.setAttribute("usuario", rs.getString("usuario"));
            sesion.setAttribute("rol", rs.getString("id_rol"));
            sesion.setAttribute("personal", rs.getString("id_personal"));
            
            // Aquí no redirigimos directamente ya que usamos AJAX
            response.sendRedirect("templates/dashboard.jsp");
        }

        if (!usuarioValido) {
            out.print("<div class=\"alert alert-danger\" role=\"alert\">Usuario no válido</div>");
        }

    } catch (Exception e) {
        out.print(e.getMessage());
    }
}
%>







	
<%--
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%@include file="../DDBB/conexion.jsp"%>

<%                                   
PreparedStatement pst = null;
ResultSet rs = null;

if (request.getParameter("acceso") != null) {

    /* Tomamos los parametros del HTML */
    String usuario = request.getParameter("usuario");
    String clave = request.getParameter("clave");

    /* Instanciamos para crear nuestras sesiones */
    HttpSession sesion = request.getSession();

    try {                                           
        String query = "SELECT * FROM usuarios WHERE usuario = ? AND clave = ?";
        pst = conn.prepareStatement(query);
        pst.setString(1, usuario);

        // Hashing de la contraseña para mayor seguridad, suponiendo que las contraseñas en la DB están hasheadas.
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(clave.getBytes());
        BigInteger number = new BigInteger(1, hash);
        String hashedClave = number.toString(16);
        
        pst.setString(2, hashedClave);

        rs = pst.executeQuery();
        if (rs.next()) {
            sesion.setAttribute("logueado", "1");
            sesion.setAttribute("id", rs.getString("id_usuario"));
            sesion.setAttribute("usuario", rs.getString("usuario"));
            sesion.setAttribute("rol", rs.getString("id_rol"));
            sesion.setAttribute("personal", rs.getString("id_personal"));
            response.sendRedirect("pruebaTemplate/templates/dashboard.jsp");
        } else {
            out.println("<div class=\"alert alert-danger\" role=\"alert\">Usuario no válido</div>");
        }
    } catch (Exception e) {
        // Loggear el error en lugar de mostrarlo al usuario
        log("Error en el proceso de autenticación: ", e);
        out.println("<div class=\"alert alert-danger\" role=\"alert\">Error en el sistema. Intente nuevamente más tarde.</div>");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) { /* Ignorar */ }
        if (pst != null) try { pst.close(); } catch (Exception e) { /* Ignorar */ }
    }
}
--%>

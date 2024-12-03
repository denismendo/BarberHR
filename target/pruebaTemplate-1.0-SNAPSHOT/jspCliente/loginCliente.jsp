<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%@include file="../DDBB/conexion.jsp"%>
<%    String correo = request.getParameter("correo");
    String clave = request.getParameter("clave");

//    out.print(correo + " " + clave);
    HttpSession sesion = request.getSession();
    boolean usuarioValido = false;
    try {

        String sql = "SELECT C.id_cliente, C.nombre FROM clientes C WHERE correo = ? AND clave = ?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, correo);
        pst.setString(2, clave);

        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            usuarioValido = true;
            sesion.setAttribute("logoutCliente", "1");
            sesion.setAttribute("cliente", rs.getString("id_cliente"));
            sesion.setAttribute("nombreCliente", rs.getString("nombre"));
//            sesion.setAttribute("cliente", rs.getString("cliente"));


%>
<!--<h1>Reserva</h1>?-->
<script>location.href = 'reserva.jsp';</script>

<%                    }
        if (!usuarioValido) {
            out.println("<div class=\"alert alert-danger\" role=\"alert\">Usuario no válido</div>");
        }

    } catch (Exception e) {
        out.print(e.getMessage());
    }
%>
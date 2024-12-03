<%@ page import="java.sql.*" %>
<%@ include file="../DDBB/conexion.jsp" %>
<%
    String accion = request.getParameter("accion");
    String idUsuario = request.getParameter("id_usuario");
    String respuesta = "";

    try {
        if ("abrir".equalsIgnoreCase(accion)) {
            String monto = request.getParameter("monto");

            if (monto == null || monto.isEmpty() || !monto.matches("\\d+")) {
                respuesta = "El monto ingresado no es válido.";
            } else {
                // Verificar si ya hay una caja abierta
                String queryCajaAbierta = "SELECT id_caja FROM caja WHERE id_usuario = ? AND estado = 'Abierta'";
                try (PreparedStatement psCajaAbierta = conn.prepareStatement(queryCajaAbierta)) {
                    psCajaAbierta.setString(1, idUsuario);
                    ResultSet rsCajaAbierta = psCajaAbierta.executeQuery();

                    if (rsCajaAbierta.next()) {
                        respuesta = "Ya tienes una caja abierta.";
                    } else {
                        // Abrir caja
                        String queryAbrirCaja = "INSERT INTO caja (fecha_apertura, monto_apertura, estado, id_usuario) " +
                                                "VALUES (CURRENT_DATE, ?, 'Abierta', ?)";
                        try (PreparedStatement psAbrirCaja = conn.prepareStatement(queryAbrirCaja)) {
                            psAbrirCaja.setInt(1, Integer.parseInt(monto));
                            psAbrirCaja.setString(2, idUsuario);
                            psAbrirCaja.executeUpdate();

                            respuesta = "Caja abierta exitosamente.";
                        }
                    }
                }
            }
        } else if ("cerrar".equalsIgnoreCase(accion)) {
            respuesta = "Funcionalidad de cierre de caja no implementada.";
        } else {
            respuesta = "Acción no válida.";
        }
    } catch (Exception e) {
        respuesta = "Error: " + e.getMessage();
    }

    out.print(respuesta);
%>

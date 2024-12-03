<%@ page import="net.sf.jasperreports.engine.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="net.sf.jasperreports.engine.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ include file="../DDBB/conexion.jsp" %>

<%    try {
        // Ruta del archivo .jasper compilado para el reporte de cursos
        File reportFile = new File(application.getRealPath("/reportes/reporteGeneralFacturas.jasper"));

        // Par�metros del reporte (ajusta seg�n sea necesario)
        Map<String, Object> parametros = new HashMap<>();

        // Obtener los par�metros de fecha del formulario
        String fechaInicioStr = request.getParameter("fecha_inicio");
        String fechaFinStr = request.getParameter("fecha_fin");

        // Convertir los par�metros de fecha de String a Date
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date fechaInicio = sdf.parse(fechaInicioStr);
        Date fechaFin = sdf.parse(fechaFinStr);

        // Agregar los par�metros de fecha al mapa de par�metros
        parametros.put("fecha_inicio", fechaInicio);
        parametros.put("fecha_fin", fechaFin);

        // Generar el reporte
        byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parametros, conn);

        // Configurar respuesta
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);

        // Enviar el reporte al navegador
        ServletOutputStream output = response.getOutputStream();
        output.write(bytes, 0, bytes.length);
        output.flush();
        output.close();
    } catch (java.io.FileNotFoundException ex) {
        out.println("Error: Archivo .jasper no encontrado.");
    } catch (Exception e) {
        out.println("Error al generar reporte: " + e.getMessage());
    }
%>
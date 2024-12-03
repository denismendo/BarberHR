<%
HttpSession sesion = request.getSession();
sesion.removeAttribute("admin"); // Elimina solo la variable del administrador
response.sendRedirect("../index.jsp");
%>

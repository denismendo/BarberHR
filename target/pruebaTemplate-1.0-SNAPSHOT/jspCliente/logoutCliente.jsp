<%
HttpSession sesion = request.getSession();
sesion.removeAttribute("cliente"); // Elimina solo la variable del cliente
response.sendRedirect("../loginCliente.jsp");
%>

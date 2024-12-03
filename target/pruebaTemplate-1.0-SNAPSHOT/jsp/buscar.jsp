<%@include file="../DDBB/conexion.jsp"  %>
<%    if (request.getParameter("listar").equals("buscarciudad")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM ciudades ORDER BY id_ciudad;");

%>
<option>Seleccionar</option>
<%            while (rs.next()) {%>       

<option value="<%out.print(rs.getInt(1));%>"><%out.print(rs.getString(2));%></option>

<% }

    } catch (Exception err) {
        out.println("Error PSLQ " + err);
    }
} else if (request.getParameter("listar").equals("buscarPersonal")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM personales ORDER BY id_personal;");

%>
<option>Seleccionar</option>
<%            while (rs.next()) {%>       

<option value="<%out.print(rs.getInt(1));%>"><%out.print(rs.getString(3));%></option>

<% }

    } catch (Exception err) {
        out.println("Error PSLQ " + err);
    }
} else if (request.getParameter("listar").equals("buscarEstilista")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT P.id_personal, P.nombre FROM personales P JOIN roles R ON P.id_rol = R.id_rol WHERE R.nombre = 'Estilista';");

%>
<option>Seleccionar</option>
<%            while (rs.next()) {%>       

<option value="<%out.print(rs.getInt(1));%>"><%out.print(rs.getString(2));%></option>

<% }

    } catch (Exception err) {
        out.println("Error PSLQ " + err);
    }
} else if (request.getParameter("listar").equals("buscarrol")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM roles ORDER BY id_rol;");

%>
<option>Seleccionar</option>
<%            while (rs.next()) {%>       

<option value="<%out.print(rs.getInt(1));%>"><%out.print(rs.getString(2));%></option>

<% }

    } catch (Exception err) {
        out.println("Error PSLQ " + err);
    }
} else if (request.getParameter("listar").equals("buscarcliente")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM clientes ORDER BY id_cliente;");

%>
<option>Seleccionar</option>
<%            while (rs.next()) {%>       

<option value="<%out.print(rs.getInt(1));%>,<%out.print(rs.getString(5));%>"><%out.print(rs.getString(3));%> <%out.print(rs.getString(4));%></option>

<% }

    } catch (Exception err) {
        out.println("Error PSLQ " + err);
    }
} else if (request.getParameter("listar").equals("buscarservicio")) {
    try {
        Statement st = null;
        ResultSet rs = null;

        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM servicios ORDER BY id_servicio");
%>
<option>Seleccionar</option>
<%
    while (rs.next()) {%>

<option value="<%out.print(rs.getString(1));%>,<%out.print(rs.getString(3));%>"><%out.print(rs.getString(2));%></option>
<% }

    } catch (Exception err) {
        out.println("Error PSLQ " + err);
    }
} else if (request.getParameter("listar").equals("buscarmetodopago")) {
    try {
        Statement st = null;
        ResultSet rs = null;

        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM metodopago");
%>
<option>Seleccionar</option>
<%
    while (rs.next()) {%>

<option value="<%out.print(rs.getString(1));%>,<%out.print(rs.getString(2));%>"><%out.print(rs.getString(2));%></option>
<% }

    } catch (Exception err) {
        out.println("Error PSLQ " + err);
    }
} else if (request.getParameter("listar").equals("buscarTarjetas")) {

    try {
        Statement st = null;
        ResultSet rs = null;

        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM tarjetas");
%>
<option>Seleccionar</option>
<%
    while (rs.next()) {%>

<option value="<%out.print(rs.getString(1));%>,<%out.print(rs.getString(2));%>"><%out.print(rs.getString(2));%></option>
<% }

        } catch (Exception err) {
            out.println("Error PSLQ " + err);
        }
    }


%>

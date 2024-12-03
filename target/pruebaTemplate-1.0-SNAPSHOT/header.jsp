<%
    HttpSession sesion = request.getSession();

    if (sesion.getAttribute("logout") == null || sesion.getAttribute("logout").equals("0")) {
%>
<script>location.href = "../index.jsp";alert('Ud. debe de identificarse..!!');</script>	
<% } %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" href="../img/logosvg.svg" type="image/ico" />

        <title>BarberHR</title>

        <!-- Bootstrap -->
        <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
        <!-- NProgress -->
        <link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
        <!-- iCheck -->
        <link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet">

        <!-- bootstrap-progressbar -->
        <link href="../vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
        <!-- JQVMap -->
        <link href="../vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet"/>
        <!-- bootstrap-daterangepicker -->
        <link href="../vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">





        <!-- Datatables -->

        <link href="../vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
        <link href="../vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
        <link href="../vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
        <link href="../vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
        <link href="../vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">  

        <!-- Custom Theme Style -->
        <link href="../build/css/custom.min.css" rel="stylesheet"> 

    </head>

    <body class="nav-md">
        <div class="container body">
            <div class="main_container">
                <div class="col-md-3 left_col">
                    <div class="left_col scroll-view">
                        <div class="navbar nav_title" style="border: 0;">
                            <a href="dashboard.jsp" class="site_title">
                                <img style="height: 50px; width: 50px;" src="../img/logosvg.svg" alt="Logo"/>
                                <span>BarberHR</span>
                            </a>
                        </div>
                        <div class="clearfix"></div>

                        <!-- menu profile quick info -->
                        <div class="profile clearfix">
                            <div class="profile_pic">
                                <img src="../production/images/user.png" alt="..." class="img-circle profile_img">
                            </div>
                            <div class="profile_info">
                                <span>Bienvenido,</span>
                                <h2 
                                    id="user"><% out.print(sesion.getAttribute("rol"));%></h2>
                            </div>
                        </div>
                        <!-- /menu profile quick info -->

                        <br />

                        <!-- sidebar menu -->
                        <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
                            <div class="menu_section">
                                <h3>General</h3>
                                <ul class="nav side-menu">
                                    <li><a><i class="fa fa-home"></i> Mantenimiento <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu">
                                            <li><a href="servicios.jsp">Servicios</a></li>
                                            <li><a href="ciudades.jsp">Ciudades</a></li>
                                            <li><a href="clientes.jsp">Clientes</a></li>
                                            <li><a href="personales.jsp">Personales</a></li>
                                            <!--<li><a href="horarios.jsp">Horarios</a></li>-->
                                            <li><a href="metododepago.jsp">Metodo de Pago</a></li>
                                            <li><a href="tarjetas.jsp">Tarjetas</a></li>
                                            <li><a href="roles.jsp">Roles</a></li>                                                                                      
                                            <li><a href="usuarios.jsp">Usuarios</a></li>
                                        </ul>
                                    </li>
                                    <li><a><i class="fa fa-home"></i> Reservaciones <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu">
                                            <li><a href="reservas.jsp">Agendamiento de Citas</a></li>                                          
                                            <li><a href="listareservas.jsp">Informes</a></li>                                          
                                        </ul>
                                    </li>
                                    <li><a><i class="fa fa-cog"></i> Modulo de Ventas <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu">
                                            <li><a href="facturacion.jsp">Generar Ventas</a></li>                                          
                                            <li><a href="listarFacturas.jsp">Informes</a></li>                                          
                                        </ul>
                                    </li>                                    
                                    <li><a><i class="fa fa-cog"></i> Modulo de Finanzas <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu">
                                            <!--<li><a href="#">Cobros</a></li>-->                                          
                                            <li><a href="listarCobros.jsp">Informes</a></li>                                       
                                        </ul>                                        
                                    </li>                                    
<!--                                    <li><a><i class="fa fa-cog"></i> Caja <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu">
                                            <li><a href="caja.jsp">Abrir Caja</a></li>                                          
                                            <li><a href="#">Movimientos</a></li>                                          
                                            <li><a href="#">Informes</a></li>                                          
                                        </ul>                                        
                                    </li>                                    -->
                                    <!--                                    <li><a><i class="fa fa-edit"></i> Forms <span class="fa fa-chevron-down"></span></a>
                                                                            <ul class="nav child_menu">
                                                                                <li><a href="form.html">General Form</a></li>
                                                                                <li><a href="form_advanced.html">Advanced Components</a></li>
                                                                                <li><a href="form_validation.html">Form Validation</a></li>
                                                                                <li><a href="form_wizards.html">Form Wizard</a></li>
                                                                                <li><a href="form_upload.html">Form Upload</a></li>
                                                                                <li><a href="form_buttons.html">Form Buttons</a></li>
                                                                            </ul>
                                                                        </li>
                                                                        <li><a><i class="fa fa-desktop"></i> UI Elements <span class="fa fa-chevron-down"></span></a>
                                                                            <ul class="nav child_menu">
                                                                                <li><a href="general_elements.html">General Elements</a></li>
                                                                                <li><a href="media_gallery.html">Media Gallery</a></li>
                                                                                <li><a href="typography.html">Typography</a></li>
                                                                                <li><a href="icons.html">Icons</a></li>
                                                                                <li><a href="glyphicons.html">Glyphicons</a></li>
                                                                                <li><a href="widgets.html">Widgets</a></li>
                                                                                <li><a href="invoice.html">Invoice</a></li>
                                                                                <li><a href="inbox.html">Inbox</a></li>
                                                                                <li><a href="calendar.html">Calendar</a></li>
                                                                            </ul>
                                                                        </li>
                                                                        <li><a><i class="fa fa-table"></i> Tables <span class="fa fa-chevron-down"></span></a>
                                                                            <ul class="nav child_menu">
                                                                                <li><a href="tables.html">Tables</a></li>
                                                                                <li><a href="tables_dynamic.html">Table Dynamic</a></li>
                                                                            </ul>
                                                                        </li>
                                                                        <li><a><i class="fa fa-bar-chart-o"></i> Data Presentation <span class="fa fa-chevron-down"></span></a>
                                                                            <ul class="nav child_menu">
                                                                                <li><a href="chartjs.html">Chart JS</a></li>
                                                                                <li><a href="chartjs2.html">Chart JS2</a></li>
                                                                                <li><a href="morisjs.html">Moris JS</a></li>
                                                                                <li><a href="echarts.html">ECharts</a></li>
                                                                                <li><a href="other_charts.html">Other Charts</a></li>
                                                                            </ul>
                                                                        </li>
                                                                        <li><a><i class="fa fa-clone"></i>Layouts <span class="fa fa-chevron-down"></span></a>
                                                                            <ul class="nav child_menu">
                                                                                <li><a href="fixed_sidebar.html">Fixed Sidebar</a></li>
                                                                                <li><a href="fixed_footer.html">Fixed Footer</a></li>
                                                                            </ul>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="menu_section">
                                                                    <h3>Live On</h3>
                                                                    <ul class="nav side-menu">
                                                                        <li><a><i class="fa fa-bug"></i> Additional Pages <span class="fa fa-chevron-down"></span></a>
                                                                            <ul class="nav child_menu">
                                                                                <li><a href="e_commerce.html">E-commerce</a></li>
                                                                                <li><a href="projects.html">Projects</a></li>
                                                                                <li><a href="project_detail.html">Project Detail</a></li>
                                                                                <li><a href="contacts.html">Contacts</a></li>
                                                                                <li><a href="profile.html">Profile</a></li>
                                                                            </ul>
                                                                        </li>
                                                                        <li><a><i class="fa fa-windows"></i> Extras <span class="fa fa-chevron-down"></span></a>
                                                                            <ul class="nav child_menu">
                                                                                <li><a href="page_403.html">403 Error</a></li>
                                                                                <li><a href="page_404.html">404 Error</a></li>
                                                                                <li><a href="page_500.html">500 Error</a></li>
                                                                                <li><a href="plain_page.html">Plain Page</a></li>
                                                                                <li><a href="login.html">Login Page</a></li>
                                                                                <li><a href="pricing_tables.html">Pricing Tables</a></li>
                                                                            </ul>
                                                                        </li>
                                                                        <li><a><i class="fa fa-sitemap"></i> Multilevel Menu <span class="fa fa-chevron-down"></span></a>
                                                                            <ul class="nav child_menu">
                                                                                <li><a href="#level1_1">Level One</a>
                                                                                <li><a>Level One<span class="fa fa-chevron-down"></span></a>
                                                                                    <ul class="nav child_menu">
                                                                                        <li class="sub_menu"><a href="level2.html">Level Two</a>
                                                                                        </li>
                                                                                        <li><a href="#level2_1">Level Two</a>
                                                                                        </li>
                                                                                        <li><a href="#level2_2">Level Two</a>
                                                                                        </li>
                                                                                    </ul>
                                                                                </li>
                                                                                <li><a href="#level1_2">Level One</a>
                                                                                </li>
                                                                            </ul>
                                                                        </li>                  -->
                                    <!--<li><a href="javascript:void(0)"><i class="fa fa-laptop"></i> Landing Page <span class="label label-success pull-right">Coming Soon</span></a></li>-->
                                </ul>
                            </div>

                        </div>
                        <!-- /sidebar menu -->


                    </div>
                </div>

                <!-- top navigation -->
                <div class="top_nav">
                    <div class="nav_menu">
                        <div class="nav toggle">
                            <a id="menu_toggle"><i class="fa fa-bars"></i></a>
                        </div>
                        <nav class="nav navbar-nav">
                            <ul class=" navbar-right">
                                <li class="nav-item dropdown open" style="padding-left: 15px;">
                                    <a href="javascript:;" class="user-profile dropdown-toggle" aria-haspopup="true" id="navbarDropdown" data-toggle="dropdown" aria-expanded="false">
                                        <img src="../production/images/user.png" alt=""><% out.print(sesion.getAttribute("personal"));%>
                                    </a>
                                    <div class="dropdown-menu dropdown-usermenu pull-right" aria-labelledby="navbarDropdown">
                                        <a class="dropdown-item"  href="javascript:;"> Profile</a>
                                        <a class="dropdown-item"  href="javascript:;">
                                            <span class="badge bg-red pull-right">50%</span>
                                            <span>Settings</span>
                                        </a>
                                        <a class="dropdown-item" href="javascritp";>Help</a>
                                        <a class="dropdown-item" href="../jsp/logout.jsp" id="logout">Cerrar sesion</a>
                                    </div>
                                </li>

                                <li role="presentation" class="nav-item dropdown open">
                                    <a href="javascript:;" class="dropdown-toggle info-number" id="navbarDropdown1" data-toggle="dropdown" aria-expanded="false">
                                        <i class="fa fa-envelope-o"></i>
                                        <span class="badge bg-green">6</span>
                                    </a>
                                    <ul class="dropdown-menu list-unstyled msg_list" role="menu" aria-labelledby="navbarDropdown1">
                                        <li class="nav-item">
                                            <a class="dropdown-item">
                                                <!--                                                <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>-->
                                                <span>
                                                    <span>John Smith</span>
                                                    <span class="time">3 mins ago</span>
                                                </span>
                                                <span class="message">
                                                    Film festivals used to be do-or-die moments for movie makers. They were where...
                                                </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="dropdown-item">
                                                <!--<span class="image"><img src="../build/images/loading.gif" alt="Profile Image" /></span>-->
                                                <span>
                                                    <span>John Smith</span>
                                                    <span class="time">3 mins ago</span>
                                                </span>
                                                <span class="message">
                                                    Film festivals used to be do-or-die moments for movie makers. They were where...
                                                </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="dropdown-item">
                                                <!--<span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>-->
                                                <span>
                                                    <span>John Smith</span>
                                                    <span class="time">3 mins ago</span>
                                                </span>
                                                <span class="message">
                                                    Film festivals used to be do-or-die moments for movie makers. They were where...
                                                </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="dropdown-item">
                                                <!--                                                <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>-->
                                                <span>
                                                    <span>John Smith</span>
                                                    <span class="time">3 mins ago</span>
                                                </span>
                                                <span class="message">
                                                    Film festivals used to be do-or-die moments for movie makers. They were where...
                                                </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <div class="text-center">
                                                <a class="dropdown-item">
                                                    <strong>See All Alerts</strong>
                                                    <i class="fa fa-angle-right"></i>
                                                </a>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <!-- /top navigation -->
            </div>
        </div>
        <!--<script src="vendors/jquery/dist/jquery.min.js"></script>-->
    </body>
</html>

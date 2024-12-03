<%@include file="../header.jsp" %>
<div class="container body">
    <div class="main_container">
        <div class="right_col" role="main">
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="dashboard_graph">

                        <div class="row x_title">
                            <div class="col-md-6">
                                <h3>Bienvenido!</h3>
                            </div>
                            <div class="col-md-6">
                                <div id="reportrange" class="pull-right" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
                                    <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                                    <span>December 30, 2014 - January 28, 2015</span> <b class="caret"></b>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div id="chart_plot_01" class="demo-placeholder"></div>
                            <div class="col-md-12">

                                <img style="height: 500px; width: 500px;" src="../img/barber.jpg" alt="Logo"/>

                            </div>
                        </div>
                        

                        <div class="clearfix"></div>
                    </div>
                </div>

            </div>
            
        </div>
    </div>
</div>

<%@include file="../footer.jsp" %>
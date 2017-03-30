<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="Ivan Dimitry Zyrianoff" content="">
<title>SenSE</title>

<!-- Bootstrap Core CSS -->
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom CSS -->
<link href="resources/css/sb-admin.css" rel="stylesheet">
<!-- Morris Charts CSS -->
<link href="resources/css/plugins/morris.css" rel="stylesheet">
<!-- Custom Fonts -->
<link href="resources/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->

<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<style>
<
meta
 
charset
="utf-8"
>
<
meta
 
http-equiv
="X-UA-Compatible"
 
content
="IE=edge"
>
<
meta
 
name
="viewport"
 
content
="width=device-width
,
initial-scale
=1"
>
</style>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/css/bootstrap-select.min.css">
<script src="resources/js/jquery.js"></script>
<!-- Latest compiled and minified JavaScript -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/js/bootstrap-select.min.js"></script>
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="https://code.highcharts.com/highcharts.src.js"></script>
<script type="text/javascript">
	//ajax for getting messages from the MQTT broker
	function crunchifyAjax() {
		$.ajax({
			url : 'ajaxtest.html',
			success : function(data) {
				$('#result').html(data);
			}
		});
	}

	//$(document).ready( function createChart() {
	function createChart() {

		$.ajax({
			url : 'chart.html',
			success : function(xhr_data) {

				var s = xhr_data.split("/");
				var x = s[0];
				var y = s[1];

				var x_split = x.split(";");
				var y_split = y.split(";");

				x = [];
				y = [];
				var i;

				for (i = 0; i < x_split.length; i++) {
					x.push(x_split[i]);
					y.push(parseInt(y_split[i]));
				}
				//console.log(x);
				//console.log(y);

				//var chart = {
				var title = {
					text : 'Message Control'
				};
				var subtitle = {
					text : 'Aggregates in 10s blocks'
				};
				var xAxis = {
					// 						      categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
					// 						         'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
					categories : x

				};
				var yAxis = {
					title : {
						text : 'Message Qnt'
					},
					plotLines : [ {
						value : 0,
						width : 1,
						color : '#808080'
					} ]
				};

				var tooltip = {
					valueSuffix : ''
				}

				var legend = {
					layout : 'vertical',
					align : 'right',
					verticalAlign : 'middle',
					borderWidth : 0
				};

				var series = [ {
					name : 'messages',
					data : y
				}
				// 						      {
				// 						         name: 'New York',
				// 						         data: [-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8,
				// 						            24.1, 20.1, 14.1, 8.6, 2.5]
				// 						      },
				// 						      {
				// 						         name: 'London',
				// 						         data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 
				// 						            16.6, 14.2, 10.3, 6.6, 4.8]
				// 						      }
				];

				var json = {};

				json.title = title;
				json.subtitle = subtitle;
				json.xAxis = xAxis;
				json.yAxis = yAxis;
				json.tooltip = tooltip;
				json.legend = legend;
				json.series = series;

				$('#container').highcharts(json);
			}
		});
		//close javascript function	  
		//});
	}
</script>



<script type="text/javascript">
	var intervalId = 0;
	intervalId = setInterval(crunchifyAjax, 1000);
	var intervalIdChart = 0;
	intervalIdChart = setInterval(createChart, 10000);
</script>
</head>

<body>
	<div id="wrapper">

		<!-- Navigation -->
		<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-ex1-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand"
					href="${pageContext.request.contextPath}/index">SenSE</a>
			</div>


			<!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
			<div class="collapse navbar-collapse navbar-ex1-collapse">
				<ul class="nav navbar-nav side-nav">
					<li><a href="${pageContext.request.contextPath}/index"><i
							class="fa fa-fw fa-home"></i> Home</a></li>
					<li><a href="${pageContext.request.contextPath}/tutorial"><i
							class="fa fa-fw fa-book"></i> Tutorial</a></li>
					<li><a href="${pageContext.request.contextPath}/settings"><i
							class="fa fa-fw fa-cog"></i> Settings </a></li>
					<li class="active"><a
						href="${pageContext.request.contextPath}/monitoring"><i
							class="fa fa-fw fa-bar-chart-o"></i> Monitoring</a></li>
					<li><a href="${pageContext.request.contextPath}/tecDetails"><i
							class="fa fa-fw fa-edit"></i>Technical Details</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</nav>

		<div id="page-wrapper">

			<div class="container-fluid">

				<!-- Page Heading -->
				<div class="row">
					<div class="col-lg-12">
						<h1 class="page-header">Monitoring</h1>
						<ol class="breadcrumb">
							<li><i class="fa fa-home"></i> <a
								href="${pageContext.request.contextPath}/index">Home</a></li>
							<li class="active"><i class="fa fa-bar-chart-o"></i>
								Monitoring</li>
						</ol>
						<!-- div for graphic style="width: 550px; height: 400px; margin: 0 auto"-->
						<div class="col-lg-6" id="container" name="container"
							style="height: 400px; margin: 0 auto"></div>
						<div class="col-lg-6">
							${info} ${message}
							<div id="result"></div>
						</div>
					</div>
				</div>
				<!-- /.row -->

			</div>
			<!-- /.container-fluid -->

		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->

	<!-- jQuery -->
	<!-- jQuery<script src="resources/js/jquery.js"></script>-->

	<!-- Bootstrap Core JavaScript -->
	<script src="resources/js/bootstrap.min.js"></script>

	<script type="text/javascript">
		
	</script>

</body>

</html>

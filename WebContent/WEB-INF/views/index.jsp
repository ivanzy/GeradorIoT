<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="Ivan Dimitry Zyrianoff" content="">
<title>SenSE</title>
<link href="resources/css/simple-sidebar.css" rel="stylesheet">
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
<!-- jQuery -->
<script src="resources/js/jquery.js"></script>

<!-- Scrolling Nav JavaScript -->
<script src="resources/js/jquery.easing.min.js"></script>

</head>
<body>

	<div id="wrapper" >

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
					<li class="active"><a
						href="${pageContext.request.contextPath}/index"><i
							class="fa fa-fw fa-home"></i> Home</a></li>
					<li><a href="${pageContext.request.contextPath}/tutorial"><i
							class="fa fa-fw fa-book"></i> Tutorial</a></li>
					<li><a href="${pageContext.request.contextPath}/settings"><i
							class="fa fa-fw fa-cog"></i> Settings </a></li>
					<li><a href="${pageContext.request.contextPath}/monitoring"><i
							class="fa fa-fw fa-bar-chart-o"></i> Monitoring</a></li>
					<li ><a href="${pageContext.request.contextPath}/tecDetails"><i
							class="fa fa-fw fa-edit"></i>Technical Details</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</nav>
	<!--  	<div id="page-content-wrapper">-->
			<div id="page-wrapper">

				<div class="container-fluid">

					<!-- Page Heading -->
					<div class="row">
						<div class="col-lg-12">
							<h1 class="page-header">
								Welcome to SenSE <small> Sensor Simulation Environment </small> 
							</h1> 
							<ol class="breadcrumb">
								<li class="active"><i class="fa fa-home"></i> Home</li>
							</ol>
						</div>
					</div>
					<!-- /.row -->
					Hello and welcome to SenSE. SenSE is a powerful tool to generate
					synthetic sensor data, it is able to generate traffic of different
					sensors sending messages simultaneously. It's a testebed for
					platforms that use sensors IoT data. It permits to go further than
					just toy examples and really test a platform in different kind of
					scenarios, specially in Smart Cities environments, in witch we
					already have sensors templates ready to use. SenSE is flexible
					enough that permits the creation of custom sensors. SenSE is able
					to generate traffic of thousands different sensors, being a
					powerful tool to test scalability and performance of IoT platforms.<br>

					<h3>Sensor's Categories</h3>
					SenSE divides sensors int two major groups.<br> -<b>Time
						Driven Sensors</b>: send data periodically to report their status (eg,
					an air quality sensor that sends data every 30 minutes); <br>
					-<b>Event Driven Sensors</b>: send data if its current state
					changes (eg, a presence sensor that only sends data if presence is
					detected).<br>
					
					Those two categories of sensors are important in a testbed, time driven sensors
					 provide a constant flow of data, on the other hand, even driven sensors provide 
					 a data flow with highs and lows.  

					<h3>Sensor's Templates</h3>
					SenSE has templates based on smart cities scenarios. The
					sensor's templates are based on Padova's modeling presented on <a
						href="http://ieeexplore.ieee.org/document/6740844/">Zanella's
						paper "Internet of Things for Smart Cities"</a>. Most of the services
					presented there where adopted in SenSE as sensors's templates, the
					specifications of those sensors is presented below.
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-bordered table-hover table-striped">
								<thead>
									<tr>
										<th>Sensor Template Name</th>
										<th>Service</th>
										<th>Traffic Rate</th>
										<th>Group</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>Air</td>
										<td>Air quality monitoring</td>
										<td>1 message every 30 min per device</td>
										<td>Time driven</td>
									</tr>
									<tr>
										<td>Waste</td>
										<td>Waste management</td>
										<td>1 message every 60 min per device</td>
										<td>Time driven</td>

									</tr>
									<tr>
										<td>Noise</td>
										<td>Noise monitoring</td>
										<td>1 message every 30 min per device</td>
										<td>Time driven</td>
									</tr>
									<tr>
										<td>Structural</td>
										<td>Structural health</td>
										<td>1 message every 10 min per device</td>
										<td>Time driven</td>
									</tr>
									<tr>
										<td>Traffic</td>
										<td>Traffic congestion</td>
										<td>1 message every 10 min per device</td>
										<td>Time driven</td>
									</tr>
									<tr>
										<td>Flow Of People*</td>
										<td>smart control of actuators</td>
										<td>On Demand</td>
										<td>Event driven</td>
									</tr>
								</tbody>
							</table>
						</div>
						*this sensor is not on Padova's model, however it fits well in a smart city environment. The section below explain how this type of
						sensor works.
					</div>
					<h3>Event Driven Challenge</h3>
					Event driven sensors require a change of state to send a message, this kind of behavior is not simple to simulate 
					in a authentic way. Considering a smart city environment, was modeled sensors that 
					were triggered by human behavior, specially, the arrival of people to certain events 
					(eg, people arriving in a stadium to watch a football game), and the arrival of each
					individual person would trigger a sensor. The probability distribution that model such events is a
					Poisson. Therefore, the time between messages of event driven sensor are generate by a exponential distribution, with 
					the lambda parameter defined by the user (arrival rate on settings). Furthermore, observing 
					the mode of people arrival at events we identified that the arrival rate of 
					persons to a event change in three periods of time: <br>
					1) Beginning: some people arrive a little early, others, on time or a little late;<br>
					2) Middle: some people that are really late or people leaving early;<br>
					3) End: at the end of the event, everybody tends to get out almost immediately<br>
					In an experiment using SenSE, it is possible to get this kind of behavior using the Event Sensor Template "Flow Of People"", 
					that automatically changes the arrival rate, according to the time of the event. In the creation of a new event driven sensor
					it is possible to choose to this behavior, just choose "variable" on the "Arrival Rate Mode" option, if "continous" is choosen, 
					it does not change the lambda parameter in the experiment.
					<br>
					<img class="img-responsive" src="<%=request.getContextPath()%>/resources/images/poisson.png"/>
					<br>
					
					<h3>Message Structure</h3>
					The message structure is based on real structure, used on <a href="http://impressproject.eu/">IMPReSS project</a>. It is: 
					<code>type=sensorType;resource=sensorID;message=sensorMessage;P1=timestamp;</code>. <br>
					
					 
					
					<h3> SenSE's GUI map</h3>
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-bordered table-hover table-striped">
								<thead>
									<tr>
										<th>Page</th>
										<th>Content</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><a href="${pageContext.request.contextPath}/index">Index</a></td>
										<td>basics about SenSE</td>
									</tr>
									<tr>
										<td><a href="${pageContext.request.contextPath}/tutorial">Tutorial</a></td>
										<td>some tutorials to get you started</td>
									</tr>
									<tr>
										<td><a href="${pageContext.request.contextPath}/settings">Setting</a></td>
										<td>configurations and start control of the experiments</td>
									</tr>
									<tr>
										<td><a
											href="${pageContext.request.contextPath}/tecDetails">Technical
												Details</a></td>
										<td>technical details about SenSE, some parts that are presented on home page are detailed</td>
									</tr>
									<tr>
										<td><a
											href="${pageContext.request.contextPath}/monitoring">Monitoring</a></td>
										<td>monitore the current running experiment</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
	<!--  	</div>-->
		<!-- /.row -->

	</div>
	<!-- /.container-fluid -->

	</div>
	<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->
	</div>


	<!-- Bootstrap Core JavaScript -->
	<script src="resources/js/bootstrap.min.js"></script>

	<!-- Morris Charts JavaScript -->
	<script src="resources/js/plugins/morris/raphael.min.js"></script>
	<script src="resources/js/plugins/morris/morris.min.js"></script>
	<script src="resources/js/plugins/morris/morris-data.js"></script>

</body>

</html>

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
					<li><a href="${pageContext.request.contextPath}/monitoring"><i
							class="fa fa-fw fa-bar-chart-o"></i> Monitoring</a></li>
					<li class="active"><a
						href="${pageContext.request.contextPath}/tecDetails"><i
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
						<h1 class="page-header">Technical Details</h1>
						<ol class="breadcrumb">
							<li><i class="fa fa-home"></i> <a
								href="{pageContext.request.contextPath}/index"> Home</a></li>
							<li class="active"><i class="fa fa-fw fa-edit"></i>Technical
								Details</a></li>
						</ol>


						<h4>1) Templates</h4>
						SenSE has templates based on smart cities scenarios. The sensor's
						templates are based on Padova's modeling presented on <a
							href="http://ieeexplore.ieee.org/document/6740844/">Zanella's
							paper "Internet of Things for Smart Cities"</a>. Most of the services
						presented there where adopted in SenSE as sensors's templates, the
						specifications of those sensors is presented below. In Zanella's
						paper it is not specify the payload of the sensors, so, they were
						defined after a quick research. Of course that the payload varies
						from sensor to sensor, so we fill them with some random data, just
						to simulate they behavior.

						<div class="panel-body">
							<div class="table-responsive">
								<table style="font-size: 12px; line-height: 1.228;"
									class="table  table-hover table-striped table-sm">
									<thead>
										<tr>
											<th>Sensor Template</th>
											<th>Service</th>
											<th>Traffic Rate</th>
											<th>Group</th>
											<th>Payload</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>Air</td>
											<td>Air quality monitoring</td>
											<td>1 message every 30 min per device</td>
											<td>Time driven</td>
											<td>6 random numbers from 0.0 to 100.0</td>
										</tr>
										<tr>
											<td>Waste</td>
											<td>Waste management</td>
											<td>1 message every 60 min per device</td>
											<td>Time driven</td>
											<td>1 random percent (0.0 to 1.0)</td>
										</tr>
										<tr>
											<td>Noise</td>
											<td>Noise monitoring</td>
											<td>1 message every 30 min per device</td>
											<td>Time driven</td>
											<td>1 random integer from 0 to 300</td>
										</tr>
										<tr>
											<td>Structural</td>
											<td>Structural health</td>
											<td>1 message every 10 min per device</td>
											<td>Time driven</td>
											<td>7 random numbers from 0.0 to 100.0</td>
										</tr>
										<tr>
											<td>Traffic</td>
											<td>Traffic congestion</td>
											<td>1 message every 10 min per device</td>
											<td>Time driven</td>
											<td>20 random numbers from 0.0 to 100.0</td>
										</tr>
										<tr>
											<td>Flow Of People*</td>
											<td>smart control of actuators</td>
											<td>On Demand</td>
											<td>Event driven</td>
											<td>"on" or "off"</td>
										</tr>
									</tbody>
								</table>
							</div>
							*this sensor is not on Padova's model, however it fits well in a
							smart city environment. The section below explain how this type
							of sensor works.
						</div>

						<h4>2)Message Structure</h4>
						The message structure is based on real structure, used on <a
							href="http://impressproject.eu/">IMPReSS project</a>. It is:
						<code>type=sensorType;resource=sensorID;message=sensorMessage;P1=timestamp;</code>
						. <br>

						<h4>2) Time Driven Sensors</h4>
						Time driven sensors send a message based on their periodicity.
						When a experiment starts running with a certain number of time
						driven sensors with the same type, they start time are a random
						value between 0 and the periodicity value. In other words, between
						experiment time zero and experiment time according to the
						periodicity of the sensor, all sensors will have already sent a
						message. SenSE permits to run experiments even if the time of the
						experiment is less than the periodicity of the sensor, in that
						case, some sensor will not send a message.<br>

						<h4>4) Event Driven Sensors</h4>
						Event driven sensors require a change of state to send a message,
						this kind of behavior is not simple to simulate in a authentic
						way. Considering a smart city environment, was modeled sensors
						that were triggered by human behavior, specially, the arrival of
						people to certain events (eg, people arriving in a stadium to
						watch a football game), and the arrival of each individual person
						would trigger a sensor. The probability distribution that model
						such events is a Poisson. Therefore, the time between messages of
						event driven sensor are generate by a exponential distribution,
						with the lambda parameter defined by the user (arrival rate on
						settings). Furthermore, observing the mode of people arrival at
						events we identified that the arrival rate of persons to a event
						change in three periods of time: <br> 1) Beginning: some
						people arrive a little early, others, on time or a little late;<br>
						2) Middle: some people that are really late or people leaving
						early;<br> 3) End: at the end of the event, everybody tends
						to get out almost immediately<br> In an experiment using
						SenSE, it is possible to get this kind of behavior using the Event
						Sensor Template "Flow Of People"", that automatically changes the
						arrival rate, according to the time of the event. The duration of
						a simulate event is 2/3 of the time of the experiment, this means
						that once you run your experiment, event sensors with variable
						arrival rate are not going to start sending messages right away,
						in the beginning of the experiment will be random selected to the
						event to start. <br> <img class="img-responsive"
							src="<%=request.getContextPath()%>/resources/images/poisson.png" />
						<br>
						<h4>4.1) New Event Driven Sensor</h4>
						One field that may cause some confusion is the Arrival Rate Mode.
						If you choose "continuous" the sensor will send messages according
						to the arrival rate value specified on the arrival rate value
						field. If you choose "variable" the sensor will follow the
						behavior like the template event sensor, with the variable 
						arrival rate according to the experiment time.

						<h4>5) Creation of new Sensors</h4>
						The creation of new sensors differs from template sensors in the
						custom periodicity/arrival rate (depends if the sensor is time
						driven or event driven) and that when you create a new sensor you
						can choose the data type that will be sent in the payload,
						furthermore, you can define a max and min value for them.
						<h4>6) BooleanText</h4>
						One data type that is not a typical one is the BooleanText. This
						type selects randomly between the max and min fields. For example,
						if you choose BooleanText as the data type and you fill max with
						"P=NP" and min with "P!=NP" and run the experiment, in each
						message the payload will be selected randomly: "P=NP" or "P!=NP".




					</div>
				</div>
			</div>
		</div>
		                        <!-- jQuery -->
	<script src="resources/js/jquery.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="resources/js/bootstrap.min.js"></script>
</body>
</html>
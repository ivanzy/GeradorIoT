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
					<li class="active"><a
						href="${pageContext.request.contextPath}/tutorial"><i
							class="fa fa-fw fa-book"></i> Tutorial</a></li>
					<li><a href="${pageContext.request.contextPath}/settings"><i
							class="fa fa-fw fa-cog"></i> Settings </a></li>
					<li><a href="${pageContext.request.contextPath}/monitoring"><i
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
						<h1 class="page-header">Tutorial</h1>
						<ol class="breadcrumb">
							<li><i class="fa fa-home"></i> <a
								href="{pageContext.request.contextPath}/index"> Home</a></li>
							<li class="active"><i class="fa fa-book"></i> Tutorial</li>
						</ol>
						So nice to have you around here! Let's take a quick tour on SenSE.

						<h2>Requirements</h2>
						SenSE sends messages through a IoT application layer protocol,
						MQTT. It's a publish/subscribe protocol and it requires a broker,
						for more info go to <a href="http://mqtt.org/">MQTT Web Page</a>.<br>
						<b>- If you want to test in a local network or on you computer</b>,
						you can easily install <a href="https://mosquitto.org/">Mosquitto
							broker</a>. A good instalation tutorial for Ubuntu distro can be
						found <a href="https://mosquitto.org/">here</a>.<br> <b>-
							If you dont want to install a MQTT broker</b>, you can use a want
						publically-accessible MQTT brokers. We recommend
						<code>iot.eclipse.org</code>
						, it's a mosquitto broker and run on MQTT default port (1883). <br>

						<h2>Tutorial #1 - The Hello World</h2>
						SenSE is a pretty easy to use, let's run a hello world on the
						tool. In this tutorial, we are going to do an experiment with one
						of the templates that the platform already has. For this, you have
						to go to the <a href="${pageContext.request.contextPath}/settings">Settings</a>
						page. There you need configure everything about your experiment,
						and press the button RUN for the experiment to start. In Network
						Settings you need to specify an IP address and port of the MQTT
						broker. In this address that the sensors's messages will be sent.
						If you are using eclipse's public broker, just set
						<code>iot.eclipse.org</code>
						as the IP address and 1883 as the port .<br> In Experiment
						Settings we configure some general specifications about our
						experiment. Experiment's Name is the name of your experiment, it
						is used in the monitoring page once the experiment is running and
						it is the file name of the log file, let's name our first
						experiment as HelloWorld. The Experiment's time is the amount of
						time you want the experiment to last, you can choose the unit of
						time as well (seconds, minutes or hours). In this tutorial, set
						this experiment to 60 seconds (or 1 minute). If you want to
						generate a log file of the experiment (it contains all the
						massages sent, as well as the timestamp of each one). The log file
						is very important for more serious experiments, the info in the
						log, gathered with some other data (generated by the platform that
						you want to test) can give important information about the
						scalability and performance of the platform tested. <br> In
						our hello world example, we are going to generate log, if you
						want, you can specify a path for the log file in "Path for saving
						files" form, if you don't specify a path, the file will be save on
						the /bin of Apache. Now we have the Sensor Settings, for more
						information on the meanings of each form, go to <a
							href="${pageContext.request.contextPath}/tecDetails">Technical
							Details</a>. In this experiment, we are going to instanciate just one
						type of sensor. Go to Template Time Driven Sensor and choose a
						type, define a topic, in which the messages will be publish, and a
						number of sensors of that type. In this tutorial, we will choose
						1.000 of sensors. Now you are all set, just click on RUN and the
						experiment will begin. After that, you will be redirect to the
						monitoring page, there you can see some infos about your
						experiment. A table is presented with the last messages sent, The
						graph shows the total number of messages sent every 10 seconds.
						Any time you can stop the experiment, just hitting the big red
						button that says stop experiment.<br> With the experiment
						running, let's check if the messages are being really sent. For
						this, you need to have mosquitto client on your pc, a good ubuntu
						instalation tutorial can be found <a
							href="https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-the-mosquitto-mqtt-messaging-broker-on-ubuntu-16-04">here</a>.
						Just type on terminal:<br>
						<code> mosquitto_sub -h ip_address -t your_topic</code>
						<br> There you will see the messages sent by SenSE.

						<h2>Tutorial #2 - Starting with Event Driven Sensors</h2>
						Event Driven Sensors behavior is explain in <a
							href="${pageContext.request.contextPath}/tecDetails">Technical
							Details</a> and in <a href="${pageContext.request.contextPath}/index">Home</a>,
						you should read them first.<br> Now that you already know how
						event driven sensors work let's configure a new experiment with
						them. Set the Network Settings and the Experiment Settings as you
						wish, now go to Template Event Driven Sensors and choose a topic a
						a arrival rate, the unit is msg per seconds (with a random
						exponential time between messages). Now press RUN. In monitoring
						the messages are not going to start right away, because the
						simulated event has not started (the fake event has duration of
						2/3 time of experiment). During this experiment, you are going to
						realize the three different periods of our fake event:<br> 1)
						Beginning: some people arrive a little early, others, on time or a
						little late;<br> 2) Middle: some people that are really late
						or people leaving early;<br> 3) End: at the end of the event,
						everybody tends to get out almost immediately.<br>

						<h2>Tutorial #3 - Creating New Sensors</h2>
						To create new custom sensors, go to new Event driven Sensors and
						fill the forms as you desire, hit run and your new sensor will
						appear on the table on monitoring. If you wanna double check, go
						to terminal and subscribe to the topic that you specify.

						<h2>Tutorial #4 - Multiple Sensors Experiment</h2>
						SenSE is able to do experiments with multiple sensors. Try to run
						a experiment with two different template time driven sensors (just
						press + to create a new line), two new time driven events and a
						new event driven sensor. Now you are all set to do your own experiments! 
					



					</div>
				</div>
			</div>
		</div>
</body>
</html>
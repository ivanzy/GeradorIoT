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
<script type="text/javascript">
	// 	function changeUnit() {
	// 		$('.selectpicker').on('change', function(){
	// 	  		var selected = $(this).find("option:selected").val();
	//   			if(selected=="minutes"){
	//   				document.getElementById("timeOfExp").value*=60;
	//   			}	
	//   			else if(selected=="hours"){
	// 	  			document.getElementById("timeOfExp").value*=3600;
	//   			}
	//   				alert(document.getElementById("timeOfExp").value);
	// 			});
	// 		};

	$('.selectpicker').selectpicker({});

	var accEDT = 1;
	function newEventDrivenTemplateLine() {
		accEDT++;
		var part1 = "<tr><td id=\"campoTEDA" + accEDT + "\"><p class=\"form-control-static\">Flow of People</p><input type=\"hidden\" id=\"lightSensor"+accEDT+"\" name=\"lightSensor"+accEDT+"\" value=\"lightSensor"+accEDT+"\" /></td>";
		var part2 = "<td id=\"campoTEDB"+accEDT+"\"><input name=\"topicTED"+accEDT+"\" type=\"text\" id=\"topicTED"+accEDT+"\" class=\"form-control\" /></td>";
		var part3 = "<td id=\"campoTEDC"+accEDT+"\"><input name=\"lambda"+accEDT+"\" type=\"number\"  min=\"1\" id=\"lambda"+accEDT+"\" class=\"form-control\" /></td>";
		var part4 = "<td id=\"removeLine"+accEDT+"\"><button type=\"button\" class=\"btn btn-default\" value=\"deletar\" onClick=\"javascript:removeLine('removeLine"
				+ accEDT + "')\" aria-label=\"Right Align\">";
		var part5 = "<span class=\"glyphicon glyphicon-minus\" aria-hidden=\"true\"></span> </button> </td>";
		document.getElementById("templateEventSensor").innerHTML += part1
				+ part2 + part3 + part4 + part5;
		document.getElementById("templateEventSensor").innerHTML += "</tr>";
	}

	var accTDT = 1;
	function newTimeDrivenTemplateLine() {
		accTDT++;
		var part1 = "<tr><td id=\"campoTTDA" + accTDT + "\"><select class=\"form-control\" title=\"Sensor Templates\" id=\"sensorTemplates"+accTDT+"\" name=\"sensorTemplates\">";
		var op1 = "\n <option value=\"\" disabled selected>SensorTemplates</option>";
		var op2 = "\n <option value=\"air\">air</option>";
		var op3 = "\n <option value=\"waste\">waste</option>";
		var op4 = "\n <option value=\"noise\">noise</option>";
		var op5 = "\n <option value=\"structural\">structural</option>";
		var op6 = "\n <option value=\"traffic\">traffic</option></select></td>";
		var part2 = "<td id=\"campoTTDB"+accTDT+"\"><input name=\"topicTTD\" type=\"text\" id=\"topicTTD"+accTDT+"\" class=\"form-control\" /></td>";
		var part3 = "<td id=\"campoTTDC"+accTDT+"\"><input name=\"numberOfDevicesT\" type=\"number\"  min=\"1\" id=\"numberOfDevicesT"+accTDT+"\" class=\"form-control\" /></td>";
		var part4 = "<td id=\"removeLine"+accTDT+"\"><button type=\"button\" class=\"btn btn-default\" value=\"deletar\" onClick=\"javascript:removeLine('removeLine"
				+ accTDT + "')\" aria-label=\"Right Align\">";
		var part5 = "<span class=\"glyphicon glyphicon-minus\" aria-hidden=\"true\"></span> </button> </td>";
		document.getElementById("templateTimeSensor").innerHTML += part1
				+ (op1 + op2 + op3 + op4 + op5 + op6) + part2 + part3 + part4
				+ part5;
		document.getElementById("templateTimeSensor").innerHTML += "</tr>";
	}

	var accTD = 1;
	function newTimeDrivenLine() {
		accTD++;
		var part1 = "<tr><td id=\"campoTDA" + accTD + "\"><input name=\"sensorType"+accTD+"\" type=\"text\" id=\"sensorType"+accTD+"\" class=\"form-control\" /></td>";
		var part2 = "<td id=\"campoTDB"+accTD+"\"><input name=\"topicTD"+accTD+"\" type=\"text\" id=\"topicTD"+accTD+"\" class=\"form-control\" /></td>";
		var part3 = "<td id=\"campoTDC"+accTD+"\"><input name=\"numberOfDevices"+accTD+"\" type=\"number\"  min=\"1\" id=\"numberOfDevices"+accTD+"\" class=\"form-control\" /></td>";
		var part4 = "<td id=\"campoTDD"+accTD+"\"><div class=\"input-group\"><input name=\"periodicity"+accTD+"\" type=\"number\" min=\"1\" id=\"periodicity"+accTD+"\" class=\"form-control\" /><div class=\"input-group-btn\"></div>";
		var part4_2 = "<select style=\"width: 62px\" class=\"form-control\" id=\"c_periodicity"+accTD+"\" name=\"c_periodicity"+accTD+"\">";

		var opt1 = "\n <option value=\"min\">min</option>";
		var opt2 = "\n <option value=\"s\">s</option></select></div></td>";

		var part5 = "<td id=\"campoTDE1"+accTD+"\"><select class=\"form-control\" title=\"Data Type\" id=\"dataType1"+accTD+"\" name=\"dataType1"+accTD+"\">";
		var op1 = "\n <option>int</option>";
		var op2 = "\n <option>float</option>";
		var op3 = "\n <option>boolean</option>";
		var op4 = "\n <option>booleanText</option>";
		var op5 = "\n <option>char</option></select></td>";
		var part6 = "<td id=\"campoTDF1"+accTD+"\"><div class=\"input-group\"><span class=\"input-group-addon\"> <input id=\"c_max1"
				+ accTD
				+ "\" type=\"checkbox\" aria-label=\"...\" onClick=\"javascript:toggleForm('max1"
				+ accTD
				+ "')\"></span><input name=\"max1"+accTD+"\" type=\"text\" id=\"max1"+accTD+"\" class=\"form-control\" disabled /></div></td>";
		var part7 = "<td id=\"campoTDG1"+accTD+"\"><div class=\"input-group\"><span class=\"input-group-addon\"> <input id=\"c_min1"
				+ accTD
				+ "\" type=\"checkbox\" aria-label=\"...\" onClick=\"javascript:toggleForm('min1"
				+ accTD
				+ "')\"></span><input name=\"min1"+accTD+"\" type=\"text\" id=\"min1"+accTD+"\" class=\"form-control\" disabled /></div></td>";
		var part8 = "<td id=\"removeLine"+accTD+"\"><button type=\"button\" class=\"btn btn-default\" value=\"deletar\" onClick=\"javascript:removeLine('removeLine"
				+ accTD + "')\" aria-label=\"Right Align\">";
		var part9 = "<span class=\"glyphicon glyphicon-minus\" aria-hidden=\"true\"></span> </button> </td>";
		document.getElementById("newTimeSensor").innerHTML += part1 + part2
				+ part3 + part4 + part4_2 + (opt1 + opt2) + part5
				+ (op1 + op2 + op3 + op4 + op5) + part6 + part7 + part8 + part9;
		document.getElementById("newTimeSensor").innerHTML += "</tr>";
	}

	var accED = 1;
	function newEventDriveLine() {
		accED++;
		var part1 = "<tr><td id=\"campoEDA" + accED + "\"><input name=\"sensorTypeE"+accED+"\" type=\"text\" id=\"sensorTypeE"+accED+"\" class=\"form-control\" /></td>";
		var part2 = "<td id=\"campoEDB"+accED+"\"><input name=\"topicED"+accED+"\" type=\"text\" id=\"topicED"+accED+"\" class=\"form-control\" /></td>";
		var part3 = "<td id=\"campoEDC"+accED+"\"><select class=\"form-control\" title=\"Arrival Rate Mode\" id=\"arrivalMode"+accED+"\" name=\"arrivalMode"+accED+"\">";
		var op = "<option>continuous</option> <option>variable</option> </select></td>";
		var part4 = "<td id=\"campoEDD"+accEDT+"\"><input name=\"lambdaE"+accED+"\" type=\"number\"  min=\"1\" id=\"lambdaE"+accED+"\" class=\"form-control\" /></td>";
		//var part5 = "<td id=\"campoEDE" + accED + "\"><input name=\"duration"+accED+"\" type=\"number\" min=\"1\" id=\"duration"+accED+"\" class=\"form-control\" /></td>";

		var part6 = "<td id=\"campoEDF1"+accED+"\"><select class=\"form-control\" title=\"Data Type\" id=\"dataTypeE1"+accED+"\" name=\"dataTypeE1"+accED+"\">";
		var op1 = "\n <option>int</option>";
		var op2 = "\n <option>float</option>";
		var op3 = "\n <option>boolean</option>";
		var op4 = "\n <option>booleanText</option>";
		var op5 = "\n <option>char</option></select></td>";
		var part7 = "<td id=\"campoEDG1"+accED+"\"><div class=\"input-group\"><span class=\"input-group-addon\"> <input id=\"c_maxE1"
				+ accED
				+ "\" type=\"checkbox\" aria-label=\"...\" onClick=\"javascript:toggleForm('maxE1"
				+ accED
				+ "')\"></span><input name=\"maxE1"+accED+"\" type=\"text\" id=\"maxE1"+accED+"\" class=\"form-control\" disabled /></div></td>";

		var part8 = "<td id=\"campoEDH1"+accED+"\"><div class=\"input-group\"><span class=\"input-group-addon\"> <input id=\"c_minE1"
				+ accED
				+ "\" type=\"checkbox\" aria-label=\"...\" onClick=\"javascript:toggleForm('minE1"
				+ accED
				+ "')\"></span><input name=\"minE1"+accED+"\" type=\"text\" id=\"minE1"+accED+"\" class=\"form-control\" disabled /></div></td>";
		var part9 = "<td id=\"removeLine"+accED+"\"><button type=\"button\" class=\"btn btn-default\" value=\"deletar\" onClick=\"javascript:removeLine('removeLine"
				+ accED + "')\" aria-label=\"Right Align\">";
		var part10 = "<span class=\"glyphicon glyphicon-minus\" aria-hidden=\"true\"></span> </button> </td>";
		document.getElementById("newEventSensor").innerHTML += part1 + part2
				+ part3 + op + part4 + part6 + (op1 + op2 + op3 + op4 + op5)
				+ part7 + part8 + part9 + part10;
		document.getElementById("newEventSensor").innerHTML += "</tr>";
	}

	function removeLine(id) {
		teste = document.getElementById(id);
		if (id == "newTimeSensor")
			accTD--;
		else if (id == "templateTimeSensor")
			accTDT--;
		else if (id == "templateEventSensor")
			accEDT--;
		else if (id == "newEventSensor")
			accED--;
		teste.parentNode.parentNode.removeChild(teste.parentNode);
	}

	var fakeArray1 = "";
	function setTemplateTimeDrivenSensors() {
		var i;
		for (i = 0; i < accTDT; i++) {
			fakeArray1 += document.getElementById("sensorTemplates" + (i + 1)).value
					+ ";";
			fakeArray1 += document.getElementById("topicTTD" + (i + 1)).value
					+ ";";
			fakeArray1 += document.getElementById("numberOfDevicesT" + (i + 1)).value
					+ ";";
		}
		document.getElementById("thisIsNotAString1").value = fakeArray1;
	}

	var fakeArray2 = "";
	function setTemplateEventDrivenSensors() {
		var i;
		for (i = 0; i < accEDT; i++) {
			fakeArray2 += document.getElementById("topicTED" + (i + 1)).value
					+ ";";
			fakeArray2 += document.getElementById("lambda" + (i + 1)).value
					+ ";";
		}
		document.getElementById("thisIsNotAString2").value = fakeArray2;
	}

	var fakeArray3 = "";
	function setNewTimeDrivenSensors() {
		var i;
		for (i = 0; i < accTD; i++) {
			fakeArray3 += document.getElementById("sensorType" + (i + 1)).value
					+ ";";
			fakeArray3 += document.getElementById("topicTD" + (i + 1)).value
					+ ";";
			fakeArray3 += document.getElementById("periodicity" + (i + 1)).value
					+ ";";
			fakeArray3 += document.getElementById("numberOfDevices" + (i + 1)).value
					+ ";";
			fakeArray3 += document.getElementById("dataType1" + (i + 1)).value
					+ ";";
			fakeArray3 += document.getElementById("max1" + (i + 1)).value + ";";
			fakeArray3 += document.getElementById("min1" + (i + 1)).value + ";";
		}
		document.getElementById("thisIsNotAString3").value = fakeArray3;
	}

	var fakeArray4 = "";
	function setNewEventDrivenSensors() {
		var i;
		for (i = 0; i < accED; i++) {
			fakeArray4 += document.getElementById("sensorTypeE" + (i + 1)).value
					+ ";";
			fakeArray4 += document.getElementById("topicED" + (i + 1)).value
					+ ";";
			fakeArray4 += document.getElementById("arrivalMode" + (i + 1)).value
					+ ";";
			fakeArray4 += document.getElementById("lambdaE" + (i + 1)).value
					+ ";";
			//fakeArray4 += document.getElementById("duration" + (i + 1)).value+ ";";
			fakeArray4 += document.getElementById("dataTypeE1" + (i + 1)).value
					+ ";";
			fakeArray4 += document.getElementById("maxE1" + (i + 1)).value
					+ ";";
			fakeArray4 += document.getElementById("minE1" + (i + 1)).value
					+ ";";
		}
		document.getElementById("thisIsNotAString4").value = fakeArray4;
	}
	function formatTimeOfExperiment() {
		if (document.getElementById("unit").value == "minutes")
			document.getElementById("timeOfExp").value *= 60;
		else if (document.getElementById("unit").value == "hours")
			document.getElementById("timeOfExp").value *= 3600;
	}
	function formatPeriodicity() {
		var i;
		for (i = 0; i < accTD; i++) {
			if (document.getElementById("c_periodicity" + (i + 1)).value == "min")
				document.getElementById("periodicity" + (i + 1)).value *= 60;
		}
	}
	function formatFakeArrays() {
		formatTimeOfExperiment();
		formatPeriodicity();
		setTemplateEventDrivenSensors();
		setTemplateTimeDrivenSensors();
		setNewTimeDrivenSensors();
		setNewEventDrivenSensors();
	}

	function toggleForm(id) {
		document.getElementById(id).disabled = !(document.getElementById(id).disabled);
	}

	function validate() {

		var row1 = false, row2 = false, row3 = false, row4 = false, error = false, config = false;
		var messages = [];

		var ip = document.getElementById("ip");
		var port = document.getElementById("port");

		//fist row
		var sensorTemplates1 = document.getElementById("sensorTemplates1");
		var ttd1 = document.getElementById("topicTTD1");
		var numberOfDevicesT1 = document.getElementById("numberOfDevicesT1");

		//second row
		var ted1 = document.getElementById("topicTED1");
		var lambda = document.getElementById("lambda1");

		//thirty row
		var sensorType1 = document.getElementById("sensorType1");
		var topicTD1 = document.getElementById("topicTD1");
		var numberOfDevices1 = document.getElementById("numberOfDevices1");
		var periodicity1 = document.getElementById("periodicity1");

		//4-th row
		var sensorTypeE1 = document.getElementById("sensorTypeE1");
		var topicED1 = document.getElementById("topicED1");
		var arrivalMode1 = document.getElementById("arrivalMode1");
		var lambdaE1 = document.getElementById("lambdaE1");
		//var duration1 = document.getElementById("duration1");
		var dataTypeE11 = document.getElementById("dataTypeE11");

		var valid = true;

		if (ip.value.length <= 0) {
			messages.push("Don't leave the ip field empty!");
			valid = false;
			error = true;
		} else if (port.value.length <= 0) {
			messages.push("Don't leave the port field empty!");
			valid = false;
			error = true;
		} else if (isNaN(port.value)) {
			messages.push("Enter a port number!");
			valid = false;
			error = true;
		} else if (nameExp.value.length <= 0) {
			messages.push("Don't leave the name of experiment field empty!");
			valid = false;
			error = true;
		}

		else if (timeOfExp.value.length <= 0) {
			messages.push("Don't leave the time of experiments field empty!");
			valid = false;
			error = true;
		}

		else if (isNaN(timeOfExp.value)) {
			messages.push("Enter a time of experiments number!");
			valid = false;
			error = true;
		}

		else {
			config = true;
		}

		//check row one

		if (ttd1.value.length > 0 && sensorTemplates1.value.length > 0
				&& numberOfDevicesT1.value.length > 0) {

			if (isNaN(numberOfDevicesT1.value)) {
				//messages.push("Enter a port number in number of devices!");
				messages.push("Enter a port number in number of devices!");
				valid = false;
				row1 = false;
				error = true;
			} else {
				row1 = true;
			}

			//messages.push("Don't leave the Time Driven field empty!");
			//valid = false;
		}

		//check row one
		if (row1 == false) {
			if (sensorTemplates1.value.length <= 0) {
				messages.push("Choose a time driven template sensor");
				valid = false;
				error = true;
			} else if (ttd1.value.length <= 0) {
				messages.push("Enter a time driven MQTT topic");
				valid = false;
				error = true;
			} else if (numberOfDevicesT1.value.length <= 0) {
				messages.push("Enter a time driven number of devices");
				valid = false;
				error = true;
			}
		}

		//row 2
		//check row two
		if (ted1.value.length > 0 && lambda.value.length > 0) {

			if (isNaN(lambda.value)) {
				messages.push("Arrival Rate is a numeric value!");
				valid = false;
				row2 = false;
				error = true
			} else {
				row2 = true;
			}

			//messages.push("Don't leave the Time Driven field empty!");
			//valid = false;
		}

		//row two
		if (row2 == false) {
			if (ted1.value.length <= 0) {
				messages.push("Enter a event driven MQTT topic");
				valid = false;
				error = true;
			} else if (lambda.value.length <= 0) {
				messages.push("Don't leave the arrival rate fiel empty!");
				valid = false;
				error = true;
			}

		}

		//row 3
		//check row three
		if (sensorType1.value.length > 0 && topicTD1.value.length > 0
				&& numberOfDevices1.value.length > 0
				&& periodicity1.value.length > 0) {

			if (isNaN(numberOfDevices1.value)) {
				messages
						.push("Enter a new time driven number of devices value!");
				valid = false;
				row3 = false;
				error = true;
			} else if (isNaN(periodicity1.value)) {
				messages.push("Enter a periodicity numeric value!");
				valid = false;
				error = true;
				row3 = false;
			} else {
				row3 = true;
			}

			//messages.push("Don't leave the Time Driven field empty!");
			//valid = false;
		}

		//row three
		if (row3 == false) {
			if (sensorType1.value.length <= 0) {
				messages.push("Choose a new time driven template sensor");
				valid = false;
				error = true;
			} else if (topicTD1.value.length <= 0) {
				messages
						.push("Don't leave the new time driven MQTT topic field empty!");
				valid = false;
				error = true;
			} else if (numberOfDevicesT1.value.length <= 0) {
				messages
						.push("Don't leave the new time driven number of devices field empty!");
				valid = false;
				error = true;
			} else if (periodicity1.value.length <= 0) {
				messages
						.push("Don't leave the new time driven periodicity field empty!");
				valid = false;
				error = true;
			}

		}

		var sensorTypeE1 = document.getElementById("sensorTypeE1");
		var topicED1 = document.getElementById("topicED1");
		var arrivalMode1 = document.getElementById("arrivalMode1");
		var periodicity1 = document.getElementById("lambdaE1");
		//var duration1 = document.getElementById("duration1");
		var dataTypeE11 = document.getElementById("dataTypeE11");

		//row 4
		//check row four
		if (sensorTypeE1.value.length > 0 && topicED1.value.length > 0
				&& arrivalMode1.value.length > 0
				&& lambdaE1.value.length > 0
				&& dataTypeE11.value.length > 0) {

			if (isNaN(periodicity1.value)) {
				messages.push("Enter a new event driven periodity value!");
				valid = false;
				row4 = false;
				error = true;

			} else {
				row4 = true;
			}

			//messages.push("Don't leave the Time Driven field empty!");
			//valid = false;
		}

		//row 4
		if (row4 == false) {
			if (sensorTypeE1.value.length <= 0) {
				messages.push("Choose a new event driven template sensor");
				valid = false;
				error = true;
			} else if (topicED1.value.length <= 0) {
				messages
						.push("Don't leave the new event driven MQTT topic field empty!");
				valid = false;
				error = true;
			} else if (arrivalMode1.value.length <= 0) {
				messages
						.push("Don't leave the new event driven arrival model field empty!");
				valid = false;
				error = true;
			} else if (periodicity1.value.length <= 0) {
				messages
						.push("Don't leave the new event driven periodic field empty!");
				valid = false;
				error = true;
			}

		}
		console.log('1 ' + row1);
		console.log('2 ' + row1);
		console.log('3 ' + row1);
		console.log('4 ' + row1);
		console.log(messages);

		if (config == true
				&& (row1 == true || row2 == true || row3 == true || row4 == true)) {
			valid = true;
		}

		else if (row1 == false && row2 == false && row3 == false
				&& row4 == false) {
			messages.push("Check the configs please!");
			var m = '', j;
			for (j = 0; j < messages.length; j++) {
				m = m.concat(messages[j]);
				m = m.concat('\n');
			}
			alert(m);
			valid = false;
		}

		return valid;
	};
	function help_network() {
		alert("Here you can set all configuration about the experiments and the network.\n\n"
				+ "MQTT Broker IP address is the IP address where the MQTT broker is deployed.\n\n "
				+ "Port is number of the port of MQTT broker which you can publish and subscrive messages \n\n");

	};
	function help_exp(){
		alert("Experiment's name will be used as the name of the log file and in the monitoring page.\n\n"
				+ "Experiment's duration is the duration of the experiment, you can choose the time unit.\n\n"
				+ "check Generate Log File if you want to generate a log of the messages sent, the default path is /bin"+
				" of Apache. If you want to save in a different path, set a new path on Path to save files");
		
	};

	function help_ttd() {
		alert("Time Driven Sensors Templates configurations are presented in details in Technical Details page. \n\n"
				+ "Topic is the mqtt topic that this sensor will send messages \n\n"
				+ "Number of devices is the number of sensors with this configurations that you want in your experiment\n\n"
				);
	};
	function help_ted() {
		alert("Event Driven Sensors Templates configurations are presented in details in Technical Details page. \n\n"
				+ "Topic is the mqtt topic that this sensor will send messages \n\n"
				+ "Arrival Rate is the parameter of the Poisson probability distribution that model this event, for more details," 
				+ "head to home and read the Event Driven Sensor part \n\n"
				);
	};
	function help_td() {
		alert("New Time Driven Sensors can be configurate to fulfill you needs. \n\n"
				+ "Type (name) is the name of your sensor, normally, the sensor name is related to it type\n\n"
				+ "Topic is the mqtt topic that this sensor will send messages \n\n"
				+ "Number of devices is the number of sensors with this configurations that you want in your experiment\n\n"
				+ "Periodity is the periodity in each sensor of this type will send a message\n\n"
				+ "Data Type is the type of data that will be sent in the payload, in max and min forms you can set a max and min "
				+" value for the choosen type. BooleanText data type is explained on the Technical Details page"
				);
	};
	
	function help_ed() {
		alert("New Time Event Sensors can be configurate to fulfill you needs. \n\n" //TODO
				+ "Type (name) is the name of your sensor, normally, the sensor name is related to it type\n\n"
				+ "Topic is the mqtt topic that this sensor will send messages \n\n"
				+ " choose variable in Arrival Rate Mode if you want that the arrival rate changes automatically in the experiment,"
				+" for more details about this check Technical Details page. \n\n"
				+ "Arrival Rate Value is the parameter of the Poisson probability distribution that model this event, for more details,"				
				+ "Data Type is the type of data that will be sent in the payload, in max and min forms you can set a max and min "
				+" value for the choosen type. BooleanText data type is explained on the Technical Details page"
				);
	};
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
					<li class="active"><a
						href="${pageContext.request.contextPath}/settings"><i
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
						<h1 class="page-header">Settings</h1>
						<ol class="breadcrumb">
							<li><i class="fa fa-home"></i> <a
								href="{pageContext.request.contextPath}/index"> Home</a></li>
							<li class="active"><i class="fa fa-cog"></i> Settings</li>
						</ol>
					</div>
				</div>
				<!-- /.row -->
				<form role=form action="run" method="post"
					onSubmit="formatFakeArrays();return validate();">
					<div class="row">
						<div class="col-lg-6">
							<p><h2>Network Settings <span alt="Help Settings"
									onclick="help_network()"
									class="glyphicon glyphicon-question-sign"></span></h2></p> 
							<div class="col-lg-8 text-left">
								<label for="ip">MQTT Broker IP address</label> <input name="ip"
									id="ip" class="form-control" placeholder="xxx.xxx.xxx.xxx">
								<p class="help-block">For localhost just type localhost</p>
							</div>

							<div class="col-lg-4 text-left">
								<label for="port">Port</label> <input name="port" id="port"
									class="form-control" placeholder="1883">
								<p class="help-block">Default is 1883</p>
							</div>


						</div>
						<div class="col-lg-6">


							<p>
							<h2>
								Experiment Settings <span alt="Help Settings"
									onclick="help_exp()"
									class="glyphicon glyphicon-question-sign"></span>
							</h2>
							</p>



							<div class="col-lg-6 text-left">
								<label for="nameExp">Experiment's name</label> <input
									name="nameExp" type="text" id="nameExp" class="form-control">
							</div>

							<div class="col-lg-6 text-left">
								<label for="timeOfExp">Experiment's Duration</label>
								<div class="form-group">
									<div class="input-group">
										<input name="timeOfExp" type="number" min="1" id="timeOfExp"
											class="form-control">
										<div class="input-group-btn"></div>
										<select class="selectpicker" id="unit" name="unit">
											<option value="seconds">seconds</option>
											<option value="minutes">minutes</option>
											<option value="hours">hours</option>
										</select>

									</div>
								</div>
							</div>
							<div class="col-lg-6 text-left">
								<label for="path">Path for saving files</label> <input
									name="path" type="text" id="path" class="form-control">
							</div>

							<div class="col-lg-6 text-left">
								<div class="col-lg-12 text-left">
									<label for="writeFile" class="checkbox-inline"><input
										type="checkbox" name="writeFile" id="checkbox" value="true">
										Generate log file</label> <input type="hidden" name="writeFile"
										value="false" />
									<p class="help-block">Log file is generate in root
										directory and has the name of the experiment</p>
								</div>
							</div>

						</div>
						<div class="col-lg-12">
							<div class="row">
								<div class="col-md-8">
									<h2>Sensor Settings</h2>

								</div>
							
							</div>
							<h6>We already have a bunch of templates ready to use. They
								are based on the implementation made on Padova's City (Italy).
								To get more details about the specifications of this templates,
								go to Technical Details</h6>
							<div class="table-responsive">
								<table class="table" id="templateTimeSensor">
									<thead>
										<tr>
											<th>Time Driven Sensors Templates <span alt="Help Settings"
									onclick="help_ttd()"
									class="glyphicon glyphicon-question-sign"></span></th>
											<th>MQTT Topic</th>
											<th>Number of Devices</th>
											<th>
												<form>
													<br>
													<button type="button" class="btn btn-default"
														value="inserir"
														onClick="javascript:newTimeDrivenTemplateLine()"
														aria-label="Right Align">
														<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
													</button>
												</form>
											</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td id="campoTTDA1"><select class="form-control"
												title="Sensor Templates" id="sensorTemplates1"
												name="sensorTemplates">
													<option value="" disabled selected>Sensor
														Templates</option>
													<option value="air">air</option>
													<option value="waste">waste</option>
													<option value="noise">noise</option>
													<option value="structural">structural</option>
													<option value="traffic">traffic</option>
											</select></td>
											<td id="campoTTDB1"><input name="topicTTD" type="text"
												id="topicTTD1" class="form-control" /></td>
											<td id="campoTTDC1"><input name="numberOfDevicesT"
												type="number" min="1" id="numberOfDevicesT1"
												class="form-control" /></td>

										</tr>
									</tbody>
								</table>
							</div>
							<div class="table-responsive">
								<table class="table" id="templateEventSensor">
									<thead>
										<tr>
											<th>Event Driven Sensor Template <span alt="Help Settings"
									onclick="help_ted()"
									class="glyphicon glyphicon-question-sign"></span></th>
											<th>MQTT Topic</th>
											<th>Arrival Rate (persons/seconds)</th>
											<th>
												<form>
													<button type="button" class="btn btn-default"
														value="inserir"
														onClick="javascript:newEventDrivenTemplateLine()"
														aria-label="Center Align">
														<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
													</button>
												</form>
											</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td id="campoTEDA1">
												<p class="form-control-static">Flow of People</p> <input
												type="hidden" name="lightSensor" value="lightSensor" />
											</td>
											<td id="campoTEDB1"><input name="topicTED1" type="text"
												id="topicTED1" class="form-control" /></td>
											<td id="campoTEDC1"><input name="lambda1" type="number"
												min="1" id="lambda1" class="form-control" /></td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="table-responsive">
								<table class="table" id="newTimeSensor">
									<h3>New Time Driven Sensor <span alt="Help Settings"
									onclick="help_td()"
									class="glyphicon glyphicon-question-sign"></span></h3>
									<h6>Create a new sensor type that fulfill your needs</h6>
									<thead>
										<tr>
											<th>Type (name)</th>
											<th>MQTT Topic</th>
											<th>Number of Devices</th>
											<th>Periodicity</th>
											<th>Data Type</th>
											<th>Max Value</th>
											<th>Min Value</th>
											<th>
												<form>
													<button type="button" class="btn btn-default"
														value="inserir" onClick="javascript:newTimeDrivenLine()"
														aria-label="Right Align">
														<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
													</button>
												</form>
											</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td id="campoTDA1"><input name="sensorType1" type="text"
												id="sensorType1" class="form-control" /></td>
											<td id="campoTDB1"><input name="topicTD1" type="text"
												id="topicTD1" class="form-control" /></td>
											<td id="campoTDC1"><input name="numberOfDevices1"
												type="number" min="1" id="numberOfDevices1"
												class="form-control" /></td>
											<td id="campoTDE1">
												<div class="input-group">
													<input name="periodicity1" type="number" min="1"
														id="periodicity1" class="form-control" />
													<div class="input-group-btn"></div>
													<select style="width: 62px" class="form-control"
														id="c_periodicity1" name="c_periodicity1">
														<option value="min">min</option>
														<option value="s">s</option>
													</select>
												</div>
											</td>
											<td id="campoTDF1"><select class="form-control"
												title="Data Type" id="dataType11" name="dataType11">
													<option>int</option>
													<option>float</option>
													<option>boolean</option>
													<option>char</option>
													<option>booleanText</option>
											</select></td>
											<td id="campoTDG11">
												<div class="input-group">
													<span class="input-group-addon"> <input id="c_max11"
														type="checkbox" aria-label="..."
														onClick="toggleForm('max11')">
													</span><input name="max11" type="text" id="max11"
														class="form-control" disabled />
												</div>
											</td>
											<td id="campoTDH11">
												<div class="input-group">
													<span class="input-group-addon"> <input id="c_min11"
														type="checkbox" aria-label="..."
														onClick="toggleForm('min11')"></span><input name="min11"
														type="text" id="min11" class="form-control" disabled />
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>

							<div class="table-responsive">
								<table class="table" id="newEventSensor">
									<h3>New Event Driven Sensor <span alt="Help Settings"
									onclick="help_ed()"
									class="glyphicon glyphicon-question-sign"></span></h3>
									<h6>Create a new sensor type that fulfill your needs.
										Event Sensors have a lot of non basic configurations, to know
										what each of them means go to our Tech Detail page.</h6>
									<thead>
										<tr>
											<th>Type (name)</th>
											<th>MQTT Topic</th>
											<th style="width: 110px">Arrival Rate Mode</th>
											<th>Arrival Rate Value</th>
											<!-- <th>Event Duration</th>-->
											<th>Data Type</th>
											<th>Max Value</th>
											<th>Min Value</th>
											<th>
												<form>
													<button type="button" class="btn btn-default"
														value="inserir" onClick="javascript:newEventDriveLine()"
														aria-label="Right Align">
														<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
													</button>
												</form>
											</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td id="campoEDA1"><input name="sensorTypeE1"
												type="text" id="sensorTypeE1" class="form-control" /></td>
											<td id="campoEDB1"><input name="topicED1" type="text"
												id="topicED1" class="form-control" /></td>
											<td id="campoEDC1"><select class="form-control"
												title="Arrival Rate Mode" id="arrivalMode1"
												name="arrivalMode1">
													<option>continuous</option>
													<option>variable</option>
											</select></td>
											<td id="campoEDD1"><input name="lambdaE1" type="number"
												min="1" id="lambdaE1" class="form-control" /></td>
											<!-- 
											<td id="campoEDE1"><input name="duration1" type="number"
												min="1" id="duration1" class="form-control" /></td> -->
											<td id="campoEDF1"><select class="form-control"
												title="Data Type" id="dataTypeE11" name="dataTypeE11">
													<option>int</option>
													<option>float</option>
													<option>boolean</option>
													<option>char</option>
													<option>booleanText</option>
											</select></td>
											<td id="campoEDG11">
												<div class="input-group">
													<span class="input-group-addon"> <input
														id="c_maxE11" type="checkbox" aria-label="..."
														onClick="toggleForm('maxE11')">
													</span><input name="maxE11" type="text" id="maxE11"
														class="form-control" disabled />
												</div>
											</td>
											<td id="campoEDH11">
												<div class="input-group">
													<span class="input-group-addon"> <input
														id="c_minE11" type="checkbox" aria-label="..."
														onClick="toggleForm('minE11')"></span><input
														name="minE11" type="text" id="minE11" class="form-control"
														disabled />
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>

							<div class="row">
								<input name="thisIsNotAStringTemplateEventDriven" type="hidden"
									id="thisIsNotAString2"> <input
									name="thisIsNotAStringNewTimeDriven" type="hidden"
									id="thisIsNotAString3"> <input
									name="thisIsNotAStringTemplateTimeDriven" type="hidden"
									id="thisIsNotAString1"> <input
									name="thisIsNotAStringNewEventDriven" type="hidden"
									id="thisIsNotAString4">

								<div class="col-lg-3 text-center"></div>
								<div class="col-lg-6 text-center">
									<br>
									<button type="submit" class="btn btn-lg btn-primary btn-block"
										value="run">RUN</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
		<!-- /.container-fluid -->
	</div>
	<!-- Bootstrap Core JavaScript -->
	<script src="resources/js/bootstrap.min.js"></script>
	<!-- jQuery -->
	<script src="resources/js/jquery.js"></script>
</body>

</html>

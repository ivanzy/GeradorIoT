package br.sense.code;

import br.sense.code.Param;
import br.sense.model.EDSensor;
import br.sense.model.TDSensor;

public class StartSenSE {

	public static void main(String[] args) {
		for (int i = 0; i < args.length; i++) {
			if (args[i].equalsIgnoreCase("-sensor")) {
				Param.number_of_devices = Integer.parseInt(args[i + 1]);
			}
			if (args[i].equalsIgnoreCase("-lambda")) {
				Param.lambda = Double.parseDouble(args[i + 1]);
			}
			if (args[i].equalsIgnoreCase("-rep")) {
				Param.number_of_replications = Integer.parseInt(args[i + 1]);
			}
			if (args[i].equalsIgnoreCase("-h")) {
				Param.address = args[i + 1];
			}
			if (args[i].equalsIgnoreCase("-t")) {
				Param.topic = args[i + 1];
			}

		}
		
		
		System.out.println("Starting experiment with: " + Param.number_of_devices + " sensors, "+ Param.lambda +" lambda,"
				+ Param.number_of_replications +" replications," + Param.address +" address,"+ Param.topic + " topic");
		for (int i = 0; i < Param.number_of_replications; i++) {
			System.out.println("\n EXPERIMENTO " + (i+1)+ " INICIANDO \n");
			TDSensor[] tdSensorArray = new TDSensor[5];
			EDSensor[] edSensorArray = new EDSensor[1];
			TDSensor t = new TDSensor();
			t.setType("air");
			t.setTopic(Param.topic);
			t.setNumberOfDevices(Param.number_of_devices);
			tdSensorArray[0] = t;
			t = new TDSensor();
			t.setType("noise");
			t.setTopic(Param.topic);
			t.setNumberOfDevices(Param.number_of_devices);
			tdSensorArray[1] = t;
			t = new TDSensor();
			t.setType("waste");
			t.setTopic(Param.topic);
			t.setNumberOfDevices(Param.number_of_devices);
			tdSensorArray[2] = t;
			t = new TDSensor();
			t.setType("structural");
			t.setTopic(Param.topic);
			t.setNumberOfDevices(Param.number_of_devices);
			tdSensorArray[3] = t;
			t = new TDSensor();
			t.setType("traffic");
			t.setTopic(Param.topic);
			t.setNumberOfDevices(Param.number_of_devices);
			tdSensorArray[4] = t;
			EDSensor e = new EDSensor();
			e.setType("lightController");
			e.setTopic(Param.topic); // TesteEvento1
			// System.out.println("for:" + edSensorArray[ind]);
			e.setLambda(Param.lambda);// 133
			edSensorArray[0] = e;
			e = new EDSensor();
			MqttPublish mqttp = new MqttPublish();
			mqttp.setEventSensors(edSensorArray);
			mqttp.setTimeSensors(tdSensorArray);
			Thread threadDoPdf = new Thread(mqttp);
			threadDoPdf.start();
			while(!TimeControl.isDone()){
				System.out.println("waiting to experiment to end");
				try {
					Thread.sleep(1000);
				} catch (InterruptedException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}				
			}
			try {
				Thread.sleep(Param.time_between_exp*1000);
			} catch (InterruptedException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
	}

}

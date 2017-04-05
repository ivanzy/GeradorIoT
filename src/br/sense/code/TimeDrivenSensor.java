package br.sense.code;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collections;
import java.util.Date;
import java.util.LinkedList;
import java.util.concurrent.CountDownLatch;
import java.util.logging.Level;
import java.util.logging.Logger;
import br.sense.model.Message;
import br.sense.model.MessageArray;

import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;

public class TimeDrivenSensor extends GenericSensor implements Runnable, MqttCallback {

	private final int nSensors;
	private LinkedList<Sensor> sensor = new LinkedList<>();
	IdController idController = new IdController();
	
	public TimeDrivenSensor(String sensorType, int number_of_sensors, String topic, CountDownLatch latch) {
		super(sensorType, topic, latch);
		this.duration = setSensorPeriodicity(sensorType) * 1000 * 60;
		this.nSensors = number_of_sensors;
	}

	public TimeDrivenSensor(String sensorType, String[] messageType, int duration, int number_of_sensors, String topic,
			CountDownLatch latch) {
		super(sensorType, messageType, duration, topic, latch);
		this.duration = duration * 1000;
		this.nSensors = number_of_sensors;

	}

	public TimeDrivenSensor(String sensorType, String[] messageType, String[] max, String[] min, int duration,
			int number_of_sensors, String topic, CountDownLatch latch) {
		super(sensorType, messageType, max, min, duration, topic, latch);
		this.idController.setId();
		this.duration = duration * 1000;
		this.nSensors = number_of_sensors;
	}

	@Override
	public void run() {
		System.out.println(
				sensorType + " sends a message  in each " + duration + " ms. We will generate " + nSensors + "\n");
		// random.setSeed(Param.seed);
		this.initializeSensors();
		try {
			this.publish();
		} catch (IOException ex) {
			Logger.getLogger(TimeDrivenSensor.class.getName()).log(Level.SEVERE, null, ex);
		}
	}

	private void initializeSensors() {
		System.out.println("A duração do sensor " + this.sensorType + " é " + this.duration);
		for (int i = 0; i < nSensors; i++) {
			Sensor s1 = new Sensor();
			s1.setDuration(duration);
			s1.setId(IdController.getId(sensorType));
			s1.setStartSend(RandomController.nextInt(s1.getDuration()));
			sensor.add(s1);
		}

	}

	private int setSensorPeriodicity(String name) {
		int p;
		switch (name) {
		case "structural":
			p = 10;
			break;
		case "air":
			p = 30;
			break;
		case "traffic":
			p = 10;
			break;
		case "noise":
			p = 10;
			break;
		case "waste":
			p = 60;
			break;
		default:
			p = 0;
			break;
		}
		return p;
	}

	private String setSensorInfo(String name, int idSensor) {

		String msg = "";
		if (messageType == null) {
			float temp;
			switch (name) {
			case "structural":
				msg += "type=structural;resource=" + idSensor + ";message=";
				for (int i = 0; i < 7; i++) {
					temp = (RandomController.nextInt(99) + RandomController.nextFloat());
					msg += (temp + ",");
				}
				return msg;
			case "air":
				msg += "type=air;resource=" + idSensor + ";message=";
				for (int i = 0; i < 6; i++) {
					temp = (RandomController.nextInt(99) + RandomController.nextFloat());
					msg += (temp + ",");
				}
				return msg;
			case "traffic":
				msg += "type=traffic;resource=" + idSensor + ";message=";
				for (int i = 0; i < 20; i++) {
					temp = RandomController.nextInt(99) + RandomController.nextFloat();
					msg += (temp + ",");
				}
				return msg;
			case "noise":
				msg += "type=noise;resource=" + idSensor + ";message=";
				msg += RandomController.nextInt(300);
				return msg;
			case "waste":
				msg += "type=waste;resource=" + idSensor + ";message=";
				msg += RandomController.nextFloat() + "";
				return msg;
			default:
				msg = "ERROR: Sensor Type not found";
				return msg;
			}
		} else {
			msg += "type=" + sensorType + ";resource=" + idController.getId() + ";message=";
			// for (int i = 0; i < messageType.length; i++) {
			if (!(messageType[0].equals("booleanText"))) {
				if (max == null)
					msg += getRandomData(messageType[0]) + ";";
				else
					msg += getRandomData(messageType[0], max[0], min[0]);
			} else {
				msg += (RandomController.nextInt() % 2 == 0) ? max[0] : min[0];
			}
			// }
			return msg;
		}
	}

	public void publish() throws IOException {
		if (client == null) {
			this.connectMQTT();
		}
		int numberOfMsg = 0;
		String m = this.setSensorInfo(sensorType, 1);
		Sensor temp, temp2;
		int timeToSleep = 1;
		try {
			if (client == null) {
				this.connectMQTT();
			}
			Collections.sort(sensor);
			temp = sensor.peek();
			
			try {
			//	System.out.println("tempo de espera de primeira msg é "+temp.getStartSend());
				Thread.sleep(temp.getStartSend());
				//System.out.println("já foi");
			} catch (InterruptedException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			do {
				MqttMessage message = new MqttMessage();
				message.setPayload(m.getBytes());

				if (!sensor.isEmpty())
					temp = (Sensor) sensor.remove();

				long time = (System.currentTimeMillis());
				numberOfMsg++;// P1=14735427300;P2=?;P3=?;P4=?;P5=?;P6=?;P7=?;REP=-1
				// m += "-"+Param.replication+"-"+time;
				m += ";REP="+Param.replication+";P1=" + time + ";";
				String timeH = new Date(System.currentTimeMillis()).toString();
			//	System.out.println(timeH);
				System.out.println(m);
				//MessageArray.setMsg(m, new Date(System.currentTimeMillis()), this.topic);
				client.publish(this.topic, m.getBytes(), Param.qos, false);
				if (Param.writeFile) {
					// System.out.println("WRITE ON FILE:"+m);
					//writeFile(m, time, numberOfMsg);
					writeFile();
				}
				if (temp != null) {
					timeToSleep = temp.getStartSend();
					temp.setStartSend(temp.getStartSend() + duration);
					sensor.add(temp);
				}
				if (!sensor.isEmpty()) {
					temp2 = (Sensor) sensor.peek();
					timeToSleep = temp2.getStartSend() - timeToSleep;
					m = this.setSensorInfo(sensorType, temp2.getId());
				}
				try {
					// System.out.println("sleep "+timeToSleep);
					Thread.sleep(timeToSleep);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			} while (!(TimeControl.isDone()) && !isAbort);
		} catch (MqttException ex) {
			Logger.getLogger(TimeDrivenSensor.class.getName()).log(Level.SEVERE, null, ex);
		}

		try {
			client.disconnect(); // problema?
		} catch (MqttException ex) {
			Logger.getLogger(TimeDrivenSensor.class.getName()).log(Level.SEVERE, null, ex);
		}
		latch.countDown();
	}
	private static int cont =0; 
	static private void writeFile() throws IOException{
		cont++;
		File arquivo = new File(Param.name_experiment + ".csv");
		try (FileWriter fw = new FileWriter(arquivo, true); BufferedWriter bw = new BufferedWriter(fw)) {
			
			bw.write(String.valueOf(cont)+";"+Param.replication);
			bw.newLine();
		}
	}


}
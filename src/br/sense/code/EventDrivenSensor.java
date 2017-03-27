package br.sense.code;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Date;
import java.util.concurrent.CountDownLatch;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.eclipse.paho.client.mqttv3.MqttPersistenceException;

import br.sense.model.MessageArray;

public class EventDrivenSensor extends GenericSensor implements Runnable, MqttCallback {
	private double lambda;
	private int randomEvent;
	private int idSensor;
	private int init;
	private int end;
	private int duration;
	private String typeSend;

	public EventDrivenSensor(String sensorType, double lambda, int duration, String topic, CountDownLatch latch) {
		super(sensorType, duration, topic, latch);
		this.duration = duration * 1000;
		this.idSensor = 1;
		this.lambda = lambda;
		this.typeSend = "variable";
		init = this.duration / 8;
		end = this.duration / 12;
		if (init < 1)
			init = 1;
		if (end < 1)
			end = 1;
		//System.out.println("duration: " + this.duration + " init:" + init + " end:" + end);

	}

	public EventDrivenSensor(String sensorType, String[] messageType, double lambda, String typeSend, int duration,
			String topic, CountDownLatch latch) {
		super(sensorType, messageType, duration, topic, latch);
		this.duration = duration * 1000;
		this.idSensor = 1;
		this.typeSend = typeSend;
		this.lambda = lambda;
		init = this.duration / 8;
		end = this.duration / 12;
		if (init < 1)
			init = 1;
		if (end < 1)
			end = 1;
		//System.out.println("duration: " + this.duration + " init:" + init + " end:" + end);
	}
	
	public EventDrivenSensor(String sensorType, String[] messageType,String[] max, String[] min, double lambda, String typeSend, int duration,
			String topic, CountDownLatch latch) {
		super(sensorType, messageType, duration, topic, latch);
		this.duration = duration * 1000;
		this.idSensor = 1;
		this.max = max;
		this.min = min;
		this.typeSend = typeSend;
		this.lambda = lambda;
		init = this.duration / 8;
		end = this.duration / 12;
		if (init < 1)
			init = 1;
		if (end < 1)
			end = 1;
		//System.out.println("duration: " + this.duration + " init:" + init + " end:" + end);
	}
//
//	public EventDrivenSensor(String sensorType, String[] messageType, double lambda, int duration, String topic,
//			int max[], int min[], CountDownLatch latch) {
//		super(sensorType, messageType, duration, topic, latch);
//		this.idSensor = 1;
//		this.lambda = lambda;
//		this.duration = duration * 1000;
//		this.typeSend = typeSend;
//		this.init = init;
//		this.end = end;
//		init = this.duration / 8;
//		end = this.duration / 12;
//		if (init < 1)
//			init = 1;
//		if (end < 1)
//			end = 1;
//		System.out.println("duration: " + this.duration + " init:" + init + " end:" + end);
//
//	}

	@Override
	public void run() {
		setRandomEvent(duration);
		System.out.println("A event will ocurre in the time " + randomEvent);
		try {
			controlPublish(lambda);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void setRandomEvent(int duration) {
		boolean isPossible;
		int randomControl = (int) Param.time_of_experiment * 1000;
		do {
			randomEvent = RandomController.nextInt(randomControl - duration);
			System.out.println(randomEvent + "  " + duration);
			if (randomEvent + duration <= (Param.time_of_experiment) * 1000)
				isPossible = true;
			else
				isPossible = false;
		} while (!isPossible);
	}

	private String setSensorInfo(String name) {
		String msg = "";
		if (messageType == null) {
			switch (name) {
			case "lightController":
				msg += "type=FlowOfPeople;resource=#;message=";
				if (RandomController.nextFloat() >= 0.5)
					msg += "on";
				else
					msg += "off";
				return msg;
			default:
				// smsg = "ERROR: Sensor Type not found";
				return msg;
			}
		} else {
			// for (int i = 0; i < messageType.length; i++) {
			msg += "type="+this.sensorType+";resource=#;message=";
			if (!(messageType[0].equals( "booleanTex"))) {
				if (max == null)
					msg += getRandomData(messageType[0]) + ";";
				else
					msg += getRandomData(messageType[0], max[0], min[0]);
				// }
			} else {
				msg += (RandomController.nextInt() % 2 == 0) ? max[0] : min[0];
			}
			return msg;
		}
	}

	int sendMessage() {
		int send;
		long t = TimeControl.getTime();
		// if (t <= (randomEvent - (duration / 8)))
		// if (t <= (randomEvent + (duration / 8)))
		// else if (t <= (randomEvent + duration - (duration / 12)))
		// else if (t <= (randomEvent + duration + (duration / 12)))
		if (typeSend.equals("variable")) {
		//	System.out.println("VARIAVEL");
			if (init != 0) {
				if (t <= (randomEvent - init))
					send = 0;
				else if (t <= (randomEvent + init))
					send = 1;
				else if (t <= (randomEvent + duration - end))
					send = 2;
				else if (t <= (randomEvent + duration + end))
					send = 3;
				else
					send = 4;
			} else {
				send = 1;
			}
		} else {
		//	System.out.println("CONTINUO");
			send = 1;
		}
		return send;
	}

	int sendMessage(int a) {
		return 1;
	}

	public void controlPublish(double lambda) throws IOException {
		// x = log(1-u)/(−λ);
		int numberOfMsg = 0;
		double u, xTemp;
		long x;
		do {
			if (client == null) {
				this.connectMQTT();
			}
			switch (sendMessage()) {
			case 0:
				// System.out.println("Event did not start");
				break;
			case 1:
				System.out.println("Event Starting");
				u = RandomController.nextFloat();
				xTemp = Math.log(u) / -lambda; // seconds
				x = Math.round(xTemp * 1000);
				System.out.println("u: " + u + " xTemp:" + xTemp + " x:" + x);
				try {
					// System.out.println(x + "ms for the next message of event
					// sensor n " + this.idSensor);
					Thread.sleep(x);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				numberOfMsg++;
				publish(numberOfMsg, 1);
				break;
			case 2:
				double lambda2 = lambda / 20;
				// System.out.println("Event in the middle");
				u = RandomController.nextFloat();
				xTemp = Math.log(u) / -lambda2; // seconds
				x = Math.round(xTemp * 1000);
				// if (((randomEvent + duration - (duration / 18)) -
				// TimeControl.getTime()) <= x)
				if (((randomEvent + duration - end) - TimeControl.getTime()) <= x)
					break;

				try {
					// System.out.println(x + "ms for the next message of event
					// sensor n " + this.idSensor);
					Thread.sleep(x);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				numberOfMsg++;
				publish(numberOfMsg, 2);

				break;
			case 3:
				double lambda3 = lambda * 3;
				System.out.println("Event close to it's finish");
				u = RandomController.nextFloat();
				xTemp = Math.log(u) / -lambda3; // seconds
				x = Math.round(xTemp * 1000);
				try {
					// System.out.println(x + "ms for the next message of event
					// sensor n " + this.idSensor);
					Thread.sleep(x);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				numberOfMsg++;
				publish(numberOfMsg, 3);
				break;
			default:
				// System.out.println("Event finished");
				break;
			}

		} while (!TimeControl.isDone());
		System.out.println("all messages sent from event driven sensors");
	}

	public void publish(int numberOfMsg, int cor) throws IOException {
		String m = this.setSensorInfo(sensorType);
		MqttMessage message = new MqttMessage();
		message.setPayload(m.getBytes());

		long time = System.currentTimeMillis();
		try {
			if (!client.isConnected())
				client.connect();
			numberOfMsg++;
			// m += "-"+Param.replication+"-"+time;
			m += ";P1=" + time + ";";
			System.out.println(m);
			MessageArray.setMsg(m, new Date(System.currentTimeMillis()), this.topic);
			client.publish(topic, m.getBytes(), Param.qos, false);
		} catch (MqttPersistenceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MqttException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		writeFile(m, time, numberOfMsg, cor);

		latch.countDown();
	}

	static public void writeFile(String m, long time, int count, int cor) throws IOException {
		String[] msg = m.split(";");
		String[] type = msg[0].split("=");
		String[] id = msg[1].split("=");
		File arquivo = new File("Experiment" + Param.experiment_num + ".csv");
		try (FileWriter fw = new FileWriter(arquivo, true); BufferedWriter bw = new BufferedWriter(fw)) {
			m = "\"" + Param.replication + "\"" + ";" + "\"" + type[1] + "\"" + ";" + "\"" + id[1] + "\"" + ";" + "\""
					+ count + "\"" + ";" + "\"" + time + "\"" + ";" + "\"" + cor + "\"";
			// devNo;msgNo;time
			bw.write(m);
			bw.newLine();
		}
	}

}

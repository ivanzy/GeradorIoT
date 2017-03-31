package br.sense.code;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Date;
import java.util.Random;
import java.util.concurrent.CountDownLatch;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;

public abstract class GenericSensor implements Runnable, MqttCallback {
	protected String sensorType, topic;
	protected int duration;
	protected CountDownLatch latch;
	protected MqttClient client;
	protected MqttConnectOptions options;
	protected Random fullRand = new Random();
	protected String[] messageType, max, min;
	protected boolean isAbort = false;

	public GenericSensor(String sensorType, int duration, String topic, CountDownLatch latch) {
		this.sensorType = sensorType;
		this.topic = topic;
		this.duration = duration;
		this.latch = latch;
		fullRand.setSeed(System.currentTimeMillis());
	}

	public GenericSensor(String sensorType, String[] messageType, int duration, String topic, CountDownLatch latch) {
		this.sensorType = sensorType;
		this.topic = topic;
		this.duration = duration;
		this.latch = latch;
		this.messageType = messageType;
		fullRand.setSeed(System.currentTimeMillis());
	}

	public GenericSensor(String sensorType, String[] messageType, String[] max, String[] min, int duration,
			String topic, CountDownLatch latch) {
		this.sensorType = sensorType;
		this.topic = topic;
		this.duration = duration;
		this.latch = latch;
		this.messageType = messageType;
		this.max = max;
		this.min = min;
		fullRand.setSeed(System.currentTimeMillis());
	}

	public GenericSensor(String sensorType, String topic, CountDownLatch latch) {
		this.sensorType = sensorType;
		this.topic = topic;
		this.latch = latch;
		fullRand.setSeed(System.currentTimeMillis());
	}

	protected String getRandomData(String type) {
		String msg;

		switch (type) {
		case "int":
			msg = String.valueOf(RandomController.nextInt());
			break;
		case "float":
			msg = String.valueOf(RandomController.nextFloat());
			break;
		case "boolean":
			msg = String.valueOf(RandomController.nextBoolean());
			break;
		case "char":
			do{
				msg = String.valueOf(RandomController.nextChar());
			}while (msg.charAt(0) == '=' || msg.charAt(0) == ';');

			break;
		default:
			msg = "invalid";
			break;
		}
		return msg;
	}

	protected String getRandomData(String type, String max, String min) {
		String msg;

		switch (type) {
		case "int":
			int maxInt = Integer.parseInt(max), minInt = Integer.parseInt(min);
			if (maxInt == minInt)
				msg = max + "";
			else if ((maxInt - minInt) > 0)
				msg = String.valueOf(RandomController.nextInt(maxInt - minInt) + minInt);
			else if (minInt == Integer.MIN_VALUE)
				msg = String.valueOf(RandomController.nextInt(maxInt));
			else
				msg = String.valueOf(RandomController.nextInt());
			break;
		case "float":
			float maxF = Float.parseFloat(max), minF = Float.parseFloat(min);
			if (maxF == minF)
				msg = max + "";
			msg = String.valueOf(RandomController.nextFloat(maxF, minF));
			break;
		case "boolean":
			msg = String.valueOf(RandomController.nextBoolean()); // does no
																	// apply
			break;
		case "char":
			char maxC = max.charAt(0), minC = min.charAt(0);
			if (maxC == minC)
				msg = max + "";
			do {
				msg = String.valueOf(RandomController.nextChar(maxC, minC));
			} while (msg.charAt(0) == '=' || msg.charAt(0) == ';');
			break;
		default:
			msg = "invalid";
			break;
		}
		return msg;
	}

	void connectMQTT() {
		if (client == null) {
			try {
				client = new MqttClient(Param.address, sensorType + Param.replication + fullRand.nextInt(9999999),
						null);
				client.setCallback(this);
				options = new MqttConnectOptions();
				options.setUserName("admin");
				options.setPassword("password".toCharArray());
				client.connect(options);
			} catch (MqttException e) {
				Logger.getLogger(TimeDrivenSensor.class.getName()).log(Level.SEVERE, null, e);
			}
		}
	}

	public void connectionLost(Throwable msg) {
	}

	public void deliveryComplete(IMqttDeliveryToken arg0) {

	}

	public void messageArrived(String topic, MqttMessage message) throws Exception {
		String time = new Date(System.currentTimeMillis()).toString();
		System.out.println("Time:\t" + time + "  Topic:\t" + topic + "  Message:\t" + new String(message.getPayload())
				+ "  QoS:\t" + message.getQos());

	}

	static public void writeFile(String m, long time, int count) throws IOException {
		String[] msg = m.split(";");
		String[] type = msg[0].split("=");
		String[] id = msg[1].split("=");
		String[] payload = msg[2].split("=");
		File arquivo = new File(Param.path + Param.name_experiment + ".csv");
		try (FileWriter fw = new FileWriter(arquivo, true); BufferedWriter bw = new BufferedWriter(fw)) {
			m = "\"" + type[1] + "\"" + ";" + "\"" + id[1] + "\"" + ";" + "\"" + count + "\"" + ";" + "\"" + time + "\""
					+ ";" + "\"" + payload[1] + "\"";
			// devNo;msgNo;time
			bw.write(m);
			bw.newLine();
		}
	}

	public boolean isAbort() {
		return isAbort;
	}

	public void setAbort(boolean isAbort) {
		this.isAbort = isAbort;
	}

}

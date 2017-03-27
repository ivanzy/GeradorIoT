package br.sense.code;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Timestamp;

import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;

public class MqttSubscribe implements Runnable,MqttCallback {

	MqttClient client = null;

	public MqttSubscribe() {
	}

	public void subscribe() {
		try {
			// MqttClient client = new MqttClient("tcp://localhost:61613",
			// "pahomqttpublish1");
			client = new MqttClient(Param.address, "subUID",null);
			client.setCallback(this);
			MqttConnectOptions options = new MqttConnectOptions();
			options.setUserName("admin");
			options.setPassword("password".toCharArray());
			client.connect(options);
			client.subscribe(Param.topic);
			try {
				System.in.read();
			} catch (IOException e) {
				// If we can't read we'll just exit
			}
			client.disconnect();
			client.close();
		} catch (MqttException e) {
			e.printStackTrace();
			System.out.println("erro: " + e.getMessage().toString());
		}
	}

	public void connectionLost(Throwable msg) {
		System.out.println("connection lost " + msg.getMessage());
	}

	public void deliveryComplete(IMqttDeliveryToken arg0) {
		System.out.println("Delivery completed.");
	}

	public void messageArrived(String topic, MqttMessage message) throws Exception {
		// String time = new Timestamp(System.currentTimeMillis()).toString();
		long time = (System.currentTimeMillis());
		System.out.println("Time:\t" + time + "  Topic:\t" + topic + "  Message:\t" + new String(message.getPayload())
				+ "  QoS:\t" + message.getQos());
		String m = new String(message.getPayload());
		String uid[] = m.split("=");
//		if (client != null) {
//			System.out.println("UNSUBSCRIBEING ...");
//			client.unsubscribe(Param.topic);
//			//client.close();
//			System.out.println("CLOSED");
//		}
		System.out.println("RECEIVED UID =" + uid[1]);

	}

	@Override
	public void run() {
		subscribe();
	}

}
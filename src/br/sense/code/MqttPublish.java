package br.sense.code;

import java.util.ArrayList;
import java.util.Random;
import java.util.concurrent.CountDownLatch;
import br.sense.model.*;

public class MqttPublish implements Runnable {

	private final Random random = new Random();
	private static TDSensor[] timeSensors;
	private static EDSensor[] eventSensors;
	private static ArrayList<Thread> threads = new ArrayList<Thread>();
	// TODO permitir instanciar até x sensores genéricos
	// setar max e min para cada valor de dado de sensor
	public MqttPublish() {
	}

	public MqttPublish(TDSensor[] timeSensors, EDSensor[] eventSensors) {
//		System.out.println("construtor");
//		this.timeSensors = timeSensors;
//		this.eventSensors = eventSensors;
	}

	public MqttPublish(EDSensor[] eventSensors) {
//		this.eventSensors = eventSensors;
	}

	public MqttPublish(TDSensor[] timeSensors) {
//		this.timeSensors = timeSensors;
	}

	@Override
	public  void run() {
		publish();
		
	}

	private static void setTemplateTimeDrivenSensor(String sensorType, String topic, int number_of_sensors, CountDownLatch l) {
		TimeDrivenSensor newSensor;
		newSensor = new TimeDrivenSensor(sensorType, number_of_sensors, topic, l);
		Thread thread = new Thread(newSensor);
		threads.add(thread);
		thread.start();
	}

	private void setUID() {
		MqttSubscribe sub = new MqttSubscribe();
		Thread threadSub = new Thread(sub);
		threadSub.start();
	}

	private static void setTimeDrivenDevices(TDSensor temp, CountDownLatch l) {
		switch (temp.getType()) {
		case "air":
			setTemplateTimeDrivenSensor("air", temp.getTopic(), temp.getNumberOfDevices(), l);
			break;
		case "waste":
			setTemplateTimeDrivenSensor("waste", temp.getTopic(), temp.getNumberOfDevices(), l);
			break;
		case "noise":
			setTemplateTimeDrivenSensor("noise", temp.getTopic(), temp.getNumberOfDevices(), l);
			break;
		case "structural":
			setTemplateTimeDrivenSensor("structural", temp.getTopic(), temp.getNumberOfDevices(), l);
			break;
		case "traffic":
			setTemplateTimeDrivenSensor("traffic", temp.getTopic(), temp.getNumberOfDevices(), l);
			break;
		default:
			setTimeDrivenSensor(temp.getType(), temp.getData(), temp.getPeriodicity(), temp.getNumberOfDevices(),	temp.getTopic(),temp.getMax(), temp.getMin(),
				 l);
			break;
		}
	}

	private static void setEventDrivenDevices(EDSensor event, CountDownLatch l) {
		if (event.getType().equals("lightController")) {
			Long temp = ((Param.time_of_experiment*3)/4);
			setTemplateEventDrivenSensor(event.getType(), event.getTopic(), event.getLambda(),temp.intValue(), l);
		} else {
			Long temp = ((Param.time_of_experiment*3)/4);
			if(event.getData()[0].equals("variable")){
				setEventDrivenSensor(event.getType(), event.getTopic(), event.getData(), event.getLambda(),
						temp.intValue(), event.getMode(), event.getMax(),event.getMin(), l);
			}else{
				setEventDrivenSensor(event.getType(), event.getTopic(), event.getData(), event.getLambda(),
						((int)Param.time_of_experiment-1),event.getMode(), event.getMax(),event.getMin(), l);
			}

		}
	}

	// Event Driven Sensors, each thread represents a event (ex: a football
	// match)
	// Constructor EventDrivenSensor(String sensorType,int idSensor, double
	// lambda, int duration, latch)
	// DURATION IN MINUTES
	private static void setTemplateEventDrivenSensor(String sensorType, String topic, double lambda, int duration,
			CountDownLatch l) {
		EventDrivenSensor newSensor;
		newSensor = new EventDrivenSensor(sensorType, lambda, duration, topic, l);
		Thread thread = new Thread(newSensor);
		threads.add(thread);
		thread.start();

	}

	private static void setTimeDrivenSensor(String sensorType, String[] messageType, int duration, int number_of_sensors,
			String topic,String[] max,String[] min,CountDownLatch latch) {
		System.out.println("max: "+max[0]+" min: "+min[0]);
		TimeDrivenSensor newSensor = new TimeDrivenSensor(sensorType, messageType, max,min,duration, number_of_sensors, topic,
				latch);
		Thread thread = new Thread(newSensor);
		threads.add(thread);
		thread.start();
	}
//	private  static void setTimeDrivenSensor(String sensorType, String[] messageType, int duration, int number_of_sensors,
//			String topic,CountDownLatch latch) {
//		TimeDrivenSensor newSensor = new TimeDrivenSensor(sensorType, messageType, duration, number_of_sensors, topic,
//				latch);
//		Thread thread = new Thread(newSensor);
//		threads.add(thread);
//		thread.start();
//	}
	private static void setEventDrivenSensor(String sensorType, String topic, String[] messageType, double lambda,
			int duration,String mode, String[] max,String[] min ,CountDownLatch latch) {
		EventDrivenSensor newSensor = new EventDrivenSensor(sensorType, messageType, max,min,lambda, mode ,duration, topic, latch);
		Thread thread = new Thread(newSensor);
		threads.add(thread);
		thread.start();
	}

	public static void publish() {
		// System.out.println(Param.experiment_num + " is going to start in " +
		// Param.time_between_exp + "s");
		RandomController.setSeed();
		TimeControl.setTimeOfExperiment(Param.time_of_experiment);
		TimeControl.startTime();
		CountDownLatch latch = new CountDownLatch(1);
		if (timeSensors != null) {
			TDSensor temp = new TDSensor();
			for (int i = 0; i < timeSensors.length; i++) {
				temp = timeSensors[i];
				setTimeDrivenDevices(temp, latch);
			}
		}
		if (eventSensors != null) {
			EDSensor event = new EDSensor();
			for (int i = 0; i < eventSensors.length; i++) {
				event = eventSensors[i];
				setEventDrivenDevices(event, latch);
			}
		}
		try {
			latch.await(); // main thread is waiting on CountDownLatch to finish
			Thread.sleep(1000);
		} catch (InterruptedException ie) {
		}

		System.out.println("Todos as Threads já foram instanciandos");
		while ( TimeControl.getTime() <= TimeControl.getTimeOfExperiment()) {
			System.out.println("waiting for experiment to end " + TimeControl.getTime() + ", ends "
					+ TimeControl.getTimeOfExperiment());
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		//IdController.resetIds();
			//MessageArray.clean();
		}
		//System.out.println("RESETANDO EXPERIMENTO");
		IdController.resetIds();
		MessageArray.clean();
	}
	
	@SuppressWarnings("deprecation")
	public static void abort(){
		//	TimeControl.s
		TimeControl.setExperimentStarted(false);
		TimeControl.setTimeControl(true);
		for(Thread thread : threads)
		{
			IdController.resetIds();
		    thread.stop();
		}
		
	}


	public static TDSensor[] getTimeSensors() {
		return timeSensors;
	}

	public static void setTimeSensors(TDSensor[] timeSensors) {
		MqttPublish.timeSensors = timeSensors;
	}

	public static EDSensor[] getEventSensors() {
		return eventSensors;
	}

	public static void setEventSensors(EDSensor[] eventSensors) {
		MqttPublish.eventSensors = eventSensors;
	}

}

package br.sense.model;

public class EDSensor extends Sensor {
	private double lambda;
	private int duration;
	private String mode;
	
	
	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	private String[] data;
	private String[] max;
	private String[] min;

	public EDSensor() {

	}

	public EDSensor(String type, String topic, int lambda, int duration) {
		this.type = type;
		this.topic = topic;
		this.lambda = lambda;
		this.duration= duration;
	}

	public EDSensor(String type, String topic, int lambda, String[] data, String[] max, String[] min) {
		this.type = type;
		this.topic = topic;
		this.lambda = lambda;
		this.data = data;
		this.max = max;
		this.min = min;
	}



	public String[] getData() {
		return data;
	}

	public void setData(String[] data) {
		this.data = data;
	}

	public String[] getMax() {
		return max;
	}

	public void setMax(String[] max) {
		this.max = max;
	}

	public String[] getMin() {
		return min;
	}

	public void setMin(String[] min) {
		this.min = min;
	}

	public double getLambda() {
		return lambda;
	}

	public void setLambda(double lambda) {
		this.lambda = lambda;
	}

}

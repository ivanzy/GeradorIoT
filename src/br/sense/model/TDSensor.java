package br.sense.model;

public class TDSensor extends Sensor {
	private int numberOfDevices;
	private int periodicity;
	private String[] data;
	private String[] max;
	private String[] min;

	public TDSensor() {

	}

	public TDSensor(String type, String topic, int numberOfDevices) {
		this.type = type;
		this.topic = topic;
		this.numberOfDevices = numberOfDevices;
	}
	
	public TDSensor(String type, String topic, int numberOfDevices, int periodicity,String[] data, String[] max, String[] min) {
		this.type = type;
		this.topic = topic;
		this.numberOfDevices = numberOfDevices;
		this.periodicity = periodicity;
		this.data = data;
		this.max = max;
		this.min = min;
	}

	public int getPeriodicity() {
		return periodicity;
	}

	public void setPeriodicity(int periodicity) {
		this.periodicity = periodicity;
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

	public int getNumberOfDevices() {
		return numberOfDevices;
	}

	public void setNumberOfDevices(int numberOfDevices) {
		this.numberOfDevices = numberOfDevices;
	}

}

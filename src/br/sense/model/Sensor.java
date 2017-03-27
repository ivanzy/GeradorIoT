package br.sense.model;

public abstract class Sensor {
	protected String type;
	protected String topic;

	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTopic() {
		return topic;
	}
	public void setTopic(String topic) {
		this.topic = topic;
	}
	
	
	
}

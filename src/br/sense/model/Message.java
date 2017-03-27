package br.sense.model;

import java.sql.Timestamp;
import java.util.Date;

public class Message implements Comparable <Message>{
	private String id;
	private String topic;
	private String type;
	private String payload;
	private String date;
	private long timestamp;

	public long getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(long timestamp) {
		this.timestamp = timestamp;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTopic() {
		return topic;
	}
	public void setTopic(String topic) {
		this.topic = topic;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getPayload() {
		return payload;
	}
	public void setPayload(String payload) {
		this.payload = payload;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String dateT) {
		this.date = dateT;
	}

	public int compareTo(Message m) {
	
		long cM = ((Message) m).getTimestamp();
		
		//ascending order
		return (int)( cM- this.timestamp);

	}	

}

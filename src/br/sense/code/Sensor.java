package br.sense.code;

public  class Sensor implements Comparable<Sensor>  {
	private int id;
	private int startSend;
	private int duration;
	private int messagesSent;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getStartSend() {
		return startSend;
	}
	public void setStartSend(int startSend) {
		this.startSend = startSend;
	}
	public int getDuration() {
		return duration;
	}
	public void setDuration(int duration) {
		this.duration = duration;
	}
	public int getMessagesSent() {
		return messagesSent;
	}
	public void setMessagesSent(int messagesSent) {
		this.messagesSent = messagesSent;
	}

	@Override
	public int compareTo(Sensor s) {
		int comparedSize = s.getStartSend();
		if (this.startSend > comparedSize) {
			return 1;
		} else if (this.startSend == comparedSize) {
			return 0;
		} else {
			return -1;
		}
	}

}

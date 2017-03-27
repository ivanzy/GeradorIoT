package br.sense.model;



public class Settings {
	private String ip;
	private String port;
	private String thisIsNotAStringTemplateTimeDriven;
	private String thisIsNotAStringTemplateEventDriven;
	private String thisIsNotAStringNewTimeDriven;
	private String thisIsNotAStringNewEventDriven;
	private String nameExp;
	private int timeOfExp;
	private String path;
	private boolean writeFile = true;
	


	public boolean isWriteFile() {
		return writeFile;
	}

	public void setWriteFile(boolean writeFile) {
		this.writeFile = writeFile;
	}

	public String getNameExp() {
		return nameExp;
	}

	public void setNameExp(String nameExp) {
		this.nameExp = nameExp;
	}

	public int getTimeOfExp() {
		return timeOfExp;
	}

	public void setTimeOfExp(int timeOfExp) {
		this.timeOfExp = timeOfExp;
	}


	public void setIp(String ip) {
		this.ip = ip;
	}

	public void setPort(String port) {
		this.port = port;
	}


	public String getIp() {
		return ip;
	}

	public String getThisIsNotAStringNewEventDriven() {
		return thisIsNotAStringNewEventDriven;
	}

	public void setThisIsNotAStringNewEventDriven(String thisIsNotAStringNewEventDriven) {
		this.thisIsNotAStringNewEventDriven = thisIsNotAStringNewEventDriven;
	}

	public String getPort() {
		return port;
	}

	public String getThisIsNotAStringTemplateTimeDriven() {
		return thisIsNotAStringTemplateTimeDriven;
	}

	public void setThisIsNotAStringTemplateTimeDriven(String thisIsNotAStringTemplateTimeDriven) {
		this.thisIsNotAStringTemplateTimeDriven = thisIsNotAStringTemplateTimeDriven;
	}

	public String getThisIsNotAStringTemplateEventDriven() {
		return thisIsNotAStringTemplateEventDriven;
	}

	public void setThisIsNotAStringTemplateEventDriven(String thisIsNotAStringTemplateEventDriven) {
		this.thisIsNotAStringTemplateEventDriven = thisIsNotAStringTemplateEventDriven;
	}

	public String getThisIsNotAStringNewTimeDriven() {
		return thisIsNotAStringNewTimeDriven;
	}

	public void setThisIsNotAStringNewTimeDriven(String thisIsNotAStringNewTimeDriven) {
		this.thisIsNotAStringNewTimeDriven = thisIsNotAStringNewTimeDriven;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}




}

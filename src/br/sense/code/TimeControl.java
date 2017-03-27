package br.sense.code;

import br.sense.model.MessageArray;

public class TimeControl {
	public static boolean timeControl = true;
	public static boolean ExperimentStarted = false;
	public static long tStart = System.currentTimeMillis();
	public static long tNow = System.currentTimeMillis();
	// public static final BigInteger tFinished = Param.time_of_experiment;
	private static long tFinished = Param.time_of_experiment;

	public static void setTimeOfExperiment(long time) {
		tFinished = time *1000;//
	}

	public static long getTimeOfExperiment() {
		return (tFinished);// / 1000);
	}

	public static void startTime() {
		ExperimentStarted = true;
		tStart = System.currentTimeMillis();
	}

	public static boolean isExperimentStarted() {
		return ExperimentStarted;
	}

	public static boolean isTimeControl() {
		return timeControl;
	}

	public static void setTimeControl(boolean timeControl) {
		TimeControl.timeControl = timeControl;
	}

	public static void setExperimentStarted(boolean experimentStarted) {
		ExperimentStarted = experimentStarted;
	}

	public static long getTime() {
		long r = 0;
		//if (ExperimentStarted) {
			tNow = System.currentTimeMillis();
			// System.out.println("Time Start "+ tStart +" Time now "+
			// (tNow-tStart));
			r = (tNow - tStart);
		
		return r;
	}


	public static boolean isDone() {
		tNow = System.currentTimeMillis();
		// if(BigInteger.valueOf(tNow-tStart).compareTo(tFinished) == 1)
		if (getTime() < tFinished) {
			timeControl = false;
		} else {
			timeControl = true;
			ExperimentStarted = false;
		}
		return timeControl;
	}
	// public static void main(String[] args) {
	// startTime();
	// while(true){
	// System.out.println(isDone() + " cmp " +" "+getTime() + " tStart:
	// "+tStart+" Tnow: "+tNow+" dif "+(tNow-tStart));
	// try {
	// Thread.sleep(1000);
	// } catch (InterruptedException e) {
	// e.printStackTrace();
	// }
	// }
	// }

}

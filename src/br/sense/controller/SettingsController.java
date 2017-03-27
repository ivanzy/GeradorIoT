package br.sense.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.ModelAndView;
import br.sense.code.MqttPublish;
import br.sense.code.Param;
import br.sense.model.*;

@Controller
public class SettingsController {
	@RequestMapping("/settings")
	public String home() {
		System.out.println("settings");
		return "settings";
	}

	@RequestMapping("run")
	public String run(Settings set, HttpServletRequest reql) {
		Param.address = "tcp://" + set.getIp() + ":" + set.getPort();
		Param.name_experiment = set.getNameExp();
		// Param.writeFile = set.getWriteFile();
		Param.path = set.getPath();
		Param.time_of_experiment = set.getTimeOfExp();
		System.out.println(set.getThisIsNotAStringTemplateTimeDriven());
		TDSensor[] tdSensorArrayA = parseTemplateTD(set.getThisIsNotAStringTemplateTimeDriven());
		EDSensor[] edSensorArrayA = parseTemplateED(set.getThisIsNotAStringTemplateEventDriven());
		EDSensor[] edSensorArrayB = parseED(set.getThisIsNotAStringNewEventDriven());
		TDSensor[] tdSensorArrayB = parseTD(set.getThisIsNotAStringNewTimeDriven());
		TDSensor[] tdSensorArray = concat(tdSensorArrayA, tdSensorArrayB);
		EDSensor[] edSensorArray = concat(edSensorArrayA, edSensorArrayB);
		System.out.println("RUN!! Sending to ip " + Param.address + " with  devices and lambda equal to ");
		System.out.println("Experiment's name:" + set.getNameExp() + " time of exp:" + set.getTimeOfExp()
				+ "write File:" + set.isWriteFile());
//		if (tdSensorArray != null && edSensorArray != null) {
//			MqttPublish.setEventSensors(edSensorArray);
//			MqttPublish.setTimeSensors(tdSensorArray);
//	        MqttPublish 
//		} else if (tdSensorArray == null) {
//			MqttPublish.setTimeSensors(null);
//			MqttPublish.setEventSensors(edSensorArray);
//			MqttPublish.publish();
//		} else if (edSensorArray == null) {
//			MqttPublish.setTimeSensors(tdSensorArray);
//			MqttPublish.setEventSensors(null);
//			MqttPublish.publish();
//		}
		MqttPublish mqttp = null;
		if (tdSensorArray != null && edSensorArray != null) {
			mqttp = new MqttPublish();
			mqttp.setEventSensors(edSensorArray);
			mqttp.setTimeSensors(tdSensorArray);
	        Thread threadDoPdf = new Thread(mqttp);
	        threadDoPdf.start();
		} else if (tdSensorArray == null) {
			mqttp.setEventSensors(edSensorArray);
			mqttp.setTimeSensors(null);
			mqttp = new MqttPublish();
			//mqttp.publish();
	        Thread threadDoPdf = new Thread(mqttp);
	        threadDoPdf.start();
		} else if (edSensorArray == null) {
			mqttp.setEventSensors(null);
			mqttp.setTimeSensors(tdSensorArray);
			mqttp = new MqttPublish();
			//mqttp.publish();
	        Thread threadDoPdf = new Thread(mqttp);
	        threadDoPdf.start();
		}

		return "monitoring";
	}

	private TDSensor[] parseTemplateTD(String s) {
		String[] tdSensorArray = s.split(";");
		int limit = tdSensorArray.length / 3;
		TDSensor tdSensor[] = new TDSensor[limit];
		TDSensor t = new TDSensor();
		for (int i = 0, ind = 0; i < limit; i++, ind++) {
			t.setType(tdSensorArray[ind]);
			t.setTopic(tdSensorArray[++ind]);
			t.setNumberOfDevices(Integer.parseInt(tdSensorArray[++ind]));
			tdSensor[i] = t;
			t = new TDSensor();
		}
		return tdSensor;
	}

	private EDSensor[] parseTemplateED(String s) {
		// TesteEvento1;1;TesteEvento2;133;TesteEvento3;1;
		System.out.println("evento templ:"+s);
		String[] edSensorArray = s.split(";");
		int limit = edSensorArray.length / 2;
		EDSensor edSensor[] = new EDSensor[limit];
		EDSensor e = new EDSensor();
		for (int i = 0, ind = 0; i < limit; i++) {
			e.setType("lightController");
			e.setTopic(edSensorArray[ind++]); // TesteEvento1
			System.out.println("for:" + edSensorArray[ind]);
			e.setLambda(Integer.parseInt(edSensorArray[ind++]));// 133
			edSensor[i] = e;
			e = new EDSensor();
		}
		return edSensor;
	}

	private boolean isNumeric(String s) {
		return s.matches("[-+]?\\d*\\.?\\d+");
	}
	private EDSensor[] parseED(String s) {
		System.out.println("PARSE ED: "+s);
		String[] edSensorArray = s.split(";");
		int limit = edSensorArray.length;
		if (edSensorArray.length >= 3)
			while (limit % 8 != 0 && isNumeric(edSensorArray[3])) {
				//System.out.println("VALOR NO ARRAY:" + edSensorArray[3]);
				limit++;
			}
		limit /= 8;
		System.out.println("Number of loops:" + limit);
		EDSensor edSensor[] = new EDSensor[limit];
		EDSensor t = new EDSensor();
		for (int i = 0, ind = 0; i < limit; i++, ind++) {
			System.out.println("tipo: " + edSensorArray[ind]);
			t.setType(edSensorArray[ind]);
			t.setTopic(edSensorArray[++ind]);
			System.out.println("topic: " + edSensorArray[ind]);
			t.setMode(edSensorArray[++ind]);
			System.out.println("mode:: " + t.getMode());
			t.setLambda(Integer.parseInt(edSensorArray[++ind]));
			System.out.println("lambda: " + t.getLambda());
			
			String[] array = new String[1];
			array[0] = edSensorArray[++ind];
			t.setData(array);
			System.out.println("data: " + t.getData()[0]);
			if (edSensorArray.length > ind + 1) {
				System.out.println("entrou no if1");
				if (edSensorArray[ind + 1].length() != 0) {
					String[] array1 = new String [1];
					array1[0] = edSensorArray[ind + 1];
					t.setMax(array1);
					System.out.println("Setando max no sensor: " + t.getMax()[0]);
				} else {
					t.setMax(setMax(t.getData()[0]));
				}
			}else {
				t.setMax(setMax(t.getData()[0]));
			}
			ind++;
			if (edSensorArray.length > ind + 1) {
				System.out.println("entrou no if2");
				if (edSensorArray[ind + 1].length() != 0) {
					String[] array2 = new String [1];
					array2[0] = edSensorArray[ind + 1];
					t.setMin(array2);
					System.out.println("Setando min no sensor: " + t.getMin()[0]);
				}else {
					t.setMin(setMin(t.getData()[0]));
				}
			}	 else {
				t.setMin(setMin(t.getData()[0]));
			}
			ind++;
			edSensor[i] = t;
			//System.out.println("no parse MAX: "+tdSensor[i].getMax()[0] +" MIN: "+tdSensor[i].getMin()[0] );  
			t = new EDSensor();
		}
		System.out.println("FIM PARSE ED");
		return edSensor;
	}


	private TDSensor[] parseTD(String s) {
		System.out.println(s);
		String[] tdSensorArray = s.split(";");
		System.out.println("Number of items:" + tdSensorArray.length);
		int limit = tdSensorArray.length;
		if (tdSensorArray.length >= 3)
			while (limit % 7 != 0 && isNumeric(tdSensorArray[3])) {
				System.out.println("VALOR NO ARRAY:" + tdSensorArray[3]);
				limit++;
			}
		limit /= 7;
		System.out.println("Number of loops:" + limit);
		TDSensor tdSensor[] = new TDSensor[limit];
		TDSensor t = new TDSensor();
		for (int i = 0, ind = 0; i < limit; i++, ind++) {
			System.out.println("tipo: " + tdSensorArray[ind]);
			t.setType(tdSensorArray[ind]);
			t.setTopic(tdSensorArray[++ind]);
			System.out.println("topic: " + tdSensorArray[ind]);
			t.setPeriodicity(Integer.parseInt(tdSensorArray[++ind]));
			System.out.println("periodicidade: " + t.getPeriodicity());
			t.setNumberOfDevices(Integer.parseInt(tdSensorArray[++ind]));
			System.out.println("number of Devices: " + t.getPeriodicity());
			String[] array = new String[1];
			array[0] = tdSensorArray[++ind];
			t.setData(array);
			System.out.println("data: " + t.getData()[0]);
			System.out.println(tdSensorArray.length + "  " + (ind + 1));
			if (tdSensorArray.length > ind + 1) {
				System.out.println("entrou no if1");
				if (tdSensorArray[ind + 1].length() != 0) {
					String[] array1 = new String [1];
					array1[0] = tdSensorArray[ind + 1];
					t.setMax(array1);
					System.out.println("Setando max no sensor: " + t.getMax()[0]);
				} else {
					t.setMax(setMax(t.getData()[0]));
				}
			}else {
				t.setMax(setMax(t.getData()[0]));
			}
			ind++;
			if (tdSensorArray.length > ind + 1) {
				System.out.println("entrou no if2");
				if (tdSensorArray[ind + 1].length() != 0) {
					String[] array2 = new String [1];
					array2[0] = tdSensorArray[ind + 1];
					t.setMin(array2);
					System.out.println("Setando min no sensor: " + t.getMin()[0]);
				}else {
					t.setMin(setMin(t.getData()[0]));
				}
			}	 else {
				t.setMin(setMin(t.getData()[0]));
			}
			ind++;
			tdSensor[i] = t;
			//System.out.println("no parse MAX: "+tdSensor[i].getMax()[0] +" MIN: "+tdSensor[i].getMin()[0] );  
			t = new TDSensor();
		}
		return tdSensor;
	}

	private String[] setMax(String data) {

		System.out.println("vazio max");
		String[] array = new String[1];
		switch (data) {
		case "int":
			array[0] = String.valueOf(Integer.MAX_VALUE);
			break;
		case "float":
			array[0] = "1";
			break;
		case "boolean":
			array[0] = "true";
			break;
		case "char":
			array[0] = "~";
			break;
		default:
			break;

		}
		return array;
	}

	private String[] setMin(String data) {

		System.out.println("vazio min");
		String[] array = new String[1];
		switch (data) {
		case "int":
			array[0] = String.valueOf(Integer.MIN_VALUE);
			break;
		case "float":
			array[0] = String.valueOf("0");
			break;
		case "boolean":
			array[0] = "false";
			break;
		case "char":
			array[0] = " ";
			break;
		default:
			break;
		}

		return array;
	}
	public EDSensor[] concat(EDSensor[] a, EDSensor[] b) {
		int aLen = a.length;
		int bLen = b.length;
		EDSensor[] c = new EDSensor[aLen + bLen];
		System.arraycopy(a, 0, c, 0, aLen);
		System.arraycopy(b, 0, c, aLen, bLen);
		return c;
	}

	public TDSensor[] concat(TDSensor[] a, TDSensor[] b) {
		int aLen = a.length;
		int bLen = b.length;
		TDSensor[] c = new TDSensor[aLen + bLen];
		System.arraycopy(a, 0, c, 0, aLen);
		System.arraycopy(b, 0, c, aLen, bLen);
		return c;
	}

}

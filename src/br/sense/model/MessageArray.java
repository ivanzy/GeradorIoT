package br.sense.model;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.sql.Timestamp;

import br.sense.code.Param;
import br.sense.code.RandomController;

public class MessageArray {
	protected static Message[] msg = new Message[50];
	protected static int acc = 0, msgCont = 0, i = 0;
	protected static String accString;
	protected static Date date;
	private static final int numberOfLines = 20;
	private static int cont = 0;
	private static String[] cSensor = { "", "", "", "" };
	private static int[] msgTemporalLine = new int[20];

	public static void clean() {
		for (String c : cSensor)
			c = "";
		msgTemporalLine = new int[20];
		msg = new Message[50];

	}

	private static String s = "0;0;0/0;0;0";

	public static String callTemporalLine() {
		if (msgCont == 0) {
			return s;
		} else {

			msgTemporalLine[i] = msgCont;
			msgCont = 0;
			i++;
			if (i > 19)
				i = 0;
			String s1 = "";
			s = "";
			int j = 0;

			for (int temp = 1; j < msgTemporalLine.length && msgTemporalLine[j] > 0; j++, temp++) {
				s += msgTemporalLine[j] + ";";
				s1 += (10 * temp) + ";";
			}
			if (s.length() > 0) {
				s = (s.substring(0, s.length() - 1));
				s1 = (s1.substring(0, s1.length() - 1));
				s = s1 + "/" + s;
			}
			return s;
		}
	}

	public static void setMsg(String m, Date date, String t) {
		Message message = new Message();
		String[] msgs = m.split(";");
		String[] type = msgs[0].split("=");
		String[] payload = msgs[2].split("=");
		if (payload[1].length() > 20)
			payload[1] = payload[1].substring(0, 20);
		String[] id = msgs[1].split("=");
		message.setId(id[1]);
		message.setType(type[1]);
		message.setPayload(payload[1]);
		String dateT = (date.toString()).substring(3, 19);
		message.setDate(dateT);
		message.setTimestamp(date.getTime());
		message.setTopic(t);
		if (acc > numberOfLines - 1) {
			acc = 0;
		}
		msg[acc++] = message;
		msgCont++;
	}

	public static void orderArray() {
		for (int i = 0; i < 1; i++) {
			Arrays.sort(msg);
		}
	}

	public static String showMessage() {
		String m = "<table style=\"font-size: 13px; line-height: 1.328;\" class=\"table table-sm\"> <thead> <tr> <th>ID</th> <th>Type</th> <th>Topic</th>  <th style=\"width: 150px\">Payload</th> <th>Time</th> </tr> </thead> <tbody>";
		String color = "";

		for (int i = 0; msg[i] != null && i < numberOfLines - 1; i++) {
			m += "<tr style=\"background-color:" + getColor(msg[i].getType()) + ";\" >";

			m += "<td >" + msg[i].getId() + "</td>";
			m += "<td >" + msg[i].getType() + "</td>";
			m += "<td>" + msg[i].getTopic() + "</td>";
			m += "<td>" + msg[i].getPayload() + "</td>";
			m += "<td>" + msg[i].getDate() + "</td></tr>";
			// System.out.println("Type:"+msg[i].getType());
			// System.out.println("Payload:"+msg[i].getPayload());
			// System.out.println("Date:"+msg[i].getDate());
		}
		m += "</tbody></table>";
		return m;
	}

	public static String showExpInfo() {
		String s = "";

		return s;
	}

	private static String getColor(String color) {
		String c = new String();
		switch (color) {
		case "structural":
			c = getColor(1);
			break;
		case "air":
			c = getColor(2);
			break;
		case "traffic":
			c = getColor(3);
			break;
		case "noise":
			c = getColor(4);
			break;
		case "waste":
			c = getColor(5);
			break;
		case "light":
			c = "Yellow";
			break;
		case "FlowOfPeople":
			c = "Yellow";
			break;
		default:
			defineColor(color);
			if (color.equals(cSensor[0])) {
				c = getColor(9);
			} else if (color.equals(cSensor[1])) {
				c = getColor(6);
			} else if (color.equals(cSensor[2])) {
				c = getColor(7);
			} else if (color.equals(cSensor[3])) {
				c = getColor(8);
			} else {
				c = getColor(10);
			}
			break;
		}

		return c;
	}

	private static void defineColor(String color) {
		if (!color.equals(cSensor[0]) && !color.equals(cSensor[1]) && !color.equals(cSensor[2])
				&& !color.equals(cSensor[3])) {
			cSensor[cont] = color;
			cont++;
		}
	}

	private static String getColor(int type) {
		String color = "";
		switch (type) {
		case 1:
			color = "SpringGreen";
			break;
		case 2:
			color = "SteelBlue";
			break;
		case 3:
			color = "Violet";
			break;
		case 4:
			color = "Tomato";
			break;
		case 5:
			color = "Turquoise";
			break;
		case 6:
			color = "Orange";
			break;
		case 7:
			color = "Cyan";
			break;
		case 8:
			color = "Grey";
			break;
		case 9:
			color = "PowderBlue";
			break;
		case 10:
			color = "Wheat";
			break;
		case 11:
			color = "SteelBlue";
			break;
		}
		return color;

	}

	public static Message[] getMsg() {
		return msg;
	}

	public static void setMsg(Message[] msg) {
		MessageArray.msg = msg;
	}

	public static int getAcc() {
		return acc;
	}

	public static void setAcc(int acc) {
		MessageArray.acc = acc;
	}

	public static String getAccString() {
		return accString;
	}

	public static void setAccString(String accString) {
		MessageArray.accString = accString;
	}

}

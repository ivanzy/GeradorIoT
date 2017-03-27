package br.sense.code;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.concurrent.Semaphore;
import java.util.concurrent.atomic.AtomicInteger;

public class IdController {
	private static int id_air = 1;
	private static int id_traffic = 1;
	private static int id_noise = 1;
	private static int id_structural = 1;
	private static int id_waste = 1;
	private static int id_default = 1;
    private static AtomicInteger auid = new AtomicInteger(0);
    public static void setAtomicInteger(){
    	auid.set(Param.uid);
    }
	public static int getId(String type) {
		int id;
		switch (type) {
		case "air":
			id = id_air++;
			break;
		case "traffic":
			id = id_traffic++;
			break;
		case "noise":
			id = id_noise++;
			break;
		case "structural":
			id = id_structural++;
			break;
		case "waste":
			id = id_waste++;
			break;
		default:
			id = id_default++ ;
			break;
		}
		return id;
	}
	public static void resetIds(){
		id_waste=id_air=id_traffic=id_noise=id_structural=id_default=0;
	}
	
	private int id;
	public void setId(){
		this.id =1;
	}
	public int getId(){
		return id++;
	}
	
	
	

	public static int getUid() {
		Param.uid = auid.incrementAndGet();
		return Param.uid;
	}

	static private void writeFile(int count) throws IOException {
		PrintWriter pw = new PrintWriter("id.txt");
		pw.close();
		File arquivo = new File("id.txt");
		arquivo = new File("id.txt");
		try (FileWriter fw = new FileWriter(arquivo, true); BufferedWriter bw = new BufferedWriter(fw)) {
			bw.write(String.valueOf(count));
		}
	}
	static public void resetUid(int count) throws IOException {
		PrintWriter pw = new PrintWriter("id.txt");
		pw.close();
		File arquivo = new File("id.txt");
		arquivo = new File("id.txt");
		try (FileWriter fw = new FileWriter(arquivo, true); BufferedWriter bw = new BufferedWriter(fw)) {
			bw.write(String.valueOf(1));
		}
	}

	static private int readFile() throws FileNotFoundException, IOException {
		String num;
		try (BufferedReader br = new BufferedReader(new FileReader("id.txt"))) {
//			StringBuilder sb = new StringBuilder();
			String line = br.readLine();
//			while (line != null) {
//				sb.append(line);
//				sb.append(System.lineSeparator());
//				line = br.readLine();
//			}
			num = line.toString();
		}
		return Integer.parseInt(num);
	}


}

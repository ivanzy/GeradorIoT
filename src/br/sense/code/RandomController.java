package br.sense.code;

import java.util.Random;

public class RandomController {
	static Random rand = new Random();

	static void setSeed() {
		// rand.setSeed(Param.seed[Param.replication]);
		rand.setSeed(System.currentTimeMillis());
	}

	static float nextFloat() {
		return rand.nextFloat();
	}
	static float nextFloat(float max, float min) {
		
		return (rand.nextFloat()* (max - min) + min);
	}

	static int nextInt() {
		int temp = rand.nextInt();
		if(temp < 0)
			temp *= -1;
		return temp;
		
	}


	static char nextChar(){
		return (char)(rand.nextInt(126-32)+32); //32-126
	}

	static char nextChar(char max, char min){
		return (char)(rand.nextInt(max-min)+min); //32-126
	}
	
	static int nextInt(int l) {
		return rand.nextInt(l);
	}
	
	static boolean nextBoolean(){
		return rand.nextBoolean();
	}

	static long nextLong(long n) {
		// error checking and 2^x checking removed for simplicity.
		long bits, val;
		do {
			bits = (rand.nextLong() << 1) >>> 1;
			val = bits % n;
		} while (bits - val + (n - 1) < 0L);
		return val;

	}
}

package com.dev801.xplaneinfo;

import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

public class UDPListener extends Thread {
	private static final Logger LOGGER = LoggerFactory.getLogger(UDPListener.class);
	static int messageLength = 36;

	public static boolean keepRunning = true;

	public static Map<Integer, List<Float>> blork = new HashMap();

	public static void main(String... arg) {
		new UDPListener().start();
	}

	@Override
	public void run() {
		int port = 49003;
		byte[] buf = new byte[1024];

		LOGGER.info("Starting up...\n\n");

		try (DatagramSocket ds = new DatagramSocket(port)) {
			DatagramPacket p = new DatagramPacket(buf, buf.length);

			while (keepRunning) {
				ds.receive(p);

				// LOGGER.info("Got data. Received: {} bytes: ", p.getLength());

				examine(p.getData(), p.getLength());
			}
		} catch (Exception e) {
			LOGGER.error("", e);
		}

		LOGGER.info("\n\nShutting down...");
	}

	private void examine(byte[] pbuf, int plen) {
		for (int x = 5; x <= plen - 1; x += messageLength) {
			blork.putAll(blah(Arrays.copyOfRange(pbuf, x, x + messageLength)));

			// LOGGER.info("\n\n");
		}
	}

	private Map<Integer, List<Float>> blah(byte[] pbuf) {
		List<Float> dataList = Lists.newArrayList();

		int x = 0;
		x = 0;
		byte[] bytex = new byte[] { pbuf[x], pbuf[++x], pbuf[++x], pbuf[++x] };
		int type = ByteBuffer.wrap(bytex).order(ByteOrder.LITTLE_ENDIAN).getInt();
		// LOGGER.info("type = {}", type);

		int q = x + 1;
		// int counter1 = 0;
		for (int i = q; i < messageLength; i += 4) {
			byte[] bytes = new byte[] { pbuf[i], pbuf[i + 1], pbuf[i + 2], pbuf[i + 3] };
			float f = ByteBuffer.wrap(bytes).order(ByteOrder.LITTLE_ENDIAN).getFloat();
			// LOGGER.info("f{} = {}", counter1++, String.format("%.6f ", f));
			dataList.add(f);
		}

		Map<Integer, List<Float>> m = Maps.newHashMap();
		m.put(type, dataList);

		return m;
	}
}

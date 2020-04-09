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

				LOGGER.debug("Got data. Received: {} bytes: ", p.getLength());

				blork = new HashMap();
				examine(p.getData(), p.getLength());
			}
		} catch (Exception e) {
			LOGGER.error("", e);
		}

		LOGGER.info("\n\nShutting down...");
	}

	private void examine(byte[] pbuf, int plen) {
		for (int x = 5; x <= plen - 1; x += messageLength) {
			blork.putAll(parseData(Arrays.copyOfRange(pbuf, x, x + messageLength)));

			LOGGER.debug("\n\n");
		}
	}

	private Map<Integer, List<Float>> parseData(byte[] pbuf) {
		List<Float> dataList = Lists.newArrayList();

		StringBuilder sb = new StringBuilder();

		int x = 0;
		x = 0;
		byte[] bytex = new byte[] { pbuf[x], pbuf[++x], pbuf[++x], pbuf[++x] };
		int type = ByteBuffer.wrap(bytex).order(ByteOrder.LITTLE_ENDIAN).getInt();
		LOGGER.debug("type = {}", type);
		sb.append("type = " + type + " \t ");

		int q = x + 1;
		int counter1 = 0;
		for (int i = q; i < messageLength; i += 4) {
			byte[] bytes = new byte[] { pbuf[i], pbuf[i + 1], pbuf[i + 2], pbuf[i + 3] };
			float f = ByteBuffer.wrap(bytes).order(ByteOrder.LITTLE_ENDIAN).getFloat();
			// LOGGER.debug("f{} = {}", counter1++, String.format("%.6f ", f));
			dataList.add(f);
			sb.append("f" + counter1++ + " = ");
			sb.append(String.format("%.6f ", f) + " :: ");
		}

		LOGGER.debug(sb.toString());

		Map<Integer, List<Float>> m = Maps.newHashMap();
		m.put(type, dataList);

		return m;
	}
}

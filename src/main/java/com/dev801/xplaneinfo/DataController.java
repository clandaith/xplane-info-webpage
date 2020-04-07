package com.dev801.xplaneinfo;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DataController {

	private static final Logger LOGGER = LoggerFactory.getLogger(DataController.class);

	@GetMapping("/data/hello")
	public String index() {
		LOGGER.info("Where in DataController");
		return "hello";
	}

	@GetMapping("/data/info")
	public Data getInfo() {
		Map<Integer, List<Float>> blork = UDPListener.blork;
		Data data = new Data();

		data.setTransponder(blork != null && blork.containsKey(104) ? "" + blork.get(104).get(1).intValue() : "none");
		data.setRpm(blork != null && blork.containsKey(37) ? "" + blork.get(37).get(0).intValue() : "0");
		data.setLatitude(blork != null && blork.containsKey(20) ? blork.get(20).get(0).toString() : "0");
		data.setLongitude(blork != null && blork.containsKey(20) ? blork.get(20).get(1).toString() : "0");
		data.setSpeed(blork != null && blork.containsKey(3) ? "" + blork.get(3).get(0).intValue() : "0");
		data.setAltitude(blork != null && blork.containsKey(20) ? "" + blork.get(20).get(5).intValue() : "0");
		data.setCompass(blork != null && blork.containsKey(19) ? "" + blork.get(19).get(0).intValue() : "0");

		return data;
	}
}

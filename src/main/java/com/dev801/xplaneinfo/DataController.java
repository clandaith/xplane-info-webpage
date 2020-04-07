package com.dev801.xplaneinfo;

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

	@GetMapping("/data/transponder")
	public Holder transponder() {
		return new Holder(); // UDPListener.blork != null && UDPListener.blork.containsKey(104) ?
								// UDPListener.blork.get(104).get(1) : 0f;
	}

	@GetMapping("/data/latitude")
	public String latitude() {
		return UDPListener.blork != null && UDPListener.blork.containsKey(20)
				? UDPListener.blork.get(20).get(0).toString()
				: "0";
	}

}

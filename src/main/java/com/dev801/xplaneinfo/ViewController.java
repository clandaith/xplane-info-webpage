package com.dev801.xplaneinfo;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ViewController {

	private static final Logger LOGGER = LoggerFactory.getLogger(ViewController.class);

	@GetMapping("/")
	public String index(Model model) {
		LOGGER.info("Where in main controller.");

		Map<Integer, List<Float>> blork = UDPListener.blork;

		// 132 1 = climb rate
		// 20 3 = feet abobe ground level

		model.addAttribute("transponder",
				blork != null && blork.containsKey(104) ? blork.get(104).get(1).intValue() : "");

		return "map";
	}

	@GetMapping("/stop")
	public String stop() {
		LOGGER.info("Shutting down UDP");
		UDPListener.keepRunning = false;
		LOGGER.info("UDP stopped");
		return "map";
	}
}

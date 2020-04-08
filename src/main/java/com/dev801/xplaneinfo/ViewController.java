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

		model.addAttribute("transponder", blork != null && blork.containsKey(104) ? blork.get(104).get(1) : "none");

		model.addAttribute("rpms", blork != null && blork.containsKey(37) ? blork.get(37).get(0) : "0");

		model.addAttribute("latitude", blork != null && blork.containsKey(20) ? blork.get(20).get(0) : "0");
		model.addAttribute("longitude", blork != null && blork.containsKey(20) ? blork.get(20).get(1) : "0");

		model.addAttribute("speed", blork != null && blork.containsKey(3) ? blork.get(3).get(0) : "0");

		model.addAttribute("altitude", blork != null && blork.containsKey(20) ? blork.get(20).get(5) : "0");

		model.addAttribute("compass", blork != null && blork.containsKey(19) ? blork.get(19).get(0) : "0");

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

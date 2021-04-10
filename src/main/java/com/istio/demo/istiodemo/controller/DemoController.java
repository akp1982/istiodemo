package com.istio.demo.istiodemo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DemoController {
	@GetMapping("/list")
	public List demoMethod() {
		System.out.println("Request-Received-Version-1");
		List<String> l = new ArrayList<String>();
	
		l.add("Version-1\n");
		
		return l;
	}
}

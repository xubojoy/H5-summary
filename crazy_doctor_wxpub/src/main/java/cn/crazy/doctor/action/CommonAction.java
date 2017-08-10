package cn.crazy.doctor.action;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/common")
public class CommonAction{
	
	@RequestMapping(value = "/map") 
	public String map(@RequestParam(value="longitude" , required=false , defaultValue="")  String longitude,
			@RequestParam(value="latitude" , required=false , defaultValue="") String latitude,
			@RequestParam(value="address" , required=false , defaultValue="") String address,
			ModelMap model){
		model.put("longitude", longitude);
		model.put("latitude", latitude);
		model.put("address", address);
		return "map";
	}
	
	
	
}

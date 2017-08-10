package cn.crazy.doctor.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SpecialOrderAction {
	
	@RequestMapping(value = "/specialOrder") 
	public String specialOrder(){
		return "specialOrder/specialOrder";
	}
	
	
}

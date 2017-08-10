package cn.crazy.doctor.action;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/login")
public class LoginAction {
	
	@RequestMapping(value = "") 
	public String toLoginPage(@RequestParam(value="backUrl" , required=false , defaultValue="")  String backUrl,ModelMap model){
		if(!"".equals(backUrl)){
			model.put("backUrl", backUrl);
		}
		return "login";
	}
	
	
}

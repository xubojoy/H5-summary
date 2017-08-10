package cn.crazy.doctor.action;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.crazy.doctor.domain.order.DoctorOrder;
import com.crazy.doctor.domain.order.ProjectOrder;
import com.crazy.doctor.domain.order.SpecialOrder;

import cn.crazy.doctor.service.MineService;

@Controller
public class MineAction {
	
	@Autowired
	private MineService mineService;
	
	@RequestMapping(value = "/mine") 
	public String mine(){
		return "/mine/mine";
	}
	
	@RequestMapping(value = "/personInfo") 
	public String personInfo(){
		return "/mine/person";
	}
	
	@RequestMapping(value = "/myOrders") 
	public String myOrders(@RequestParam(value="orderType" , required=false , defaultValue="projects")  String orderType,ModelMap model){
		if("projects".equals(orderType)){
			model.put("orderType", "预约理疗");
		}else if("doctors".equals(orderType)){
			model.put("orderType", "预约医生");
		}
		return "/mine/myOrders";
	}
	
	@RequestMapping(value = "/mySpecialOrders") 
	public String mySpecialOrders(){
		return "/mine/mySpecialOrders";
	}
	
	@RequestMapping(value = "/myOrders/{id}/project") 
	public String projectOrder(@PathVariable("id") int id,HttpServletRequest request,ModelMap model){
		String accessToken = request.getAttribute("accessToken").toString();
		ProjectOrder order = mineService.findProjectOrderById(id,accessToken);
		model.put("order", order);
		return "/mine/projectOrder";
	}
	
	@RequestMapping(value = "/myOrders/{id}/doctor") 
	public String doctorOrder(@PathVariable("id") int id,HttpServletRequest request,ModelMap model){
		String accessToken = request.getAttribute("accessToken").toString();
		DoctorOrder order = mineService.findDoctorOrderById(id,accessToken);
		model.put("order", order);
		return "/mine/doctorOrder";
	}
	
	@RequestMapping(value = "/myOrders/{id}/special") 
	public String specialOrder(@PathVariable("id") int id,HttpServletRequest request,ModelMap model){
		String accessToken = request.getAttribute("accessToken").toString();
		SpecialOrder order = mineService.findSpecialOrderById(id,accessToken);
		model.put("order", order);
		return "/mine/specialOrder";
	}
	
	@RequestMapping(value = "/myInfo") 
	public String myInfo(){
		return "/mine/myInfo";
	}

	@RequestMapping(value = "/myOrders/{id}/evaluate") 
	public String evaluate(@PathVariable("id") int id,HttpServletRequest request,ModelMap model){
		String accessToken = request.getAttribute("accessToken").toString();
		ProjectOrder order = mineService.findProjectOrderById(id,accessToken);
		model.put("order", order);
		return "/mine/evaluation";
	}
	
	@RequestMapping(value = "/protocol") 
	public String protocol(@RequestParam(value="backUrl" , required=false , defaultValue="")  String backUrl,ModelMap model){
		if(!"".equals(backUrl)){
			model.put("backUrl", backUrl);
		}
		return "/mine/protocol";
	}
	
	
}

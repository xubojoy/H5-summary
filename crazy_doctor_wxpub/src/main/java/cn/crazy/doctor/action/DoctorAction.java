package cn.crazy.doctor.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.crazy.doctor.domain.organization.Doctor;

import cn.crazy.doctor.service.DoctorService;

@Controller
public class DoctorAction {
	
	@Autowired
	private DoctorService doctorService;
	
	@RequestMapping(value = "/doctors") 
	public String toDoctorsPage(){
		return "/doctorOrder/doctors";
	}
	
	@RequestMapping(value = "/doctors/{doctorId}") 
	public String doctor(@PathVariable("doctorId") int doctorId,ModelMap model){
		Doctor doctor = doctorService.findDoctorById(doctorId);
		model.put("doctor", doctor);
		return "/doctorOrder/doctor";
	}
	
	@RequestMapping(value = "/doctors/{doctorId}/order") 
	public String order(@PathVariable("doctorId") int doctorId,ModelMap model,
			String orderDate,String orderHalfDay
			){
		Doctor doctor = doctorService.findDoctorById(doctorId);
		model.put("doctor", doctor);
		model.put("orderDate", orderDate);
		model.put("orderHalfDay",orderHalfDay);
		return "/doctorOrder/order";
	}
	
	@RequestMapping(value = "/doctors/{doctorId}/orderConfirm") 
	public String orderConfirm(@PathVariable("doctorId") String doctorId){
		return "/doctorOrder/orderConfirm";
	}
	
	
	
}

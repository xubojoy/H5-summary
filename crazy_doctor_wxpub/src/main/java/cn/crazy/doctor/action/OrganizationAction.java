package cn.crazy.doctor.action;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.crazy.doctor.domain.organization.Organization;

import cn.crazy.doctor.service.OrganizationService;

@Controller
public class OrganizationAction {
	
	@Autowired
	private OrganizationService organizationService;
	
	@RequestMapping(value = "/organizations/{organizationId}") 
	public String organization(@PathVariable("organizationId") int organizationId,ModelMap model){
		Organization organization = organizationService.findOrganizationById(organizationId);
		model.put("organization", organization);
		return "projectOrder/organization";
	}
	
	
}

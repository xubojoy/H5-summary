package cn.crazy.doctor.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.crazy.doctor.domain.organization.Project;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.crazy.doctor.service.ProjectService;

@Controller
public class ProjectAction {
	
	@Autowired
	private ProjectService projectService;
	
	@RequestMapping(value = "/projects") 
	public String projects(@RequestParam(value="feature" , required=false , defaultValue="")  String feature,
			@RequestParam(value="organizationId" , required=false , defaultValue="0")  int organizationId,
			ModelMap model){
		if(!"".equals(feature)){
			model.put("feature",feature);
		}
		if(organizationId > 0){
			model.put("organizationId", organizationId);
		}
		return "projectOrder/projects";
	}
	
	@RequestMapping(value = "/projects/{projectId}") 
	public String project(@PathVariable("projectId") int projectId,ModelMap model){
		Project project = projectService.findProjectById(projectId);
		model.put("project", project);
		return "projectOrder/project";
	}
	
	@RequestMapping(value = "/projects/{projectId}/evaluation") 
	public String evaluation(@PathVariable("projectId") String projectId,ModelMap model){
		model.put("projectId", projectId);
		return "projectOrder/projectEvaluation";
	}
	
	
	@RequestMapping(value = "/projects/{projectId}/order") 
	public String order(@PathVariable("projectId") int projectId,ModelMap model,
			@RequestParam(value="backUrl" , required=false , defaultValue="")  String backUrl
			){
		if(!"".equals(backUrl)){
			model.put("backUrl", backUrl);
		}
		Project project = projectService.findProjectById(projectId);
		model.put("project", project);
		
		return "projectOrder/order";
	}
	
	@RequestMapping(value = "/projects/{projectId}/orderConfirm") 
	public String orderConfirm(@PathVariable("projectId") String projectId){
		return "projectOrder/orderConfirm";
	}
	
}

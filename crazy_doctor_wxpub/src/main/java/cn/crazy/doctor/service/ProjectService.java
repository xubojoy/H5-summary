package cn.crazy.doctor.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import cn.crazy.doctor.common.Constant;
import com.crazy.doctor.domain.organization.Project;
@Service
public class ProjectService {
	
	@Autowired 
	public RestTemplate restTemplate;
	
	public Project findProjectById(int projectId){
		String url = Constant.getServiceUrl() + "/projects/"+projectId;
		ResponseEntity<Project> responseEntity = restTemplate.getForEntity(url, Project.class);
		return responseEntity.getBody();
	}
	
}

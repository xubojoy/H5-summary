package cn.crazy.doctor.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import cn.crazy.doctor.common.Constant;

import com.crazy.doctor.domain.organization.Organization;
@Service
public class OrganizationService {
	
	@Autowired 
	public RestTemplate restTemplate;
	
	public Organization findOrganizationById(int organizationId){
		String url = Constant.getServiceUrl() + "/organizations/"+organizationId;
		ResponseEntity<Organization> responseEntity = restTemplate.getForEntity(url, Organization.class);
		return responseEntity.getBody();
	}
	
}

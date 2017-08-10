package cn.crazy.doctor.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import cn.crazy.doctor.common.Constant;

import com.crazy.doctor.domain.organization.Doctor;
@Service
public class DoctorService {
	
	@Autowired 
	public RestTemplate restTemplate;
	
	public Doctor findDoctorById(int doctorId){
		String url = Constant.getServiceUrl() + "/doctors/"+doctorId;
		ResponseEntity<Doctor> responseEntity = restTemplate.getForEntity(url, Doctor.class);
		return responseEntity.getBody();
	}
	
}

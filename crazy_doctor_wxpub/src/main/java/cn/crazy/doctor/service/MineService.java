package cn.crazy.doctor.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import cn.crazy.doctor.common.Constant;

import com.crazy.doctor.domain.order.DoctorOrder;
import com.crazy.doctor.domain.order.ProjectOrder;
import com.crazy.doctor.domain.order.SpecialOrder;
@Service
public class MineService {
	
	@Autowired 
	public RestTemplate restTemplate;
	
	public ProjectOrder findProjectOrderById(int id,String accessToken){
		String url = Constant.getServiceUrl() + "/projectOrders/"+id+"?Authorization="+accessToken;
		ResponseEntity<ProjectOrder> responseEntity = restTemplate.getForEntity(url, ProjectOrder.class);
		return responseEntity.getBody();
	}
	
	public DoctorOrder findDoctorOrderById(int id,String accessToken){
		String url = Constant.getServiceUrl() + "/doctorOrders/"+id+"?Authorization="+accessToken;
		ResponseEntity<DoctorOrder> responseEntity = restTemplate.getForEntity(url, DoctorOrder.class);
		return responseEntity.getBody();
	}
	
	public SpecialOrder findSpecialOrderById(int id,String accessToken){
		String url = Constant.getServiceUrl() + "/specialOrders/"+id+"?Authorization="+accessToken;
		ResponseEntity<SpecialOrder> responseEntity = restTemplate.getForEntity(url, SpecialOrder.class);
		return responseEntity.getBody();
	}
	
}

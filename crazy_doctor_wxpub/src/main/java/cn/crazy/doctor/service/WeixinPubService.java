package cn.crazy.doctor.service;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.DeserializationConfig.Feature;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import cn.crazy.doctor.common.Constant;
import cn.crazy.doctor.domain.SystemRecord;
import cn.crazy.doctor.domain.WxEntity;
import cn.crazy.doctor.domain.WxUser;
import cn.crazy.doctor.utils.StringUtil;

@Service
public class WeixinPubService {

	@Autowired 
	public RestTemplate restTemplate;
	
	private static final SystemRecord systemRecord = new SystemRecord();
	
	/**
	 * 获取access token
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String getWXAccessToken(){
		if(systemRecord == null || systemRecord.isAccessTokenExpired()){
			RestTemplate restTemplate = new RestTemplate();
			String url = String.format(Constant.getWxAccessTokenUrl(),
										Constant.getWxpubAppId(), Constant.getWxpubAppSecret());
			Map<String ,Object> result = restTemplate.getForObject(url, Map.class);
			String weixin_access_token = (String)result.get("access_token");
			if(StringUtils.isBlank(weixin_access_token)){
				String title = "获取微信accessToken失败";
				this.parseResponseResult(result, title);
				weixin_access_token = "";
			}
			systemRecord.setAccessToken(weixin_access_token);
			systemRecord.setAccessTokenLastUpdateTime(Calendar.getInstance().getTime().getTime());
		}
		return systemRecord.getAccessToken();
	}
	
	/**
	 * 解析返回的状态信息
	 * @param result
	 */
	private void parseResponseResult(Map<String ,Object> result , String title){
		Integer errcode = (Integer)result.get("errcode");
		if(errcode != 0){
			String receiver = "huanying@golfd.cn";
			String content = String.format("错误码:%d \n 错误信息:%s",  
											(Integer)result.get("errcode"), 
											(String)result.get("errmsg"));
		}
	}
		
	public Map<String, String> queryJsapiTicket(String pageUrl) {
		if( systemRecord == null || null == systemRecord.getJsapiTicket() || systemRecord.isJsapiTicketExpired()){
			RestTemplate restTemplate = new RestTemplate();
			String url = String.format(Constant.getWxJsapiTicketUrl(), getWXAccessToken() );
			ResponseEntity<Map> response = restTemplate.getForEntity(url, Map.class);
			Map<String,Object> result = response.getBody();
			String ticket = (String)result.get("ticket");
			systemRecord.setJsapiTicket(ticket);
			systemRecord.setJsapiTicketLastUpdateTime(Calendar.getInstance().getTime().getTime());
		}
		
		String noncestr = RandomStringUtils.random(16, true, true);
		String timestamp = new Date().getTime()+"";
		String str = String.format("jsapi_ticket=%s&noncestr=%s&timestamp=%s&url=%s", systemRecord.getJsapiTicket() , noncestr , timestamp , pageUrl);
		String signature = StringUtil.sha1(str);
		Map<String ,String> params = new HashMap<String ,String>();
		params.put("nonceStr", noncestr);
		params.put("jsapi_ticket", systemRecord.getJsapiTicket());
		params.put("timestamp", timestamp);
		params.put("signature", signature);
		params.put("appId", Constant.getWxpubAppId());
		return params;
	}
	
	@SuppressWarnings("unchecked")
	public String fetchWXOpenId(String code) {
		RestTemplate restTemplate = new RestTemplate();
		String url = String.format("https://api.weixin.qq.com/sns/oauth2/access_token?appid=%s&secret=%s&code=%s&grant_type=%s",
					Constant.getWxpubServiceAppId(),Constant.getWxpubServiceAppSecret(),code,"authorization_code");
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity reqeust = new HttpEntity(headers);
		ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, reqeust, String.class);
		System.out.println("response的值为"+response);
		String body =  response.getBody();
		return body;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public WxEntity fetchWXEntiy(String code) {
		RestTemplate restTemplate = new RestTemplate();
		String url = String.format("https://api.weixin.qq.com/sns/oauth2/access_token?appid=%s&secret=%s&code=%s&grant_type=%s",
				Constant.getWxpubServiceAppId(),Constant.getWxpubServiceAppSecret(),code,"authorization_code");
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity reqeust = new HttpEntity(headers);
		ResponseEntity<String> response =  restTemplate.exchange(url, HttpMethod.GET, reqeust, String.class);
		
		WxEntity wx = null;
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.configure(Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		try {
			wx = objectMapper.readValue(response.getBody(), WxEntity.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return wx;
	}
	
	/*
	 * <200 OK,{"access_token":"OezXcEiiBSKSxW0eoylIeHkW3Ltr4ZU_mMgjpmFoGWSSKffqNBeVt1RjIirT1fMnwW89KTqLlmuCARqywmxOnuTExAje8vk75RP3XSMbl-mcK_t0Jcqj44-K9_ZClBPjUWQOa0JwNIikVr-LHqcblw","expires_in":7200,"refresh_token":"OezXcEiiBSKSxW0eoylIeHkW3Ltr4ZU_mMgjpmFoGWSSKffqNBeVt1RjIirT1fMnvV1wt2TJI3H3NXJNY16LuvNVgVsYgbjYY05lhT4BkbYFmffPEdzxgicFbgiT9FAbpUUgzIQiN68HiA7ccxpd6Q","openid":"oSSd9s2li3mAuLr7aXuOxbJEChi8","scope":"snsapi_base","unionid":"oYvO5t9qVAvdQmTSBjxKSXGSuqrQ"},{Server=[nginx/1.8.0], Date=[Thu, 30 Jul 2015 09:43:32 GMT], Content-Type=[text/plain], Content-Length=[459], Connection=[keep-alive]}>
	 *
	 *<200 OK,{"errcode":40029,"errmsg":"invalid code"},{Server=[nginx/1.8.0], Date=[Thu, 30 Jul 2015 09:56:48 GMT], Content-Type=[text/plain], Content-Length=[41], Connection=[keep-alive]}>
	 */
	@SuppressWarnings("unchecked")
	public String fetchWXOpenidCode(String redirectUrl) {
		RestTemplate restTemplate = new RestTemplate();
		String url = String.format("https://open.weixin.qq.com/connect/oauth2/authorize?appid=%s&redirect_uri=%s&response_type=code&scope=snsapi_base&state=STETE#wechat_redirect",
					Constant.getWxpubServiceAppId(),redirectUrl);
		System.out.println("获取code的Url为:"+url);
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity reqeust = new HttpEntity(headers);
		ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, reqeust, String.class);
		System.out.println("response的值为"+response);
		String body =  response.getBody();
		return body;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public WxUser fetchWxUser(WxEntity wxEntiy ) {
		RestTemplate restTemplate = new RestTemplate();
		String url = String.format("https://api.weixin.qq.com/sns/userinfo?access_token=%s&openid=%s&lang=zh_CN",
				wxEntiy.getAccess_token(),wxEntiy.getOpenid());
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity reqeust = new HttpEntity(headers);
		ResponseEntity<String> response =  restTemplate.exchange(url, HttpMethod.GET, reqeust, String.class);
		
		WxUser wx = null;
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.configure(Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		try {
			wx = objectMapper.readValue(response.getBody(), WxUser.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return wx;
	}
	
	public String findAccessToken(){
		return systemRecord.getAccessToken();
	}
	
	
	
}

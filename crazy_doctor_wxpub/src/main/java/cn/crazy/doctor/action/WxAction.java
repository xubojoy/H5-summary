package cn.crazy.doctor.action;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.crazy.doctor.service.WeixinPubService;


@Controller
public class WxAction {
	
	@Autowired 
	private WeixinPubService weixinPubService;

	/**
	 * 获取微信jsapi_ticket
	 */
	@ResponseBody
	@RequestMapping(value="/wx/jsapi/ticket" , method = RequestMethod.GET)
	public ResponseEntity<Map<String ,String>> getJsapi(@RequestParam("url") String url){
		try {
			url = URLDecoder.decode(url, "UTF8");
			Map<String ,String> result = weixinPubService.queryJsapiTicket(url);
			return new ResponseEntity<Map<String ,String>>(result , HttpStatus.OK);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * 获取微信jsapi_ticket
	 */
	@ResponseBody
	@RequestMapping(value="/wx/accessToken" , method = RequestMethod.GET)
	public ResponseEntity<String> accessToken(){
		String acessToken = weixinPubService.findAccessToken();
		return new ResponseEntity<String>(acessToken , HttpStatus.OK);
	}
	


}

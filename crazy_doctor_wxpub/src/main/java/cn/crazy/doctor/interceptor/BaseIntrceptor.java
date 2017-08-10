package cn.crazy.doctor.interceptor;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.ui.ModelMap;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.context.request.WebRequestInterceptor;

import cn.crazy.doctor.common.Constant;

import com.mysql.jdbc.StringUtils;

public class BaseIntrceptor  implements WebRequestInterceptor{

	@Override
	public void afterCompletion(WebRequest arg0, Exception arg1)
			throws Exception {
		
	}

	@Override
	public void postHandle(WebRequest arg0, ModelMap arg1) throws Exception {
		
	}

	@Override
	public void preHandle(WebRequest request) throws Exception {
		String accessToken = this.readCookieByKey(request, "Access-Token");
		if(!StringUtils.isNullOrEmpty(accessToken)){
			request.setAttribute("accessToken",accessToken,WebRequest.SCOPE_REQUEST);
		}
		String Authorization = request.getParameter("Authorization");
		String noHeaderFlag  = request.getParameter("noHeaderFlag");
		String noFooterFlag = request.getParameter("noFooterFlag");
		if(!StringUtils.isNullOrEmpty(Authorization)){
			request.setAttribute("Authorization",Authorization,WebRequest.SCOPE_REQUEST);
		}
		if(!StringUtils.isNullOrEmpty(noHeaderFlag)){
			request.setAttribute("noHeaderFlag",noHeaderFlag,WebRequest.SCOPE_REQUEST);
		}
		if(!StringUtils.isNullOrEmpty(noFooterFlag)){
			request.setAttribute("noFooterFlag",noFooterFlag,WebRequest.SCOPE_REQUEST);
		}
		String footerName = request.getParameter("footerName");
		if(!StringUtils.isNullOrEmpty(footerName)){
			request.setAttribute("footerName",footerName,WebRequest.SCOPE_REQUEST);
		}
		
		request.setAttribute("mobileUrl",Constant.getMobileUrl(),WebRequest.SCOPE_SESSION);
		request.setAttribute("apiUrl", Constant.getServiceUrl(),WebRequest.SCOPE_SESSION);
		request.setAttribute("domainUrl", Constant.getDomainUrl(),WebRequest.SCOPE_SESSION);
	}
	
	
	public String readCookieByKey(WebRequest request,String keyStr){
		Map<String,String> cookieMap = new HashMap<String,String>();
	    String[] cookies = request.getHeaderValues("Cookie");
	    if(null!=cookies){
	        for(String cookie : cookies){
	        	String[] cookieStrs = cookie.split(";");
	        	for(String cookieStr : cookieStrs){
	        		String[]  cookieStrss = cookieStr.split("=");
	        		try {
						cookieMap.put(cookieStrss[0].trim(), java.net.URLDecoder.decode(cookieStrss[1],"utf-8"));
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
	        	}
	        }
	    }
	    return cookieMap.get(keyStr);
	}

}

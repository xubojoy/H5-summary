package cn.crazy.doctor.domain;

import java.util.Date;

import javax.persistence.Transient;

import org.apache.commons.lang.StringUtils;

public class SystemRecord {

	private int id;
	private String accessToken;
	private String jsapiTicket;
	private long accessTokenLastUpdateTime;
	private long jsapiTicketLastUpdateTime;
	private Date createTime;
	private String wxType;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getAccessToken() {
		return accessToken;
	}
	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}
	
	public String getJsapiTicket() {
		return jsapiTicket;
	}
	public void setJsapiTicket(String jsapiTicket) {
		this.jsapiTicket = jsapiTicket;
	}
	
	public long getAccessTokenLastUpdateTime() {
		return accessTokenLastUpdateTime;
	}
	public void setAccessTokenLastUpdateTime(long accessTokenLastUpdateTime) {
		this.accessTokenLastUpdateTime = accessTokenLastUpdateTime;
	}
	
	public long getJsapiTicketLastUpdateTime() {
		return jsapiTicketLastUpdateTime;
	}
	public void setJsapiTicketLastUpdateTime(long jsapiTicketLastUpdateTime) {
		this.jsapiTicketLastUpdateTime = jsapiTicketLastUpdateTime;
	}

	
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public String getWxType() {
		return wxType;
	}
	public void setWxType(String wxType) {
		this.wxType = wxType;
	}
	
	@Transient
	public boolean isAccessTokenExpired(){
		if(StringUtils.isBlank(this.getAccessToken()) || (new Date().getTime()) >= (this.getAccessTokenLastUpdateTime() + 7200*1000)){
			return true;
		}
		return false;
	}
	
	@Transient
	public boolean isJsapiTicketExpired(){
		if(StringUtils.isBlank(this.getJsapiTicket()) || (new Date().getTime()) >= (this.getJsapiTicketLastUpdateTime() + 7200*1000)){
			return true;
		}
		return false;
	}
	
}

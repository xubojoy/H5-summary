<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"></meta>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name='apple-touch-fullscreen' content='yes'>
<meta name="full-screen" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta name="format-detection" content="address=no">
<meta http-equiv="mobile-agent" content="format=xhtml" charset="UTF-8"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="domainUrl" value="${domainUrl}" />
<c:set var="mobileUrl" value="${mobileUrl}"/>
<c:set var="apiUrl" value="${apiUrl}"/>
<c:set var="pageTitle" value="疯狂太医"></c:set>
<!-- 
<script type="text/javascript" src="http://cdn.bootcss.com/jquery/2.2.1/jquery.min.js"></script>
<script type="text/javascript" src="http://cdn.bootcss.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
 -->
<link rel="stylesheet" type="text/css" href="<c:url value="/js/libs/bootstrap/css/bootstrap.min.css"/>" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/mobile.css"/>" />
<script type="text/javascript" src="<c:url value="/js/libs/jquery/jquery.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/mobile/base_mobile.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/libs/jquery/json2.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/libs/bootstrap/js/bootstrap.min.js"/>" ></script>
<script type="text/javascript" src="<c:url value="/js/libs/jquery/jquery.browser.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/libs/jquery/jquery.cookie.js"/>"></script>
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=e93b3a9f534b95f95997fe365295d0ee"  /></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"/></script> 
<script type="text/javascript">
var mobileUrl = '${mobileUrl}';
var apiUrl = '${apiUrl}';
if(mobileUrl != ''){
	window.localStorage.setItem('crazy_doctor_mobileUrl',mobileUrl);
}else{
	mobileUrl = window.localStorage.getItem('crazy_doctor_mobileUrl');
}

if(apiUrl != ''){
	window.localStorage.setItem('crazy_doctor_apiUrl',apiUrl);
}else{
	mobileUrl = window.localStorage.getItem('crazy_doctor_apiUrl');
}

var lng = window.localStorage.getItem('crazy_doctor_user_lng');
var lat = window.localStorage.getItem('crazy_doctor_user_lat');
AMap.service(["AMap.Geolocation"], function() {
	var geoOptions={ 
			enableHighAccuracy:true,  //是否使用高精度
			timeout:10000,    //若在指定时间内未定位成功，返回超时错误信息。默认无穷大。
	}; 
	var geolocation=new AMap.Geolocation(geoOptions);
	geolocation.getCurrentPosition() ;
	AMap.event.addListener(geolocation, "complete", function(result){
		lat = result.position.getLat();
        lng = result.position.getLng();
       	window.localStorage.setItem('crazy_doctor_user_lng',lng);
       	window.localStorage.setItem('crazy_doctor_user_lat',lat);
	});
});
$().ready(function(){
	var noHeaderFlag = null;
	
	if('${noHeaderFlag}' != '' ){
		noHeaderFlag  = '${noHeaderFlag}';
		window.localStorage.setItem('noHeaderFlag',noHeaderFlag);
	}else{
		noHeaderFlag  =  window.localStorage.getItem('noHeaderFlag');
	}
	if( noHeaderFlag == '0'){
		$('#header').css('display','none');
	}else{
		$('#header').css('display','block');
	}
	var Authorization = null;
	if('${Authorization}' != ''){
		Authorization  = '${Authorization}';
		window.localStorage.setItem('Authorization',Authorization);
	}else{
		Authorization = window.localStorage.getItem('Authorization');
	}
	if( '${Authorization}' != ''){
		var params = {
			Authorization	:  Authorization	
		}
		CrazyDoctor.User.ininUserInfo(params);
	}
	
	var noFooterFlag  =null;
	if(  '${noFooterFlag}' != ''){
		noFooterFlag = '${noFooterFlag}';
		window.localStorage.setItem('noFooterFlag',noFooterFlag);
	}else{
		noFooterFlag = window.localStorage.getItem('noFooterFlag');
	}
	if( noFooterFlag == '0' ){
		$('#footerBar').css('display','none');
	}else{
		$('#footerBar').css('display','block');
	}
	var backUrl = '${backUrl}';
	$('#header .back').click(function(){
		if( backUrl !=''){
			window.location.href  = backUrl;
		}else{
			var path = CrazyDoctor.history.preView();
			window.location.href  = path;
		}
	});
	
	var currentPath = window.location.href;
	CrazyDoctor.history.putView(currentPath);
	
	
	
	
	var currentUrl = window.location.href.split("#")[0];
	currentUrl = encodeURIComponent(currentUrl);
	var url = "${mobileUrl}/wx/jsapi/ticket?url="+currentUrl;
	$.ajax({
		url : url,
		type : "GET",
		success : function(data){
	    	wx.config({
	    	    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	    	    appId: data.appId, // 必填，公众号的唯一标识
	    	    timestamp: data.timestamp, // 必填，生成签名的时间戳
	    	    nonceStr: data.nonceStr, // 必填，生成签名的随机串
	    	    signature: data.signature,// 必填，签名，见附录1
	    	    jsApiList: ['previewImage' , 'uploadImage' , 'chooseImage','onMenuShareTimeline','onMenuShareAppMessage','onMenuShareQQ'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	    	});
	    	wx.ready(function(){
				
	    	});
	    	wx.error(function(res){
	    	});
			
		}
	});

	
});
</script>
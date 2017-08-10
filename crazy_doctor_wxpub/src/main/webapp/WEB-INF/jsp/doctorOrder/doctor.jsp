<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
#main .visitInfo li:nth-child(1){
	min-height:42px;
}
</style>
<script type="text/javascript" src="<c:url value="/js/libs/jquery/jquery-dateFormat.js"/>"></script>
<title>${pageTitle }</title>
</head>
<body>
<div id="main" class="bg_f4">
	<section id="header" class="bg_white">
		<span class="back font_dark_gray font14">返回</span>
		<span class="title font_dark_brown font17"><b>预约医生</b></span>	
	</section>
	<div class="info bg_white">
		<ul>
			<li>
				<span class="font16 font_gray"><b>${doctor.name }</b></span>
				<span class="font13 font_dark_brown" style="margin-left:20px;">${doctor.level }</span>
			</li>
			<li>
				<span class="font14 font_dark_gray">${doctor.hospital.name }</span>
			</li>
			<li>
				<span class="font12 font_gray">${doctor.intro }</span>
			</li>
			<li>
				<span class="font14 font_gray" style="margin-right:15px;position:absolute;margin-top:10px;">擅长</span>
				<div class="skillList">
					<c:forEach items="${fn:split(doctor.skills,',')}" var="skill" varStatus="index"> 
						<span class="doctor_skill_tag font12 font_shallow_brown">${skill }</span>
					</c:forEach>
				</div>
			</li>
		</ul>
		<div class="imgBox" style="position: absolute;right:15px;top: 44px;">
			<img src="${doctor.avatarUrl}" />
			<span class="bg_white font10 font_deep_gray">${doctor.workAge}年经验</span>
		</div>
	</div>
	<div class="w100p15 address bg_white toMap">
		<span class="font_gray font14" style="line-height:45px;">地址</span>
		<span class="location_sign" style="vertical-align:middle"></span>
		<span class="addr font15 font_dark_brown textOverFlow"><b>${doctor.hospital.address }</b></span>
		<span class="rightArrow"></span>
	</div>
	<ul class="visitInfo bg_white w100p15">
		<li class="font14 font_gray">
			出诊信息
		</li>
		<!-- 
		<c:forEach items="${doctor.workTimes }" var="workTime">
			<li datetime="${workTime.date }" class="timeInfo" onclick="toOrder('${workTime.date }','${workTime.halfDay }','${workTime.callCount}')">
				<span class="font15 font_dark_gray">
					<b>${workTime.date }</b><font style="margin-left:10px"><b>${workTime.halfDay }</b></font>
					<font class="font12">剩余号数：${workTime.callCount }</font>
				</span>
				<c:choose>
					<c:when test="${workTime.callCount gt 0 }">
						<span class="font15 font_white bg_dark_brown">预约</span>
					</c:when>
					<c:otherwise>
					<span class="font15 font_white bg_gray">预约</span>
					</c:otherwise>
				</c:choose>
			</li>
		</c:forEach>
		 -->
	</ul>
</div>
<script type="text/javascript">
$().ready(function(){
	var option ={
			methodType	:	'GET',
			url			:	 'doctors/${doctor.id}',
			params		:	null
	};
	var successCB = function(data){
		var items = data.workTimes;
		for(var i=0;i<items.length;i++){
			var dateTime = items[i].date;
			if(new Date(dateTime).getTime() >= new Date($.format.date(new Date(), 'yyyy/MM/dd')).getTime() ){
				var liHtml = '<li  class="timeInfo" onclick=toOrder("'+items[i].date+'","'+items[i].halfDay+'","'+items[i].callCount+'")>';
				liHtml += '<span class="font15 font_dark_gray">';
				liHtml += '<b>'+items[i].date+'</b><font style="margin-left:10px;margin-right:5px;"><b>'+items[i].halfDay+'</b></font>';
				liHtml += '<font class="font12">剩余号数：'+items[i].callCount+'</font>';
				liHtml +='</span>';
				if(items[i].callCount >0 ){
					liHtml += '<span class="font15 font_white bg_dark_brown">预约</span>';
				}else{
					liHtml += '<span class="font15 font_white bg_gray">预约</span>';
				}
				liHtml +='</li>';
				$('.visitInfo').append(liHtml);
			}
		}
		
	};
	commonAjax(option,successCB);
	
	
	$('.toMap').click(function(){
		window.location.href = mobileUrl + '/common/map?longitude=${doctor.hospital.latitude}&latitude=${doctor.hospital.longitude}&address=${doctor.hospital.address}' ;
	});
});

var toOrder = function(orderDate,orderHalfDay,count){
	if(count == 0 ){
		return;
	}
	var path= mobileUrl + '/doctors/${doctor.id}/order?orderDate='+orderDate+"&orderHalfDay="+orderHalfDay;
	if(!CrazyDoctor.User.isLogin()){
		path = encodeURIComponent(path);
		window.location.href = mobileUrl + '/login?backUrl=' +path;
		return ;
	}else{
		window.location.href= path;
	}
};
</script>
</body>
</html>
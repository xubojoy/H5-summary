<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<c:url value='/js/mobile/projectOrder.js' /> "></script>
<title>${pageTitle }</title>
</head>
<body>
<div id="main" class="bg_f4" style="height:auto;">
	<section id="header" class="bg_white">
		<span class="back font_dark_gray font14">返回</span>
		<span class="title font_dark_brown font17"><b>预约详情</b></span>	
	</section>
	<div class="projectDetailBox" class="bg_f4">
	<div class="doctorInfo">
		<ul class="w100m15 bg_white">
			<li>
				<span class="font14 font_gray">理疗项目</span>
				<span class="font16 font_dark_gray" style="margin-left:13px;"><b>理疗</b></span>
			</li>
			<li class="content">
				<span class="font14 font_gray">理疗院名</span>
				<span class="font16 font_dark_gray" style="margin-left:13px;"><b>长安协和医院</b></span>
			</li>
			<li class="content">
				<span class="font14 font_gray">理疗店地址</span>
				<span class="font16 font_dark_gray"><b>爱的飒大大叔的爱大啊啊</b></span>
			</li>
			<li class="content">
				<span class="font14 font_gray">理疗店电话</span>
				<span class="font16 font_dark_gray"><b>010-231321</b></span>
			</li>
		</ul>
	</div>
	<ul class="visitInfo w100p15 bg_white patientInfo">
		<li>
			<span class="font15 font_gray">到诊人姓名</span>
			<span class="font16 font_dark_gray orderRightInfo ">沾上干</span>
		</li>
		<li>
			<span class="font15 font_gray">到诊人电话</span>
			<span class="font16 font_dark_gray orderRightInfo">18013131212</span>
		</li>
		<li>
			<span class="font15 font_gray">到诊人年龄</span>
			<span class="font16 font_dark_gray orderRightInfo">33</span>
		</li>
		<li>
			<span class="font_gray font15">到诊人性别</span>
			<span class="rightArrow"></span>
			<font class="font16 font_dark_gray" style="float:right;line-height:45px;">女</font>
		</li>
		<li>
			<span class="font15 font_dark_gray">到诊日期</span>
			<span class="rightArrow"></span>
			<font class="font16 font_dark_red" style="float:right;line-height:45px;"><b>2016/06/03</b></font>
		</li>
		<li>
			<span class="font15 font_dark_gray">到诊具体时间</span>
			<span class="rightArrow"></span>
			<font class="font16 font_dark_red" style="float:right;line-height:45px;"><b>13:03</b></font>
		</li>
	</ul>
	</div>
	<div class="footerBtn bg_white orderButton" >
		<span class="orderBtn font18 font_white bg_dark_brown">立即预约</span>	
	</div>
	
	
	<div class="full_mask">
	</div>
	<!-- 
	<div class="modalDialog bg_white">
		<span class="font17 font_gray"></span>
		<ul >
			<li class="font18 font_deep_gray cancelBtn">取消</li>
			<li class="font18 font_dark_brown confirmBtn">确定</li>
		</ul>
	</div> -->
	
	<div class="modalDialog bg_white" style="background:url('../../images/bg_popup_box_popup.png');background-size:100% 100%">
	</div>
</div>

</body>
</html>
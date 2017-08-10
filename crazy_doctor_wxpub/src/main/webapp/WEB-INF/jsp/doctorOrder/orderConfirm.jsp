<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<c:url value='/js/mobile/doctorOrder.js' /> "></script>
<title>${pageTitle }</title>
</head>
<body>
<div id="main" class="bg_f4" style="height:auto;">
	<section id="header" class="bg_white">
		<span class="back font_dark_gray font14">返回</span>
		<span class="title font_dark_brown font17"><b>预约详情</b></span>	
	</section>
	<div class="doctorInfo">
		<ul class="w100m15 bg_white">
			<li>
				<span class="font14 font_gray">医生姓名</span>
				<span class="font16 font_dark_gray"><b>理疗</b></span>
				<span class="font13 font_dark_brown" style="margin-left:20px;">主任医师</span>
			</li>
			<li class="content">
				<span class="font14 font_gray">医生名称</span>
				<span class="font16 font_dark_gray"><b>长安协和医院</b></span>
			</li>
			<li class="content">
				<span class="font14 font_gray">医生地址</span>
				<span class="font16 font_dark_gray"><b>爱的飒大大叔的爱大啊啊</b></span>
			</li>
			<li class="content">
				<span class="font14 font_gray">医生电话</span>
				<span class="font16 font_dark_gray"><b>010-231321</b></span>
			</li>
		</ul>
	</div>
	<ul class="visitInfo w100p15 bg_white patientInfo">
		<li>
			<span class="font15 font_gray">到诊人姓名</span>
			<span class="font16 font_dark_gray">沾上干</span>
		</li>
		<li>
			<span class="font15 font_gray">到诊人电话</span>
			<span class="font16 font_dark_gray">18013131212</span>
		</li>
		<li>
			<span class="font15 font_gray">到诊人年龄</span>
			<span class="font16 font_dark_gray">33</span>
		</li>
		<li>
			<span class="font_gray font15">到诊人性别</span>
			<span class="rightArrow"></span>
			<font class="font16 font_dark_gray" style="float:right;line-height:45px;">女</font>
		</li>
		<li>
			<span class="font15 font_dark_gray">预约日期</span>
			<div class="time">
				<span class="font16 font_dark_red"><b>2016/06/03</b></span>
				<span class="font16 font_dark_red"><b>下午</b></span>
			</div>
		</li>
	</ul>
	<div class="footerBtn bg_white orderButton" >
		<span class="orderBtn font18 font_white bg_dark_brown">立即预约</span>	
	</div>
	
	
	<div class="full_mask">
	</div>
	
	<div class="modalDialog bg_white">
		<span class="font17 font_gray"></span>
		<ul >
			<li class="font18 font_deep_gray cancelBtn">取消</li>
			<li class="font18 font_dark_brown confirmBtn">确定</li>
		</ul>
	</div>
</div>

</body>
</html>
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
	<div class="projectDetailBox" class="bg_f4">
	<div class="doctorInfo">
		<ul class="w100m15 bg_white">
			<li>
				<span class="font14 font_gray">医生姓名</span>
				<span class="font16 font_dark_gray"><b>${doctor.name }</b></span>
				<span class="font13 font_dark_brown" style="margin-left:20px;">${doctor.level }</span>
			</li>
			<li class="content">
				<span class="font14 font_gray">医院名称</span>
				<span class="font16 font_dark_gray"><b>${doctor.hospital.name }</b></span>
			</li>
			<li class="content">
				<span class="font14 font_gray">医生地址</span>
				<span class="font16 font_dark_gray"><b>${doctor.hospital.address}</b></span>
			</li>
			<li class="content" onclick="window.location.href='tel:${doctor.hospital.tel}' ">
				<span class="font14 font_gray">医生电话</span>
				<span class="font16 font_dark_gray"><b>${doctor.hospital.tel }</b></span>
			</li>
		</ul>
	</div>
	<ul class="visitInfo w100p15 bg_white patientInfo">
		<li class="orderName_input">
			<input type="text" name="orderName" onblur="DoctorOrderVM.changeInputInfo('orderName','name')" class="font_dark_gray font15" placeholder="请输入就诊人姓名" />
		</li>
		<li class="orderName_content" style="display:none" onclick="DoctorOrderVM.backEdit('orderName')">
			<span class="font_gray font15">就诊人姓名</span>
			<span class="font16 font_dark_gray orderRightInfo val" ></span>
		</li>
		<li class="orderMobileNo_input">
			<input type="tel" name="orderMobileNo" min="11" maxLength="11" onblur="DoctorOrderVM.changeInputInfo('orderMobileNo','tel')" class="font_dark_gray font15" placeholder="请输入就诊人电话" />
		</li>
		<li class="orderMobileNo_content" style="display:none" onclick="DoctorOrderVM.backEdit('orderMobileNo')">
			<span class="font_gray font15">就诊人电话</span>
			<span class="font16 font_dark_gray orderRightInfo val"></span>
		</li>
		<li class="orderAge_input">
			<input type="text" name="orderAge" onkeyup="value=value.replace(/[^\d]/g,'');" onblur="DoctorOrderVM.changeInputInfo('orderAge','age')" maxLength="3" class="font_dark_gray font15" placeholder="请输入就诊人年龄" />
		</li>
		<li class="orderAge_content" style="display:none" onclick="DoctorOrderVM.backEdit('orderAge')">
			<span class="font_gray font15">就诊人年龄</span>
			<span class="font16 font_dark_gray orderRightInfo val"></span>
		</li>
		<li class="selectSex">
			<span class="font_gray font15">就诊人性别</span>
			<span class="rightArrow">
			<font  class="sexText" ></font>
			</span>
		</li>
		<li class="orderDate">
			<span class="font15 font_dark_gray">预约日期</span>
			<div class="time">
				<span class="font16 font_dark_red"><b>${orderDate}</b></span>
				<span class="font16 font_dark_red"><b>${orderHalfDay }</b></span>
			</div>
		</li>
	</ul>
	</div>
	<div class="footerBtn bg_white" onclick="DoctorOrderVM.createProjectOrder()">
		<span class="orderBtn font18 font_white bg_dark_brown">立即预约</span>	
	</div>
	
	<div class="sexItems bg_f4">
		<span class="font16 font_dark_gray bg_white sex">女</span>	
		<span class="font16 font_dark_gray bg_white sex">男</span>
		<span class="font16 font_dark_gray bg_white button">取消</span>
	</div>
	
	<div class="full_mask">
	</div>
	
	<div class="successModalDialog bg_white" >
		<span onclick="DoctorOrderVM.hideSuccessModel()"></span>
		<img src="<c:url value='/images/bg_word_commit_success.png' />" class="successWord" />
	</div>
</div>
<script type="text/javascript">
var doctorId = '${doctorId}';
var orderDate = '${orderDate}';
var orderHalfDay  = '${orderHalfDay}';
</script>
</body>
</html>
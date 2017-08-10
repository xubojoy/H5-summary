<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<c:url value='/js/mobile/projectOrder.js' /> "></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/js/libs/mobiscroll/css/mobiscroll.core-2.5.2.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/js/libs/mobiscroll/css/mobiscroll.animation-2.5.2.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/js/libs/mobiscroll/css/mobiscroll.android-ics-2.5.2.css"/>"/>
<script type="text/javascript" src="<c:url value='/js/libs/mobiscroll/js/mobiscroll.core-2.5.2.js' /> "></script>
<script type="text/javascript" src="<c:url value='/js/libs/mobiscroll/js/mobiscroll.core-2.5.2-zh.js' /> "></script>
<script type="text/javascript" src="<c:url value='/js/libs/mobiscroll/js/mobiscroll.datetime-2.5.1.js' /> "></script>
<script type="text/javascript" src="<c:url value='/js/libs/mobiscroll/js/mobiscroll.datetime-2.5.1-zh.js' /> "></script>
<script type="text/javascript" src="<c:url value="/js/libs/jquery/jquery-dateFormat.js"/>"></script>
<script type="text/javascript">
var projectId = '${project.id}';
var organizationId = '${project.organization.id}';
</script>
<title>${pageTitle }</title>
</head>
<body>
<div id="main" class="bg_f4" style="height:auto;">
	<section id="header" class="bg_white" >
		<span class="back font_dark_gray font14">返回</span>
		<span class="title font_dark_brown font17"><b>理疗详情</b></span>	
	</section>
	<div class="projectDetailBox" class="bg_f4">
	<div class="doctorInfo" style="height:auto">
		<ul class="w100m15 bg_white  organizationInfo">
			<li>
				<span class="font14 font_gray">理疗项目</span>
				<span class="font16 font_dark_gray" style="margin-left:13px;"><b>${project.name }</b></span>
			</li>
			<li class="content">
				<span class="font14 font_gray">理疗院名</span>
				<span class="font16 font_dark_gray" style="margin-left:13px;"><b>${project.organization.name }</b></span>
			</li>
			<li class="content">
				<span class="font14 font_gray">理疗店地址</span>
				<span class="font16 font_dark_gray"><b>${project.organization.address }</b></span>
			</li>
			<li class="content" onclick="window.location.href='tel:${project.organization.phone }' ">
				<span class="font14 font_gray">理疗店电话</span>
				<span class="font16 font_dark_gray"><b>${project.organization.phone }</b></span>
			</li>
		</ul>
	</div>
	<ul class="visitInfo w100p15 bg_white patientInfo">
		<li class="orderName_input">
			<input type="text" name="orderName"  onblur="ProjectOrderVM.changeInputInfo('orderName','name')" class="font_dark_gray font15" placeholder="请输入就诊人姓名" />
		</li>
		<li class="orderName_content" style="display:none" onclick="ProjectOrderVM.backEdit('orderName')">
			<span class="font_gray font15">就诊人姓名</span>
			<span class="font16 font_dark_gray orderRightInfo val" ></span>
		</li>
		<li class="orderMobileNo_input">
			<input type="tel" name="orderMobileNo" maxLength="11" min="11" onblur="ProjectOrderVM.changeInputInfo('orderMobileNo','tel')" class="font_dark_gray font15" placeholder="请输入就诊人电话" />
		</li>
		<li class="orderMobileNo_content" style="display:none" onclick="ProjectOrderVM.backEdit('orderMobileNo')">
			<span class="font_gray font15">就诊人电话</span>
			<span class="font16 font_dark_gray orderRightInfo val"></span>
		</li>
		<li class="orderAge_input">
			<input type="text" name="orderAge" onkeyup="value=value.replace(/[^\d]/g,'');" onblur="ProjectOrderVM.changeInputInfo('orderAge','age')" maxLength="3" class="font_dark_gray font15" placeholder="请输入就诊人年龄" />
		</li>
		<li class="orderAge_content" style="display:none" onclick="ProjectOrderVM.backEdit('orderAge')">
			<span class="font_gray font15">就诊人年龄</span>
			<span class="font16 font_dark_gray orderRightInfo val"></span>
		</li>
		<li class="selectSex">
			<span class="font_gray font15">就诊人性别</span>
			<span class="rightArrow">
			<font  class="sexText" ></font>
			</span>
		</li>
		<li class="dateTimeMouble">
			<label class="font15 font_gray"  style="width:60px;" for="projectDateSelect">就诊日期</label>
			<input type="text" class="dateTimePicker font_dark_red font16"  readOnly id="projectDateSelect" style="width: -moz-calc(100%  - 65px);  width: -webkit-calc(100% - 65px);width: calc(100% - 65px);font-weight:bold"/>
		</li>
		<li class="dateTimeMouble">
			<label class="font15 font_gray"  style="width:100px;" for="projectTimeSelect">到诊具体时间</label>
			<input type="text" class="dateTimePicker font_dark_red font16"  readOnly id="projectTimeSelect" style="width: -moz-calc(100%  - 105px);  width: -webkit-calc(100% - 105px);width: calc(100% - 105px);font-weight:bold"/>
		</li>
	</ul>
	</div>
	<div class="footerBtn bg_white" onclick="ProjectOrderVM.createProjectOrder();" >
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
		<span onclick="ProjectOrderVM.hideSuccessModel()"></span>
		<img src="../../images/bg_word_commit_success.png" class="successWord" />
	</div>
</div>
</body>
</html>
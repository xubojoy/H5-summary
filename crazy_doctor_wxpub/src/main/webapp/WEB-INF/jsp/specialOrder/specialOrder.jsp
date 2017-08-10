<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
#main .orderPersonInfo>li>span{
	padding-top:0;
}

#main .orderPersonInfo>li>span:nth-child(1){
	width: 75px;
	position: absolute;
    margin-top: 15px;
}

#main .orderPersonInfo>li>span:nth-child(2){
	width: -moz-calc(100% - 130px);
    width: -webkit-calc(100% - 130x);
    width: calc(100% - 130px);
    padding-right: 22px;
    text-align: right;
    margin-left: 130px;
    float:none;
}

.sexSpan{
    margin-right:-3px;
}

</style>
<script type="text/javascript">
	if(CrazyDoctor.User.isLogin()){
		var initUserInfoCB = function(data){
		}
		CrazyDoctor.User.ininUserInfo(null,initUserInfoCB);
	}else{
		window.localStorage.removeItem('crazy_doctor_user');
		var path = window.location.href ;
		path = encodeURIComponent(path);
		window.location.href = mobileUrl + '/login?backUrl=' +path+'&t='+Math.random();
	}
</script>
<script type="text/javascript" src="<c:url value='/js/mobile/specialOrder.js' /> "></script>
<title>${pageTitle }</title>
</head>
<body>
<div id="main" class="bg_f4">
	<section id="header" class="bg_white">
		<span class="title font_dark_brown font17"><b>预约特需</b></span>	
	</section>
	<div class="projectDetailBox">
	<ul class="w100p15 bg_white orderPersonInfo">
		<li>
			<span class="font15 font_gray">患者姓名</span>
			<span><input type="text" class="font15 font_deep_gray" onblur="SpecialOrderVM.checkInput('patientName','name')" name="patientName" placeholder="请输入患者姓名" /></span>
		</li>
		<li class="selectSex">
			<span class="font15 font_gray">患者性别</span>
			<span class="sexSpan"><input type="text" class="font15 font_deep_gray" style=""  name="patientGender" readOnly placeholder="请输入患者性别" />
			</span>
			<font class="rightArrow" style="position: relative;right:0;margin-top:-35px;float:right"></font>
		</li>
		<li>
			<span class="font15 font_gray">患者年龄</span>
			<span><input type="text" class="font15 font_deep_gray" onkeyup="value=value.replace(/[^\d]/g,'')" onblur="SpecialOrderVM.checkInput('patientAge','age')" name="patientAge" maxLength="3"  placeholder="请输入患者年龄" /></span>
		</li>
		<li>
			<span class="font15 font_gray">预约人姓名</span>
			<span><input type="text" class="font15 font_deep_gray" name="orderName" onblur="SpecialOrderVM.checkInput('orderName','name')" placeholder="请输入预约人姓名" /></span>
		</li>
		<li>
			<span class="font15 font_gray">预约人电话</span>
			<span><input type="tel" class="font15 font_deep_gray"  min="11" maxLength="11" onblur="SpecialOrderVM.checkInput('orderMobileNo','tel')" name="orderMobileNo" placeholder="请输入预约人电话" /></span>
		</li>
		<li>
			<span class="font15 font_gray">预约医院</span>
			<span><input type="text" class="font15 font_deep_gray" name="hospital"  placeholder="请输入预约医院" /></span>
		</li>
		<li>
			<span class="font15 font_gray">预约科室</span>
			<span><input type="text" class="font15 font_deep_gray" name="department" placeholder="请输入预约科室" /></span>
		</li>
		<li>
			<span class="font15 font_gray">预约大夫</span>
			<span><input type="text" class="font15 font_deep_gray" name="doctor" placeholder="请输入预约大夫" /></span>
		</li>
	</ul>
	
	<ul class="serviceList w100p15 bg_white">
		<li class="font13 font_gray" name="booking"><img class="icon_select" src="<c:url value='/images/icon_xuanze_nor.png' />" />预订票服务(汽车票 火车票 飞机票)</li>
		<li class="font13 font_gray" name="shuttle"><img class="icon_select" src="<c:url value='/images/icon_xuanze_nor.png' />" />接送站服务</li>
		<li class="font13 font_gray" name="charteredCar"><img class="icon_select" src="<c:url value='/images/icon_xuanze_nor.png' />" />包车服务</li>
		<li class="font13 font_gray" name="hotel"><img class="icon_select" src="<c:url value='/images/icon_xuanze_nor.png' />" />预定酒店服务</li>
		<li class="font13 font_gray" name="accompany"><img class="icon_select" src="<c:url value='/images/icon_xuanze_nor.png' />" />陪诊服务</li>
		<li class="font13 font_gray" name="guide"><img class="icon_select" src="<c:url value='/images/icon_xuanze_nor.png' />" />导诊服务</li>
	</ul>
	<div class="w100p15 bg_white specialRemark" >
		<textarea class="font12 font_deep_gray"  placeholder="备注"  ></textarea>	
	</div>
	<div class="w100p15 bg_white specialButton" onclick="SpecialOrderVM.createOrder();">
		<button  class="font18 bg_dark_brown font_white">提交</button>
	</div>
	</div>
	<jsp:include page="../common/footer.jsp?footerName=special"></jsp:include>
	
	<div class="full_mask">
	</div>
	
	<div class="sexItems bg_f4">
		<span class="font16 font_dark_gray bg_white sex">女</span>	
		<span class="font16 font_dark_gray bg_white sex">男</span>
		<span class="font16 font_dark_gray bg_white button">取消</span>
	</div>
	
	<div class="successModalDialog bg_white" >
		<span onclick="SpecialOrderVM.hideSuccessModel()"></span>
		<img src="<c:url value='/images/bg_word_commit_success.png' />" class="successWord" />
	</div>
</div>

<script type="text/javascript">
$().ready(function(){
	SpecialOrderVM.selectSex();
	SpecialOrderVM.selectService();
});
</script>
</body>
</html>
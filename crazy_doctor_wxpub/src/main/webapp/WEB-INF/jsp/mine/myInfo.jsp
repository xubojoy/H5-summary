<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
#main .projectDetailBox{
    width: 100%;
    height: -moz-calc(100% - 44px);
    height: -webkit-calc(100% - 44px);
    height: calc(100% - 44px);
}

#main .myInfo>li{
	height:50px;
    line-height:50px;
}

#main .myInfo>li:before{
	content: "";
	position:absolute;
	left:0;
	right:0;
	border-top: 1px solid #dddddd;
	-webkit-transform: scaleY(.5);
	-webkit-transform-origin: 0 0;
}

#main .myInfo>li:nth-child(1):before{
	content: "";
	position:absolute;
	left:0;
	right:0;
	border-top: 0;
}

#main .myInfo>li>span:nth-child(1){
	height:50px;
    line-height:50px;
}

#main .myInfo>li>span:nth-child(2){
	height:50px;
    line-height:50px;
}

#main .myInfo>li .span2{
	width:60px;
	display:inline-block;
}

#main .myInfo>li .span2_right{
	width:-moz-calc(100% - 90px);
    width: -webkit-calc(100% - 90px);
    width: calc(100% - 90px);
	display:inline-block;
	text-align:right;
}

#main .myInfo>li .span3{
	width:65px;
	display:inline-block;
}

#main .myInfo>li .span3_right{
	width:-moz-calc(100% - 95px);
    width: -webkit-calc(100% - 95px);
    width: calc(100% - 95px);
	display:inline-block;
	text-align:right;
}

#main .myInfo>li .span4{
	width:85px;
	display:inline-block;
}

#main .myInfo>li .span4_right{
	width:-moz-calc(100% - 115px);
    width: -webkit-calc(100% - 115px);
    width: calc(100% - 115px);
	display:inline-block;
	text-align:right;
}

#main .myInfo>li .span7{
	width:125px;
	display:inline-block;
}

#main .myInfo>li .span7_right{
	width:-moz-calc(100% - 155px);
    width: -webkit-calc(100% - 155px);
    width: calc(100% - 155px);
	display:inline-block;
	text-align:right;
}

#main .myInfo>li>span:nth-child(2)>input{
	width:100%;
	height:50px;
	line-height:50px;
	border:0;
	text-align:right;
}

#main .pastMedicalHistoryItems>ul>li{
	min-width:79px;
	height:30px;
	line-height:30px;
	text-align:center;
	border-radius:5px;
	display:inline-block;
	float:left;
	margin-left:15px;
	margin-top:18px;
}

.header{
	width:100%;
	height:45px;
}

.header .back{
	height:44px;
	line-height:44px;
	display:inline-block;
	background: url('./images/icon_back.png') no-repeat;
	background-size: 20px 20px;
	padding-left:30px;
	background-position: 10px 12px;
	position: absolute;
}

.header .title{
	width:100%;
	height:44px;
	line-height:44px;
	text-align:center;
	display:block;
}

.header .header_right{
	width: 80px;
    position: absolute;
    top: 0px;
    right: 0px;
    line-height: 44px;
    text-align: right;
    padding-right: 30px;
}

.header:after{
	content: "";
	position:absolute;
	left:0;
	right:0;
	border-bottom: 1px solid #dddddd;
	-webkit-transform: scaleY(.5);
	-webkit-transform-origin: 0 0;
}

</style>

<link rel="stylesheet" type="text/css" href="<c:url value="/js/libs/mobiscroll/css/mobiscroll.core-2.5.2.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/js/libs/mobiscroll/css/mobiscroll.animation-2.5.2.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/js/libs/mobiscroll/css/mobiscroll.android-ics-2.5.2.css"/>"/>
<script type="text/javascript" src="<c:url value='/js/libs/mobiscroll/js/mobiscroll.core-2.5.2.js' /> "></script>
<script type="text/javascript" src="<c:url value='/js/libs/mobiscroll/js/mobiscroll.core-2.5.2-zh.js' /> "></script>
<script type="text/javascript" src="<c:url value='/js/libs/mobiscroll/js/mobiscroll.datetime-2.5.1.js' /> "></script>
<script type="text/javascript" src="<c:url value='/js/libs/mobiscroll/js/mobiscroll.datetime-2.5.1-zh.js' /> "></script>
<script type="text/javascript" src="<c:url value='/js/mobile/myInfo.js' /> "></script>
<title>${pageTitle }</title>
</head>
<body>
<div id="main" class="bg_f4">
	<section id="header" class="bg_white" >
		<span class="back font_dark_gray font14">返回</span>
		<span class="title font_dark_brown font17"><b>我的资料</b></span>
		<span class="header_right font14 font_dark_gray" onclick="MyInfoVM.updateUserInfo();">确定</span>
	</section>
	<div class="projectDetailBox">
	<ul class="w100p15 bg_white myInfo">
		<li>
			<span class="font15 font_gray span2"><font class="font_color_ff00000" style="margin-right:20px"></font>姓名</span>
			<span class="span2_right"><input type="text" class="font15 font_dark_gray"  name="name"  placeholder="请输入内容" /></span>
		</li>
		<li class="selectSex">
			<span class="font15 font_gray span2"><font class="font_color_ff00000" style="margin-right:15px">*</font>性别</span>
			<span class="span2_right"><input type="text" class="font15 font_dark_gray" name="userGender"  readOnly placeholder="请输入内容" /></span>
			<span class="rightArrow" style="position: absolute;right: 15px;float:none;margin-top:17px;"></span>
		</li>
		<li class="selectMarry">
			<span class="font15 font_gray span2"><font class="font_color_ff00000" style="margin-right:20px"></font>婚否</span>
			<span class="span2_right"><input type="text" class="font15 font_dark_gray"  name="userMarry" readOnly placeholder="请输入内容" /></span>
			<span class="rightArrow" style="position: absolute;right: 15px;float:none;margin-top:17px;"></span>
		</li>
		<li>
			<span class="font15 font_gray span4"><font class="font_color_ff00000" style="margin-right:15px">*</font>出生日期</span>
			<span class="span4_right"><input type="text" class="font15 font_dark_gray"  name="birthday"  id="birthdaySelect" readOnly placeholder="请输入内容" /></span>
			<span class="rightArrow" style="position: absolute;right: 15px;float:none;margin-top:17px;"></span>
		</li>
		<li>
			<span class="font15 font_gray span2"><font class="font_color_ff00000" style="margin-right:15px">*</font>身高</span>
			<span class="span2_right"><input type="text" class="font15 font_dark_gray" name="userHeight" onkeyup="value=value.replace(/[^\d]/g,'')" maxLength="3" placeholder="请输入内容" /></span>
		</li>
		<li>
			<span class="font15 font_gray span2"><font class="font_color_ff00000" style="margin-right:15px">*</font>体重</span>
			<span class="span2_right"><input type="tel" class="font15 font_dark_gray" maxLength="3"   onkeyup="value=value.replace(/[^\d]/g,'')" name="userWeight" placeholder="请输入内容" /></span>
		</li>
		<li>
			<span class="font15 font_gray span4"><font class="font_color_ff00000" style="margin-right:15px">*</font>出生城市</span>
			<span class="span4_right"><input type="text" class="font15 font_dark_gray" name="birthCity"  placeholder="请输入内容" /></span>
		</li>
		<li>
			<span class="font15 font_gray span4"><font class="font_color_ff00000" style="margin-right:20px"></font>身份证号</span>
			<span class="span4_right"><input type="text" class="font15 font_dark_gray" name="userIDNo"  maxLength="18" placeholder="请输入内容" /></span>
		</li>
		<li>
			<span class="font15 font_gray span3"><font class="font_color_ff00000" style="margin-right:20px"></font>手机号</span>
			<span class="span3_right"><input type="tel" class="font15 font_dark_gray" name="mobileNo"   readOnly placeholder="请输入内容" /></span>
		</li>
		<li>
			<span class="font15 font_gray span2"><font class="font_color_ff00000" style="margin-right:20px"></font>职业</span>
			<span class="span2_right"><input type="text" class="font15 font_dark_gray" name="userJob"   placeholder="请输入内容" /></span>
		</li>
		<li>
			<span class="font15 font_gray span4"><font class="font_color_ff00000" style="margin-right:20px"></font>所在城市</span>
			<span class="span4_right"><input type="text" class="font15 font_dark_gray" name="userSetCity"   placeholder="请输入内容" /></span>
		</li>
		<li class="selectPastMedicalHistory">
			<span class="font15 font_gray span7"><font class="font_color_ff00000" style="margin-right:20px"></font>既往病史及习惯</span>
			<span class="span7_right"><input type="text" class="font15 font_dark_gray"  name="pastMedicalHistory"  readOnly placeholder="请输入内容" /></span>
			<span class="rightArrow" style="position: absolute;right: 15px;float:none;margin-top:17px;"></span>
		</li>
	</ul>
	</div>
	
	<div class="full_mask">
	</div>
	
	<div class="sexItems bg_f4">
		<span class="font16 font_dark_gray bg_white sex">女</span>	
		<span class="font16 font_dark_gray bg_white sex">男</span>
		<span class="font16 font_dark_gray bg_white button">取消</span>
	</div>
	
	<div class="marriageItems selectItems bg_f4">
		<span class="font16 font_dark_gray bg_white marry">已婚</span>	
		<span class="font16 font_dark_gray bg_white marry">未婚</span>
		<span class="font16 font_dark_gray bg_white button">取消</span>
	</div>
	
	
	<div class="pastMedicalHistoryItems bg_white" style="display:none;width:100%;height:100%;position: fixed;top: 0;">
		<section class="header" class="bg_white" >
			<span onclick="$('.pastMedicalHistoryItems').hide()" class="back font_dark_gray font14">返回</span>
			<span class="title font_dark_brown font17"><b>既往病史及习惯</b></span>
			<span class="header_right font14 font_dark_gray" onclick="MyInfoVM.confirmPastMedicalHistory()">确定</span>
		</section>	
		<ul class="items w100p15">
			
		</ul>
	</div>
</div>



<script type="text/javascript">
$().ready(function(){
	MyInfoVM.selectSex();
	MyInfoVM.selectMarriage();
	MyInfoVM.selectBirthday();
	MyInfoVM.selectPastMedicalHistory();
	MyInfoVM.fillUserInfo();
});
</script>
</body>
</html>
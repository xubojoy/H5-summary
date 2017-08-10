<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<c:url value='/js/mobile/login.js' /> "></script>
<title>${pageTitle}</title>
</head>
<body>
 <!-- onblur="LoginVM.changeLoginBtn(this)" -->
<div id="main">
	<div id="loginPage">
		<ul class="bodyContainer">
			<li>
				<input type="tel" name="mobile" min="11" onblur="LoginVM.changeSendCodeBtn(this);" maxlength="11" class="font14 font_dark_brown"  placeholder="请输入手机号"/>
			</li>
			<li>
				<input type="password" name="code"  class="font14 font_dark_brown" placeholder="请短信验证码"/>
                <button class="mobile_code_btn bg_white font_deep_gray font14" onclick="LoginVM.seneSMSCode(this)">获取验证码</button>
			</li>
			<li class="font_white font18 bg_gray loginButton" onclick="LoginVM.login()">
				登录
			</li>
			<li style="text-align:center">
				<img src="<c:url value="/images/icon_radio.png" />"  style="width:16px;height:16px;margin-right:15px"/>
				<a href="./protocol?backUrl=${mobileUrl}/login"  class="font_dark_brown" style="display:inline;text-decoration: underline;"><b>用户协议</b></a>
			</li>
		</ul>
	</div>	
</div>
</body>
</html>
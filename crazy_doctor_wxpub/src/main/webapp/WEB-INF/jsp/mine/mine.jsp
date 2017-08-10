<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<title>${pageTitle }</title>
</head>
<body>
<div id="main" class="bg_f4">
	<section id="header" class="bg_white" >
		<span class="title font_dark_brown font17"><b>我的</b></span>
	</section>
	<div class="projectDetailBox" class="bg_f4">
		<div class="mineInfo bg_white" path="personInfo">
			<img src="<c:url value="/images/icon_head_nor.png"/>" class="avatar" />
			<div class="content">
				<span class="name font16 font_dark_gray"></span>
				<a class="font12 font_dark_brown"></a>
			</div>
			<span class="rightArrow" style="position: absolute;right:10px;margin-top:40px;"></span>
		</div>
		<ul class="operateMenu">
			<li class="bg_white" path="myOrders">
				<img src="<c:url value="/images/icon_order.png"/> " /> 我的订单
				<span class="rightArrow"></span>
			</li>
			<li style="margin-top:10px;display:none" class="bg_white">
				<img src="<c:url value="/images/icon_archives.png"/> " /> 我的档案
				<span class="rightArrow"></span>
			</li>
			<li class="bg_white topline" path="myInfo" >
				<img src="<c:url value="/images/icon_personInfo.png"/> " /> 我的资料
				<span class="rightArrow"></span>
			</li>
			<li class="bg_white topline" path="mySpecialOrders"> 
				<img src="<c:url value="/images/icon_special.png"/> " /> 我的特需
				<span class="rightArrow"></span>
			</li>
			<li class="bg_white" style="margin-top:10px;display:none">
				<img src="<c:url value="/images/icon_wallet.png"/> " /> 钱包
				<span class="rightArrow"></span>
			</li>
			<li class="bg_white" style="margin-top:10px">
				<img src="<c:url value="/images/icon_about.png"/> " /> 关于英特莱特
				<span class="rightArrow"></span>
			</li>
			<li class="bg_white topline" path="protocol">
				<img src="<c:url value="/images/icon_protocol.png"/> " /> 服务协议
				<span class="rightArrow"></span>
			</li>
			<li class="bg_white topline" >
				<img src="<c:url value="/images/icon_question.png"/> " /> 常见问题
				<span class="rightArrow"></span>
			</li>
			<li class="bg_white topline" style="margin-top:10px" onclick="logOut();">
				<img src="<c:url value="/images/icon_logout.png"/> " /> 退出登录
				<span class="rightArrow"></span>
			</li>
		</ul>
	</div>
	<jsp:include page="../common/footer.jsp?footerName=mine"></jsp:include>	
</div>

<script type="text/javascript">
$().ready(function(){
		var user = CrazyDoctor.User.getUser();
		if(user.avatarUrl != ''){
			$('.mineInfo .avatar').attr('src',user.avatarUrl);
		}
		$('.mineInfo .content>span').text(user.name);
		$('.mineInfo .content>a').text('手机号：'+user.mobileNo.substring(0,3)+'****'+user.mobileNo.substring(7));
	
	$('.operateMenu>li').click(function(){
		var path = $(this).attr('path');
		if(path != undefined){
			window.location.href = mobileUrl+ '/' +path;
		}
	});
	
	$('.mineInfo').click(function(){
		var path = $(this).attr('path');
		if(path != undefined){
			window.location.href = mobileUrl+ '/' +path +'?aa='+Math.random();
		}
	});
	
});

var logOut = function(){
	if(confirm('确认退出登录吗？')){
		window.localStorage.removeItem('crazy_doctor_user');
		window.location.href = mobileUrl + '/login';
	}
};

</script>
</body>
</html>
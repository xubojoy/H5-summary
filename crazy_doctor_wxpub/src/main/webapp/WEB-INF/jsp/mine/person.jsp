<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
#main .personSelfInfo>li>span:nth-child(2){
    width: -moz-calc(100% - 60px);
	width: -webkit-calc(100% - 60x);
	width: calc(100% - 60px);
	float:none;
	padding-right:5px;
}
</style>
<title>${pageTitle }</title>
</head>
<body>
<div id="main" class="bg_f4">
	<section id="header" class="bg_white" >
		<span class="back font_dark_gray font14">返回</span>
		<span class="title font_dark_brown font17"><b>个人信息</b></span>
		<span class="header_right font14 font_dark_gray" onclick="updateUserInfo();">确定</span>
	</section>
	<ul class="orderPersonInfo w100p15 bg_white personSelfInfo" >
		<li onclick="sendImgToWeiXin()">
			<span class="font15 font_gray">头像</span>
			<span>
				<img  class="avatar" src="<c:url value="/images/icon_head_nor.png"/>" />
			</span>
			<span class="rightArrow" style="position: absolute;right:10px;margin-top:40px;"></span>
		</li>
		<li>
			<span class="font15 font_gray">昵称</span>
			<span class="font15 font_dark_gray nickname">
				<input type ="text" name="nickName" />
			</span>
		</li>
		<li>
			<span class="font15 font_gray">手机号</span>
			<span class="font15 font_dark_gray mobileNo"  style="padding-right:20px;">
			</span>
		</li>
	</ul>
</div>

<script type="text/javascript">
$().ready(function(){
	var initUserInfoCB = function(){
		var user = CrazyDoctor.User.getUser();
		if(user.avatarUrl != ''){
			$('.orderPersonInfo .avatar').attr('src',user.avatarUrl);
		}
		$('input[name="nickName"]').val(user.name);
		$('.mobileNo').text(user.mobileNo.substring(0,3)+'****'+user.mobileNo.substring(7));
	}
	CrazyDoctor.User.ininUserInfo(null,initUserInfoCB);
});


var updateUserInfo = function(avatarUrl){
	var $this = this;
	var nickName = $('input[name="nickName"]').val();
	if(nickName =='null' || nickName ==''){
		alert('昵称不能为空');
		return ;
	}
	var params= {
		name	:	nickName
	}
	if(avatarUrl !=null && avatarUrl!=''){
		params.avatarUrl = avatarUrl;
	}
	var option ={
		methodType	:	'PUT',
		url			:	 'users/'+CrazyDoctor.User.getUser().id+'/info',
		params		:	params
	};
	var successCB = function(data){
		var accessToken = CrazyDoctor.User.getUser().accessToken;
		data.accessToken = accessToken;
		if(nickName =='null' || nickName ==''){
			$('input[name="nickName"]').val(data.name);
		}
		window.localStorage.setItem('crazy_doctor_user',JSON.stringify(data));
		alert('信息修改成功！');
	}
	commonAjax(option,successCB);
};

var sendImgToWeiXin = function(){
	wx.chooseImage({
	    success: function(res) {
	        var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
	        if(localIds.length > 1){
	        	alert('只能上传一个图片！');
	        	return;
	        }
	        var imgMessages = [];
	        for(var i=0 ; i<localIds.length ; i++){
	        	var imgMessage = {};
	        	imgMessage.type = "img";
	        	imgMessage.url = localIds[i];
	        	imgMessage.created = new Date().getTime();
	        	imgMessages.push(imgMessage);
	        }
			for(var i=0 ; i<imgMessages.length ; i++){
				wx.uploadImage({
				    localId: imgMessages[i].url , // 需要上传的图片的本地ID，由chooseImage接口获得
				    isShowProgressTips: 1,// 默认为1，显示进度提示
				    success: function (res) {
				        var serverId = res.serverId; // 返回图片的服务器端ID
				        uploadImgsToServer(serverId);
				    },
				});
			}
	    }
	});
};

var uploadImgsToServer = function(serverId){
	var option ={
			methodType	:	'GET',
			url			:	 'images/wx/'+serverId,
			params		:	null
	};
	var successCB = function(data){
		$('.avatar').attr('src',data);
		updateUserInfo(data);
	};
	commonAjax(option,successCB);
};
</script>

</body>
</html>
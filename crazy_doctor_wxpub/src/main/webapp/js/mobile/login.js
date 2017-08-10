	
var LoginVM = {
	loginFlag : false,
	changeLoginBtn : function(obj){
		if(!CrazyDoctor.formCheck.checkFlag){
			if(obj.value != null && obj.value != ''){
				this.loginFlag  = true;
				$('#loginPage .loginButton').removeClass('bg_gray');
				$('#loginPage .loginButton').addClass('bg_dark_brown');
			}else{
				this.loginFlag  = false;
				$('#loginPage .loginButton').removeClass('bg_dark_brown');
				$('#loginPage .loginButton').addClass('bg_gray');
			}
		}else{
			$('input[name="mobile"]').focus();
		}
	},
	changeSendCodeBtn : function(obj){
		if(CrazyDoctor.formCheck.telCheckNoAlert('mobile')){
			if(obj.value != null && obj.value != ''){
				$('#loginPage .mobile_code_btn').removeClass('bg_white');
				$('#loginPage .mobile_code_btn').addClass('bg_color_f9f5f1');
			}else{
				$('#loginPage .mobile_code_btn').removeClass('bg_color_f9f5f1');
				$('#loginPage .mobile_code_btn').addClass('bg_white');
			}
		}else{
			CrazyDoctor.formCheck.telCheck('mobile');
			$('input[name="mobile"]').focus();
		}
	},
	seneSMSCode : function(obj){
		var mobileNo = $('input[name="mobile"]').val();
		if(mobileNo == ''){
			alert('请输入手机号');
			return;
		}
		if(CrazyDoctor.formCheck.telCheckNoAlert('mobile')){
			this.loginFlag = true;
			$('#loginPage .loginButton').removeClass('bg_gray');
			$('#loginPage .loginButton').addClass('bg_dark_brown');
			this.sendSMSTime(obj);
			var params = {
					mobileNo	:	mobileNo
			};
			var option ={
					methodType	:	'POST',
					url			:	'tempPwds',
					params		:	params
			};
			var successCB = function(){};
			commonAjax(option,successCB);
		}
	},
	
	sendSMSTime : function(obj){
		var count = 60;
        var countdown = setInterval(CountDown, 1000);
        function CountDown() {
        	$(obj).attr('disabled',true);
            $(obj).removeClass('bg_white');
            $(obj).addClass('bg_gray');
            $(obj).text(count + " 秒后重新发送");
            if (count == 0) {
            	$(obj).removeClass('bg_gray');
            	$(obj).addClass('bg_white');
            	$(obj).text('获取验证码');
            	$(obj).attr('disabled',false);
                clearInterval(countdown);
            }
            count--;
        }
	},
	
	login : function(){
		var mobileNo = $('input[name="mobile"]').val();
		if(mobileNo == ''){
			alert('请输入手机号');
			return;
		}
		if(!this.loginFlag){
			alert('请获取验证码后登录');
			return ;
		}
		
		var code = $('input[name="code"]').val();
		if(code == ''){
			alert('请输入验证码');
			return;
		}
		var params = {
				mobileNo	:	mobileNo,
				pwd			:	code
		};
		var option ={
				methodType	:	'POST',
				url			:	'userSessions',
				params		:	params,
				errorToLogin : false
		};
		var successCB = function(data){
			$.cookie('Access-Token', data.accessToken, {
				expires : 100,
				path : '/'
			});
			window.localStorage.setItem('crazy_doctor_user',JSON.stringify(data));
			if(backUrl != ''){
				window.location.href= backUrl;
			}else{
				window.location.href= mobileUrl +'/projects';
			}
		};
		var errorCB = function(response){
			var status = response.status;
			var code =0;
			if(status == 400){
				code = parseInt(response.responseJSON.code);
			}
			if(code== 40001 ){
				alert('验证码错误，请重新输入');
				return;
			}
		}
		commonAjax(option,successCB,errorCB);
	}
	
		
};
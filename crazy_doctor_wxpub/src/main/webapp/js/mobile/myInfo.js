
var MyInfoVM = {
	commitFlag : true,
	selectSex	: function(){
		$('.myInfo .selectSex').click(function(){
			$('.full_mask').show();
			$('body').addClass('no_overflow');
			$('.sexItems').show();
		});
		
		$('.sexItems .button').click(function(){
			$('.full_mask').hide();
			$('body').removeClass('no_overflow');
			$('.sexItems').hide();
		});
		
		$('.sexItems .sex').click(function(){
			var sex = $(this).text();
			$('input[name="userGender"]').val(sex);
			$('.full_mask').hide();
			$('body').removeClass('no_overflow');
			$('.sexItems').hide();
		});
	},
	selectMarriage : function(){
		$('.myInfo .selectMarry').click(function(){
			$('.full_mask').show();
			$('body').addClass('no_overflow');
			$('.marriageItems').show();
		});
		
		$('.marriageItems .button').click(function(){
			$('.full_mask').hide();
			$('body').removeClass('no_overflow');
			$('.marriageItems').hide();
		});
		
		$('.marriageItems .marry').click(function(){
			var marriage = $(this).text();
			$('input[name="userMarry"]').val(marriage);
			$('.full_mask').hide();
			$('body').removeClass('no_overflow');
			$('.marriageItems').hide();
		});
	},
	selectBirthday : function(){
		var optDate = CrazyDoctor.birthdayPicker();
		$('#birthdaySelect').mobiscroll(optDate).date(optDate);
	},
	selectPastMedicalHistory : function(){
		var $this = this;
		$('.selectPastMedicalHistory').click(function(){
			$('body').addClass('no_overflow');
			$('.pastMedicalHistoryItems').show();
		});
		var option ={
				methodType	:	'GET',
				url			:	'tags/既往病史',
				params		:	null
		};
		var successCB = function(data){
			for(var i=0;i<data.tagArrs.length;i++){
				var html = '<li class="bg_color_f5f5f5 font12 font_dark_gray">'+data.tagArrs[i]+'</li>';
				$('.pastMedicalHistoryItems>ul').append(html);
			}
			$('.pastMedicalHistoryItems>ul>li').click(function(){
				if($(this).hasClass('bg_color_f5f5f5')){
					$(this).removeClass('bg_color_f5f5f5');
					$(this).addClass('bg_color_efd6bc');
				}else{
					$(this).removeClass('bg_color_efd6bc');
					$(this).addClass('bg_color_f5f5f5');
				}
			});
		};
		commonAjax(option,successCB);
	},
	confirmPastMedicalHistory : function(){
		var items = $('.pastMedicalHistoryItems>ul .bg_color_efd6bc');
		var str ='';
		for(var i=0;i<items.length;i++){
			str += $(items[i]).text()+"、";
		}
		str = str.substring(0,str.lastIndexOf('、'));
		$('input[name="pastMedicalHistory"]').val(str);
		$('.pastMedicalHistoryItems').hide();
	},
	fillUserInfo : function(){
		var initUserInfoCB = function(data){
			console.log(data);
			$('input[name="name"]').val(data.name);
			$('input[name="userGender"]').val(parseInt(data.userGender) == 1 ? '男' : '女');
			$('input[name="userMarry"]').val(data.userMarry == 1 ? '已婚' : '未婚');
			$('input[name="birthday"]').val(data.birthday);
			
			$('input[name="userHeight"]').val(data.userHeight>0 ? data.userHeight : '' );
			$('input[name="userWeight"]').val(data.userWeight>0 ? data.userWeight : '' );
			$('input[name="birthCity"]').val(data.birthCity || '' );
			$('input[name="userIDNo"]').val(data.userIDNo>-1 ? data.userIDNo : '' );
			$('input[name="mobileNo"]').val(data.mobileNo>-1 ? data.mobileNo : '' );
			$('input[name="userJob"]').val(data.userJob || '' );
			$('input[name="userSetCity"]').val(data.userSetCity || '' );
			$('input[name="pastMedicalHistory"]').val(data.pastMedicalHistory || '' );
		}
		CrazyDoctor.User.ininUserInfo(null,initUserInfoCB);
	},
	updateUserInfo : function(){
		var $this = this;
		if(!this.commitFlag){
			return false;
		}
		var name = $('input[name="name"]').val();
		var userGender = $('input[name="userGender"]').val();
		if(userGender == '' ){
			alert('性别不能为空');
			return;
		}
		var userMarry = $('input[name="userMarry"]').val();
		var birthday = $('input[name="birthday"]').val();
		if(birthday == '' ){
			alert('出生日期不能为空');
			return;
		}
		var userHeight = $('input[name="userHeight"]').val();
		if(userHeight == '' || parseInt(userHeight) == 0){
			alert('身高不能为空');
			return;
		}
		var userWeight = $('input[name="userWeight"]').val();
		if(userWeight == '' || parseInt(userWeight) == 0 ){
			alert('体重不能为空');
			return;
		}
		var birthCity = $('input[name="birthCity"]').val();
		if(birthCity == '' ){
			alert('出生城市不能为空');
			return;
		}
		var userIDNo = $('input[name="userIDNo"]').val();
		var userJob = $('input[name="userJob"]').val();
		var userSetCity = $('input[name="userSetCity"]').val();
		var pastMedicalHistory = $('input[name="pastMedicalHistory"]').val();
		var params= {
				name	:	name,
				userGender : userGender =='男' ? 1 : 0,
				userMarry	:	userMarry=='已婚'?1:0,
				birthday	:   birthday,
				userHeight  : userHeight,
				userWeight	:	userWeight ,
				birthCity	:	birthCity,
				userIDNo	: 	userIDNo,
				userJob		:	userJob,
				userSetCity	:	userSetCity,
				pastMedicalHistory	:	pastMedicalHistory
		}
		var option ={
				methodType	:	'PUT',
				url			:	 'users/'+CrazyDoctor.User.getUser().id+'/info',
				params		:	params,
				contentType : 'application/x-www-form-urlencoded'
		};
		var successCB = function(data){
			var accessToken = CrazyDoctor.User.getUser().accessToken;
			data.accessToken = accessToken;
			window.localStorage.setItem('crazy_doctor_user',JSON.stringify(data));
			alert('信息修改成功！');
		}
		commonAjax(option,successCB);
	},
	showSuccessModel : function(){
		$('.full_mask').show();
		$('body').addClass('no_overflow');
		var leftWidth = ( $(window).width()-280)/2;
		$('.successModalDialog').css('left',leftWidth);
		$('.successModalDialog').show();
	},
	hideSuccessModel : function(){
		$('.full_mask').hide();
		$('body').removeClass('no_overflow');
		$('.successModalDialog').hide();
	}
	
}
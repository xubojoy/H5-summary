$().ready(function(){
	var width  = $(window).width();
    var minWidth =(  width - 75 ) /3;
	$('.skillList ul>li').css('min-width', minWidth);
	
	var timeMinWidth = (  width - 63 ) /2;
	$('.timesList ul>li').css('min-width', timeMinWidth);
	
	$('.skillList li').click(function(){
		$('.skillList li').removeClass('bg_dark_brown');
		$('.skillList li').css('color','#b9976c');
		$(this).addClass('bg_dark_brown');
		$(this).css('color','#fff');
	});
	
	$('.selectSex').click(function(){
		if(DoctorOrderVM.checkFlag){
		$('.full_mask').show();
		$('body').addClass('no_overflow');
		$('.sexItems').show();
		}
	});
	
	$('.sexItems .button').click(function(){
		$('.full_mask').hide();
		$('body').removeClass('no_overflow');
		$('.sexItems').hide();
	});
	
	$('.sexItems .sex').click(function(){
		var sex = $(this).text();
		$('.sexText').text(sex);
		$('.full_mask').hide();
		$('body').removeClass('no_overflow');
		$('.sexItems').hide();
	});
	
	
	$('.orderButton').click(function(){
		$('.full_mask').show();
	//	$('body').addClass('no_overflow');
		$('.modalDialog span').text('预约成功');
		$('.modalDialog').show();
	});
	
	$('.modalDialog .cancelBtn').click(function(){
		$('.full_mask').hide();
		$('.modalDialog').hide();
		//$('.full_mask').hide();
		//$('body').removeClass('no_overflow');
		//
	});
})

var DoctorOrderVM = {
	commitFlag : true,
	checkFlag : true,
	changeInputInfo : function(name,type){
		var val = $('input[name="'+name+'"]').val();
		$('.'+name+'_content .val').text(val);
		$('.'+name+'_input').hide();
		$('.'+name+'_content').show();
	},
	/*
	changeInputInfo : function(name,type){
		if(type == 'name'){
			if(!CrazyDoctor.formCheck.nameCheckNoAlert(name)){
				this.checkFlag = false;
				$('input[name="'+name+'"]').focus();
				CrazyDoctor.formCheck.nameCheck(name);
				return false;
			}else{
				var val = $('input[name="'+name+'"]').val();
				$('.'+name+'_content .val').text(val);
				$('.'+name+'_input').hide();
				$('.'+name+'_content').show();
				this.checkFlag= true;
			}
		}else if(type =='age'){
			if(!CrazyDoctor.formCheck.ageCheckNoAlert(name)){
				this.checkFlag = false;
				$('input[name="'+name+'"]').focus();
				CrazyDoctor.formCheck.ageCheck(name);
				return false;
			}else{
				var val = $('input[name="'+name+'"]').val();
				$('.'+name+'_content .val').text(val);
				$('.'+name+'_input').hide();
				$('.'+name+'_content').show();
				this.checkFlag= true;
			}
		}else if(type =='tel'){
			if(!CrazyDoctor.formCheck.telCheckNoAlert(name)){
				this.checkFlag = false;
				$('input[name="'+name+'"]').focus();
				CrazyDoctor.formCheck.telCheck(name);
				return false;
			}else{
				var val = $('input[name="'+name+'"]').val();
				$('.'+name+'_content .val').text(val);
				$('.'+name+'_input').hide();
				$('.'+name+'_content').show();
				this.checkFlag= true;
			}
		}
	},*/
	backEdit : function(name){
		if(this.checkFlag){
		$('.'+name+'_content').hide();
		$('.'+name+'_input').show();
		$('input[name="'+name+'"]').focus();
		}
	},
	createProjectOrder : function(){
		var $this = this;
		if(!this.commitFlag){
			return;
		}
		var orderName = $('.orderName_content .val').text();
		if(orderName == null || orderName == ''){
			alert('就诊人姓名不能为空');
			return;
		}
		if(!CrazyDoctor.formCheck.nameCheckNoAlert('orderName')){
			alert('就诊人姓名长度必须在2-20之间');
			return;
		}
		var orderMobileNo = $('.orderMobileNo_content .val').text();
		if(orderMobileNo == null || orderMobileNo == ''){
			alert('就诊人电话不能为空');
			return;
		}
		if(!CrazyDoctor.formCheck.telCheckNoAlert('orderMobileNo')){
			alert('就诊人电话长度必须是11位');
			return;
		}
		var orderAge = $('.orderAge_content .val').text();
		if(orderAge == null || orderAge == ''){
			alert('就诊人年龄不能为空');
			return;
		}
		if(!CrazyDoctor.formCheck.ageCheckNoAlert('orderAge')){
			alert('就诊人年龄必须在0-100之间');
			return;
		}
		var orderGender = $('.sexText').text();
		if(orderGender == null || orderGender == ''){
			alert('就诊人性别不能为空');
			return;
		}
		this.commitFlag = false; 
		var orderTime = new Date(orderDate).getTime();
		var halfDay = orderHalfDay;
		var params= {
			userId		: 	CrazyDoctor.User.getUser().id,
			doctorId	:	doctorId,
			orderName	:   orderName,
			orderMobileNo  : orderMobileNo,
			orderAge	:	orderAge ,
			orderGender	:	orderGender == '男' ? 1 : 0,
			orderTime	:	orderTime,
			halfDay		: 	halfDay
		}
		var option ={
				methodType	:	'POST',
				url			:	'doctorOrders',
				params		:	JSON.stringify(params),
				contentType     : 'application/json'
		};
		var successCB = function(data){
			$this.showSuccessModel();
			var url = mobileUrl +'/myOrders?orderType=doctors';
			CrazyDoctor.utils.toPageAfterSeconds(url,3);
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
		window.location.href= mobileUrl +'/myOrders?orderType=doctors';
	}
}


var SpecialOrderVM = {
	commitFlag : true,
	checkFlag : true,
	selectSex	: function(){
		var $this =this;
		$('.orderPersonInfo .selectSex').click(function(){
			if($this.checkFlag){
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
			$('input[name="patientGender"]').val(sex);
			$('.full_mask').hide();
			$('body').removeClass('no_overflow');
			$('.sexItems').hide();
		});
	},
	checkInput : function(name,type){
		/*
		if(type == 'name'){
			if(!CrazyDoctor.formCheck.nameCheckNoAlert(name)){
				this.checkFlag = false;
				$('input[name="'+name+'"]').focus();
				CrazyDoctor.formCheck.nameCheck(name);
				return false;
			}
			this.checkFlag = true;
		}else if(type =='age'){
			if(!CrazyDoctor.formCheck.ageCheck(name)){
				this.checkFlag = false;
				$('input[name="'+name+'"]').focus();
				return false;
			}
			this.checkFlag = true;
		}else if(type =='tel'){
			if(!CrazyDoctor.formCheck.telCheckNoAlert(name)){
				this.checkFlag = false;
				$('input[name="'+name+'"]').focus();
				CrazyDoctor.formCheck.telCheck(name);
				return false;
			}
			this.checkFlag = true;
		}*/
	},
	selectService : function(){
		$('.serviceList>li').click(function(){
			//$('.serviceList>li').find('.icon_select').attr('src',mobileUrl+'/images/icon_xuanze_nor.png');
			if($(this).find('.icon_select').attr('src').indexOf('icon_xuanze_nor.png') >-1 ){
				$(this).find('.icon_select').attr('src',mobileUrl+'/images/icon_xuanze_pre.png');
			}else{
				$(this).find('.icon_select').attr('src',mobileUrl+'/images/icon_xuanze_nor.png');
			}
		});
	},
	createOrder : function(){
		var $this = this;
		if(!this.commitFlag){
			return false;
		}
		var patientName = $('input[name="patientName"]').val();
		if(patientName == ''){
			alert('患者姓名不能为空');
			return;
		}
		if(!CrazyDoctor.formCheck.nameCheckNoAlert('patientName')){
			alert('患者姓名长度必须在2-20之间');
			return;
		}
		var patientGender = $('input[name="patientGender"]').val();
		if(patientGender == '' ){
			alert('患者性别不能为空');
			return;
		}
		var patientAge = $('input[name="patientAge"]').val();
		if(patientAge == '' ){
			alert('患者年龄不能为空');
			return;
		}
		if(!CrazyDoctor.formCheck.ageCheckNoAlert('patientAge')){
			alert('患者年龄必须在0-100之间');
			return;
		}
		var orderName = $('input[name="orderName"]').val();
		if(orderName == '' ){
			alert('预约人姓名不能为空');
			return;
		}
		if(!CrazyDoctor.formCheck.nameCheckNoAlert('orderName')){
			alert('预约人姓名长度必须在2-20之间');
			return;
		}
		var orderMobileNo = $('input[name="orderMobileNo"]').val();
		if(orderMobileNo == '' ){
			alert('预约人电话不能为空');
			return;
		}
		if(!CrazyDoctor.formCheck.telCheckNoAlert('orderMobileNo')){
			alert('预约人电话长度必须是11位');
			return;
		}
		var hospital = $('input[name="hospital"]').val();
		if(hospital == '' ){
			alert('预约医院不能为空');
			return;
		}
		var department = $('input[name="department"]').val();
		if(department == '' ){
			alert('预约科室不能为空');
			return;
		}
		var doctor = $('input[name="doctor"]').val();
		if(doctor == '' ){
			alert('预约大夫不能为空');
			return;
		}
		var serviceList = $('.serviceList>li');
		var serviceFlag = false;
		var remark = $('.specialRemark>textarea').val();
		var params= {
				userId		: 	CrazyDoctor.User.getUser().id,
				patientName	:	patientName,
				patientGender : patientGender =='男' ? 1 : 0,
				patientAge	:	patientAge,
				orderName	:   orderName,
				orderMobileNo  : orderMobileNo,
				hospital	:	hospital ,
				department	:	department,
				doctor		: 	doctor,
				remark		:	remark
		}
		var serviceName = null;
		for(var i=0;i<serviceList.length;i++){
			var li = $(serviceList[i]);
			if(li.find('.icon_select').attr('src').indexOf('icon_xuanze_pre.png') > -1){
				serviceFlag = true;
				serviceName = li.attr('name');if(serviceName == 'booking'){
					params.booking = true;
				}else if(serviceName == 'shuttle'){
					params.shuttle = true;
				}else if(serviceName == 'charteredCar'){
					params.charteredCar = true;
				}else if(serviceName == 'hotel'){
					params.hotel = true;
				}else if(serviceName == 'accompany'){
					params.accompany = true;
				}else if(serviceName == 'guide'){
					params.guide = true;
				}
			}
		}
		var option ={
				methodType	:	'POST',
				url			:	'specialOrders',
				params		:	JSON.stringify(params),
				contentType     : 'application/json'
		};
		var successCB = function(data){
			$this.showSuccessModel();
			var url = mobileUrl +'/mySpecialOrders';
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
		window.location.href= mobileUrl + '/mySpecialOrders';
	}
	
}
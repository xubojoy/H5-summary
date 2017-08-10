
var MyOrders = {
	pageNo : 1,
	pageSize : 10,
	template : function(){
		/*
			<li class="bg_white w100p15" id="{{id}}">
				<div class="title">
					<img src="images/icon_project_order.png" />	
					<span class="name textOverFlow">{{organization.name}}</span>
					<span class="font15 font_dark_brown" style="position:absolute;right:15px">{{orderStatusText}}</span>
				</div>
				<ul class="orderContent">
					<li>
						<span class="font14 font_gray">理疗项目</span>
						<span class="font15 font_dark_gray">{{project.name}}</span>
					</li>
					<li>
						<span class="font14 font_gray">预约时间</span>
						<span class="font15 font_dark_gray">{{orderDateTime}}</span>
					</li>
					<li>
						<span class="font14 font_gray" style="letter-spacing:27px">地址</span>
						<span class="font15 font_dark_gray textOverFlow" style="position: relative;margin-left:-25px;top: 5px;">{{organization.address}}</span>
					</li>
				</ul>
			</li>
			{{#if cancelFlag}}
			<div class="operatorBtn bg_white" style="padding-right:30px;"  onclick="MyOrders.cancelProjectOrder({{id}})" ><span class="font12 font_color_ca7e5c" style="float:right">取消</span></div>
			{{/if}}
			{{#if completeFlag}}
			<div class="bg_white operatorBtn" style="padding-right:30px;" onclick="MyOrders.evaluateOrder({{id}})"><span class="font12 font_color_ca7e5c" style="float:right">评价</span></div>
			{{/if}}
		*/
	},
	doctorOrderTemplate : function(){
		/*
			<li class="bg_white w100p15" id="{{id}}">
				<div class="title">
					<img src="images/icon_project_order.png" />	
					<span class="name textOverFlow">{{doctor.hospital.name}}</span>
					<span class="font15 font_dark_brown" style="position:absolute;right:15px">{{orderStatusText}}</span>
				</div>
				<ul class="orderContent">
					<li>
						<span class="font14 font_gray">医生姓名</span>
						<span class="font15 font_dark_gray">{{doctor.name}}</span>
					</li>
					<li>
						<span class="font14 font_gray">预约时间</span>
						<span class="font15 font_dark_gray">{{orderDateTime}}</span>
					</li>
					<li>
						<span class="font14 font_gray" style="letter-spacing:27px">地址</span>
						<span class="font15 font_dark_gray textOverFlow" style="position: relative;margin-left:-25px;top: 5px;">{{doctor.hospital.address}}</span>
					</li>
				</ul>
			</li>
			{{#if cancelFlag}}
			<div class="operatorBtn bg_white" style="padding-right:30px;"  onclick="MyOrders.cancelDoctorOrder({{id}})" ><span class="font12 font_color_ca7e5c" style="float:right">取消</span></div>
			{{/if}}
		*/
	},
	specialOrderTemplate : function(){
		/*
			<li class="bg_white w100p15" id="{{id}}">
				<div class="title">
					<img src="images/icon_special_order.png" />	
					<span class="name textOverFlow">{{orderName}}</span>
					<span class="font15 font_dark_brown" style="position:absolute;right:15px">{{orderStatusText}}</span>
				</div>
				<ul class="orderContent">
					<li>
						<span class="font14 font_gray">电话</span>
						<span class="font15 font_dark_gray">{{orderMobileNo}}</span>
					</li>
					<li>
						<span class="font14 font_gray">类型</span>
						<span class="font15 font_dark_gray">预约特需</span>
					</li>
					<li>
						<span class="font14 font_gray">时间</span>
						<span class="font15 font_dark_gray">{{orderDateTime}}</span>
					</li>
				</ul>
			</li>
		*/
	},
	seacher : function(clearFlag){
		var $this = this;
		var params = {
			pageNo	 :	this.pageNo,
			pageSize :	this.pageSize,
			userId   : 	CrazyDoctor.User.getUser().id
		};
		var status = $('.ordersNav>li .selected').text();
		if(status != '全部'){
			if(status == '待确认'){
				status = 'waitingConfirm';
			}else if(status == '待服务' || status == '已沟通' ){
				status = 'confirmed';
			}else if(status == '已完成'){
				status = 'completed';
			}else if(status == '已取消'){
				status = 'canceled';
			}
			params.orderStatus = status;
		}
		var dateTime = $('.navigate .dateTime>span').text();
		if(dateTime != '时间'){
			if(dateTime == '近一周'){
				dateTime = CrazyDoctor.DateFormat.getLastDateByCondition(6);
			}else if(dateTime == '近半月'){
				dateTime = CrazyDoctor.DateFormat.getLastDateByCondition(14);
			}else if(dateTime == '近一月'){
				dateTime = CrazyDoctor.DateFormat.getLastDateByCondition(30);
			}else if(dateTime  == '近一年'){
				dateTime = CrazyDoctor.DateFormat.getLastDateByCondition(364);
			}else if(dateTime =='2015年前'){
				dateTime = [];
				dateTime[0] = '2015-01-01'; 
				dateTime[1] = '';
			}
			params.orderTimeStar = dateTime[1];
			params.orderTimeEnd = dateTime[0];
		}
		var url ="";
		var type = $.trim( $('.navigate .orderType>span').text() );
		if(type == '预约理疗'){
			url = 'projectOrders/search';
		}else if(type == '预约医生'){
			url = 'doctorOrders/search';
		}else if(type == '预约特需'){
			url = 'specialOrders/search';
		}
		var option ={
			methodType	:	'GET',
			url			:	url,
			params		:	params
		};
		var successCB = function(data){
			CrazyDoctor.utils.isLoadingData = false;
			if(clearFlag){
				$('.ordersContainer').empty();
			}
			var myOrdersView = new CrazyDoctor.View();
			var items = data.items;
			for(var i=0;i<items.length;i++){
				var item = items[i];
				if(type =='预约特需'){
					item.orderDateTime = $.format.date(new Date(item.createTime), 'yyyy-MM-dd HH:mm');
				}else{
					item.orderDateTime =  $.format.date(new Date(item.orderTime), 'yyyy-MM-dd HH:mm');
				}
				if(item.orderStatus == 'waitingConfirm'){
					item.orderStatusText = '等待确认';
					item.cancelFlag  = true;
				}else if(item.orderStatus == 'confirmed'){
					item.orderStatusText = '已确认';
				}else if(item.orderStatus == 'canceled'){
					item.orderStatusText = '已取消';
				}else if(item.orderStatus == 'payed'){
					item.orderStatusText = '已支付';
				}else if(item.orderStatus == 'waitingRefund'){
					item.orderStatusText = '等待退款';
				}else if(item.orderStatus == 'refunded'){
					item.orderStatusText = '已退款';
				}else if(item.orderStatus == 'unCompleted'){
					item.orderStatusText = '未完成';
				}else if(item.orderStatus == 'completed'){
					item.orderStatusText = '已完成';
					if(!item.commentFlag){
						item.completeFlag  = true;
					}
				}
				if(type == '预约理疗'){
					myOrdersView.render($this.template,'ordersContainer','append',item);
				}else if(type =='预约医生'){
					myOrdersView.render($this.doctorOrderTemplate,'ordersContainer','append',item);
				}else if(type =='预约特需'){
					myOrdersView.render($this.specialOrderTemplate,'ordersContainer','append',item);
				}
			}
			$('.ordersContainer>li').click(function(){
				var id = $(this).attr('id');
				var initUserInfoCB = function(){
					if(type == '预约理疗'){
						window.location.href= mobileUrl + '/myOrders/'+id+'/project';
					}else if(type =='预约医生'){
						window.location.href= mobileUrl + '/myOrders/'+id+'/doctor';
					}else if(type =='预约特需'){
						window.location.href= mobileUrl + '/myOrders/'+id+'/special';
					}
				}
				CrazyDoctor.User.ininUserInfo(null,initUserInfoCB);
			});
		}
		commonAjax(option,successCB);
	},
	searchTypeSelect : function(type,obj){
		var $this = this;
		$('.seacherTypeSelect').empty();
		if(type == 'orderType'){
			$('.seacherTypeSelect').css('left','inherit');
			$('.seacherTypeSelect').css('right',0);
			var html = '<li class="w100m15 font_dark_brown font16">预约理疗</li>';
			html += '<li class="w100m15 font_dark_brown font16">预约特需</li>';
			html += '<li class="w100m15 font_dark_brown font16">预约医生</li>';
			$('.seacherTypeSelect').append(html);
		}else{
			$('.seacherTypeSelect').css('left',0);
			$('.seacherTypeSelect').css('right','inherit');
			var html  = '<li class="w100m15 font_dark_brown font16">全部</li>';
			html += '<li class="w100m15 font_dark_brown font16">近一周</li>';
			html += '<li class="w100m15 font_dark_brown font16">近半月</li>';
			html += '<li class="w100m15 font_dark_brown font16">近一月</li>';
			html += '<li class="w100m15 font_dark_brown font16">近一年</li>';
			$('.seacherTypeSelect').append(html);
		}
		$('.full_mask').css('top','84px');
		$('.full_mask').show();
		$('body').addClass('no_overflow');
		var text = $(obj).find('span').text();
		$(obj).find('img').attr('src',mobileUrl + '/images/icon_down_deep.png');
		$(obj).find('span').addClass('font_dark_brown');
		var items = $('.seacherTypeSelect>li');
		for(var i=0;i<items.length;i++){
			if($(items[i]).text() == text){
				$(items[i]).css('background-color','#774c22');
				$(items[i]).css('color','#fff');
				break;
			}
			if($(items[i]).text() == '全部' && text == '时间'){
				$(items[i]).css('background-color','#774c22');
				$(items[i]).css('color','#fff');
				break;
			}
		}
		$('.seacherTypeSelect>li').click(function(){
			if(type == 'orderType'){
				$('.navigate .orderType>span').text($(this).text());
			}else{
				if($(this).text() != '全部'){
					$('.navigate .dateTime>span').text($(this).text());
				}
			}
			$('.full_mask').css('top','0');
			$('.full_mask').hide();
			$('body').removeClass('no_overflow');
			$('.seacherTypeSelect').hide();
			$this.seacher(true);
		});
		$('.seacherTypeSelect').show();
	},
	orderNavSearch : function(type,obj){
		var $this = this;
		$('.itemsList').empty();
		$('.itemsList').css('height',$(window).height()-84+"px");
		$('.itemsList').css('width',$(window).width());
		$('.itemsList').css('margin','0');
		if(type == 'orderType'){
			var html = '<ul><li class="font_dark_brown font16">预约理疗</li>';
			html += '<li class="font_dark_brown font16">预约医生</li></ul>';
			$('.itemsList').append(html);
		}else{
			var html  = '<ul><li class="font_dark_brown font16">全部</li>';
			html += '<li class="font_dark_brown font16">近一周</li></ul>';
			html += '<ul><li class="font_dark_brown font16">近半月</li>';
			html += '<li class="font_dark_brown font16">近一月</li></ul>';
			html += '<ul><li class="font_dark_brown font16">近一年</li>';
			html += '<li class="font_dark_brown font16">2015年前</li>';
			html +='</ul>';
			$('.itemsList').append(html);
		}
		var text = $(obj).find('span').text();
		var items = $('.itemsList li');
		for(var i=0;i<items.length;i++){
			if($(items[i]).text() == text){
				$(items[i]).css('background-color','#774c22');
				$(items[i]).css('color','#fff');
				break;
			}
			if($(items[i]).text() == '全部' && text == '时间'){
				$(items[i]).css('background-color','#774c22');
				$(items[i]).css('color','#fff');
				break;
			}
		}
		var width  = $(window).width();
	    var minWidth =(  width -55 ) /2;  
		$('.itemsList ul>li').css('min-width', minWidth);
		$('.itemsList ul>li:nth-child(1)').css('margin-left', '15px');
		$('.ordersContainer').hide();
		$('.itemsList').show();
		$('.itemsList li').click(function(){
			var text = $(obj).find('span').text();
			$(obj).find('img').attr('src',mobileUrl + '/images/icon_down_deep.png');
			$(obj).find('span').addClass('font_dark_brown');
			if(type == 'orderType'){
				$('.navigate .orderType>span').text($(this).text());
			}else{
				if($(this).text() != '全部'){
					$('.navigate .dateTime>span').text($(this).text());
				}else{
					$('.navigate .dateTime>span').text('时间');
				}
			}
			$('.itemsList').hide();
			$this.seacher(true);
			$('.ordersContainer').show();
		});
		
		
	},
	statusSearch : function(status,obj){
		$('.ordersNav>li>span').removeClass('selected');
		$(obj).addClass('selected');
		this.seacher(true);
	},
	cancelProjectOrder : function(id){
		var params = {
				status : 'canceled'
		}
		if(confirm('确定取消订单吗？')){
				var option ={
						methodType	:	'PUT',
						url			:	'projectOrders/'+id+'/status',
						params		:	params
				};
				var successCB = function(data){
					alert('订单取消成功');
					window.location.reload();
				};
				commonAjax(option,successCB);	
		}
	},
	cancelDoctorOrder : function(id){
		var params = {
				orderStatus : 'canceled'
		}
		if(confirm('确定取消订单吗？')){
				var option ={
						methodType	:	'PUT',
						url			:	'doctorOrders/'+id+'/status',
						params		:	params
				};
				var successCB = function(data){
					alert('订单取消成功');
					window.location.reload();
				};
				commonAjax(option,successCB);	
		}
	},
	evaluateOrder : function(id){
		window.location.href= mobileUrl + '/myOrders/'+id+'/evaluate';
	}
	
	
}
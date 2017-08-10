
var DoctorsVM = {
	pageNo : 1,
	pageSize : 10,
	conditionsFlag : true,
	template : function(){
		/*
		<li id="{{id}}">
			<div class="imgBox" style="position:absolute">
				<img src="{{avatarUrl}}" />
				<span class="bg_white font10 font_deep_gray">{{workAge}}年经验</span>
			</div>
			<ul class="content">
				<li><b class="font_dark_gray font16">{{name}}</b>
					<font class="title font13 font_dark_brown">{{level}}</font>
					{{#if hospital.distance}}
					<span class="distance font11 font_deep_gray">{{distance}}</span>
					{{/if}}
				</li>
				<li class="font14 font_dark_gray textOverFlow">
					{{hospital.name}}
				</li>
				<li class="font13 font_gray textOverFlow">
				简介：{{intro}}
				</li>
				<li>
				 <font class="font13 font_gray" style="margin-right:8px;position:absolute;margin-top:10px;">擅长</font>
				 <div class="skillList">
				 	{{#each skillList}}
				 	<span class="doctor_skill_tag font12 font_shallow_brown">{{this}}</span>
				 	{{/each}}
				 </div>
				</li>
			</ul>
		</li>
		*/
	},
	searcher : function(poi,skill,orderTime,halfDay,clearFlag){
		var $this = this;
		var params = {
			pageNo	 :	this.pageNo,
			pageSize :	this.pageSize
		};
		if(poi != null ){
			params.poi = poi;
		}
		if(skill != null  && skill != '医生擅长' && skill != '全部'){
			params.skill = skill;
		}
		if(orderTime != null && orderTime != '预约时间' && orderTime != '全部'){
			params.orderTime = orderTime;
		}
		if(halfDay != null){
			params.halfDay = halfDay;
		}
		var option ={
				methodType	:	'GET',
				url			:	'doctors/search',
				params		:	params
		};
		var successCB = function(data){
			CrazyDoctor.utils.isLoadingData = false;
			if(clearFlag){
				$('.projectList>li').remove();
			}
			var doctorView = new CrazyDoctor.View();
			var items = data.items;
			for(var i=0;i<items.length;i++){
				var skillList = items[i].skills.split(',');
				items[i].skillList = skillList;
				items[i].distance = CrazyDoctor.utils.distanceTxt(items[i].hospital.distance);
				doctorView.render($this.template,'lastItem','before',items[i]);
			}
			$('.projectList li').click(function(){
				var id = $(this).attr('id');
				window.location.href= mobileUrl + '/doctors/'+id;
			});
			$('.itemsList').hide();
			$('.projectList').show();
		};
		commonAjax(option,successCB);
	},
	typeCondition : function(type){
		if(!this.conditionsFlag){
			return;
		}
		this.conditionsFlag = false;
		$('.projectList').hide();
		$('.itemsList').show();
		$('.itemsList').empty();
		var $this = this;
		var tagTypeName = '医生擅长';
		var curTagName = '';
		if(type == 'skills'){
			tagTypeName = '医生擅长';
			curTagName = ( $('.navigate .skills>span').text() == '医生擅长' ? '全部' : $('.navigate .skills>span').text() );
			$('.navigate .skills').removeClass('font_gray');
			$('.navigate .skills').addClass('font_dark_brown');
			//$('.navigate .dateTime').removeClass('font_dark_brown');
			//$('.navigate .dateTime').addClass('font_gray');
			$('.navigate .skills>img').attr('src',mobileUrl+'/images/icon_up.png');
			//$('.navigate .dateTime>img').attr('src',mobileUrl+'/images/icon_down.png');
		}else if(type =='dateTime'){
			tagTypeName = '预约时间';
			curTagName = ( $('.navigate .dateTime>span').text() == '预约时间' ? '全部' : $('.navigate .dateTime>span').text() );
			$('.navigate .dateTime').removeClass('font_gray');
			$('.navigate .dateTime').addClass('font_dark_brown');
			//$('.navigate .skills').removeClass('font_dark_brown');
			//$('.navigate .skills').addClass('font_gray');
			//$('.navigate .skills>img').attr('src',mobileUrl+'/images/icon_down.png');
			$('.navigate .dateTime>img').attr('src',mobileUrl+'/images/icon_up.png');
		}
		if(type == 'skills'){
			var option ={
					methodType	:	'GET',
					url			:	'tags/'+tagTypeName,
					params		:	null
			};
			var successCB = function(data){
				var dataAll = ['全部'];
				var tagArrs =dataAll.concat(data.tagArrs);
				var html = '<ul>';
				var index = 0; 
				for(var i=0;i<tagArrs.length;i++){
					index++;
					if(curTagName == tagArrs[i]){
						html += '<li class="bg_dark_brown font_white font15">'+tagArrs[i]+"</li>";
					}else{
						html += '<li class="font_gray font15">'+tagArrs[i]+"</li>";
					}
					if(index%3 ==0){
						html += '</ul>';
						$('.itemsList').append(html);
						html = '<ul>';
					}
				}
				if(html != '<ul>'){
					$('.itemsList').append(html+'</ul>');	
				}
				var width  = $(window).width();
			    var minWidth =(  width - 75 ) /3;
				$('.itemsList ul>li').css('min-width', minWidth);
				
				$('.itemsList li').click(function(){
					$('.itemsList li').removeClass('bg_dark_brown');
					$('.itemsList li').css('color','#b9976c');
					$(this).addClass('bg_dark_brown');
					$(this).css('color','#fff');
					if(type == 'skills'){
						$('.navigate .skills>span').text($(this).text() == '全部' ? '医生擅长' : $(this).text());
						var dateAndHalfDay = $('.navigate .dateTime>span').text().split(" ");
						$this.searcher(null,$(this).text(),dateAndHalfDay[0],dateAndHalfDay[1],true);
					}
				});
				$this.conditionsFlag = true;
			};
			commonAjax(option,successCB);
		}
		if(type == 'dateTime'){
			var curLongTime = new Date().getTime();
			var arrs = new Array();
			var arrs1 = $.format.date(new Date(curLongTime+24*60*60*1000), 'yyyy/MM/dd');
			var arrsIndex = 0;
			arrs[arrsIndex++] = '全部';
			arrs[arrsIndex++] = arrs1+' 上午';
			arrs[arrsIndex++] = arrs1+' 下午';
			var arrs2 = $.format.date(new Date(curLongTime+2*24*60*60*1000), 'yyyy/MM/dd');
			arrs[arrsIndex++] = arrs2+' 上午';
			arrs[arrsIndex++] = arrs2+' 下午';
			var arrs3 = $.format.date(new Date(curLongTime+3*24*60*60*1000), 'yyyy/MM/dd');
			arrs[arrsIndex++] = arrs3+' 上午';
			arrs[arrsIndex++] = arrs3+' 下午';
			var arrs4 = $.format.date(new Date(curLongTime+4*24*60*60*1000), 'yyyy/MM/dd');
			arrs[arrsIndex++] = arrs4+' 上午';
			arrs[arrsIndex++] = arrs4+' 下午';
			var arrs5 = $.format.date(new Date(curLongTime+5*24*60*60*1000), 'yyyy/MM/dd');
			arrs[arrsIndex++] = arrs5+' 上午';
			arrs[arrsIndex++] = arrs5+' 下午';
			var arrs6 = $.format.date(new Date(curLongTime+6*24*60*60*1000), 'yyyy/MM/dd');
			arrs[arrsIndex++] = arrs6+' 上午';
			arrs[arrsIndex++] = arrs6+' 下午';
			var arrs7 = $.format.date(new Date(curLongTime+7*24*60*60*1000), 'yyyy/MM/dd');
			arrs[arrsIndex++] = arrs7+' 上午';
			arrs[arrsIndex++] = arrs7+' 下午';
			var index = 0; 
			var html = '<ul>';
			for(var i=0;i<arrs.length;i++){
				index++;
				if(curTagName == arrs[i]){
					html += '<li class="bg_dark_brown font_white font15 doctorTimeVal">'+arrs[i]+"</li>";
				}else{
					html += '<li class="font_gray font15 doctorTimeVal">'+arrs[i]+"</li>";
				}
				if(index%2 ==0){
					html += '</ul>';
					$('.itemsList').append(html);
					html = '<ul>';
				}
			}
			if(html != '<ul>'){
				$('.itemsList').append(html+'</ul>');	
			}
			$this.conditionsFlag = true;
			$('.itemsList .doctorTimeVal').css('margin-right',0);
			
			var width  = $(window).width();
		    var minWidth =(  width -55 ) /2;  
			$('.itemsList ul>li').css('min-width', minWidth);
			
			$('.itemsList li').click(function(){
				$('.itemsList li').removeClass('bg_dark_brown');
				$('.itemsList li').css('color','#b9976c');
				$(this).addClass('bg_dark_brown');
				$(this).css('color','#fff');
				if(type == 'dateTime'){
					$('.navigate .dateTime>span').text($(this).text() == '全部' ? '预约时间' : $(this).text());
					var dateAndHalfDay = $(this).text().split(" ");
					$this.searcher(null,$('.navigate .skills>span').text(),dateAndHalfDay[0],dateAndHalfDay[1],true);
				}
			});
			
		}
	},
	fetchFeatures : function(className){
		var option ={
				methodType	:	'GET',
				url			:	'tags/理疗功效',
				params		:	null
		};
		var successCB = function(data){
			for(var i=0;i<data.tagArrs.length;i++){
				var html ='<li class="font13 font_gray">'+data.tagArrs[i]+'</li>';
				$('.'+className).append(html);
			}
		}
		commonAjax(option,successCB);
	}
	
	
};









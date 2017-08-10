
var ProjectsVM = {
	pageNo : 1,
	pageSize : 10,
	conditionsFlag : true,
	template : function(){
		/*
			<li id="{{id}}">
				<img src="{{logoUrl}}" class="projectImg" />
				<ul class="content">
					<li><b class="font_dark_gray font16">{{name}}</b>
						<font class="tag font13 font_dark_brown" style="margin-left:10px;">{{projectFeatures}}</font>
						<span class="distance font11 font_deep_gray">2.6km</span>
					</li>
					<li class="font14 font_dark_gray">
						{{organization.address}}
					</li>
					<li>
						<img class="icon_time" src="images/icon_time.png" />
						<font class="font15 project_time font_dark_brown">{{time}}</font>
						<font class="font_deep_gray">分钟</font>	
							<img class="icon_money" src="images/icon_money.png" />
							<font class="font_color_f45f41">{{specialPrice}}</font>
							<span class="font11 font_deep_gray"><s>{{price}}</s></span>
					</li>
					<li class="font12 font_gray textOverFlow paddingRight15"  >
					简介：{{remark}}
					</li>
				 </ul>	
			</li>
		*/
	},
	searcher : function(poi,projectFeature,projectWay,clearFlag){
		var $this = this;
		var params = {
			pageNo	 :	this.pageNo,
			pageSize :	this.pageSize
		};
		if(poi != null ){
			params.poi = poi;
		}
		
		if(projectFeature != null  && projectFeature != '全部' && projectFeature !='功效'){
			params.projectFeature = projectFeature;
		}else{
			if($('.navigate .feature>span').text() != '' && $('.navigate .feature>span').text()!='全部' &&$('.navigate .feature>span').text() !='功效'){
				params.projectFeature = $('.navigate .feature>span').text();
			}
		}
		
		if(projectWay != null && projectWay != '全部'&& projectWay != '方式'){
			params.projectWay = projectWay;
		}
		if(organizationId !=''){
			params.organizationId = organizationId;
		}
		var option ={
				methodType	:	'GET',
				url			:	'projects/search',
				params		:	params
		};
		var successCB = function(data){
			CrazyDoctor.utils.isLoadingData = false;
			if(clearFlag){
				$('.projectList>li').remove();
			}
			var projectView = new CrazyDoctor.View();
			var items = data.items;
			for(var i=0;i<items.length;i++){
				projectView.render($this.template,'lastItem','before',items[i]);
			}
			$('.projectList li').click(function(){
				var id = $(this).attr('id');
				window.location.href= mobileUrl + '/projects/'+id;
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
		var tagTypeName = '理疗功效';
		var curTagName = '';
		if(type == 'feature'){
			tagTypeName = '理疗功效';
			curTagName = ( $('.navigate .feature>span').text() == '功效' ? '全部' : $('.navigate .feature>span').text());
			$('.navigate .feature').removeClass('font_gray');
			$('.navigate .feature').addClass('font_dark_brown');
			//$('.navigate .way').removeClass('font_dark_brown');
			//$('.navigate .way').addClass('font_gray');
			$('.navigate .feature>img').attr('src',mobileUrl+'/images/icon_up.png');
			//$('.navigate .way>img').attr('src',mobileUrl+'/images/icon_down.png');
			/*
			$('.navigate .feature').css('background','url("images/icon_up.png") no-repeat');
			$('.navigate .feature').css('background-size','11px 6px');
			$('.navigate .feature').css('background-position','36px');
			$('.navigate .way').css('background','url("images/icon_down.png") no-repeat');
			$('.navigate .way').css('background-size','11px 6px');
			$('.navigate .way').css('background-position','right');*/
		}else if(type =='way'){
			tagTypeName = '理疗方式';
			curTagName = ( $('.navigate .way>span').text() == '方式' ? '全部' : $('.navigate .way>span').text() );
			$('.navigate .way').removeClass('font_gray');
			$('.navigate .way').addClass('font_dark_brown');
			//$('.navigate .feature').removeClass('font_dark_brown');
			//$('.navigate .feature').addClass('font_gray');
			//$('.navigate .feature>img').attr('src',mobileUrl+'/images/icon_down.png');
			$('.navigate .way>img').attr('src',mobileUrl+'/images/icon_up.png');
			/*
			$('.navigate .way').css('background','url("images/icon_up.png") no-repeat');
			$('.navigate .way').css('background-size','11px 6px');
			$('.navigate .way').css('background-position','right');
			$('.navigate .feature').css('background','url("images/icon_down.png") no-repeat');
			$('.navigate .feature').css('background-size','11px 6px');
			$('.navigate .feature').css('background-position','36px');*/
		}
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
				if(type == 'feature'){
					$('.navigate .feature>span').text($(this).text() == '全部' ? '功效' : $(this).text());
					$this.searcher(null,$(this).text(),$('.navigate .way>span').text(),true);
				}else if(type == 'way'){
					$('.navigate .way>span').text($(this).text() == '全部' ? '方式' : $(this).text());
					$this.searcher(null,$('.navigate .feature>span').text(),$(this).text(),true);
				}
			});
			$this.conditionsFlag = true;
		};
		commonAjax(option,successCB);
	},
	fetchFeatures : function(className,successCallBack){
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
			if(successCallBack){
				successCallBack();
			}
		}
		commonAjax(option,successCB);
	}
	
	
};









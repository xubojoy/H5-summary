
var ProjectVM = {
	pageNo  : 1,
	pageSize : 10,
	typeCondition : function(){
		var $this = this;
		var tagTypeName = '理疗功效';
		var option ={
				methodType	:	'GET',
				url			:	'tags/'+tagTypeName,
				params		:	null
		};
		var successCB = function(data){
			var html = '<ul>';
			var index = 0; 
			for(var i=0;i<data.tagArrs.length;i++){
				index++;
				html += '<li class="font_dark_gray font13 bg_color_efd6bc">'+data.tagArrs[i]+"</li>";
				if(index/3 ==1){
					html += '</ul>';
					$('.evaluateContainer .tags').append(html);
					html = '<ul>';
				}
			}
			if(html != '<ul>'){
				$('.evaluateContainer .tags').append(html+'</ul>');	
			}
			var width  = $(window).width();
		    var minWidth =(  width - 52 ) /3;
			$('.evaluateContainer .tags li').css('min-width', minWidth);
			
			
		};
		commonAjax(option,successCB);
	},
	toPage : function(path,isLoginFlag){
		path  = mobileUrl + '/'+ path;
		if(isLoginFlag == 1){
			if(!CrazyDoctor.User.isLogin()){
				path = encodeURIComponent(path);
				window.location.href = mobileUrl + '/login?backUrl=' +path;
				return ;
			}
			var initUserInfoCB = function(){
				window.location.href = path;
			}
			CrazyDoctor.User.ininUserInfo(null,initUserInfoCB);
		}
		window.location.href = path;
	},
	evaluationTemplate : function(){
		/*
		 <li class="evaluation{{index}}">
			<div class="personInfo font13 font_gray">
					<img src="{{avatarUrl}}" /> 
					<div class="nameTime">
						{{userName}}
						<span class="time font10 font_shallow_gay">{{createTimeText}}</span>
					</div>
					<span class="starLevel">
						<img class="icon_star" src="{{mobileUrl}}/images/icon_star.png" />
						<img class="icon_star" src="{{mobileUrl}}/images/icon_star.png" />
						<img class="icon_star" src="{{mobileUrl}}/images/icon_star.png" />
						<img class="icon_star" src="{{mobileUrl}}/images/icon_star.png" />
						<img class="icon_star" src="{{mobileUrl}}/images/icon_star.png" />
					</span>
			</div>
			<ul class="tags">
			{{#each serviceArry}}
				{{#if this}}
				<li class="font_dark_gray font13 bg_color_efd6bc">{{this}}</li>
				{{/if}}
			{{/each}}
			</ul>
			<p class="description font12 font_dark_gray">
				{{commentContent}}
			</p>
		</li>
		*/
	},
	evaluationSearcher : function(projectId,pageSize){
		var $this  = this;
		var projectView = new CrazyDoctor.View();
		if(pageSize){
			this.pageSize = pageSize;
		}
		var params = {
			pageNo : $this.pageNo,
			pageSize : $this.pageSize
		}
		var option ={
			methodType	:	'GET',
			url			:	'projectOrders/'+projectId+'/commented',
			params		:	params
		}
		var successCB = function(data){
			var items = data.items;
			if(data.totalCount > 0){
				$('.evaluateContainer').show();
			}
			$('.evaluateContainer .title>font').text('('+data.totalCount+")");
			for(var i=0;i<items.length;i++){
				items[i].mobileUrl = mobileUrl;
				items[i].index = i+1;
				items[i].createTimeText = $.format.date(new Date(items[i].createTime), 'yyyy/MM/dd');
				items[i].serviceArry = items[i].commentTags.split(',');
				
				projectView.render($this.evaluationTemplate,'evaluateList','append',items[i]);
				var tagItems = $('.'+('evaluation'+items[i].index)+' .starLevel>img');
				for(var m=0;m<tagItems.length;m++){
					if(m+1 > items[i].commentStarLevel){
						$(tagItems[m]).remove();
					}
				}
			}	
		}
		commonAjax(option,successCB);
	}
	
	
	
};









var EvaluationVM = {
	starCount : 0,
	starSelect : function(){
		var $this = this;
		$('.starList>img').click(function(){
			var count = parseInt($(this).attr('alt'));
			var items = $('.starList>img');
			if( count>$this.starCount ){
				for(var i=0;i<count;i++){
					$(items[i]).attr('src',mobileUrl+'/images/icon_evaluate_star_pre.png');
				}
			}else if(count<$this.starCount){
				$('.starList>img').attr('src',mobileUrl+'/images/icon_evaluate_star_nor.png');
				for(var i=0;i<count;i++){
					$(items[i]).attr('src',mobileUrl+'/images/icon_evaluate_star_pre.png');
				}
			}
			$this.starCount = count;
		});
	},
	evaluationTag : function(){
		var $this =this;
		var option ={
				methodType	:	'GET',
				url			:	'tags/理疗评价',
				params		:	null
		};
		var successCB = function(data){
			for(var i=0;i<data.tagArrs.length;i++){
				var html ='<li class="bg_color_f5f5f5">'+data.tagArrs[i]+'</li>';
				$('.serviceRateList').append(html);
			}
			$('.serviceRateList>li').click(function(){
				if($(this).hasClass('bg_color_f5f5f5')){
					$(this).removeClass('bg_color_f5f5f5');
					$(this).addClass('bg_color_efd6bc');
				}else{
					$(this).removeClass('bg_color_efd6bc');
					$(this).addClass('bg_color_f5f5f5');
				}
			});
		}
		commonAjax(option,successCB);
	},
	commitEvaluation : function(id){
		var $this = this;
		var items = $('.serviceRateList .bg_color_efd6bc');
		var remark = $('textarea[name="remark"]').val();
		if(this.starCount == 0){
			alert('请给总体评价打分');
			return;
		}
		if(items.length==0){
			alert('请给出服务评价');
			return;
		}
		var itemStr = '';
		for(var i=0;i<items.length;i++){
			itemStr += $(items[i]).text()+',';
		}
		
		var params = {
			commentStarLevel : $this.starCount,
			commentContent  :  remark,
			commentTags : itemStr
		}
		var option ={
				methodType	:	'POST',
				url			:	'projectOrders/'+id+'/comment',
				params		:	params
		};
		
		var successCB  = function(data){
			$this.showSuccessModel();
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
		window.location.href= mobileUrl +'/myOrders?orderType=projects';
	}
	
		
}
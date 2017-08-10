	

	var commonAjax = function(option,successCB,errorCB,completeCB){
		jQuery.support.cors = true;
		var url = "";
		
		url = getApiUrl(apiUrl+'/'+option.url);
		if(option.urlType  == 'local'){
			url = mobileUrl+'/'+option.url;
		}
		else if(option.urlType  == 'pay'){
			url = getPayUrl(payUrl+'/'+option.url);
		}
		
		var contentType  = 'application/x-www-form-urlencoded';
		if(option.contentType){
			contentType = option.contentType;
		}
		if(option.params != null ){
			option.params.t= Math.random();
		}
		
		$.ajax({
			type 		: option.methodType,
			url 		: url,
			contentType	: contentType,
			data		: option.params,
			success : function(data) {
				console.log(data);
				successCB && successCB(data);
			},
			error	:function(response){
				var status = response.status;
				var code = 0;
				if(status == 400){
					code = parseInt(response.responseJSON.code);
				}
				if(option.errorToLogin == null){
					if(status == 401 || code== 40001 ){
						window.localStorage.removeItem('crazy_doctor_user');
						window.localStorage.removeItem('crazy_doctor_views');
						//var path = window.location.href ;
						//path = encodeURIComponent(path);
						//var newPath = mobileUrl + '/login?backUrl=' +path;
						//alert(newPath);
						//window.top.location.href = newPath+'&tt='+Math.random();
						window.location.href= mobileUrl+'/login?tt='+Math.random();
					}
				}
				var msg = '';
				try{
					msg = JSON.parse(response.responseText);
					msg = msg.message;
				}catch(e){
					msg = response.responseText;
				}
				errorCB && errorCB(response);
			},
			complete : function(){
				completeCB && completeCB();
			}
		});
	};


	var userAgent = function(){
	        var userAgent = $.os.name+',1.0'+';'+$.browser.name+','+$.browser.version+';'+'crazy_doctor,1.0;unknow;unknow';
	    	return userAgent;
	};
	
	var getApiUrl = function(requestUrl){
		requestUrl += requestUrl.indexOf('?')>0 ? "&" : "?" ;
		requestUrl += "User-Agent="+userAgent();
		var user = window.localStorage.getItem('crazy_doctor_user');
		if(user !=null && parseInt(user.indexOf('id')) > -1){
			user = JSON.parse(user);
			requestUrl += "&Authorization="+user.accessToken;
		}
		return requestUrl;
	};
	
	var getCmsUrl = function(requestUrl){
		requestUrl += requestUrl.indexOf('?')>0 ? "&" : "?" ;
		requestUrl += "User-Agent="+userAgent();
		var user = window.localStorage.getItem('crazy_doctor_user');
		if(user !=null && user.indexOf('id') > -1){
			user = JSON.parse(user);
			requestUrl += "&Authorization="+user.accessToken;
		}
		return requestUrl;
	};
	
	var getPayUrl = function(requestUrl){
		requestUrl += requestUrl.indexOf('?')>0 ? "&" : "?" ;
		requestUrl += "User-Agent="+userAgent();
		var user = window.localStorage.getItem('crazy_doctor_user');
		if(user !=null && user.indexOf('id') > -1){
			user = JSON.parse(user);
			requestUrl += "&Authorization="+user.accessToken;
		}
		return requestUrl;
	};
	
	var CrazyDoctor = {};
	CrazyDoctor.View = function(){
		this.getMultiLine  = function(template){
			var lines = new String(template);
	        lines = lines.substring(lines.indexOf("/*") + 3, lines.lastIndexOf("*/"));
	        return $.trim(lines);
	    },
	    this.render  = function(template,className,type,data){
	    	var source =  this.getMultiLine(template);
            var sourceTemplate = Handlebars.compile(source);
	            if(type == 'append'){
	                $("."+className).append(sourceTemplate(data));
	            }else if(type == 'html'){
	                $("."+className).html(sourceTemplate(data));
	            }else if(type == 'prepend'){
	            	$("."+className).prepend(sourceTemplate(data));
	            }else if(type =='before'){
	            	$("."+className).before(sourceTemplate(data));
	            }
	    }
	};
	
	CrazyDoctor.User = {
		getUser : function(){
			var user =  window.localStorage.getItem('crazy_doctor_user');
			if(user){
				return JSON.parse(user);
			}
		},
		isLogin : function(){
			var user =  window.localStorage.getItem('crazy_doctor_user');
			if(user){
				return true;
			}
			return false;
		},
		ininUserInfo : function(params,loadSuccessCB){
			var $this = this;
			var option ={
					methodType	:	'GET',
					url			:	'myUserInfo',
					params		:	params
			};
			var successCB = function(data){
				$.cookie('Access-Token', data.accessToken, {
					expires : 100,
					path : '/'
				});
				window.localStorage.setItem('crazy_doctor_user',JSON.stringify(data));
				if(loadSuccessCB){
					loadSuccessCB(data);
				}
			};
			commonAjax(option,successCB);	
		}
	};
	
	
	CrazyDoctor.initDatePicker  = function(){
		var currYear = (new Date()).getFullYear();
		var opt={};
		opt.date = {preset : 'date'};
		opt.datetime = {preset : 'datetime'};
		opt.time = {preset : 'time'};
		opt.defaults = {
			theme: 'android-ics light', //皮肤样式
	        display: 'bottom', //显示方式 
	        mode: 'scroller', //日期选择模式
			lang:'zh',
			minDate:new Date(),
	        startYear:currYear , //开始年份
	        endYear:currYear + 10, //结束年份,
			//stepMinute: 10,
			dateFormat: 'yyyy/mm/dd', // 日期格式
		};
	  	var optDateTime = $.extend(opt['date'], opt['defaults']);
	  	return optDateTime;
	};
	
	
	CrazyDoctor.birthdayPicker  = function(){
		var currYear = (new Date()).getFullYear();
		var startYear = (new Date('1910-01-01')).getFullYear();
		var opt={};
		opt.date = {preset : 'date'};
		opt.datetime = {preset : 'datetime'};
		opt.time = {preset : 'time'};
		opt.defaults = {
			theme: 'android-ics light', //皮肤样式
	        display: 'bottom', //显示方式 
	        mode: 'scroller', //日期选择模式
			lang:'zh',
	        startYear:startYear , //开始年份
	        endYear:currYear, //结束年份,
			dateFormat: 'yyyy/mm/dd', // 日期格式
		};
	  	var optDateTime = $.extend(opt['date'], opt['defaults']);
	  	return optDateTime;
	};
	
	CrazyDoctor.DateFormat  = {
		getTime : function(dateStr){
			dateStr= dateStr.replace(/-/g,"/");
	    	dateStr = new Date(dateStr).getTime();
	    	return dateStr;
		},
		getDateTime : function(dateStr){
			dateStr= dateStr.replace(/-/g,"/");
	    	dateStr = new Date(dateStr);
	    	return dateStr;
		},
		getDay : function(dateStr){
			dateStr= dateStr.replace(/-/g,"/");
	    	dateStr = new Date(dateStr).getDay();
	    	return dateStr;
		},
		getHour : function(dateStr){
			dateStr= dateStr.replace(/-/g,"/");
	    	dateStr = new Date(dateStr).getHours();
	    	return dateStr;
		},
		getLastDateByCondition : function(count){
			var dateArray = new Array();
			var curDate = new Date();
			var last7day = curDate.getTime()-count*24*60*60*1000;
			dateArray.push( $.format.date(curDate, 'yyyy-MM-dd') );
			dateArray.push( $.format.date(new Date(last7day), 'yyyy-MM-dd') );
			return dateArray;
		}
		
		
		
    };
	
	CrazyDoctor.history = {
		initViews : function(){
			var views = window.localStorage.getItem('crazy_doctor_views');
			if(views ==null || views == undefined || views ==''){
				views = new Array();
				window.localStorage.setItem('crazy_doctor_views',JSON.stringify(views));
			}else{
				views = JSON.parse(views);
			}
			return views;
		},
		preView : function(){
			var views = window.localStorage.getItem('crazy_doctor_views');
			views = JSON.parse(views);
			var lastPrevView = views[0];
			views.shift();
			var lastView = views[0];
			if(lastView == undefined){
				if(lastPrevView.indexOf('doctors') >-1){
					return mobileUrl+'/doctors';
				}else{
					return mobileUrl+'/projects';
				}
			}
			window.localStorage.setItem('crazy_doctor_views',JSON.stringify(views));
			return lastView;
		},
		putView : function(path){
			var views = this.initViews();
			if(path.indexOf('login') <0 && views[0] != path){
				views.unshift(path);
			}
			window.localStorage.setItem('crazy_doctor_views',JSON.stringify(views));
			console.log(views);
		}
	};
	
	CrazyDoctor.utils = {
		isLoadingData : false,
		distanceTxt : function(result){
				if(result != 0){
					if(result < 1000){
						result += '米';
					}else if(result > 1000 && result < 10000){
						floatvar  = result / 1000;
						var f_x = parseFloat(floatvar);
						var f_x = Math.round(floatvar*100)/100;
						
						result  = f_x + 'Km';
					}else{
						result = parseInt( result/1000 ) + 'Km';
					}
				}else{
					result = '';
				}
				return result;
		},
		weixin : function(){
			var ua = navigator.userAgent.toLowerCase();//获取判断用的对象
	        if (ua.match(/MicroMessenger/i) == "micromessenger") {
	                //在微信中打开
	        	return true;
	        }else{
	        	return false;
	        }
		},
		toPageAfterSeconds : function(url,count){
			  var countdown = setInterval(CountDown, 1000);
		      function CountDown() {
		            if (count == 0) {
		            	window.location.href=url;
		                clearInterval(countdown);
		            }
		            count--;
		       }
		}
	};

	CrazyDoctor.formCheck = {
		checkFlag : true,
		ageCheckNoAlert : function(name){
			var age = $('input[name="'+name+'"]').val();
			if(age == ''|| parseInt(age) < 0 || parseInt(age) > 100 ){
				this.checkFlag = false;
				return false;
			}
			this.checkFlag = true;
			return true;
		},
		ageCheck : function(name){
			if(!this.ageCheckNoAlert(name)){
				alert('输入年龄只能在0-100之间');
				return;
			}
		},
		nameCheckNoAlert : function(name){
			var name = $('input[name="'+name+'"]').val();
			if(name.length < 2 || name.length > 20){
				this.checkFlag = false;
				return false;
			}
			this.checkFlag = true;
			return true;
		},
		nameCheck : function(name){
			if(!this.nameCheckNoAlert(name)){
				alert('输入长度只能在2-20个字符');
				return ;
			}
		},
		telCheckNoAlert : function(name){
			var tel = $('input[name="'+name+'"]').val();
			if(tel.length < 11 || tel.length >11){
				this.checkFlag = false;
				return false;
			}
			this.checkFlag = true;
			return true;
		},
		telCheck : function(name){
			if(!this.telCheckNoAlert(name)){
				alert('输入长度只能是11位');
				return ;
			}
		},
		
	};
	
	
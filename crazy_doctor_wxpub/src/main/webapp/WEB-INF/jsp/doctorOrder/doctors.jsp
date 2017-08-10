<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
#main .itemsList ul:nth-child(1){
	margin-top:0;
}
</style>
<script type="text/javascript" src="<c:url value='/js/libs/handlebars/handlebars.js' /> "></script>
<script type="text/javascript" src="<c:url value='/js/mobile/doctors.js' /> "></script>
<script type="text/javascript" src="<c:url value="/js/libs/jquery/jquery-dateFormat.js"/>"></script>
<title>${pageTitle }</title>
</head>
<body>
<div id="main">
	<section id="header" >
		<a class="back font_dark_gray font14" style="display:none" href="doctor://${domainUrl}/app/backdiscover">返回</a>
		<span class="title font_dark_brown font17"><b>医生列表</b></span>	
	</section>
	<nav class="navigate">
		<ul>
			<li class="font_gray skills"  onclick="DoctorsVM.typeCondition('skills')">
				<span style="margin-right:5px;">医生擅长</span><img src="<c:url value="/images/icon_down.png" />" /> 
			</li>
			<li class="font_gray dateTime" onclick="DoctorsVM.typeCondition('dateTime')">
				<span style="margin-right:5px;">预约时间</span><img src="<c:url value="/images/icon_down.png" />" /> 
			</li>
		</ul>
	</nav>
	<ul class="projectList w100p15 doctorsList" style="display:block">
		<div class="lastItem"></div>		
	</ul>
	
	<ul class="itemsList skillList" style="display:none">
		<li class="confirmBtn font18 font_white bg_dark_brown">
			确定
		</li>
	</ul>
	<jsp:include page="../common/footer.jsp?footerName=doctor"></jsp:include>
<script type="text/javascript">
$().ready(function(){
	if(!CrazyDoctor.utils.weixin()){
		$('#header .back').show();
	}
	
	var poi =null;
	if(lng != null && lng !='' && lat !=null && lat != ''){	
		poi = lat+','+lng;
	}
	$('.projectList').bind('scroll',function(e){
		var scrollHeight = $(e.currentTarget).scrollTop(); // 滚动高度
        var divHeight = $(e.currentTarget)[0].offsetHeight;  // 带偏移高度的div高度
        var totalHeight = $(e.currentTarget)[0].scrollHeight;  // 总高度
        if (!CrazyDoctor.utils.isLoadingData && scrollHeight + divHeight >= totalHeight ) {
        	CrazyDoctor.utils.isLoadingData = true;
            DoctorsVM.pageNo +=  1;
			var dateAndHalfDay = $('.navigate .dateTime>span').text().split(" ");
			DoctorsVM.searcher(poi,$('.navigate .skills>span').text(),dateAndHalfDay[0],dateAndHalfDay[1],false);
        } 	
	});	
	
	DoctorsVM.searcher(poi);
});
</script>
</div>
</body>
</html>
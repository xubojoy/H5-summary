<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<c:url value='/js/libs/handlebars/handlebars.js' /> "></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/js/libs/mobiscroll/css/mobiscroll.core-2.5.2.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/js/libs/mobiscroll/css/mobiscroll.animation-2.5.2.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/js/libs/mobiscroll/css/mobiscroll.android-ics-2.5.2.css"/>"/>
<script type="text/javascript" src="<c:url value='/js/libs/mobiscroll/js/mobiscroll.core-2.5.2.js' /> "></script>
<script type="text/javascript" src="<c:url value='/js/libs/mobiscroll/js/mobiscroll.core-2.5.2-zh.js' /> "></script>
<script type="text/javascript" src="<c:url value='/js/libs/mobiscroll/js/mobiscroll.datetime-2.5.1.js' /> "></script>
<script type="text/javascript" src="<c:url value='/js/libs/mobiscroll/js/mobiscroll.datetime-2.5.1-zh.js' /> "></script>
<script type="text/javascript" src="<c:url value='/js/mobile/projects.js' /> "></script>
<title>${pageTitle}</title>
</head>
<body>
<div id="main">
	<section id="header" >
		<a class="back font_dark_gray font14"  style="display:none" href="doctor://${domainUrl}/app/backdiscover">返回</a>
		<span class="title font_dark_brown font17"><b>预约理疗</b></span>	
	</section>
	<nav class="navigate">
		<ul>
			<li class="font_gray feature" onclick="ProjectsVM.typeCondition('feature')">
				<c:choose>
					<c:when test="${feature ne null }">
						<span class="font_dark_brown">${feature }</span> <img src="<c:url value="/images/icon_up.png" />" /> 					
					</c:when>
					<c:otherwise>
						<span>功效</span> <img src="<c:url value="/images/icon_down.png" />" />
					</c:otherwise>
				</c:choose>
				
			</li>
			<li class="font_gray way" onclick="ProjectsVM.typeCondition('way')">
				<span>方式</span> <img src="<c:url value="/images/icon_down.png" />" /> 
			</li>
		</ul>
	</nav>
	<ul class="projectList doctorsList w100p15" style="display:block">
		<div class="lastItem"></div>
	</ul>
	
	<ul class="itemsList" style="display:none">
		<li class="confirmBtn font18 font_white bg_dark_brown">
			确定
		</li>
	</ul>	
	<jsp:include page="../common/footer.jsp?footerName=project"></jsp:include>
</div>
<script type="text/javascript">
//var feature = '${feature}';
var organizationId = '${organizationId}';
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
        	ProjectsVM.pageNo +=  1;
        	ProjectsVM.searcher(poi,$('.navigate .feature>span').text(),$('.navigate .way>span').text(),false);
        } 	
	});	
	ProjectsVM.searcher();
})
</script>
</body>
</html>
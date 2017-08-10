<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<c:url value='/js/libs/handlebars/handlebars.js' /> "></script>
<script type="text/javascript" src="<c:url value='/js/libs/jquery/jquery.touchSwipe.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/mobile/organization.js' /> "></script>
<script type="text/javascript" src="<c:url value='/js/mobile/projects.js' /> "></script>
<title>${pageTitle }</title>
</head>
<body>
<div id="main">
	<section id="header" class="bg_white">
		<span class="back font_dark_gray font14">返回</span>
		<span class="title font_dark_brown font17"><b>${organization.name }</b></span>	
	</section>
	<div class="banner_block">
		<div id="myCarousel" class="carousel slide">
			<ol class="carousel-indicators">
			<c:forEach items="${fn:split(organization.pics,',')}" varStatus="index"> 
				<c:choose>
					<c:when test="${index.index eq 0 }">
						<li data-target="#myCarousel" data-slide-to="${index.index }" class="active"></li>
					</c:when>
					<c:otherwise>
						<li data-target="#myCarousel" data-slide-to="${index.index }" ></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			</ol>   
			<div class="carousel-inner">
				<c:forEach items="${fn:split(organization.pics,',')}" var="pic" varStatus="index"> 
					<c:choose>
						<c:when test="${index.index eq 0 }">
							<div class="item swiper-slide active" >
								<img class="banner_img" src="${pic}" style="width:100%;height:100%" >
								<span class="title">这里是文章</span>
							</div>
						</c:when>
						<c:otherwise>
							<div class="item swiper-slide" >
								<img class="banner_img" src="${pic}" style="width:100%;height:100%">
								<span class="title">这里是文章</span>
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			
				
			</div>
		</div>
	</div>
	<ul class="w100p15 bg_white projectIntro" >
		<li>
			<h4 class="font16 font_dark_brown">${organization.name }</h4>
			<p class="font12 font_gray">
				${organization.address}
			</p>
		</li>
		<li class="address addrAndPhone toMap">
			<span class="location_sign"></span>
			<span class="addr font15 font_dark_gray">${organization.address }</span>
			<span class="rightArrow"></span>
		</li>
		<li class="address addrAndPhone" onclick="window.location.href='tel:${organization.phone }' " >
			<span class="phone_sign"> </span>
			<span class="addr font15 font_dark_gray">${organization.phone }</span>
			<span class="rightArrow"></span>
		</li>
	</ul>
	<div style="height:10px;" class="bg_f4"></div>
	<div class="projectTags w100p15 bg_white">
		<div class="title font15 font_dark_brown"><span></span>理疗项目</div>
		<ul class="bg_white projectTagsList">
		</ul>
	</div>
</div>
<script type="text/javascript">
var organizationId = '${organization.id}';
$().ready(function(){
	$('.projectIntro .toMap').click(function(){
		window.location.href = mobileUrl + '/common/map?longitude=${organization.latitude}&latitude=${organization.longitude}&address=${organization.address}' ;
	});
	
	
});
</script>
</body>
</html>
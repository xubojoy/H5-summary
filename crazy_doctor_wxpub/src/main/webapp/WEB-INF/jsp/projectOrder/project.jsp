<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
#main .evaluateContainer .list>li .personInfo{
}
</style>
<script type="text/javascript" src="<c:url value='/js/libs/handlebars/handlebars.js' /> "></script>
<script type="text/javascript" src="<c:url value='/js/mobile/project.js' /> "></script>
<script type="text/javascript" src="<c:url value="/js/libs/jquery/jquery-dateFormat.js"/>"></script>
<title>${pageTitle }</title>
</head>
<body>
<div id="main" class="bg_f4">
	<section id="header" class="bg_white">
		<span class="back font_dark_gray font14">返回</span>
		<span class="title font_dark_brown font17"><b>理疗详情</b></span>	
	</section>
	<div class="projectDetailBox" >
	<div class="doctorInfo projectDetail">
		<ul class="bg_white">
			<li>
				<span class="font14 font_gray">理疗项目</span>
				<font style="float:right;margin-top:5px;" class="font13 font_dark_brown">${project.projectWays }</font>
				<span class="font15 font_dark_gray" style=""><b>${project.name }</b></span>
			</li>
			<li class="content">
				<span class="font14 font_gray">理疗院名</span>
				<span class="font15 font_dark_gray" style="">${project.organization.name }</span>
			</li>
			<li class="content">
				<span class="font14 font_gray">理疗店地址</span>
				<span class="font15 font_dark_gray"><p class="addressInfo">${project.organization.address }</p></span>
			</li>
		</ul>
		<img src="${project.logoUrl }"  />
	</div>
	<ul class="w100p15 bg_white projectInfoContainer">
		<li>
			<span class="font15 font_gray">适合人群</span>
			<span class="font16 font_dark_gray rightInfo">${project.suitableForUse }</span>
		</li>
		<li>
			<span class="font15 font_gray">理疗功效</span>
			<span class="font16 font_dark_gray rightInfo">${project.projectFeatures }</span>
		</li>
		<li class="projectSuppliesAndAttention">
			<span class="font15 font_gray">理疗用品</span>
			<span class="font16 font_dark_gray rightInfo">${project.material }</span>
		</li>
		<li class="projectSuppliesAndAttention">
			<span class="font_gray font15">注意事项</span>
			<span class="font16 font_dark_gray rightInfo">${project.remark }</span>
		</li>
	</ul>
	<div class="evaluateContainer w100p15 bg_white" style="display:none">
		<h4 class="title font15 font_dark_gray" >评价<font style="margin-left:10px">(0)</font></h4>		
		<ul class="list evaluateList">
			
		</ul>
		<div class="w100p15" style="padding-bottom:10px;" onclick="ProjectVM.toPage('projects/${project.id}/evaluation',0)">
		<button class="showAllEvaluateBtn bg_white font12 font_shallow_brown">查看全部评价</button>
		</div>
	</div>
	</div>
	
	<ul class="footerBtn bg_white orderButton" >
		<li class="font18 font_dark_brown"  onclick="ProjectVM.toPage('organizations/${project.organization.id}',0);" ><img src="${mobileUrl}/images/icon_project.png" />理疗院</li>
		<li class="font18 font_white bg_dark_brown" onclick="ProjectVM.toPage('projects/${project.id}/order',1);">立即预约</li>	
	</ul>
	
	
	<div class="full_mask">
	</div>
	
	<div class="modalDialog bg_white">
		<span class="font17 font_gray"></span>
		<ul >
			<li class="font18 font_deep_gray cancelBtn">取消</li>
			<li class="font18 font_dark_brown confirmBtn">确定</li>
		</ul>
	</div>
</div>
<script type="text/javascript">
$().ready(function(){
ProjectVM.evaluationSearcher('${project.id}',3);
})
</script>
</body>
</html>
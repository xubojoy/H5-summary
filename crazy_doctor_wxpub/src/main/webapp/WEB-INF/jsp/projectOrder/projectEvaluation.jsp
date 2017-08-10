<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
#main .evaluateContainer:before {
    content: "";
    position: absolute;
    left: 0px;
    right: 0px;
    border-top: 0;
}

#main .evaluateBox{
	width:100%;
	height: -moz-calc(100% - 44px);
    height: -webkit-calc(100% - 44px);
    height: calc(100% - 44px);
	position: absolute;
	overflow:auto;	
	-webkit-overflow-scrolling: touch;
}
</style>
<script type="text/javascript" src="<c:url value='/js/libs/handlebars/handlebars.js' /> "></script>
<script type="text/javascript" src="<c:url value="/js/libs/jquery/jquery-dateFormat.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/mobile/project.js"/>"></script>
<title>${pageTitle }</title>
</head>
<body>
<div id="main" class="bg_f4" >
	<section id="header" class="bg_white">
		<span class="back font_dark_gray font14">返回</span>
		<span class="title font_dark_brown font17"><b>评价</b></span>	
	</section>
	<div class="evaluateBox">
		<div class="evaluateContainer w100p15 bg_white">
			<h4 class="title font15 font_dark_gray" >评价<font style="margin-left:10px">()</font></h4>		
			<ul class="list evaluateList">
			</ul>
		</div>
	</div>
</div>
<script type="text/javascript">
$().ready(function(){
	ProjectVM.evaluationSearcher('${projectId}');
	
	$('.projectList').bind('scroll',function(e){
		var scrollHeight = $(e.currentTarget).scrollTop(); // 滚动高度
        var divHeight = $(e.currentTarget)[0].offsetHeight;  // 带偏移高度的div高度
        var totalHeight = $(e.currentTarget)[0].scrollHeight-50;  // 总高度
        if (!CrazyDoctor.utils.isLoadingData && scrollHeight + divHeight +1 >= totalHeight ) {
        	CrazyDoctor.utils.isLoadingData = true;
        	ProjectsVM.pageNo +=  1;
        	ProjectsVM.evaluationSearcher('${projectId}');
        } 	
	});	
})

</script>
</body>
</html>
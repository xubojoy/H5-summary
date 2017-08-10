<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<c:url value="/js/mobile/evaluation.js"/>"></script>
<title>${pageTitle }</title>
</head>
<body>
<div id="main" class="bg_f4">
	<section id="header" class="bg_white" >
		<span class="back font_dark_gray font14">返回</span>
		<span class="title font_dark_brown font17"><b>发表评价</b></span>
	</section>
	<div class="eveluationHeader"  >
		<span class="title font17 font_dark_gray">${order.project.organization.name}</span>
		<span class="project font14 font_dark_brown">[${order.project.name}]</span>
	</div>
	<div class="eveluationBody bg_white">
		<div class="rateBox w100p15">
			<span class="font17 font_dark_gray title">总体评价</span>
			<div class="starList">
				<img class="icon_star" alt="1" src="<c:url value="/images/icon_evaluate_star_nor.png" />">
				<img class="icon_star" alt="2" src="<c:url value="/images/icon_evaluate_star_nor.png" />">
				<img class="icon_star" alt="3" src="<c:url value="/images/icon_evaluate_star_nor.png" />">
				<img class="icon_star" alt="4" src="<c:url value="/images/icon_evaluate_star_nor.png" />">
				<img class="icon_star" alt="5" src="<c:url value="/images/icon_evaluate_star_nor.png" />">
			</div>
			<p class="font12 font_deep_gray" style="margin-top:20px;">
				请您从技能、礼貌、守时、真实度、服务等五个维度打分，给出一颗星
				到五颗星的综合评价。
			</p>
			<ul class="serviceRateList">
			</ul>
			<div class="remark">
				<textarea rows="" class="font_dark_gray" name="remark" placeholder="写点评吧；对其他小伙伴帮助很大哦" cols="" style="width:100%;height:100%"></textarea>
			</div>
			<div class="w100p15 bg_white specialButton" onclick="EvaluationVM.commitEvaluation('${order.id}')">
				<button class="font18 bg_dark_brown font_white">提交</button>
			</div>
		</div>
	
	</div>
	
	<div class="full_mask">
	</div>
	
	<div class="successModalDialog bg_white" >
		<span onclick="EvaluationVM.hideSuccessModel()"></span>
		<img src="<c:url value='/images/icon_word_evaluation.png' />" class="successWord" />
	</div>
</div>

<script type="text/javascript">
$().ready(function(){
	EvaluationVM.starSelect();
	EvaluationVM.evaluationTag();
	
});

</script>

</body>
</html>
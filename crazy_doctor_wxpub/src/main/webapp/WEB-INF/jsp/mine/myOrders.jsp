<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<c:url value='/js/libs/handlebars/handlebars.js' /> "></script>
<script type="text/javascript" src="<c:url value="/js/libs/jquery/jquery-dateFormat.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/mobile/myOrders.js"/>"></script>
<title>${pageTitle }</title>
</head>
<body>
<div id="main" class="bg_f4" style="-webkit-overflow-scrolling : touch;">
	<section id="header" class="bg_white" >
		<a class="back font_dark_gray font14" style="display:none" href="doctor://${domainUrl}/app/backdiscover">返回</a>
		<span class="back font_dark_gray font14 backBtn" style="display:none">返回</span>
		<span class="title font_dark_brown font17"><b>我的订单</b></span>	
	</section>
	<nav class="navigate bg_white" >
		<ul>
			<li class="font_gray dateTime"  onclick="MyOrders.orderNavSearch('dateTime',this)">
				<span style="margin-right:5px;">时间</span><img src="<c:url value="/images/icon_down.png" />" /> 
			</li>
			<li class="font_dark_brown orderType" onclick="MyOrders.orderNavSearch('orderType',this)">
				<span style="margin-right:5px;">
					<c:choose>
						<c:when test="${orderType ne '' }">
							${orderType}
						</c:when>
						<c:otherwise>
							预约理疗
						</c:otherwise>
					</c:choose>
				</span><img src="<c:url value="/images/icon_down_deep.png" />" /> 
			</li>
		</ul>
	</nav>
	<ul class="seacherTypeSelect bg_white " style="display:none"></ul>
	<ul class="ordersNav font15 font_dark_gray bg_white">
		<li style="width:25%"><span class="selected" onclick="MyOrders.statusSearch(null,this)">全部</span></li>
		<li style="width:25%"><span onclick="MyOrders.statusSearch('waitingConfirm',this)">待确认</span></li>
		<li style="width:25%"><span onclick="MyOrders.statusSearch('confirmed',this)">待服务</span></li>
		<li style="width:25%"><span onclick="MyOrders.statusSearch('completed',this)">已完成</span></li>
	</ul>
	<div class="noOrders bg_white" style="display:none">
		<img src="<c:url value="/images/bg_no.png" />" />
		<span class="font11 font_deep_gray">暂无订单,选择<font class="font12 font_shallow_brown">订单类型</font></span>
	</div>
	<div class="myOrdersContainer">
		<ul class="ordersContainer" >
		</ul>
		<ul class="itemsList bg_white" style="display:none">
		</ul>
	</div>
	<div class="full_mask">
	</div>
</div>


<script type="text/javascript">
$().ready(function(){
	MyOrders.seacher(true);	
	if(CrazyDoctor.utils.weixin()){
		$('#header .backBtn').show();
		$('#header .backBtn').unbind('click');
		$('#header .backBtn').click(function(){
			window.location.href= mobileUrl +'/mine';
		});
	}
	
	$('.myOrdersContainer').bind('scroll',function(e){
		var scrollHeight = $(e.currentTarget).scrollTop(); // 滚动高度
        var divHeight = $(e.currentTarget)[0].offsetHeight;  // 带偏移高度的div高度
        var totalHeight = $(e.currentTarget)[0].scrollHeight;  // 总高度
        if (!CrazyDoctor.utils.isLoadingData && scrollHeight + divHeight >= totalHeight ) {
        	CrazyDoctor.utils.isLoadingData = true;
        	MyOrders.pageNo +=  1;
        	MyOrders.seacher(false);
        } 	
	});	
	
	
	
});
</script>
</body>
</html>
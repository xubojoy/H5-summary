<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${pageTitle }</title>
</head>
<body>
<div id="main" class="bg_f4">
	<section id="header" class="bg_white" >
		<span class="back font_dark_gray font14">返回</span>
		<span class="title font_dark_brown font17"><b>我的特需</b></span>
	</section>
	<ul class="orderPersonInfo w100p15 bg_white" style="margin-top:10px" >
		<li>
			<span class="font15 font_gray">患者姓名</span>
			<span class="font16 font_dark_gray" style="padding-right:3px">
			${order.patientName }
			</span>
		</li>
		<li>
			<span class="font15 font_gray">患者年龄</span>
			<span class="font16 font_dark_gray" style="padding-right:3px">
			${order.patientAge}
			</span>
		</li>
		<li>
			<span class="font15 font_gray">患者性别</span>
			<span class="font16 font_dark_gray" style="padding-right:3px">
				<c:choose>
					<c:when test="${order.patientGender eq 1}">
						男
					</c:when>
					<c:when test="${order.patientGender eq 0}">
						女
					</c:when>
				</c:choose>
			</span>
		</li>
		<li>
			<span class="font15 font_gray">预约人姓名</span>
			<span class="font16 font_dark_gray" style="padding-right:3px">${order.orderName}</span>
		</li>
		<li>
			<span class="font15 font_gray">预约人电话</span>
			<span class="font16 font_dark_gray" style="padding-right:3px">${order.orderMobileNo }</span>
		</li>
		<li>
			<span class="font15 font_gray">预约医院</span>
			<span class="font16 font_dark_gray" style="padding-right:3px">${order.hospital }</span>
		</li>
		<li>
			<span class="font15 font_gray">预约科室</span>
			<span class="font16 font_dark_gray" style="padding-right:3px">${order.department }</span>
		</li>
		<li>
			<span class="font15 font_gray">预约大夫</span>
			<span class="font16 font_dark_gray" style="padding-right:3px">${order.doctor }</span>
		</li>
		<li style="line-height:normal;padding-bottom:5px;">
			<span class="font15 font_gray" style="position: absolute;margin-top:10px;">附加服务</span>
			<span class="font16 font_dark_gray" style="padding-right:0;margin-left:80px;padding-top:10px;float:none;text-align:left">
				<c:if test="${order.booking eq true}">
					预约票服务、
				</c:if>
				<c:if test="${order.shuttle eq true}">
					接送站服务、
				</c:if>
				<c:if test="${order.charteredCar eq true}">
					包车服务、
				</c:if>
				<c:if test="${order.hotel eq true}">
					预约酒店服务、
				</c:if>
				<c:if test="${order.accompany eq true}">
					陪诊服务、
				</c:if>
				<c:if test="${order.guide eq true}">
					导诊服务
				</c:if>
			</span>
		</li>
		<li style="line-height:normal;padding-bottom:5px;">
			<span class="font15 font_gray" style="position: absolute;margin-top:10px;">备注</span>
			<span class="font16 font_dark_gray" style="padding-right:0;margin-left:80px;padding-top:10px;float:none">${order.remark }</span>
		</li>
		<li>
			<span class="font15 font_gray">预约状态</span>
			<span class="font16 font_shallow_brown" style="padding-right:3px">
				<c:choose>
					<c:when test="${order.orderStatus eq 'waitingConfirm' }">
						等待确认
					</c:when>
					<c:when test="${order.orderStatus eq 'confirmed' }">
						已沟通
					</c:when>
					<c:when test="${order.orderStatus eq 'canceled' }">
						已取消
					</c:when>
					<c:when test="${order.orderStatus eq 'completed' }">
						已完成
					</c:when>
					<c:when test="${order.orderStatus eq 'unCompleted' }">
						未完成
					</c:when>
				</c:choose>
			</span>
		</li>
	</ul>
	<c:choose>
		<c:when test="${order.orderStatus eq 'waitingConfirm' }">
			<div class="footerBtn bg_white" onclick="cancelOrder('${order.id}');">
				<span class="orderBtn font18 font_white bg_dark_brown">取消</span>	
			</div>
		</c:when>
	</c:choose>
</div>

<script type="text/javascript">
var cancelOrder = function(id){
	if(confirm('确认取消此订单吗？')){
	var option ={
			methodType	:	'GET',
			url			:	'/specialOrders/'+id,
			params		:	null
	};
	var successCB = function(data){
		var order = data;
		data.status = 'canceled';
		option ={
				methodType	:	'POST',
				url			:	'specialOrders/'+id+'/status',
				params		:	JSON.stringify(data),
				contentType     : 'application/json'
		};
		var updateSuccessCB = function(){
			alert('订单取消成功！');
			window.location.href= mobileUrl + '/mySpecialOrders';
		};
		commonAjax(option,updateSuccessCB);
		
	};
	commonAjax(option,successCB);
	}
		
};
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.orderPersonInfo>li{
	line-height:50px;
}
</style>
<title>${pageTitle }</title>
</head>
<body>
<div id="main" class="bg_f4">
	<section id="header" class="bg_white" >
		<span class="back font_dark_gray font14">返回</span>
		<span class="title font_dark_brown font17"><b>订单详情</b></span>
	</section>
	<ul class="orderPersonInfo w100p15 bg_white" style="margin-top:10px" >
		<li>
			<span class="font15 font_gray">预约时间</span>
			<span class="font16 font_dark_gray" style="padding-right:3px">
				<fmt:formatDate  value="${order.createTime}"  pattern="yyyy/MM/dd" />
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
			<span class="font16 font_dark_gray" style="padding-right:3px">${order.doctor.hospital.name }</span>
		</li>
		<li>
			<span class="font15 font_gray">预约医生</span>
			<span class="font16 font_dark_gray" style="padding-right:3px">${order.doctor.name }</span>
		</li>
		<li>
			<span class="font15 font_gray">预约状态</span>
			<span class="font16 font_shallow_brown" style="padding-right:3px">
				<c:choose>
					<c:when test="${order.orderStatus eq 'waitingConfirm' }">
						等待确认
					</c:when>
					<c:when test="${order.orderStatus eq 'confirmed' }">
						已确认
					</c:when>
					<c:when test="${order.orderStatus eq 'canceled' }">
						已取消
					</c:when>
					<c:when test="${order.orderStatus eq 'payed' }">
						已支付
					</c:when>
					<c:when test="${order.orderStatus eq 'waitingRefund' }">
						等待退款
					</c:when>
					<c:when test="${order.orderStatus eq 'refunded' }">
						已退款
					</c:when>
					<c:when test="${order.orderStatus eq 'completed' }">
						已完成
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
	var params = {
		orderStatus : 'canceled'
	}
	if(confirm('确定取消订单吗？')){
		var option ={
				methodType	:	'PUT',
				url			:	'doctorOrders/'+id+'/status',
				params		:	params
		};
		var successCB = function(data){
			alert('订单取消成功');
			window.location.reload();
		};
		commonAjax(option,successCB);	
	}
};
</script>
</body>
</html>
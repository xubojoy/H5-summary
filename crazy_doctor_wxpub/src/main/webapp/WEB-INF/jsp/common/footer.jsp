<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<ul id="footerBar" class="bg_white">
	<li class="project" path="projects">
		<c:choose>
			<c:when test="${ footerName eq 'project' ||   footerName eq null  && param.footerName eq null}">
				<span class="selected"></span>
			</c:when>
			<c:when test="${param.footerName eq 'project' || param.footerName eq null}">
				<span class="selected"></span>
			</c:when>
			<c:otherwise>
				<span class="unSelected"></span>
			</c:otherwise>
		</c:choose>
		<font class="font12 font_color_603d21">预约理疗</font>
	</li>
	<li class="doctor" path="doctors">
		<c:choose>
			<c:when test="${footerName eq 'doctor' }">
				<span class="selected"></span>
			</c:when>
			<c:when test="${param.footerName eq 'doctor' }">
				<span class="selected"></span>
			</c:when>
			<c:otherwise>
				<span class="unSelected"></span>
			</c:otherwise>
		</c:choose>
		<font class="font12 font_color_603d21">预约医生</font>
	</li>
	<li class="special" path="specialOrder" isLogin="true">
		<c:choose>
			<c:when test="${footerName eq 'special' }">
				<span class="selected"></span>
			</c:when>
			<c:when test="${param.footerName eq 'special' }">
				<span class="selected"></span>
			</c:when>
			<c:otherwise>
				<span class="unSelected"></span>
			</c:otherwise>
		</c:choose>
		<font class="font12 font_color_603d21">预约特需</font>
	</li>
	<li class="mine" path="mine">
		<c:choose>
			<c:when test="${footerName eq 'mine' }">
				<span class="selected"></span>
			</c:when>
			<c:when test="${param.footerName eq 'mine' }">
				<span class="selected"></span>
			</c:when>
			<c:otherwise>
				<span class="unSelected"></span>
			</c:otherwise>
		</c:choose>
		<font class="font12 font_color_603d21">我的</font>
	</li>
</ul>
<script type="text/javascript">
$().ready(function(){
	$('#footerBar>li').click(function(){
		$('#footerBar>li>span').removeClass('selected');
		$('#footerBar>li>span').addClass('unSelected');
		$(this).find('span').removeClass('unSelected');
		$(this).find('span').addClass('selected');
		var name = $(this).attr('class');
		var path  = $(this).attr('path');
		var isLogin = $(this).attr('isLogin');
		path= mobileUrl + '/' +path+'?footerName='+name;
		if(isLogin == 'true'){
			if(!CrazyDoctor.User.isLogin()){
				path = encodeURIComponent(path);
				window.location.href = mobileUrl + '/login?backUrl=' +path;
			}else{
				window.location.href= path ;
			}
		}else{
			window.location.href= path ;
		}
	});
	
});
</script>
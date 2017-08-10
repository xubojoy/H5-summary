<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
var longitude = '${longitude}';
var latitude = '${latitude}';
</script>
 <style type="text/css">
        .winInfo {
            border:1px solid #dddddd;
            margin-left: 5%;
        }
        div.winInfo-top {
            position: relative;
            background: none repeat scroll 0 0 #F9F9F9;
            border-bottom: 1px solid #CCC;
            border-radius: 5px 5px 0 0;
        }
        div.winInfo-top div {
            display: inline-block;
            color: #333333;
            font-size: 14px;
            font-weight: bold;
            line-height: 31px;
            padding: 0 10px;
        }
        div.winInfo-top img {
            position: absolute;
            top: 10px;
            right: 10px;
            transition-duration: 0.25s;
        }
        div.winInfo-top img:hover {
            box-shadow: 0px 0px 5px #000;
        }
        div.winInfo-middle {
            font-size: 12px;
            padding: 6px;
            line-height: 20px;
        }
        div.winInfo-bottom {
            height: 0px;
            width: 100%;
            clear: both;
            text-align: center;
        }
        div.winInfo-bottom img {
            position: relative;
            z-index: 104;
        }
        span {
            margin-left: 5px;
            font-size: 11px;
        }
        .winInfo-middle img {
            float: left;
            margin-right: 6px;
        }
    </style>
<title>${pageTitle}</title>
</head>
<body>
<div id="main">
	<section id="header" class="bg_white">
		<span class="back font_dark_gray font14">返回</span>
		<span class="title font_dark_brown font17"><b>店铺地址</b></span>	
	</section>
	<div id="mapContainer" style="width:100%;height:100%;">
		
	</div>
</div>

<script type="text/javascript">
	var lnglat = new AMap.LngLat('${longitude}', '${latitude}');
	
	var distanceText = CrazyDoctor.utils.distanceTxt ( lnglat.distance([lng, lat]) );
	var map = new AMap.Map("mapContainer", {
	    resizeEnable: true,
	    center: ['${longitude}', '${latitude}'],
	    zoom: 16
	});  
	
	var  marker= null;
	function addMarker() {
		map.clearMap();
	    marker = new AMap.Marker({
	    	map: map,
	        position: ['${longitude}', '${latitude}']
	    });
	}
	addMarker();
	  //实例化信息窗体
    var title = '<span style="font-size:11px;color:#F00;"></span>',
        content = [];
    content.push("<font class='font16 font_dark_gray'><b>${address}</b></font>");
    content.push("<img style='width:9px;height:10px;margin-top:5px;' src='${mobileUrl}/images/icon_location_gray.png' /> " +distanceText);
	
	var infoWindow = new AMap.InfoWindow({
	        isCustom: true,  //使用自定义窗体
	        content: createInfoWindow(title, content.join("<br/>")),
	        offset: new AMap.Pixel(16, -45)
	});
	
	  function createInfoWindow(title, content) {
	        var info = document.createElement("div");
	        info.className = "winInfo";

	        //可以通过下面的方式修改自定义窗体的宽高
	        //info.style.width = "400px";
	        // 定义顶部标题
	       // var top = document.createElement("div");
	       // var titleD = document.createElement("div");
	        //var closeX = document.createElement("img");
	        //top.className = "winInfo-top";
	        //titleD.innerHTML = title;
	        //closeX.src = "http://webapi.amap.com/images/close2.gif";
	        //closeX.onclick = closeInfoWindow;

	        //top.appendChild(titleD);
	        //top.appendChild(closeX);
	        //info.appendChild(top);

	        // 定义中部内容
	        var middle = document.createElement("div");
	        middle.className = "winInfo-middle";
	        middle.style.backgroundColor = 'white';
	        middle.innerHTML = content;
	        info.appendChild(middle);

	        // 定义底部内容
	        var bottom = document.createElement("div");
	        bottom.className = "winInfo-bottom";
	        bottom.style.position = 'relative';
	        bottom.style.top = '0px';
	        bottom.style.margin = '0 auto';
	        var sharp = document.createElement("img");
	        sharp.src = "http://webapi.amap.com/images/sharp.png";
	        bottom.appendChild(sharp);
	        info.appendChild(bottom);
	        return info;
	    }

	    //关闭信息窗体
	    function closeInfoWindow() {
	        map.clearInfoWindow();
	    }
	    
		infoWindow.open(map, marker.getPosition());
</script>
</body>
</html>
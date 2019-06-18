<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>车辆分布</title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">    
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=GM94gjW65szPTsNj3ghCGb1Q"></script>
    <script src="<%=basePath%>/scripts/botton.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/main.css">
    
    <style>
        .dv1 { width:100%; position: absolute; z-index: 3; height: 100%; border: 1px solid #000; margin: 0 auto; }
        .dv2 { width: 50px; height: 50px; position: absolute; right: 50px; top: 40px; z-index: 4; background: #903; border: 1px solid #093; }
    </style>
  </head>
  
  <body>
        <div id="maparea" class="dv1" style="width:100%; height:100%">
        </div>
  </body>
</html>
<script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map("maparea");                        // 创建Map实例--这里必须放body下面，应为要allmap先加载
    map.centerAndZoom(new BMap.Point(102.34, 35.24), 5);     // 初始化地图,设置中心点坐标和地图级别//113.73416 28.97734
    map.addControl(new BMap.NavigationControl());               // 添加平移缩放控件
    map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
    map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件
    map.enableScrollWheelZoom();                            //启用滚轮放大缩小
    map.addControl(new BMap.MapTypeControl());          //添加地图类型控件
    map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
    
    
    var imageicon="<%=path%>/images/vechile.png";
    
    <c:forEach items="${vehiclelist}" var="vehicle">
        var contentstr = '<div><span style="font-weight:bolder;color:red;">车辆编号：</span>${vehicle.deviceid}</br>'+
                '<span style="font-weight:bolder;color:red;">工作小时：</span>${vehicle.worktime}</br>'+
                '<span style="font-weight:bolder;color:red;">工作状态：</span>${vehicle.carkey}</br>'+
                '<span style="font-weight:bolder;color:red;">地理位置：</span>${vehicle.locate}</br></div>';
        var creatMarker = function(lng,lat,contentstr){
	        var pt = new BMap.Point(lng,lat);
	        var myIcon = new BMap.Icon(imageicon, new BMap.Size(60,49));
	        var _marker = new BMap.Marker(pt,{icon:myIcon});  //
	        var infoWindow = new BMap.InfoWindow(contentstr);
	        _marker.addEventListener("click", function(){this.openInfoWindow(infoWindow);});
	        return _marker;
	    };
	    var marker = creatMarker(${vehicle.longitude},${vehicle.latitude},contentstr);
        map.addOverlay(marker);              // 将标注添加到地图中
    </c:forEach>
</script>
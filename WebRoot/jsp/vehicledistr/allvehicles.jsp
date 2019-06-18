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
    
    <title>�����ֲ�</title>
    
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
    // �ٶȵ�ͼAPI����
    var map = new BMap.Map("maparea");                        // ����Mapʵ��--��������body���棬ӦΪҪallmap�ȼ���
    map.centerAndZoom(new BMap.Point(102.34, 35.24), 5);     // ��ʼ����ͼ,�������ĵ�����͵�ͼ����//113.73416 28.97734
    map.addControl(new BMap.NavigationControl());               // ���ƽ�����ſؼ�
    map.addControl(new BMap.ScaleControl());                    // ��ӱ����߿ؼ�
    map.addControl(new BMap.OverviewMapControl());              //������Ե�ͼ�ؼ�
    map.enableScrollWheelZoom();                            //���ù��ַŴ���С
    map.addControl(new BMap.MapTypeControl());          //��ӵ�ͼ���Ϳؼ�
    map.setCurrentCity("����");          // ���õ�ͼ��ʾ�ĳ��� �����Ǳ������õ�
    
    
    var imageicon="<%=path%>/images/vechile.png";
    
    <c:forEach items="${vehiclelist}" var="vehicle">
        var contentstr = '<div><span style="font-weight:bolder;color:red;">������ţ�</span>${vehicle.deviceid}</br>'+
                '<span style="font-weight:bolder;color:red;">����Сʱ��</span>${vehicle.worktime}</br>'+
                '<span style="font-weight:bolder;color:red;">����״̬��</span>${vehicle.carkey}</br>'+
                '<span style="font-weight:bolder;color:red;">����λ�ã�</span>${vehicle.locate}</br></div>';
        var creatMarker = function(lng,lat,contentstr){
	        var pt = new BMap.Point(lng,lat);
	        var myIcon = new BMap.Icon(imageicon, new BMap.Size(60,49));
	        var _marker = new BMap.Marker(pt,{icon:myIcon});  //
	        var infoWindow = new BMap.InfoWindow(contentstr);
	        _marker.addEventListener("click", function(){this.openInfoWindow(infoWindow);});
	        return _marker;
	    };
	    var marker = creatMarker(${vehicle.longitude},${vehicle.latitude},contentstr);
        map.addOverlay(marker);              // ����ע��ӵ���ͼ��
    </c:forEach>
</script>
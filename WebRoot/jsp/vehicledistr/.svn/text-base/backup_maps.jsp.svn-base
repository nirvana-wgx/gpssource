<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

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
	
	<script src="http://maps.google.com/maps/api/js?v=3.1&sensor=true" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/main.css">
	
	<script type="text/javascript">
    var map;
    var poly;
  function initialize() {
    var latlng = new google.maps.LatLng(25.774252, -80.190262);
    var myOptions = {
      zoom: 4,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      rotateControl:true
    };
    map = new google.maps.Map(document.getElementById("maparea"), myOptions);
    
    var imageicon="<%=path%>/images/vechile.png";
    
    var lat=25.774252;
    var lon=-80.190262;
    
    for(var i = 0; i < 10; i++ ){
        var contentstr = 'BMSRTYY';
        contentstr = contentstr+i;
        addMarker(lat,lon,imageicon,contentstr);
        lat++;
        lon++;
    }
    
    var triangleCoords = [
        new google.maps.LatLng(25.774252, -80.190262),
        new google.maps.LatLng(18.466465, -66.118292),
        new google.maps.LatLng(32.321384, -64.75737),
        new google.maps.LatLng(25.774252, -80.190262)
    ];

    
    // 线段的样式
    var polyOptions = {
          strokeColor: '#000008',
          strokeOpacity: 1.0,
          strokeWeight: 3,
          //自动画线，为轨迹回放使用
          path:triangleCoords//此值如果设置，就相当于已经给注入了点，线段会根据这些点自动画好。折线坐标的有序序列。可以使用一个简单的 LatLng 数组或者 LatLng 的 MVCArray 指定此路径。请注意，如果您传递简单的数组，则它会转换为 MVCArray。在 MVCArray 中插入或删除 LatLng 将自动更新地图上的折线。
      }
      // 创建线段
      poly = new google.maps.Polyline(polyOptions);
      // 将线段与地图关联
      poly.setMap(map);
      

    //google.maps.event.addListener(map, 'click', chkDistan);//writePolygon、chkDistan-如果是自动画线，这个事件不需要监听
  }
  
  
  //添加标点
  function addMarker(lat,lon,imageicon,contentstr){
    var latlng = new google.maps.LatLng(lat, lon);
    var marker1=new google.maps.Marker({
        position:latlng,
        map:map,
        icon:imageicon,
        title:"车辆"
    });
    
    var contentString=contentstr;
    
    var infowindow = new google.maps.InfoWindow({
            content:contentString
        });
    google.maps.event.addListener(marker1,'click',function(){
            infowindow.open(map,marker1);
        });
  }
  
  //画多边形
  function writePolygon(event){
    // 获取线段路径-点数组MVCArray
        var path = poly.getPath(); 
        path.push(event.latLng);
        
    var bermudaTriangle = new google.maps.Polygon({
          paths: path,
          strokeColor: "#000000",
            strokeOpacity: 0.1,
          strokeWeight: 2,
          fillColor: "#FF0000",
          fillOpacity: 0.35
        });
        bermudaTriangle.setMap(map);    
  }
  
  //话折线测距离
  function chkDistan(event){
                
            // 获取线段路径
                var path = poly.getPath(); 
              path.push(event.latLng);
              
              // 设置距离初始为0
                dis = 0;
                // 遍历线段，计算总长度
                for( var i = 0; i < path.length - 1; i++ )
                {
                    var p1 = path.getAt(i);
                    var p2 = path.getAt(i + 1);
                    var curd = distance(p1.lat(),p1.lng(),p2.lat(),p2.lng());
                    dis = dis + curd;
                }
                // 长度信息
                var putDis = "0km";
                // 小于1公里则输出米为单位的长度
                if (dis>1) 
                {
                    putDis = Math.round(dis)+"公里";
                }
                // 大于1公里则输出公里数
                else if (dis<=1)
                {
                    putDis = Math.round(dis*1000)+"米";
                }
                // 将计算距离信息显示
                document.getElementById("contents").innerHTML = '<p><b>' + '当前距离测量结果：' + putDis + '<p><b>';
                
  }
  
  // 距离计算   
    function distance(lat1,lon1,lat2,lon2) 
    {
        // 地球半径
        var R = 6371;
        var dLat = (lat2-lat1) * Math.PI / 180;
        var dLon = (lon2-lon1) * Math.PI / 180; 
        var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
            Math.cos(lat1 * Math.PI / 180 ) * Math.cos(lat2 * Math.PI / 180 ) * 
            Math.sin(dLon/2) * Math.sin(dLon/2); 
        var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
        var d = R * c;
    
        return d;
    }
  google.maps.event.addDomListener(window, 'load', initialize);
</script>

  </head>
  
  <body>
    <div>
        <div id="maparea" style="width:100%; height:85%">
        </div>
        <div id="textarea" style="width:100%; height:15%">
            <table>
                <tr>
                    <td colspan=3>总数：108台</td>
                </tr>
                <tr>
                    <td>湖南：108台</td>
                    <td>广东：108台</td>
                    <td>福建么：108台</td>
                </tr>
                <tr>
                    <td>新疆：108台</td>
                    <td>黑龙江：108台</td>
                    <td>北京：108台</td>
                </tr>
                <tr>
                    <td>上海：108台</td>
                    <td colspan=2>江西：108台</td>
                </tr>
            </table>
        </div>
    </div>
  </body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>车辆定位</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	http://maps.googleapis.com/maps/api/js?sensor=false  这是看别人写的 不知道有没有用
	http://maps.google.com/maps/api/js?v=3.1&sensor=true  这个是我们以前用的
	http://ditu.google.cn/maps/api/js?sensor=false  这个是后来google被河蟹后用的
	<script src="http://maps.google.com/maps/api/js?v=3.1&sensor=true" type="text/javascript"></script>
	<script src="<%=basePath%>/mapfiles/mapapi.js" type="text/javascript"></script> ditu.google.cn
	-->
	
	<script src="http://ditu.google.cn/maps/api/js?sensor=false" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/main.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>jsp/vechiclemanager/css/map.css">
	<script type="text/javascript" src="<%=basePath%>/plugs/My97DatePicker/WdatePicker.js"></script>
	<script src="<%=basePath%>/scripts/botton.js" type="text/javascript"></script>
	
	
     
   <script type="text/javascript">
     var map;
     var poly;
     
     
     // 图标
    var image = '<%=path%>/images/beachflag.png';
    var imageChg = '<%=path%>/images/nothing.png';
    // 前一个轨迹点
    var PreIndex;
    // 动画路径
    var MovePoly;
    // 动画路径节点
    var MoveNodes = [];
    // 动画开关
    var MoveOn;
    // 动画路径样式
    var MovePolyOptions;
    // 当前序号（动画过程中）
    var playCount = 0;
    // 动画节点图标
    var MoveMarkers = [];
    // 标签序列
    var LabelArray = [];
    
    function setIndex(index) {
        // 将前一小车隐藏
    if (PreIndex >= 0) {
        MoveMarkers[PreIndex].setIcon(imageChg);
    }
        // 显示当前选择的小车
    if (MoveMarkers[index - 1] != null) {
        MoveMarkers[index - 1].setIcon(image);
        PreIndex = index - 1;
        map.setCenter(MoveNodes[index - 1]);
    }
}

//==========标签类=========
function Label(opt_options) {

        // 设定属性，主要是设定map
    this.setValues(opt_options);

        // 标签字体
    var span = this.span_ = document.createElement("span");
    span.style.cssText = "position: relative; left: 0%; top: 1px; " + "white-space: nowrap; border: 1px; font-family:arial; font-weight:bold;" + "padding: 2px; background-color: #0ff; " + "opacity: .75; " + "filter: alpha(opacity=75); " + "-ms-filter: \"alpha(opacity=75)\"; " + "-khtml-opacity: .75; " + "-moz-opacity: .75;";
    var div = this.div_ = document.createElement("div");
    div.appendChild(span);
    div.style.cssText = "position: absolute; display: none";
}
Label.prototype = new google.maps.OverlayView;

    // 添加标签
Label.prototype.onAdd = function () {
    var pane = this.getPanes().overlayLayer;
    pane.appendChild(this.div_);

    
        // 当内容发生改变时，重新绘制
    var me = this;
    this.listeners_ = [google.maps.event.addListener(this, "position_changed", function () {
        me.draw();
    }), google.maps.event.addListener(this, "text_changed", function () {
        me.draw();
    })];
};

    // 移除标签
Label.prototype.onRemove = function () {
    this.div_.parentNode.removeChild(this.div_);
        // 移除标签后，要移除相应的监听器
    for (var i = 0, I = this.listeners_.length; i < I; ++i) {
        google.maps.event.removeListener(this.listeners_[i]);
    }
};

    // 绘制标签
Label.prototype.draw = function () {
    var projection = this.getProjection();
    var position = projection.fromLatLngToDivPixel(this.get("position"));
    var div = this.div_;
    div.style.left = position.x + "px";
    div.style.top = position.y + "px";
    div.style.display = "block";
    this.span_.innerHTML = this.get("text").toString();
};
//========标签类结束===========

// 初始化动画路径
function initMoveNode() {       
        // 动画路径样式
    MovePolyOptions = {strokeColor:"#FF0000", strokeOpacity:0.5, strokeWeight:5};
        
        // 动画路径
    MovePoly = new google.maps.Polyline(MovePolyOptions);
    MovePoly.setMap(map);
    
        // 动画开关
    MoveOn = 0;
   
        // 添加节点
        //var myLatlng  = map.getCenter(); 
    var lat = 28.12345;
    var lon = 112.59123;
    var curLatlng;
    for (var i = 0; i < 20; i = i + 1) {
        curLatlng = new google.maps.LatLng(lat, lon);
        MoveNodes.push(curLatlng);
        lat = lat + 0.2;
        lon = lon + 0.3;
    }
}
function clearNode() {
        // 重新构建运动轨迹
    MovePoly.setMap(null);
    MovePoly = new google.maps.Polyline(MovePolyOptions);
    MovePoly.setMap(map);
        
        // 清空节点标记
    for (var i = 0; i < MoveMarkers.length; i++) {
        MoveMarkers[i].setMap(null);
        MoveMarkers[i] = null;
        LabelArray[i].setMap(null);
        LabelArray[i] = null;
    }
    MoveMarkers = [];
    LabelArray = [];
        // 前一个轨迹点
    PreIndex = -1;
}

// 播放动画
function playMoveNode() {
        // 当前序号（动画过程中）
    playCount = 0; 
        // 清空动画轨迹
    clearNode();
        // 设置播放时间间隔及其回调函数
    setTimeout(playtimer, 3500);
}

// 动画回调函数
function playtimer() {
        // 当前播放序号小于总节点数，则继续播放
    if (playCount < MoveNodes.length) {
            // 设置动画路径的数据
        var path = MovePoly.getPath();
        path.push(MoveNodes[playCount]);
        MovePoly.setMap(map);
        map.setCenter(MoveNodes[playCount]);
            // 创建图标
        var mk = new google.maps.Marker({position:MoveNodes[playCount], map:map, icon:image});
        mk.CurNum = playCount + 1;
        if (PreIndex >= 0) {
            MoveMarkers[PreIndex].setIcon(imageChg);
        }
        PreIndex = playCount;
            // 创建一个标签，绑定到当前的图标上
        var MarkerNum = new Label({map:map});
        MarkerNum.bindTo("position", mk, "position");
            // 设定标签的信息
        MarkerNum.set("text", mk.CurNum);
        MoveMarkers.push(mk);
        LabelArray.push(MarkerNum);
            // 图标设置到地图中
        mk.setMap(map);
  
            // 动画序号增加
        playCount++;
            // 播放下一节点
        setTimeout(playtimer, 500);
    }
}
    
    
     
     
	 function initialize() {
	   var latlng = new google.maps.LatLng(${mapinf.latitude}, ${mapinf.longtitude});
	   var myOptions = {
	     zoom: 4,
	     center: latlng,
	     mapTypeId: google.maps.MapTypeId.ROADMAP,
	     rotateControl:true
	   };
	   //加载地图
	   map = new google.maps.Map(document.getElementById("map"), myOptions);
	   
	   //图标
	   var imageicon="<%=path%>/images/vechile.png";
	   
	   //单击标点后的文本显示内容
	   var contentstr = '<div><table><tr><td><span style="font-weight:bolder;color:black;">车辆编号：</span>${mapinf.deviceid}</td></tr>'+
	       '<tr><td><span style="font-weight:bolder;color:black;">工作小时：</span>${mapinf.worktime}</td></tr>'+
	       '<tr><td><span style="font-weight:bolder;color:black;">工作状态：</span>${mapinf.workstatus}</td></tr>'+
	       '<tr><td><span style="font-weight:bolder;color:black;">地理位置：</span>${mapinf.locate}</td></tr></table></div>';
	       contentstr = '<div>' +

    '</div>' +

    '<h1>我的标签</h1>' +

    '<div id="bodyContent">' +

    '<p class = "mapStyle">我的淘宝 <a href="http://ggydggyd.taobao.com">http://ggydggyd.taobao.com</a>' +

    '</div>' +

    '</div>';
	       
	   //添加标记   
	   addMarker(${mapinf.latitude},${mapinf.longtitude},imageicon,contentstr);
	   
	   //进入地图时，显示为未进行距离测试
	   document.getElementById("importinfo").innerHTML = '<p><b>' + '未进行距离测量' + '<p><b>';
	   
	   //自动画线的坐标点
		 //var triangleCoords = [
		    //new google.maps.LatLng(25.774252, -80.190262),
		    //new google.maps.LatLng(18.466465, -66.118292),
		    //new google.maps.LatLng(32.321384, -64.75737),
		    //new google.maps.LatLng(25.774252, -80.190262)
		//];
	   
	   
	   // 清空轨迹按钮
	   var ClearControl = new BottonControl(map, '清空轨迹回放', '清空轨迹', '清空轨迹', 0);
	   ClearControl.controlUI.ActionFunc = function()
	   {
	       // 清空动画轨迹
	       clearNode();
	   }
	   
	   // 设定定位功能对应的按钮
	   var homeControl = new BottonControl(map, '定位到当前位置', '定位', '定位', 1);
	   homeControl.controlUI.ActionFunc = function()
	   {
	       map.setCenter(new  google.maps.LatLng(${mapinf.latitude}, ${mapinf.longtitude}));
	   }
	   
	   // 设定距离测量功能对应的按钮
	   var rulerControl = new BottonControl(map, '测量距离', '距离测量', '结束测量', 2);
	   //重写按钮单击事件的方法
	   rulerControl.controlUI.ActionFunc = function()
	   {
	       // 默认为不开启
	       if( this.status == 0 )
	       {//单击开始测量
	           //开关状态设置为开启
	           this.status = 1;
	           
	           // 线段的样式
       var polyOptions = {
             strokeColor: '#000008',
             strokeOpacity: 1.0,
             strokeWeight: 3
             //自动画线，为轨迹回放使用
             //path:triangleCoords此值如果设置，就相当于已经给注入了点，线段会根据这些点自动画好。折线坐标的有序序列。可以使用一个简单的 LatLng 数组或者 LatLng 的 MVCArray 指定此路径。请注意，如果您传递简单的数组，则它会转换为 MVCArray。在 MVCArray 中插入或删除 LatLng 将自动更新地图上的折线。
       }
       // 创建线段
       poly = new google.maps.Polyline(polyOptions);
	           
	           // 将线段与地图关联
               poly.setMap(map);
	           // 开启距离测量
	           google.maps.event.addListener(map, 'click', chkDistan);//writePolygon、chkDistan-如果是自动画线，这个事件不需要监听  
	       }
	       else
	       {//单击结束测量
	           
	           // 清除测量路径
	           poly.setMap(null);
	           // 关闭距离测量监听事件，这里是关闭地图的单击事件
	           google.maps.event.clearListeners(map, 'click');
	           //google.maps.event.removeListener(chkDistan);//接口里说可以，但是实际不可以不知道为什么
	           this.status = 0;
	           
	           document.getElementById("importinfo").innerHTML = '<p><b>' + '未进行距离测量' + '<p><b>';
               
	       }
	   }
	   playMoveNode();
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
                document.getElementById("importinfo").innerHTML = '<p><b>' + '当前距离测量结果：' + putDis + '<p><b>';
                
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
    <div class="wrapper">
        <div class="m_left">
            <h3>当前信息</h3>
            <div class="p1">
                <p><b>机号：</b>${mapinf.vehicleid}</p>
                <p><b>设备号：</b>${mapinf.deviceid}</p>
                <p><b>位置：</b>${mapinf.locate}</p>
                <p><b>纬度：</b>${mapinf.latitude}</p>
                <p><b>经度：</b>${mapinf.longtitude}</p>
                <p><b>定位时间：</b>${mapinf.locatetime}</p>
            </div>
            <h3>查看轨迹</h3>
            <div class="p2">
                <form name="form1" method="post" action="">
                    <p><b>开始时间：</b><input  id="receivetimemin" type="text" name="receivetimemin" onclick="WdatePicker()"/></p>
                    <p><b>结束时间：</b><input  id="receivetimemax" type="text" name="receivetimemax" onclick="WdatePicker()"/></p>
                    <p>&nbsp;&nbsp;&nbsp;
                        <b>精细度：</b>
                        <select name="sample">
                            <option value="0">粗略</option>
                            <option value="1">精细</option>
                            <option value="2">原始</option>
                        </select>
                    </p>
                </form>
                <p class="btn">
                    <a href="#" class="reset_e">回放</a>
                    <a href="#" target="_self" class="reset_e">清空</a>
                </p>
            </div>
            <div class="p1">
                <p><b>温馨提示:</b></p>
                <p>1.按住Shift键拖动鼠标可进行拉框放大地图</p>
            </div>
            <div class="p3" id="importinfo">
            </div>
            <h3>时间列表</h3>
            <table cellpadding="0" cellspacing="0" border="0" class="time_list m_t10">
                <col width="100" />
                <col width="130" />
                <thead><tr><th>标题</th><th>时间</th></tr></thead>
            </table>
        </div>
        <div class="m_right">
            <div id="map" style="width:100%; height:99%"></div>
        </div>
    </div>
  </body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>������λ</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	http://maps.googleapis.com/maps/api/js?sensor=false  ���ǿ�����д�� ��֪����û����
	http://maps.google.com/maps/api/js?v=3.1&sensor=true  �����������ǰ�õ�
	http://ditu.google.cn/maps/api/js?sensor=false  ����Ǻ���google����з���õ�
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
     
     
     // ͼ��
    var image = '<%=path%>/images/beachflag.png';
    var imageChg = '<%=path%>/images/nothing.png';
    // ǰһ���켣��
    var PreIndex;
    // ����·��
    var MovePoly;
    // ����·���ڵ�
    var MoveNodes = [];
    // ��������
    var MoveOn;
    // ����·����ʽ
    var MovePolyOptions;
    // ��ǰ��ţ����������У�
    var playCount = 0;
    // �����ڵ�ͼ��
    var MoveMarkers = [];
    // ��ǩ����
    var LabelArray = [];
    
    function setIndex(index) {
        // ��ǰһС������
    if (PreIndex >= 0) {
        MoveMarkers[PreIndex].setIcon(imageChg);
    }
        // ��ʾ��ǰѡ���С��
    if (MoveMarkers[index - 1] != null) {
        MoveMarkers[index - 1].setIcon(image);
        PreIndex = index - 1;
        map.setCenter(MoveNodes[index - 1]);
    }
}

//==========��ǩ��=========
function Label(opt_options) {

        // �趨���ԣ���Ҫ���趨map
    this.setValues(opt_options);

        // ��ǩ����
    var span = this.span_ = document.createElement("span");
    span.style.cssText = "position: relative; left: 0%; top: 1px; " + "white-space: nowrap; border: 1px; font-family:arial; font-weight:bold;" + "padding: 2px; background-color: #0ff; " + "opacity: .75; " + "filter: alpha(opacity=75); " + "-ms-filter: \"alpha(opacity=75)\"; " + "-khtml-opacity: .75; " + "-moz-opacity: .75;";
    var div = this.div_ = document.createElement("div");
    div.appendChild(span);
    div.style.cssText = "position: absolute; display: none";
}
Label.prototype = new google.maps.OverlayView;

    // ��ӱ�ǩ
Label.prototype.onAdd = function () {
    var pane = this.getPanes().overlayLayer;
    pane.appendChild(this.div_);

    
        // �����ݷ����ı�ʱ�����»���
    var me = this;
    this.listeners_ = [google.maps.event.addListener(this, "position_changed", function () {
        me.draw();
    }), google.maps.event.addListener(this, "text_changed", function () {
        me.draw();
    })];
};

    // �Ƴ���ǩ
Label.prototype.onRemove = function () {
    this.div_.parentNode.removeChild(this.div_);
        // �Ƴ���ǩ��Ҫ�Ƴ���Ӧ�ļ�����
    for (var i = 0, I = this.listeners_.length; i < I; ++i) {
        google.maps.event.removeListener(this.listeners_[i]);
    }
};

    // ���Ʊ�ǩ
Label.prototype.draw = function () {
    var projection = this.getProjection();
    var position = projection.fromLatLngToDivPixel(this.get("position"));
    var div = this.div_;
    div.style.left = position.x + "px";
    div.style.top = position.y + "px";
    div.style.display = "block";
    this.span_.innerHTML = this.get("text").toString();
};
//========��ǩ�����===========

// ��ʼ������·��
function initMoveNode() {       
        // ����·����ʽ
    MovePolyOptions = {strokeColor:"#FF0000", strokeOpacity:0.5, strokeWeight:5};
        
        // ����·��
    MovePoly = new google.maps.Polyline(MovePolyOptions);
    MovePoly.setMap(map);
    
        // ��������
    MoveOn = 0;
   
        // ��ӽڵ�
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
        // ���¹����˶��켣
    MovePoly.setMap(null);
    MovePoly = new google.maps.Polyline(MovePolyOptions);
    MovePoly.setMap(map);
        
        // ��սڵ���
    for (var i = 0; i < MoveMarkers.length; i++) {
        MoveMarkers[i].setMap(null);
        MoveMarkers[i] = null;
        LabelArray[i].setMap(null);
        LabelArray[i] = null;
    }
    MoveMarkers = [];
    LabelArray = [];
        // ǰһ���켣��
    PreIndex = -1;
}

// ���Ŷ���
function playMoveNode() {
        // ��ǰ��ţ����������У�
    playCount = 0; 
        // ��ն����켣
    clearNode();
        // ���ò���ʱ��������ص�����
    setTimeout(playtimer, 3500);
}

// �����ص�����
function playtimer() {
        // ��ǰ�������С���ܽڵ��������������
    if (playCount < MoveNodes.length) {
            // ���ö���·��������
        var path = MovePoly.getPath();
        path.push(MoveNodes[playCount]);
        MovePoly.setMap(map);
        map.setCenter(MoveNodes[playCount]);
            // ����ͼ��
        var mk = new google.maps.Marker({position:MoveNodes[playCount], map:map, icon:image});
        mk.CurNum = playCount + 1;
        if (PreIndex >= 0) {
            MoveMarkers[PreIndex].setIcon(imageChg);
        }
        PreIndex = playCount;
            // ����һ����ǩ���󶨵���ǰ��ͼ����
        var MarkerNum = new Label({map:map});
        MarkerNum.bindTo("position", mk, "position");
            // �趨��ǩ����Ϣ
        MarkerNum.set("text", mk.CurNum);
        MoveMarkers.push(mk);
        LabelArray.push(MarkerNum);
            // ͼ�����õ���ͼ��
        mk.setMap(map);
  
            // �����������
        playCount++;
            // ������һ�ڵ�
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
	   //���ص�ͼ
	   map = new google.maps.Map(document.getElementById("map"), myOptions);
	   
	   //ͼ��
	   var imageicon="<%=path%>/images/vechile.png";
	   
	   //����������ı���ʾ����
	   var contentstr = '<div><table><tr><td><span style="font-weight:bolder;color:black;">������ţ�</span>${mapinf.deviceid}</td></tr>'+
	       '<tr><td><span style="font-weight:bolder;color:black;">����Сʱ��</span>${mapinf.worktime}</td></tr>'+
	       '<tr><td><span style="font-weight:bolder;color:black;">����״̬��</span>${mapinf.workstatus}</td></tr>'+
	       '<tr><td><span style="font-weight:bolder;color:black;">����λ�ã�</span>${mapinf.locate}</td></tr></table></div>';
	       contentstr = '<div>' +

    '</div>' +

    '<h1>�ҵı�ǩ</h1>' +

    '<div id="bodyContent">' +

    '<p class = "mapStyle">�ҵ��Ա� <a href="http://ggydggyd.taobao.com">http://ggydggyd.taobao.com</a>' +

    '</div>' +

    '</div>';
	       
	   //��ӱ��   
	   addMarker(${mapinf.latitude},${mapinf.longtitude},imageicon,contentstr);
	   
	   //�����ͼʱ����ʾΪδ���о������
	   document.getElementById("importinfo").innerHTML = '<p><b>' + 'δ���о������' + '<p><b>';
	   
	   //�Զ����ߵ������
		 //var triangleCoords = [
		    //new google.maps.LatLng(25.774252, -80.190262),
		    //new google.maps.LatLng(18.466465, -66.118292),
		    //new google.maps.LatLng(32.321384, -64.75737),
		    //new google.maps.LatLng(25.774252, -80.190262)
		//];
	   
	   
	   // ��չ켣��ť
	   var ClearControl = new BottonControl(map, '��չ켣�ط�', '��չ켣', '��չ켣', 0);
	   ClearControl.controlUI.ActionFunc = function()
	   {
	       // ��ն����켣
	       clearNode();
	   }
	   
	   // �趨��λ���ܶ�Ӧ�İ�ť
	   var homeControl = new BottonControl(map, '��λ����ǰλ��', '��λ', '��λ', 1);
	   homeControl.controlUI.ActionFunc = function()
	   {
	       map.setCenter(new  google.maps.LatLng(${mapinf.latitude}, ${mapinf.longtitude}));
	   }
	   
	   // �趨����������ܶ�Ӧ�İ�ť
	   var rulerControl = new BottonControl(map, '��������', '�������', '��������', 2);
	   //��д��ť�����¼��ķ���
	   rulerControl.controlUI.ActionFunc = function()
	   {
	       // Ĭ��Ϊ������
	       if( this.status == 0 )
	       {//������ʼ����
	           //����״̬����Ϊ����
	           this.status = 1;
	           
	           // �߶ε���ʽ
       var polyOptions = {
             strokeColor: '#000008',
             strokeOpacity: 1.0,
             strokeWeight: 3
             //�Զ����ߣ�Ϊ�켣�ط�ʹ��
             //path:triangleCoords��ֵ������ã����൱���Ѿ���ע���˵㣬�߶λ������Щ���Զ����á�����������������С�����ʹ��һ���򵥵� LatLng ������� LatLng �� MVCArray ָ����·������ע�⣬��������ݼ򵥵����飬������ת��Ϊ MVCArray���� MVCArray �в����ɾ�� LatLng ���Զ����µ�ͼ�ϵ����ߡ�
       }
       // �����߶�
       poly = new google.maps.Polyline(polyOptions);
	           
	           // ���߶����ͼ����
               poly.setMap(map);
	           // �����������
	           google.maps.event.addListener(map, 'click', chkDistan);//writePolygon��chkDistan-������Զ����ߣ�����¼�����Ҫ����  
	       }
	       else
	       {//������������
	           
	           // �������·��
	           poly.setMap(null);
	           // �رվ�����������¼��������ǹرյ�ͼ�ĵ����¼�
	           google.maps.event.clearListeners(map, 'click');
	           //google.maps.event.removeListener(chkDistan);//�ӿ���˵���ԣ�����ʵ�ʲ����Բ�֪��Ϊʲô
	           this.status = 0;
	           
	           document.getElementById("importinfo").innerHTML = '<p><b>' + 'δ���о������' + '<p><b>';
               
	       }
	   }
	   playMoveNode();
  }
  
  
  //��ӱ��
  function addMarker(lat,lon,imageicon,contentstr){
    var latlng = new google.maps.LatLng(lat, lon);
    var marker1=new google.maps.Marker({
        position:latlng,
        map:map,
        icon:imageicon,
        title:"����"
    });
    
    var contentString=contentstr;
    
    var infowindow = new google.maps.InfoWindow({
            content:contentString
        });
    google.maps.event.addListener(marker1,'click',function(){
            infowindow.open(map,marker1);
        });
  }
  
  //�����߲����
  function chkDistan(event){
                
            // ��ȡ�߶�·��
                var path = poly.getPath(); 
              path.push(event.latLng);
              
              // ���þ����ʼΪ0
                dis = 0;
                // �����߶Σ������ܳ���
                for( var i = 0; i < path.length - 1; i++ )
                {
                    var p1 = path.getAt(i);
                    var p2 = path.getAt(i + 1);
                    var curd = distance(p1.lat(),p1.lng(),p2.lat(),p2.lng());
                    dis = dis + curd;
                }
                // ������Ϣ
                var putDis = "0km";
                // С��1�����������Ϊ��λ�ĳ���
                if (dis>1) 
                {
                    putDis = Math.round(dis)+"����";
                }
                // ����1���������������
                else if (dis<=1)
                {
                    putDis = Math.round(dis*1000)+"��";
                }
                // �����������Ϣ��ʾ
                document.getElementById("importinfo").innerHTML = '<p><b>' + '��ǰ������������' + putDis + '<p><b>';
                
  }
  
  // �������   
    function distance(lat1,lon1,lat2,lon2) 
    {
        // ����뾶
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
            <h3>��ǰ��Ϣ</h3>
            <div class="p1">
                <p><b>���ţ�</b>${mapinf.vehicleid}</p>
                <p><b>�豸�ţ�</b>${mapinf.deviceid}</p>
                <p><b>λ�ã�</b>${mapinf.locate}</p>
                <p><b>γ�ȣ�</b>${mapinf.latitude}</p>
                <p><b>���ȣ�</b>${mapinf.longtitude}</p>
                <p><b>��λʱ�䣺</b>${mapinf.locatetime}</p>
            </div>
            <h3>�鿴�켣</h3>
            <div class="p2">
                <form name="form1" method="post" action="">
                    <p><b>��ʼʱ�䣺</b><input  id="receivetimemin" type="text" name="receivetimemin" onclick="WdatePicker()"/></p>
                    <p><b>����ʱ�䣺</b><input  id="receivetimemax" type="text" name="receivetimemax" onclick="WdatePicker()"/></p>
                    <p>&nbsp;&nbsp;&nbsp;
                        <b>��ϸ�ȣ�</b>
                        <select name="sample">
                            <option value="0">����</option>
                            <option value="1">��ϸ</option>
                            <option value="2">ԭʼ</option>
                        </select>
                    </p>
                </form>
                <p class="btn">
                    <a href="#" class="reset_e">�ط�</a>
                    <a href="#" target="_self" class="reset_e">���</a>
                </p>
            </div>
            <div class="p1">
                <p><b>��ܰ��ʾ:</b></p>
                <p>1.��סShift���϶����ɽ�������Ŵ��ͼ</p>
            </div>
            <div class="p3" id="importinfo">
            </div>
            <h3>ʱ���б�</h3>
            <table cellpadding="0" cellspacing="0" border="0" class="time_list m_t10">
                <col width="100" />
                <col width="130" />
                <thead><tr><th>����</th><th>ʱ��</th></tr></thead>
            </table>
        </div>
        <div class="m_right">
            <div id="map" style="width:100%; height:99%"></div>
        </div>
    </div>
  </body>
</html>

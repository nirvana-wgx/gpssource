<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

        <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=GM94gjW65szPTsNj3ghCGb1Q"></script><!-- wangguixian 851204 百度开发者账号 -->
        <script type="text/javascript" src="http://api.map.baidu.com/library/DistanceTool/1.2/src/DistanceTool_min.js"></script>
        <link rel="stylesheet" type="text/css"
            href="<%=basePath%>/css/main.css">
        <link rel="stylesheet" type="text/css"
            href="<%=basePath%>jsp/vechiclemanager/css/map.css">
        <script type="text/javascript"
            src="<%=basePath%>/plugs/My97DatePicker/WdatePicker.js"></script>
        <script type="text/javascript"
            src="<%=path%>/scripts/jquery-1.7.1.min.js"></script>
        <script src="<%=basePath%>/scripts/botton.js" type="text/javascript"></script>
        <script type="text/javascript" src="<%=path%>/scripts/jquery-1.7.1.min.js"></script>
        
        <script type="text/javascript">
            function validate()
            {
                if(document.getElementById("start").value=="")
                {
                    alert("起始时间不能为空，请输入起始时间！");    
                    return false;
                }
                if(document.getElementById("end").value=="")
                {
                    alert("终止时间不能为空，请输入终止时间！");    
                    return false;
                }
                return true;
            }
            function gohistory(){
                var form = document.getElementsByName("form1")[0];
                form.submit();
            }
        </script>
        
        
        <script type="text/javascript">
            //层的id  
            var loadingDivId  = "loading_div";  
     
            //创建或显示loading层  
            function showLoadingDiv()  
            {  
                // $("#pass_word").css("display","none"); 
                //$("#hidden_pass_word").css("display","block"); 
                var cc = document.getElementById(loadingDivId);  
                var _h=$(document).height();
                if(!cc)  
                {  
                    cc  = document.createElement("DIV");     
                    with(cc)  
                    {  
                        id = loadingDivId;            
                        innerHTML="<img src='<%=path%>/images/processing.gif' width='32' height='32' border='0' style='position:absolute;bottom:5%;left:50%;' >"
                        cc.style.position  = "absolute";  
                        cc.style.zIndex  = "9999";  
                        cc.style.backgroundColor="#000000";  
                        cc.style.width="100%";  
                        cc.style.height= _h+"px"; 
                        cc.style.top = "0";  
                        cc.style.left = "0";       
                        cc.style.textAlign="center"; 
                        var Sys = {};
                        var ua = navigator.userAgent.toLowerCase();
                        var s;
                        (s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] :
                        (s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :
                        (s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
                        (s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :
                        (s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;
                        if (Sys.ie){
                            cc.style.filter="progid:DXImageTransform.Microsoft.Alpha(opacity=50)";  
                        }
                        else if (Sys.firefox || Sys.chrome || Sys.opera || Sys.safari) {
                            cc.style.opacity="0.5";
                        };
                    }  
                    document.body.appendChild(cc);  
                }  
                cc.style.display="block";                         
            } 
 
            //隐藏loading层  
            function hiddenLoadingDiv()  
            {  
                var cc = document.getElementById(loadingDivId);  
                if(cc)  
                cc.style.display="none";  
            }
        </script>
    </head><div class="wrapper">
            <div class="m_left">
                <h3>
                    当前信息
                </h3>
                <div class="p1">
                    <p>
                        <b>机号：</b>${mapinf.vehicleid}
                    </p>
                    <p>
                        <b>设备号：</b>${mapinf.deviceid}
                    </p>
                    <p>
                        <b>位置：</b>${mapinf.locate}
                    </p>
                    <p>
                        <b>纬度：</b>${mapinf.latitude}
                    </p>
                    <p>
                        <b>经度：</b>${mapinf.longitude}
                    </p>
                    <p>
                        <b>定位时间：</b>${locatetime}
                    </p>
                </div>
                <h3>
                    查看轨迹
                </h3>
                <div class="p2">
                    <form name="form1" method="post"
                        action="<%=basePath%>/jsp/vechiclemanager/singlevehicle/history.page">
                        <input id="vehicleid" type="hidden" name="vehicleid"
                            value="${mapinf.vehicleid}" />
                        <input id="deviceid" type="hidden" name="deviceid"
                            value="${mapinf.deviceid}" />
                        <p>
                            <b>开始时间：</b>
                            <input id="start" type="text" name="start"
                                onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'1900-03-08 11:30:00',maxDate:'2100-03-10 20:59:30'})"
                                value="${start}" />
                        </p>
                        <p>
                            <b>结束时间：</b>
                            <input id="end" type="text" name="end"
                                onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'1900-03-08 11:30:00',maxDate:'2100-03-10 20:59:30'})"
                                value="${end}" />
                        </p>
                        <p>
                            <b>播放频率：</b>
                            <select name="sample" id="sample">
                                <option value="1000" <c:if test="${sample==1000}"> selected="selected" </c:if> >一般</option>
                                <option value="2000" <c:if test="${sample==2000}"> selected="selected" </c:if>>较慢</option>
                                <option value="500" <c:if test="${sample==500}"> selected="selected" </c:if>>较快</option>
                                <option value="200" <c:if test="${sample==200}"> selected="selected" </c:if>>很快</option>
                            </select>
                            <b>精细度：</b>
                            <select name="precision" id="precision">
                                <option value="0" <c:if test="${precision==0}"> selected="selected" </c:if>>粗略</option>
                                <option value="1" <c:if test="${precision==1}"> selected="selected" </c:if>>精细</option>
                                <option value="2" <c:if test="${precision==2}"> selected="selected" </c:if>>原始</option>
                            </select>
                        </p>
                    </form>
                    <p class="btn">
                        <input type="button" id="" value="回放"
                            onclick="validate();gohistory();">
                            <!--<input type="button" id="" value="清空">-->
                        <!-- <a href="javascript:if(validate())document.forms['form1'].submit();" class="reset_e">回放</a> -->
                        <!--<a href="#" target="_self" class="reset_e">清空</a>-->
                    </p>
                </div>
                <div class="p1">
                    <p>
                        <b>温馨提示:</b>
                    </p>
                    <p>
                        1.双击可以放大地图
                    </p>
                </div>
                <div class="p3" id="importinfo">
                </div>
                
                   <h3>
                    时间列表
                </h3>
                <div id="div1">
                <table cellpadding="0" cellspacing="0" border="0"
                    class="time_list m_t10" >
                    
                        <tr>
                            <td>
                               序号
                            </td>
                            <td>
                                时间
                            </td>
                        </tr>
                        <c:if test="${fn:length(list)==0}">
                              <tr><td align='center' colspan='10' style="border-left:0px;border-right:0px;"><font color='red'>无记录</font></td></tr>
                        </c:if>
                        <c:forEach items="${list}" var="historyinf" varStatus="status">
                        <tr>
                           <td scope="row" abbr="序号" style="border-left:0px;">
                                    ${status.index + 1}
                                 </td>
                                 <td>
                                    <a href="" target="_self" onClick="setIndex('${status.index + 1}');return false;"><fmt:formatDate value="${ historyinf.receivetime }" pattern="yyyy-MM-dd HH:mm:ss" /></a>
                                 </td>
                                 </tr>
                        </c:forEach>
                </table>
                </div>
                
            </div>
            <div class="m_right">
                <div id="allmap" style="width: 100%; height: 99%"></div>
            </div>
        </div>
    <body>
        
    </body>
</html>
<script type="text/javascript">
    /*
        轨迹回放js
        分如下几步:
       1、根据传入的各个点画折线添加到地图上
       2、
    */
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
    //动画图标
    //var mk;
    
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
    
    
    
    // 初始化动画路径
    function initMoveNode() {
        // 动画路径样式
        MovePolyOptions = {strokeColor:"#FF0000", strokeWeight:5, strokeOpacity:0.5};//, path:MoveNodes
            
        
        
        // 添加节点
        //var myLatlng  = map.getCenter();
        var lat;
        var lon;
        
        <c:forEach items="${list}" var="historyinf">
            
            lat = ${historyinf.latitude};
            lon = ${historyinf.longitude};
            curLatlng = new BMap.Point(lon, lat);
            MoveNodes.push(curLatlng);
        </c:forEach>
        
        //var lat = 28.12345;
        //var lon = 112.59123;
        //var curLatlng;
        //for (var i = 0; i < 20; i = i + 1) {
            //curLatlng = new BMap.Point(lon, lat);
            //MoveNodes.push(curLatlng);
            //lat = lat + 0.2;
            //lon = lon + 0.3;
        //}
        
        // 动画路径
        MovePoly = new BMap.Polyline(MoveNodes,MovePolyOptions);
        map.addOverlay(MovePoly);
    }
    
    //清除以前动画，初始化轨迹回放
    function clearNode() {
        //清除折线
        map.removeOverlay(MovePoly);
        // 清空节点标记
        //map.removeOverlay(mk);
        //map.clearOverlays();
        for (var i = 0; i < MoveMarkers.length; i++) {
            map.removeOverlay(MoveMarkers[i]);
            map.removeOverlay(LabelArray[i]);
            //LabelArray[i].setMap(null);
            //LabelArray[i] = null;
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
        //初始化动画路径
        initMoveNode();
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
            map.setCenter(MoveNodes[playCount]);
            // 创建图标
            var mk = new BMap.Marker(MoveNodes[playCount],{icon:myIcon});  // 创建标注
            MoveMarkers.push(mk);
            //设置后续序号图标
            if(playCount>=1){
               setLable(MoveNodes[playCount-1],playCount); 
            }
            //移除前一个小车
            map.removeOverlay(MoveMarkers[playCount-1]);
            map.addOverlay(mk);// 将标注添加到地图中
            
            mk.CurNum = playCount + 1;
            
            PreIndex = playCount;
            
            // 动画序号增加
            playCount++;
            // 播放下一节点
            setTimeout(playtimer, ${sample});
            //2012-12-06 11:30:02
        }
    }
    
    //设置标签 传入点和序号
    function setLable(mapPoint,num){
        function ComplexCustomOverlay(point, text, mouseoverText){
	      this._point = point;
	      this._text = text;
	      this._overText = mouseoverText;
	    }
	    ComplexCustomOverlay.prototype = new BMap.Overlay();
	    ComplexCustomOverlay.prototype.initialize = function(map){
	      this._map = map;
	      var div = this._div = document.createElement("div");
	      div.style.position = "absolute";
	      div.style.zIndex = BMap.Overlay.getZIndex(this._point.lat);
	      div.style.backgroundColor = "#EE5D5B";
	      div.style.border = "1px solid #BC3B3A";
	      div.style.color = "white";
	      div.style.height = "18px";
	      div.style.padding = "2px";
	      div.style.lineHeight = "18px";
	      div.style.whiteSpace = "nowrap";
	      div.style.MozUserSelect = "none";
	      div.style.fontSize = "12px"
	      var span = this._span = document.createElement("span");
	      div.appendChild(span);
	      span.appendChild(document.createTextNode(this._text));      
	      var that = this;
	
	      var arrow = this._arrow = document.createElement("div");
	      arrow.style.background = "url(http://map.baidu.com/fwmap/upload/r/map/fwmap/static/house/images/label.png) no-repeat";
	      arrow.style.position = "absolute";
	      arrow.style.width = "11px";
	      arrow.style.height = "10px";
	      arrow.style.top = "22px";
	      arrow.style.left = "2px";
	      arrow.style.overflow = "hidden";
	      div.appendChild(arrow);
	     
	      div.onmouseover = function(){
	        this.style.backgroundColor = "#6BADCA";
	        this.style.borderColor = "#0000ff";
	        this.getElementsByTagName("span")[0].innerHTML = that._overText;
	        arrow.style.backgroundPosition = "0px -20px";
	      }
	
	      div.onmouseout = function(){
	        this.style.backgroundColor = "#EE5D5B";
	        this.style.borderColor = "#BC3B3A";
	        this.getElementsByTagName("span")[0].innerHTML = that._text;
	        arrow.style.backgroundPosition = "0px 0px";
	      }
	
	      map.getPanes().labelPane.appendChild(div);
	      
	      return div;
	    }
	    ComplexCustomOverlay.prototype.draw = function(){
	      var map = this._map;
	      var pixel = map.pointToOverlayPixel(this._point);
	      this._div.style.left = pixel.x - parseInt(this._arrow.style.left) + "px";
	      this._div.style.top  = pixel.y - 30 + "px";
	    }
	    var txt = num, mouseoverTxt = txt;
	        
	    var myCompOverlay = new ComplexCustomOverlay(mapPoint, num,mouseoverTxt);
	    LabelArray.push(myCompOverlay);
	    map.addOverlay(myCompOverlay);
    
    }
    
</script>
<script type="text/javascript">
    // 图标
    var image = '<%=path%>/images/beachflag.png';
    var imageChg = '<%=path%>/images/nothing.png';
    var latitude=${mapinf.latitude};//纬度
    var longitude=${mapinf.longitude};//经度
    // 百度地图API功能
    var map = new BMap.Map("allmap");                        // 创建Map实例--这里必须放body下面，应为要allmap先加载
    map.centerAndZoom(new BMap.Point(longitude,latitude), 9);     // 初始化地图,设置中心点坐标和地图级别//113.73416 28.97734
    map.addControl(new BMap.NavigationControl());               // 添加平移缩放控件
    map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
    map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件
    map.enableScrollWheelZoom();                            //启用滚轮放大缩小
    map.addControl(new BMap.MapTypeControl());          //添加地图类型控件
    map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
    
    //*****************************************添加图标***********************************************
    //创建图标
    //图标
    var imageicon="<%=path%>/images/vechile.png";
    var pt = new BMap.Point(longitude,latitude);
    var myIcon = new BMap.Icon(imageicon, new BMap.Size(60,49));
    var marker = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
    map.addOverlay(marker);              // 将标注添加到地图中
    
    //进入地图时，显示为未进行距离测试
    document.getElementById("importinfo").innerHTML = '<p><b>' + '未进行距离测量' + '<p><b>';
     
    //******************************************创建跟随图标的信息框**********************************************
    //单击标点后的文本显示内容
    var contentstr = '<div><span style="font-weight:bolder;color:red;">车辆编号：</span>${mapinf.deviceid}</br>'+
        '<span style="font-weight:bolder;color:red;">工作小时：</span>${mapinf.worktime}</br>'+
        '<span style="font-weight:bolder;color:red;">工作状态：</span>${mapinf.carkey}</br>'+
        '<span style="font-weight:bolder;color:red;">地理位置：</span>${mapinf.locate}</br></div>';
    //创建对应图标的信息框
    var infoWindow = new BMap.InfoWindow(contentstr);
    marker.addEventListener("click", function(){this.openInfoWindow(infoWindow);});
    
    //******************************************创建自定义控件**********************************************
    //******************************************定位**********************************************
    // 定义一个控件类,即function
    function ZoomControl(){
      // 默认停靠位置和偏移量
      this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
      this.defaultOffset = new BMap.Size(80, 10);
    }
    
    // 通过JavaScript的prototype属性继承于BMap.Control
    ZoomControl.prototype = new BMap.Control();
    
    // 自定义控件必须实现自己的initialize方法,并且将控件的DOM元素返回
    // 在本方法中创建个div元素作为控件的容器,并将其添加到地图容器中
    ZoomControl.prototype.initialize = function(map){
      // 创建一个DOM元素
      var div = document.createElement("div");
      // 添加文字说明
      div.appendChild(document.createTextNode("定位"));
      // 设置样式
      div.style.cursor = "pointer";
      div.style.border = "2px solid gray";
      div.style.width = "40px";
      div.style.height = "17px";
      div.style.fontSize="14px";
      div.style.textAlign="center";
      div.style.backgroundColor = "white";
      // 绑定事件,点击一次放大两级
      div.onclick = function(e){
        map.setCenter(new BMap.Point(longitude,latitude))
        //map.setZoom(map.getZoom() + 2);//放大两级
      }
      // 添加DOM元素到地图中
      map.getContainer().appendChild(div);
      // 将DOM元素返回
      return div;
    }
    // 创建控件
    var myZoomCtrl = new ZoomControl();
    // 添加到地图当中
    map.addControl(myZoomCtrl);
    
    //*****************************************清除轨迹***********************************************
    // 定义一个控件类,即function
    function ZoomControlClear(){
      // 默认停靠位置和偏移量
      this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
      this.defaultOffset = new BMap.Size(160, 10);
    }
    
    // 通过JavaScript的prototype属性继承于BMap.Control
    ZoomControlClear.prototype = new BMap.Control();
    
    // 自定义控件必须实现自己的initialize方法,并且将控件的DOM元素返回
    // 在本方法中创建个div元素作为控件的容器,并将其添加到地图容器中
    ZoomControlClear.prototype.initialize = function(map){
      // 创建一个DOM元素
      var div = document.createElement("div");
      // 添加文字说明
      div.appendChild(document.createTextNode("清楚轨迹"));
      // 设置样式
      div.style.cursor = "pointer";
      div.style.border = "2px solid gray";
      div.style.width = "80px";
      div.style.height = "17px";
      div.style.fontSize="14px";
      div.style.textAlign="center";
      div.style.backgroundColor = "white";
      // 绑定事件,点击一次放大两级
      div.onclick = function(e){
        clearNode();
      }
      // 添加DOM元素到地图中
      map.getContainer().appendChild(div);
      // 将DOM元素返回
      return div;
    }
    // 创建控件
    var myZoomCtrlClear = new ZoomControlClear();
    // 添加到地图当中
    map.addControl(myZoomCtrlClear);
    
    
    //*****************************************测距***********************************************
    // 定义一个控件类,即function
    function ZoomControlCalcDis(){
      // 默认停靠位置和偏移量
      this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
      this.defaultOffset = new BMap.Size(280, 10);
    }
    
    // 通过JavaScript的prototype属性继承于BMap.Control
    ZoomControlCalcDis.prototype = new BMap.Control();
    
    // 自定义控件必须实现自己的initialize方法,并且将控件的DOM元素返回
    // 在本方法中创建个div元素作为控件的容器,并将其添加到地图容器中
    ZoomControlCalcDis.prototype.initialize = function(map){
      // 创建一个DOM元素
      var div = document.createElement("div");
      // 添加文字说明
      div.appendChild(document.createTextNode("测量距离"));
      // 设置样式
      div.style.cursor = "pointer";
      div.style.border = "2px solid gray";
      div.style.width = "80px";
      div.style.height = "17px";
      div.style.fontSize="14px";
      div.style.textAlign="center";
      div.style.backgroundColor = "white";
      // 绑定事件,点击一次放大两级
      div.onclick = function(e){
        var myDis = new BMapLib.DistanceTool(map);
         myDis.open();
      }
      // 添加DOM元素到地图中
      map.getContainer().appendChild(div);
      // 将DOM元素返回
      return div;
    }
    // 创建控件
    var myZoomCtrlCalcDis = new ZoomControlCalcDis();
    // 添加到地图当中
    map.addControl(myZoomCtrlCalcDis);
    
    
    //*****************************************轨迹回放初始化***********************************************
    var moveon=0;
    
    moveon=${moveon};
    if(moveon=='1'){
        playMoveNode();
    }
    
</script>
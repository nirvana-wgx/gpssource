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

        <title>������λ</title>

        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <meta http-equiv="description" content="This is my page">

        <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=GM94gjW65szPTsNj3ghCGb1Q"></script><!-- wangguixian 851204 �ٶȿ������˺� -->
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
                    alert("��ʼʱ�䲻��Ϊ�գ���������ʼʱ�䣡");    
                    return false;
                }
                if(document.getElementById("end").value=="")
                {
                    alert("��ֹʱ�䲻��Ϊ�գ���������ֹʱ�䣡");    
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
            //���id  
            var loadingDivId  = "loading_div";  
     
            //��������ʾloading��  
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
 
            //����loading��  
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
                    ��ǰ��Ϣ
                </h3>
                <div class="p1">
                    <p>
                        <b>���ţ�</b>${mapinf.vehicleid}
                    </p>
                    <p>
                        <b>�豸�ţ�</b>${mapinf.deviceid}
                    </p>
                    <p>
                        <b>λ�ã�</b>${mapinf.locate}
                    </p>
                    <p>
                        <b>γ�ȣ�</b>${mapinf.latitude}
                    </p>
                    <p>
                        <b>���ȣ�</b>${mapinf.longitude}
                    </p>
                    <p>
                        <b>��λʱ�䣺</b>${locatetime}
                    </p>
                </div>
                <h3>
                    �鿴�켣
                </h3>
                <div class="p2">
                    <form name="form1" method="post"
                        action="<%=basePath%>/jsp/vechiclemanager/singlevehicle/history.page">
                        <input id="vehicleid" type="hidden" name="vehicleid"
                            value="${mapinf.vehicleid}" />
                        <input id="deviceid" type="hidden" name="deviceid"
                            value="${mapinf.deviceid}" />
                        <p>
                            <b>��ʼʱ�䣺</b>
                            <input id="start" type="text" name="start"
                                onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'1900-03-08 11:30:00',maxDate:'2100-03-10 20:59:30'})"
                                value="${start}" />
                        </p>
                        <p>
                            <b>����ʱ�䣺</b>
                            <input id="end" type="text" name="end"
                                onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'1900-03-08 11:30:00',maxDate:'2100-03-10 20:59:30'})"
                                value="${end}" />
                        </p>
                        <p>
                            <b>����Ƶ�ʣ�</b>
                            <select name="sample" id="sample">
                                <option value="1000" <c:if test="${sample==1000}"> selected="selected" </c:if> >һ��</option>
                                <option value="2000" <c:if test="${sample==2000}"> selected="selected" </c:if>>����</option>
                                <option value="500" <c:if test="${sample==500}"> selected="selected" </c:if>>�Ͽ�</option>
                                <option value="200" <c:if test="${sample==200}"> selected="selected" </c:if>>�ܿ�</option>
                            </select>
                            <b>��ϸ�ȣ�</b>
                            <select name="precision" id="precision">
                                <option value="0" <c:if test="${precision==0}"> selected="selected" </c:if>>����</option>
                                <option value="1" <c:if test="${precision==1}"> selected="selected" </c:if>>��ϸ</option>
                                <option value="2" <c:if test="${precision==2}"> selected="selected" </c:if>>ԭʼ</option>
                            </select>
                        </p>
                    </form>
                    <p class="btn">
                        <input type="button" id="" value="�ط�"
                            onclick="validate();gohistory();">
                            <!--<input type="button" id="" value="���">-->
                        <!-- <a href="javascript:if(validate())document.forms['form1'].submit();" class="reset_e">�ط�</a> -->
                        <!--<a href="#" target="_self" class="reset_e">���</a>-->
                    </p>
                </div>
                <div class="p1">
                    <p>
                        <b>��ܰ��ʾ:</b>
                    </p>
                    <p>
                        1.˫�����ԷŴ��ͼ
                    </p>
                </div>
                <div class="p3" id="importinfo">
                </div>
                
                   <h3>
                    ʱ���б�
                </h3>
                <div id="div1">
                <table cellpadding="0" cellspacing="0" border="0"
                    class="time_list m_t10" >
                    
                        <tr>
                            <td>
                               ���
                            </td>
                            <td>
                                ʱ��
                            </td>
                        </tr>
                        <c:if test="${fn:length(list)==0}">
                              <tr><td align='center' colspan='10' style="border-left:0px;border-right:0px;"><font color='red'>�޼�¼</font></td></tr>
                        </c:if>
                        <c:forEach items="${list}" var="historyinf" varStatus="status">
                        <tr>
                           <td scope="row" abbr="���" style="border-left:0px;">
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
        �켣�ط�js
        �����¼���:
       1�����ݴ���ĸ����㻭�������ӵ���ͼ��
       2��
    */
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
    //����ͼ��
    //var mk;
    
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
    
    
    
    // ��ʼ������·��
    function initMoveNode() {
        // ����·����ʽ
        MovePolyOptions = {strokeColor:"#FF0000", strokeWeight:5, strokeOpacity:0.5};//, path:MoveNodes
            
        
        
        // ���ӽڵ�
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
        
        // ����·��
        MovePoly = new BMap.Polyline(MoveNodes,MovePolyOptions);
        map.addOverlay(MovePoly);
    }
    
    //�����ǰ��������ʼ���켣�ط�
    function clearNode() {
        //�������
        map.removeOverlay(MovePoly);
        // ��սڵ���
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
        // ǰһ���켣��
        PreIndex = -1;
    }
    
    // ���Ŷ���
    function playMoveNode() {
        // ��ǰ��ţ����������У�
        playCount = 0; 
        // ��ն����켣
        clearNode();
        //��ʼ������·��
        initMoveNode();
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
            map.setCenter(MoveNodes[playCount]);
            // ����ͼ��
            var mk = new BMap.Marker(MoveNodes[playCount],{icon:myIcon});  // ������ע
            MoveMarkers.push(mk);
            //���ú������ͼ��
            if(playCount>=1){
               setLable(MoveNodes[playCount-1],playCount); 
            }
            //�Ƴ�ǰһ��С��
            map.removeOverlay(MoveMarkers[playCount-1]);
            map.addOverlay(mk);// ����ע���ӵ���ͼ��
            
            mk.CurNum = playCount + 1;
            
            PreIndex = playCount;
            
            // �����������
            playCount++;
            // ������һ�ڵ�
            setTimeout(playtimer, ${sample});
            //2012-12-06 11:30:02
        }
    }
    
    //���ñ�ǩ ���������
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
    // ͼ��
    var image = '<%=path%>/images/beachflag.png';
    var imageChg = '<%=path%>/images/nothing.png';
    var latitude=${mapinf.latitude};//γ��
    var longitude=${mapinf.longitude};//����
    // �ٶȵ�ͼAPI����
    var map = new BMap.Map("allmap");                        // ����Mapʵ��--��������body���棬ӦΪҪallmap�ȼ���
    map.centerAndZoom(new BMap.Point(longitude,latitude), 9);     // ��ʼ����ͼ,�������ĵ�����͵�ͼ����//113.73416 28.97734
    map.addControl(new BMap.NavigationControl());               // ����ƽ�����ſؼ�
    map.addControl(new BMap.ScaleControl());                    // ���ӱ����߿ؼ�
    map.addControl(new BMap.OverviewMapControl());              //�������Ե�ͼ�ؼ�
    map.enableScrollWheelZoom();                            //���ù��ַŴ���С
    map.addControl(new BMap.MapTypeControl());          //���ӵ�ͼ���Ϳؼ�
    map.setCurrentCity("����");          // ���õ�ͼ��ʾ�ĳ��� �����Ǳ������õ�
    
    //*****************************************����ͼ��***********************************************
    //����ͼ��
    //ͼ��
    var imageicon="<%=path%>/images/vechile.png";
    var pt = new BMap.Point(longitude,latitude);
    var myIcon = new BMap.Icon(imageicon, new BMap.Size(60,49));
    var marker = new BMap.Marker(pt,{icon:myIcon});  // ������ע
    map.addOverlay(marker);              // ����ע���ӵ���ͼ��
    
    //�����ͼʱ����ʾΪδ���о������
    document.getElementById("importinfo").innerHTML = '<p><b>' + 'δ���о������' + '<p><b>';
     
    //******************************************��������ͼ�����Ϣ��**********************************************
    //����������ı���ʾ����
    var contentstr = '<div><span style="font-weight:bolder;color:red;">������ţ�</span>${mapinf.deviceid}</br>'+
        '<span style="font-weight:bolder;color:red;">����Сʱ��</span>${mapinf.worktime}</br>'+
        '<span style="font-weight:bolder;color:red;">����״̬��</span>${mapinf.carkey}</br>'+
        '<span style="font-weight:bolder;color:red;">����λ�ã�</span>${mapinf.locate}</br></div>';
    //������Ӧͼ�����Ϣ��
    var infoWindow = new BMap.InfoWindow(contentstr);
    marker.addEventListener("click", function(){this.openInfoWindow(infoWindow);});
    
    //******************************************�����Զ���ؼ�**********************************************
    //******************************************��λ**********************************************
    // ����һ���ؼ���,��function
    function ZoomControl(){
      // Ĭ��ͣ��λ�ú�ƫ����
      this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
      this.defaultOffset = new BMap.Size(80, 10);
    }
    
    // ͨ��JavaScript��prototype���Լ̳���BMap.Control
    ZoomControl.prototype = new BMap.Control();
    
    // �Զ���ؼ�����ʵ���Լ���initialize����,���ҽ��ؼ���DOMԪ�ط���
    // �ڱ������д�����divԪ����Ϊ�ؼ�������,���������ӵ���ͼ������
    ZoomControl.prototype.initialize = function(map){
      // ����һ��DOMԪ��
      var div = document.createElement("div");
      // ��������˵��
      div.appendChild(document.createTextNode("��λ"));
      // ������ʽ
      div.style.cursor = "pointer";
      div.style.border = "2px solid gray";
      div.style.width = "40px";
      div.style.height = "17px";
      div.style.fontSize="14px";
      div.style.textAlign="center";
      div.style.backgroundColor = "white";
      // ���¼�,���һ�ηŴ�����
      div.onclick = function(e){
        map.setCenter(new BMap.Point(longitude,latitude))
        //map.setZoom(map.getZoom() + 2);//�Ŵ�����
      }
      // ����DOMԪ�ص���ͼ��
      map.getContainer().appendChild(div);
      // ��DOMԪ�ط���
      return div;
    }
    // �����ؼ�
    var myZoomCtrl = new ZoomControl();
    // ���ӵ���ͼ����
    map.addControl(myZoomCtrl);
    
    //*****************************************����켣***********************************************
    // ����һ���ؼ���,��function
    function ZoomControlClear(){
      // Ĭ��ͣ��λ�ú�ƫ����
      this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
      this.defaultOffset = new BMap.Size(160, 10);
    }
    
    // ͨ��JavaScript��prototype���Լ̳���BMap.Control
    ZoomControlClear.prototype = new BMap.Control();
    
    // �Զ���ؼ�����ʵ���Լ���initialize����,���ҽ��ؼ���DOMԪ�ط���
    // �ڱ������д�����divԪ����Ϊ�ؼ�������,���������ӵ���ͼ������
    ZoomControlClear.prototype.initialize = function(map){
      // ����һ��DOMԪ��
      var div = document.createElement("div");
      // ��������˵��
      div.appendChild(document.createTextNode("����켣"));
      // ������ʽ
      div.style.cursor = "pointer";
      div.style.border = "2px solid gray";
      div.style.width = "80px";
      div.style.height = "17px";
      div.style.fontSize="14px";
      div.style.textAlign="center";
      div.style.backgroundColor = "white";
      // ���¼�,���һ�ηŴ�����
      div.onclick = function(e){
        clearNode();
      }
      // ����DOMԪ�ص���ͼ��
      map.getContainer().appendChild(div);
      // ��DOMԪ�ط���
      return div;
    }
    // �����ؼ�
    var myZoomCtrlClear = new ZoomControlClear();
    // ���ӵ���ͼ����
    map.addControl(myZoomCtrlClear);
    
    
    //*****************************************���***********************************************
    // ����һ���ؼ���,��function
    function ZoomControlCalcDis(){
      // Ĭ��ͣ��λ�ú�ƫ����
      this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
      this.defaultOffset = new BMap.Size(280, 10);
    }
    
    // ͨ��JavaScript��prototype���Լ̳���BMap.Control
    ZoomControlCalcDis.prototype = new BMap.Control();
    
    // �Զ���ؼ�����ʵ���Լ���initialize����,���ҽ��ؼ���DOMԪ�ط���
    // �ڱ������д�����divԪ����Ϊ�ؼ�������,���������ӵ���ͼ������
    ZoomControlCalcDis.prototype.initialize = function(map){
      // ����һ��DOMԪ��
      var div = document.createElement("div");
      // ��������˵��
      div.appendChild(document.createTextNode("��������"));
      // ������ʽ
      div.style.cursor = "pointer";
      div.style.border = "2px solid gray";
      div.style.width = "80px";
      div.style.height = "17px";
      div.style.fontSize="14px";
      div.style.textAlign="center";
      div.style.backgroundColor = "white";
      // ���¼�,���һ�ηŴ�����
      div.onclick = function(e){
        var myDis = new BMapLib.DistanceTool(map);
         myDis.open();
      }
      // ����DOMԪ�ص���ͼ��
      map.getContainer().appendChild(div);
      // ��DOMԪ�ط���
      return div;
    }
    // �����ؼ�
    var myZoomCtrlCalcDis = new ZoomControlCalcDis();
    // ���ӵ���ͼ����
    map.addControl(myZoomCtrlCalcDis);
    
    
    //*****************************************�켣�طų�ʼ��***********************************************
    var moveon=0;
    
    moveon=${moveon};
    if(moveon=='1'){
        playMoveNode();
    }
    
</script>
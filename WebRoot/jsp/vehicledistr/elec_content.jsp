<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>��ҳ���л�Ч��_TABЧ����ȫ</title>
		<script src="http://maps.google.com/maps/api/js?v=3.1&sensor=true" type="text/javascript"></script>
    
    <script type="text/javascript">
    var map;
    var poly;
  function initialize() {
    var latlng = new google.maps.LatLng(35.24, 102.34);
    var myOptions = {
      zoom: 4,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      rotateControl:true
    };
    map = new google.maps.Map(document.getElementById("map"), myOptions);
    
    var imageicon="<%=path%>/images/vechile.png";
    
    //var lat=25.774252;
    //var lon=-80.190262;
    
    //for(var i = 0; i < 10; i++ ){
        //var contentstr = 'BMSRTYY';
        //contentstr = contentstr+i;
        //addMarker(lat,lon,imageicon,contentstr);
        //lat++;
        //lon++;
    //}
    
    //var triangleCoords = [
        //new google.maps.LatLng(25.774252, -80.190262),
        //new google.maps.LatLng(18.466465, -66.118292),
        //new google.maps.LatLng(32.321384, -64.75737),
       // new google.maps.LatLng(25.774252, -80.190262)
    //];

    
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
      

    google.maps.event.addListener(map, 'click', writePolygon);//writePolygon��chkDistan-������Զ����ߣ�����¼�����Ҫ����
  }
  
  
  //�������
  function writePolygon(event){
    // ��ȡ�߶�·��-������MVCArray
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
  
  new google.maps.event.addDomListener(window, 'load', initialize);
</script>
		
		<style>
			* {
				margin: 0;
				padding: 0;
			}
			
			body {
				margin: 1px;
				font-size: 12px;
				color: #666;
			}
			
			li {
				list-style: none;
			}
			
			.tab2 {
				width: 270px;
				height: 34px;
				
				border-bottom: 0;
			}
			
			.tab2 ul {
				margin: 0;
				padding: 0;
			}
			
			.tab2 li {
				float: left;
				padding: 0 35px;
				height: 34px;
				line-height: 34px;
				text-align: center;
				border-right: 1px #ebf7ff solid;
				cursor: pointer;
			}
			
			.tab2 li.now {
				color: #5299c4;
				background: #fff;
				font-weight: bold;
			}
			
			.tablist {
				width: 270px;
				height: 95%;
				
                font-size: 14px;
                line-height: 24px;
                border: 1px #cfedff solid;
                border-top: 0;
				display: none;
			}
			
			.block {
				display: block;
			}
			.m_right{
			    margin-left:270px;border-left:1px solid #1d548f;
			}
			.m_left{
			    float:left;width:260px;min-height:600px;
			}
			table td {
    font-size: 12px;
}
			</style>
	<script type="text/javascript">
		function tab(o, s, cb, ev){ //tab�л���
		    var $ = function(o){return document.getElementById(o)};
		    var css = o.split((s||'_'));
		    if(css.length!=4)return;
		    this.event = ev || 'onclick';
		    o = $(o);
		    if(o){
		        this.ITEM = [];
		        o.id = css[0];
				var item = o.getElementsByTagName(css[1]);
				var j=1;
				for(var i=0;i<item.length;i++){
				  if(item[i].className.indexOf(css[2])>=0 || item[i].className.indexOf(css[3])>=0){
					if(item[i].className == css[2])o['cur'] = item[i];
					item[i].callBack = cb||function(){};
					item[i]['css'] = css;
					item[i]['link'] = o;
					this.ITEM[j] = item[i];
					item[i]['Index'] = j++;
					item[i][this.event] = this.ACTIVE;
		          }
		        }
		        return o;
		    }
		}
		tab.prototype = {
		    ACTIVE:function(){
			    var $ = function(o){return document.getElementById(o)};
			    this['link']['cur'].className = this['css'][3];
			    this.className = this['css'][2];
			    try{
			        $(this['link']['id']+'_'+this['link']['cur']['Index']).style.display = 'none';
			        $(this['link']['id']+'_'+this['Index']).style.display = 'block';
			    }catch(e){}
			    this.callBack.call(this);
			    this['link']['cur'] = this;
			}
		}
	</script>
</head>
	<body>
	<div class="m_left">
		<div class="tab2">
			<ul id="test2_li_now_">
				<li class="now">
					�ҵ�����
				</li>
				<li>
					�ҵ��豸
				</li>
			</ul>
		</div>
		<div>
		     
			<div id="test2_1" class="tablist block">
			  <div id="" class=""> 
                    <table border="0" cellpadding="0" cellspacing="0"> 
                        <tbody><tr> 
                            <td align="center" width="100"> 
                                <select id="sltQueryBy" onchange="clearKey()"> 
                                    <option value="1" selected="selected">��е����</option> 
                                    <option value="2">�豸��</option> 
                                    <option value="3">SIM����</option> 
                                </select> 
                            </td> 
                            <td> 
                                <div> 
                                    <div> 
                                        <input id="txtKey" name="txtKey" onclick="" type="text"> 
                                    </div> 
                                </div> 
                            </td>
                            <td align="center" width="50"><input value="��ѯ" class="" onclick="" type="button"></td> 
                        </tr> 
                    </tbody></table> 
                </div> 
              
                <div> 
                    <table border="0" cellpadding="0" cellspacing="0"> 
                        <tbody><tr> 
                            <td align="center" height="30" width="172"><span id="spnName">�豸����</span></td> 
                            <td id="td_op" align="center" width="80"><span id="spnState">����Χ��</span></td> 
                        </tr> 
                    </tbody></table> 
                </div> 
			
			
				<table id="ff" border="0" cellpadding="0" cellspacing="0">
				    <tbody>
				        <tr id="tr_49042" style="background-color: rgb(240, 237, 237); cursor: pointer;" onmouseover='over1("tr_49042")' onmouseout='out1("tr_49042","#f0eded")'>
				            <td onclick=''align="center" height="25" width="172">
				                &nbsp;��
				            </td>
				            <td align="center" width="70">
				                ������
				            </td>
				        </tr>
				        <tr id="tr_35290" style="background-color: rgb(255, 255, 255); cursor: pointer;" onmouseover='over1("tr_35290")' onmouseout='out1("tr_35290","#FFFFFF")'>
				            <td onclick='' align="center" height="25" width="172">
				                &nbsp;С��
				            </td>
				            <td align="center" width="70">
				                   ������
				            </td>
				        </tr>
				     </tbody>
				</table> 
			</div>
			<div id="test2_2" class="tablist">
				<div id="dv_Weilan" class=""> 
                    <input id="txtKey1" name="txtKey1" class="" style="width:210px;" type="text"> 
                    <input value="��ѯ" class="btn" onclick="search()" type="button"> 
                </div>
                <div> 
                    <table border="0" cellpadding="0" cellspacing="0"> 
                        <tbody><tr> 
                            <td align="center" height="30" width="172"><span id="spnName">����Χ������</span></td> 
                            <td id="td_op" align="center" width="80"><span id="spnState">����</span></td> 
                            <td id="td_op" align="center" width="50"><span id="spnState">����</span></td> 
                        </tr> 
                    </tbody></table> 
                </div> 
            
            
                <table id="ff" border="0" cellpadding="0" cellspacing="0">
                    <tbody>
                        <tr id="tr_49042" style="background-color: rgb(240, 237, 237); cursor: pointer;" onmouseover='over1("tr_49042")' onmouseout='out1("tr_49042","#f0eded")'>
                            <td onclick=''align="center" height="25" width="172">
                                &nbsp;Χ��1
                            </td>
                            <td align="center" width="70">
                                ��Χ��
                            </td>
                            <td align="center">
                                <a id="" href="#">ɾ��</a>
                            </td>
                        </tr>
                        <tr id="tr_35290" style="background-color: rgb(255, 255, 255); cursor: pointer;" onmouseover='over1("tr_35290")' onmouseout='out1("tr_35290","#FFFFFF")'>
                            <td onclick='' align="center" height="25" width="172">
                                &nbsp;Χ��2
                            </td>
                            <td align="center" width="70">
                                   ������
                            </td>
                            <td align="center"  width="70">
                                   <a id="" href="#">ɾ��</a>
                            </td>
                        </tr>
                     </tbody>
                </table> 
			</div>
		</div>
	</div>
	<div class="m_right">
	   <div><a id="" href="#">�½�Χ��</a>&nbsp;&nbsp;&nbsp;���ͣ�<select><option>����</option><option>���</option></select>&nbsp;&nbsp;&nbsp;�󶨳�����<input type="text" onclick="" ></div>
	   <div id="map" style="height:95%"></div>
	</div>
	</body>
<script type="text/javascript">
window.onload = function(){
    new tab('test2_li_now_');
}
</script>
</html>

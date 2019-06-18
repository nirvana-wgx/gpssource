<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
%>

<html>
   <head>
    
      <title>My JSP 'singlevechicle_left.jsp' starting page</title>
    
      <meta http-equiv="pragma" content="no-cache">
      <meta http-equiv="cache-control" content="no-cache">
	  <!--
	  <link rel="stylesheet" type="text/css" href="styles.css">
	  -->
     <link rel="stylesheet" href="<%=path%>/css/single.css" type="text/css" media="all" />
     <link rel="stylesheet" href="<%=path %>/css/YUIcssreset.css" type="text/css" media="all" />  
   <link rel="stylesheet" href="<%=path %>/css/layout.css" type="text/css" media="all" />
   <script type="text/javascript" src="<%=path %>/scripts/jquery-1.7.1.min.js" > </script>
    <script type="text/javascript">
    function addTab(object){
      var _a =$(object).parent();
      addClass($(object));
      var id =$(_a).find("a").attr("id");
      var url =$(_a).find("a").attr("title");
      var title=$(object).html();
      var content = window.top.frames["singlerightframe"];
//       alert($(window.parent.document).contents().find("#singlerightframe")[0].contentWindow.iframefunction());
       window.top.document.getElementById("singlerightframe").contentWindow.loadContent(id,title,url);
//       content.contentWindow.loadContent(id,title,url);
   }
 function addClass(_a){
   var $li,
   $container;
   if (_a.length) {
      $li = _a.parent();
      $container = $li.parent();
      $container.find('li').removeClass('sidebar_menu_selected');
      $li.addClass('sidebar_menu_selected');
   }
}
    
    </script>
   </head>
  
   <body  class="panel" topmargin="0px" leftmargin="0">
      <div id="body">
			<!-- OA树开始-->
			<div class="sidebar_title">
            <h3 class="sidebar_setting"><b>&nbsp;&nbsp;${vehicleid}</b>车辆</h3>
         </div><!-- .sidebar_title end -->
			<ul id="menu">
			   <li class="L1"><a href="javascript:c(m01);" id="m01"><span><img src="<%=path%>/images/singlevechIma/ico/2.gif" style="vertical-align:middle;"/>车辆信息</span></a></li>
		      <li>
			      <ul id="m01d" style="display:none;" class="U1">
			         <li class="L22"><a title="<%=path%>/jsp/vechiclemanager/singlevehicle/VehicleInfo.page?deviceid=${ deviceid }" href="javascript:void(0);" onclick="addTab(this);set_current('4');" id="f4"><span><img src="<%=path%>/images/singlevechIma/ico/2.gif" style="vertical-align:middle;"/>车辆基本信息</span></a></li>
			         <li class="L22"><a title="<%=path%>/jsp/vechiclemanager/singlevehicle/Map.page?deviceid=${ deviceid }" href="javascript:void(0);" id="f147" onclick="javascript:addTab(this);set_current('147')"><span><img src="<%=path%>/images/singlevechIma/ico/2.gif" style="vertical-align:middle;"/>地图定位</span></a></li>
			         <li class="L22"><a title="<%=path%>/jsp/vechiclemanager/singlevehicle/FastTips.page?deviceid=${ deviceid }" href="javascript:void(0);" onclick="javascript:addTab(this);set_current('148')" id="f148"><span><img src="<%=path%>/images/singlevechIma/ico/2.gif" style="vertical-align:middle;"/>快速查询</span></a></li>
	               <c:if test="${ ishistoryshow == '1' }">
	                  <li class="L22"><a title="<%=path%>/jsp/vechiclemanager/singlevehicle/HistoryInf.page?historytype=1&deviceid=${ deviceid }" href="javascript:void(0);" onclick="javascript:addTab(this);set_current('149')" id="f149"><span><img src="<%=path%>/images/singlevechIma/ico/2.gif" style="vertical-align:middle;"/>历史信息</span></a></li>
			         </c:if>
			      </ul>
			   </li>
			   <li class="L1"><a href="javascript:c(m02);" id="m02"><span><img class="menu_list" src="<%=path%>/images/singlevechIma/ico/2.gif" style="vertical-align:middle;"/>销售信息</span></a></li>
		      <li>
			      <ul id="m02d" style="display:none;" class="U1">
			         <li class="L22"><a title="<%=path%>/jsp/vechiclemanager/singlevehicle/SalesInf.page?deviceid=${ deviceid }" href="javascript:void(0);" id="f130" onclick="javascript:addTab(this);set_current('6')"><span><img src="<%=path%>/images/singlevechIma/ico/2.gif" style="vertical-align:middle;"/>基本信息</span></a></li>
			         <li class="L22"><a title="<%=path%>/jsp/vechiclemanager/singlevehicle/Refund.page?deviceid=${ deviceid }" href="javascript:void(0);" id="f5" onclick="javascript:addTab(this);set_current('5')"><span><img src="<%=path%>/images/singlevechIma/ico/2.gif" style="vertical-align:middle;"/>还款信息</span></a></li>
			      </ul>
		      </li>
			   <li class="L1"><a href="javascript:c(m03);" id="m03"><span><img src="<%=path%>/images/singlevechIma/ico/2.gif" style="vertical-align:middle;"/>服务信息</span></a></li>
		      <li>
			      <ul id="m03d" style="display:none;" class="U1">
			         <li class="L22"><a title="<%=path%>/jsp/vechiclemanager/singlevehicle/MaintenaceInfo.page?type=1&deviceid=${ deviceid }" href="javascript:void(0);" onclick="javascript:addTab(this);set_current('96')" id="f96"><span><img src="<%=path%>/images/singlevechIma/ico/2.gif" style="vertical-align:middle;"/>保养信息</span></a></li>
			         <li class="L22"><a title="<%=path%>/jsp/vechiclemanager/singlevehicle/MaintenaceInfo.page?type=2&deviceid=${ deviceid }" href="javascript:void(0);" onclick="javascript:addTab(this);set_current('97')" id="f97"><span><img src="<%=path%>/images/singlevechIma/ico/2.gif" style="vertical-align:middle;"/>保养历史</span></a></li>
			      </ul>
		      </li>
          </ul>
      </div>
<script type="text/javascript">
window.onload=function(){
   
   var obj = document.getElementById("f4");
   addTab(obj);
   set_current('4');
   c(m01);
}

function openMap() {
   var obj = document.getElementById("f147");
   addTab(obj);
   set_current('147');
   var target_element = document.getElementById("m01d");
   if(target_element.style.display=="none") {
      c(m01);
   }
}

function righttab_select(id) {
   var obj = document.getElementById(id);
   var id_num = id.substring(1);
   set_current(id_num);
   var parentid = $("#" + id).parent().parent("ul").attr("id");
   var target_element = document.getElementById(parentid);
   if(target_element.style.display=="none") {
      if(parentid = "m01d") {
         c(m01);
      } else if(parentid = "m02d") {
         c(m02);
      } else {
         c(m03);
      }
      
   }
}

var cur_id="";
var flag=0,sflag=0;

//-------- 菜单点击事件 -------
function c(srcelement)
{
  var targetid,srcelement,targetelement;
  var strbuf;

  //-------- 如果点击了展开或收缩按钮---------
  targetid=srcelement.id+"d";
  targetelement=document.getElementById(targetid);

  if (targetelement.style.display=="none")
  {
     srcelement.className="active";
     targetelement.style.display='';

     menu_flag=0;
//      expand_text.innerHTML="收缩";
  }
  else
  {
     srcelement.className="";
     targetelement.style.display="none";

     menu_flag=1;
//      expand_text.innerHTML="展开";
     var links=document.getElementsByTagName("A");
     for (i=0; i<links.length; i++)
     {
       srcelement=links[i];
       if(srcelement.parentNode.className.toUpperCase()=="L1" && srcelement.className=="active" && srcelement.id.substr(0,1)=="m")
       {
          menu_flag=0;
//           expand_text.innerHTML="收缩";
          break;
       }
     }
  }
}
function set_current(id)
{
   cur_link=document.getElementById("f"+cur_id)
   if(cur_link)
      cur_link.className="";
   cur_link=document.getElementById("f"+id);
   if(cur_link)
      cur_link.className="active";
   cur_id=id;
}
function bindFunc() {
  var args = [];
  for (var i = 0, cnt = arguments.length; i < cnt; i++) {
    args[i] = arguments[i];
  }
  var __method = args.shift();
  var object = args.shift();
  return (
    function(){
      var argsInner = [];
        for (var i = 0, cnt = arguments.length; i < cnt; i++) {
          argsInner[i] = arguments[i];
        }
      return __method.apply(object, args.concat(argsInner));
    });
}
var timerId = null;
var firstTime = true;
function d(URL,id)
{
   var winMgr = parent.parent.table_index.main.winManager;
    if (!winMgr) {
      if (firstTime) {
        parent.openURL("/fis/common/frame.jsp",0);
        firstTime = false;
      }
      timerId = setTimeout(bindFunc(d, window, URL, id), 100);
      return;
    }
    firstTime = true;
    if (timerId) {
      clearTimeout(timerId);
    }
    if (winMgr) {
      winMgr.openActionPort("/fis/"+URL, document.getElementById("f" + id).innerText);
      return;
    }
   set_current(id);
   URL = "/fis/"+URL;
    parent.openURL(URL,0);
}
</script>
   </body>
</html>
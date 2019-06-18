<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
String path = request.getContextPath();
%>

<!DOCTYPE html>
<html>
   <head>
    
      <title>车辆列表</title>
    
      <meta http-equiv="pragma" content="no-cache">
      <meta http-equiv="cache-control" content="no-cache">
      <!--
      <link rel="stylesheet" type="text/css" href="styles.css">
      -->
      <link href="<%=path%>/css/common.css" rel="stylesheet" type="text/css" />
      <link rel="stylesheet" href="<%=path%>/css/layout.css" type="text/css" media="all" />
      <link href="<%=path %>/css/toolbars.css" rel="stylesheet" type="text/css"  media="all"/>
      <script type="text/javascript" src="<%=path %>/plugs/My97DatePicker/WdatePicker.js"></script>
      
      <style type="text/css">
         html, body {
            margin: 0px 0px;
            width: 100%;
            height: 100%;
            background: #E6EAE9;
         }
      </style>
   </head>
  
   <body> 
      <div style="border:0px;">
      <fieldset style="width:98%;margin-top:10px">
   <legend>机械信息 </legend>
         <input type="hidden" id="vehicleid" value="${ relation.vehicleid }"/>
         <table id="tab_list" style="border-collapse:collapse;border-spacing:0;width:95%;margin-left:2%;margin-top:4px;">
            <tbody>
	            <tr>
	               <th style="border-left:1px solid #CCCCFF;border-top:1px solid #CCCCFF;">机械种类</th>
	               <th style="border-top:1px solid #CCCCFF;">机型</th>
	               <th style="border-top:1px solid #CCCCFF;" >机号</th>
	               <th style="border-top:1px solid #CCCCFF;">设备号</th>
	               <th style="border-top:1px solid #CCCCFF;">SIM卡号</th>
	            </tr>
	            <tr>
	               <td style="border-left:1px solid #CCCCFF;">${ relation.type }</td>
	               <td>${ relation.typename }</td>
	               <td>${ relation.vehicleid }</td>
	               <td>${ relation.deviceid }</td>
	               <td style="border-buttom:1px solid #CCCCFF;">${ relation.sim }</td>
	            </tr>
            <tbody>
        </table>
        <div style="height:20px;border:0px"></div>
        <div id="auto_div" style="overflow:auto;height:auto;width:100%;margin-left:2%;border:0px;">
           <table id="tab_list" style="width:3000px;border-collapse:collapse;border-spacing:0;" class="data_list_sty1" id="data_list_sty4">
              <tbody>
                 <tr>
                    <th>序号</th>
                    <th>信息接收时间</th>
                    <th>信息类型</th>
                    <th>定位时间</th>
                    <th>定位状态</th>
                    <th>数据采集时间</th>
                    <th>车钥匙状态</th>
                    <th>电源电压</th>
                    <th>工作小时</th>
                    <th>油位</th>
                    <th>水温</th>
                    <th>油温</th>
                    <th>油压</th>
                    <th>转速</th>
                    <th>报警码</th>
                    <th>外壳</th>
                    <th>天线</th>
                    <th>监控</th>
                    <th>继电器1</th>
                    <th>继电器2</th>
                    <th>继电器3</th>
                    <th>继电器4</th>
                    <th>设备状态</th>
                    <th>两月不入网</th>
                    <th>开壳</th>
                    <th>天线异常</th>
                    <th>总线通信</th>
                    <th>电池电压</th>
                    <th>芯片温度</th>
                    <th>经度</th>
                    <th>纬度</th>
                    <th>位置</th>
                 </tr>
	              <c:if test="${fn:length(messagebmlist)==0}">
                    <tr><td colspan='99' style="border-left:0px;border-right:0px;text-align:left;"><span style="margin-left:20%;"><font color='red'>无记录</font></span></td></tr>
                 </c:if>
                 
                 <c:forEach items="${messagebmlist}" var="messagebm" varStatus="status">
                    <tr>
                       <th scope="row" style="border-left:0px;width:auto;">
                          ${(page_no - 1) * page_num + status.index + 1}
                       </th>
                       <td>
                          <fmt:formatDate value="${ messagebm.receivetime }" pattern="yyyy-MM-dd HH:mm:ss"/>
                       </td>
                       <td>
                          ${ messagebm.infotype }
                       </td>
                       <td>
                          <fmt:formatDate value="${ messagebm.locatetime }" pattern="yyyy-MM-dd HH:mm:ss"/>
                       </td>
                       <td>
                          ${ messagebm.gpslocate }
                       </td>
                       <td>
                          <fmt:formatDate value="${ messagebm.collecttime }" pattern="yyyy-MM-dd HH:mm:ss"/>
                       </td>
                       <td>
                          <c:choose>
                             <c:when test="${ messagebm.carkey == null }">
                                <input type="image" name="ck" src="<%=path%>/images/unknown.gif" />
                             </c:when>
                             <c:when test="${ messagebm.carkey == '关闭' }">
                                <input type="image" name="ck" src="<%=path%>/images/close.gif" />
                             </c:when>
                             <c:otherwise>
                                <input type="image" name="ck" src="<%=path%>/images/ok.gif" />
                             </c:otherwise>
                          </c:choose>
                       </td>
                       <td>
                          ${ messagebm.voltage }
                       </td>
                       <td>
                          ${ messagebm.worktime }
                       </td>
                       <td>
                          ${ messagebm.oillevel }
                       </td>
                       <td>
                          ${ messagebm.watertemperature }
                       </td>
                       <td>
                          ${ messagebm.oiltemperature }
                       </td>
                       <td>
                          ${ messagebm.oilpressure }
                       </td>
                       <td>
                          ${ messagebm.rotaryspeed }
                       </td>
                       <td title="水温报警">
                          <c:choose>
	                          <c:when test="${ messagebm.warncd == '正常' && messagebm.warnry == '正常' && messagebm.warnyy == '正常' 
	                                           && messagebm.warnsw == '正常' && messagebm.warnyw == '正常' && messagebm.warnyl == '正常' && messagebm.warnkl == '正常' }">
	                             正常
	                          </c:when>
	                          <c:otherwise>
	                             报警
	                          </c:otherwise>
                          </c:choose>
                       </td>
                       <td>
                          ${ messagebm.gpsshell }
                       </td>
                       <td>
                          ${ messagebm.gpsantenna }
                       </td>
                       <td>
                          ${ messagebm.gpsminitor }
                       </td>
                       <td>
                          ${ messagebm.gpsrelay1 }
                       </td>
                       <td>
                          ${ messagebm.gpsrelay2 }
                       </td>
                       <td>
                          ${ messagebm.gpsrelay3 }
                       </td>
                       <td>
                          ${ messagebm.gpsrelay4 }
                       </td>
                       <td>
                          ${ messagebm.gpssleep }
                       </td>
                       <td>
                          ${ messagebm.gpsautolocktwomonth }
                       </td>
                       <td>
                          ${ messagebm.gpsautolockshell }
                       </td>
                       <td>
                          ${ messagebm.gpsautolockantenna }
                       </td>
                       <td>
                          ${ messagebm.gpsautolockmain }
                       </td>
                       <td>
                          ${ messagebm.backup }
                       </td>
                       <td>
                          ${ messagebm.envtemperature }
                       </td>
                       <td>
                          ${ messagebm.longitude }
                       </td>
                       <td>
                          ${ messagebm.latitude }
                       </td>
                       <td title="这里显示全部文字">
<!--                           <a href=""> -->
                          ${ messagebm.positioninfo }
<!--                           </a> -->
                       </td>
                    </tr>
                 </c:forEach>
              </tbody>
           </table>
        </div>
        <div style="width:95.2%;margin-left:1.9%;border:0px;">
           <table>
              <tr>
                  <td colspan="99" class="jpaginate">
                     <a href="javascript:gotofirst();"><img src="<%=path%>/images/sprevious.png" /></a>
                     <a href="javascript:gotoback();"><img src="<%=path%>/images/previous.png" /></a>
                     <span>第<input id="go_page_no" type="text" value="${ page_no }" />页/${ tot_page }页</span>
                     <a href="javascript:gotonext();"><img src="<%=path%>/images/next.png" /></a>
                     <a href="javascript:gotolast();"><img src="<%=path%>/images/snext.png" /></a> 
                     <span>每页<input id="page_num" type="text" value="${ page_num }" />条</span>
                     <a href="javascript:gotopage();"><img src="<%=path%>/images/Refresh.gif"/></a>
                     <input id="tot_page" type="hidden" value="${ tot_page }"/>
                     <input id="page_no" type="hidden" value="${ page_no }"/>
                  </td>
               </tr>
            </table>
        </div>
        </fieldset>
      </div>
       
<script type="text/javascript">
   window.onload=function(){
      var width = document.body.offsetWidth;
      width = width * 0.92;
      var auto_div = document.getElementById("auto_div");
      auto_div.style.width=width + "px";
   }
   window.onresize=function() {
      var width = document.body.offsetWidth;
      width = width * 0.92;
      var auto_div = document.getElementById("auto_div");
      auto_div.style.width=width + "px";
   }
   
   function gotofirst() {
      var vehicleid = document.getElementById("vehicleid").value;
      var page_no = 1;
      var page_num = document.getElementById("page_num").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/VehicleSearch.page?flg=1&vehicleid=" + vehicleid + "&page_no=" + page_no + "&page_num=" + page_num;
   }
   
   function gotoback() {
      var vehicleid = document.getElementById("vehicleid").value;
      var page_no = Number(document.getElementById("page_no").value) - 1;
      if(page_no <= 0) {
         page_no = 1;
      }
      var page_num = document.getElementById("page_num").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/VehicleSearch.page?flg=1&vehicleid=" + vehicleid + "&page_no=" + page_no + "&page_num=" + page_num;
   }
   
   function gotonext() {
      var vehicleid = document.getElementById("vehicleid").value;
      var page_no = Number(document.getElementById("page_no").value) + 1;
      var tot_page = Number(document.getElementById("tot_page").value);
      if(page_no > tot_page) {
         page_no = tot_page;
      }
      var page_num = document.getElementById("page_num").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/VehicleSearch.page?flg=1&vehicleid=" + vehicleid + "&page_no=" + page_no + "&page_num=" + page_num;
   }
   
   function gotolast() {
      var vehicleid = document.getElementById("vehicleid").value;
      var page_no = document.getElementById("tot_page").value;
      var page_num = document.getElementById("page_num").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/VehicleSearch.page?flg=1&vehicleid=" + vehicleid + "&page_no=" + page_no + "&page_num=" + page_num;
   }
   
   function gotopage() {
      var vehicleid = document.getElementById("vehicleid").value;
      var page_no = Number(document.getElementById("go_page_no").value);
      var tot_page = Number(document.getElementById("tot_page").value);
      if(page_no > tot_page) {
         page_no = tot_page;
      } else if(page_no <= 0) {
         page_no = 1;
      }
      var page_num = document.getElementById("page_num").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/VehicleSearch.page?flg=1&vehicleid=" + vehicleid + "&page_no=" + page_no + "&page_num=" + page_num;
   }
   
</script>
   </body>
</html>



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
    
      <title>GPS设备报警</title>
    
      <meta http-equiv="pragma" content="no-cache">
      <meta http-equiv="cache-control" content="no-cache">
      <!--
      <link rel="stylesheet" type="text/css" href="styles.css">
      -->
      <script type="text/javascript" src="<%=path %>/scripts/jquery-1.7.1.min.js" ></script>
      <link href="<%=path%>/css/common.css" rel="stylesheet" type="text/css" />
      <link href="<%=path %>/css/toolbars.css" rel="stylesheet" type="text/css"  media="all"/>      
      <style type="text/css">
         html, body {
            margin: 0px 0px;
            width: 100%;
            height: 100%;
            background: #E6EAE9;
         }
         #div_list{
            height:auto;
         }
      </style>
   
   </head>
  
   <body>  
      <br/>  
      <div>
         <form id="serform" action="<%=path%>/jsp/alarm/GpsAlarm.page"  method="post">
            <table style="border-collapse:collapse;border-spacing:0;">
               <tr>
                  <td style="text-align:right;">设备号</td>
                  <td><input id="serdeviceid" onmouseover="this.style.border='1px solid green'" onmouseout="this.style.border=''" name="serdeviceid" type="text" value="${ serdeviceid }"/></td>
                  <td style="text-align:right;">SIM卡号</td>
                  <td><input id="sersim" onmouseover="this.style.border='1px solid green'" onmouseout="this.style.border=''" name="sersim" type="text" value="${ sersim }"/></td>
               </tr>
               <tr>
                  <td style="text-align:right;">报警项目</td>
                  <td>
                     <select id="seritem" name="seritem" style="width:150px;">
                        <option value="">全部</option>
                        <option value="gpsantenna">GPS天线</option>
                        <option value="gpsshell">GPS外壳</option>
                        <option value="voltage">GPS电源电压</option>
                     </select>
                  </td>
                  <td style="border-right:0px;"></td>
                  <td>
                     <a href="javascript:document.forms['serform'].submit();" onclick="" id="btn_add"> <span
                        class="toolbar_btn"><span
                           class="toolbar_btn_ico toolbar_btn_search">查询</span></span></a>
                     <a href="javascript:reset();" onclick="" id="btn_add"><span
                        class="toolbar_btn"><span
                           class="toolbar_btn_ico toolbar_btn_clear">重置</span>
                     </span></a>
                  </td>
               </tr>
            </table>
      
            <table style="border-collapse:collapse;border-spacing:0;">
               <tr>
                  <td class="left" colspan="99" style="height:14px;border-bottom:0px;">
                  </td>
               </tr>
               <tr>
                  <td colspan="99" style="border-bottom:0px;">
                     <div id="div_list">
                        <table id="tab_list">
                           <tr>
                              <th scope="col" abbr="设备号">设备号</th>
                              <th scope="col" abbr="SIM卡号">SIM卡号</th>
                              <th scope="col" abbr="报警时间">报警时间</th>
                              <th scope="col" abbr="报警项目">报警项目</th>
                           </tr>
                           
                           <c:if test="${fn:length(gpsalarmlist)==0}">
                              <tr><td align='center' colspan='10'><font color='red'>无记录</font></td></tr>
                           </c:if>
                           
                           <c:forEach items="${gpsalarmlist}" var="gpsalarm" varStatus="status">
                              <tr>
                                 <td>
                                    ${ gpsalarm.deviceid }
                                 </td>
                                 <td>
                                    ${ gpsalarm.sim }
                                 </td>
                                 <td>
                                    <fmt:formatDate value="${ gpsalarm.receivetime }" pattern="yyyy年MM月dd日  HH:mm:ss"/>
                                 </td>
                                 <td>
                                    <c:choose>
	                                    <c:when test="${ gpsalarm.items == 'gpsantenna' }">
	                                       GPS天线异常
	                                    </c:when>
	                                    <c:when test="${ gpsalarm.items == 'gpsshell' }">
	                                       GPS外壳打开
	                                    </c:when>
	                                    <c:when test="${ gpsalarm.items == 'voltage' }">
	                                       GPS电源电压过低
	                                    </c:when>
	                                    <c:otherwise>
	                                    </c:otherwise>
	                                 </c:choose>
                                 </td>
                              </tr>
                           </c:forEach>
                        </table>
                     </div>
            
                  </td>
               </tr>
            
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
         </form>
      </div>
   </body>
   
<script type="text/javascript">
$(function(){
   var ser_item = '${ seritem }';
   if(ser_item == "gpsantenna" || ser_item == "gpsshell" || ser_item == "voltage") {
      $("#seritem").find("option[value='" + ser_item + "']").attr("selected",true);
   } else {
      $("#seritem").find("option[value='']").attr("selected",true);
   }
});


function gotofirst() {
   var serdeviceid = document.getElementById("serdeviceid").value;
   var sersim = document.getElementById("sersim").value;
   var seritem = document.getElementById("seritem").value;
   var page_no = 1;
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/alarm/GpsAlarm.page?serdeviceid=" + serdeviceid + "&sersim=" + sersim + "&seritem=" + seritem + "&page_no=" + page_no + "&page_num=" + page_num;
}

function gotoback() {
   var serdeviceid = document.getElementById("serdeviceid").value;
   var sersim = document.getElementById("sersim").value;
   var seritem = document.getElementById("seritem").value;
   var page_no = Number(document.getElementById("page_no").value) - 1;
   if(page_no <= 0) {
      page_no = 1;
   }
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/alarm/GpsAlarm.page?serdeviceid=" + serdeviceid + "&sersim=" + sersim + "&seritem=" + seritem + "&page_no=" + page_no + "&page_num=" + page_num;
}

function gotonext() {
   var serdeviceid = document.getElementById("serdeviceid").value;
   var sersim = document.getElementById("sersim").value;
   var seritem = document.getElementById("seritem").value;
   var page_no = Number(document.getElementById("page_no").value) + 1;
   var tot_page = Number(document.getElementById("tot_page").value);
   if(page_no > tot_page) {
      page_no = tot_page;
   }
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/alarm/GpsAlarm.page?serdeviceid=" + serdeviceid + "&sersim=" + sersim + "&seritem=" + seritem + "&page_no=" + page_no + "&page_num=" + page_num;
}

function gotolast() {
   var serdeviceid = document.getElementById("serdeviceid").value;
   var sersim = document.getElementById("sersim").value;
   var seritem = document.getElementById("seritem").value;
   var page_no = document.getElementById("tot_page").value;
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/alarm/GpsAlarm.page?serdeviceid=" + serdeviceid + "&sersim=" + sersim + "&seritem=" + seritem + "&page_no=" + page_no + "&page_num=" + page_num;
}

function gotopage() {
   var serdeviceid = document.getElementById("serdeviceid").value;
   var sersim = document.getElementById("sersim").value;
   var seritem = document.getElementById("seritem").value;
   var page_no = Number(document.getElementById("go_page_no").value);
   var tot_page = Number(document.getElementById("tot_page").value);
   if(page_no > tot_page) {
      page_no = tot_page;
   } else if(page_no <= 0) {
      page_no = 1;
   }
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/alarm/GpsAlarm.page?serdeviceid=" + serdeviceid + "&sersim=" + sersim + "&seritem=" + seritem + "&page_no=" + page_no + "&page_num=" + page_num;
}

function reset() {
   document.getElementById("serdeviceid").value = "";
   document.getElementById("sersim").value = "";
   $("#seritem").find("option[value='']").attr("selected",true);
}

</script>
</html>



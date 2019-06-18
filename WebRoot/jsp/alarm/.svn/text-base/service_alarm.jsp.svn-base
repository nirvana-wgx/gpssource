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
    
      <title>服务报警</title>
    
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
         <form id="serform" action="<%=path%>/jsp/alarm/ServiceAlarm.page"  method="post">
            <table style="border-collapse:collapse;border-spacing:0;">
               <tr>
                  <td style="text-align:right;">机号</td>
                  <td><input id="servehicleid" onmouseover="this.style.border='1px solid green'" onmouseout="this.style.border=''" name="servehicleid" type="text" value="${ servehicleid }"/></td>
                  <td style="text-align:right;">账号</td>
                  <td><input id="seraccount" onmouseover="this.style.border='1px solid green'" onmouseout="this.style.border=''" name="seraccount" type="text" value="${ seraccount }"/></td>
               </tr>
               <tr>
                  <td style="text-align:right;">报警项目</td>
                  <td><input id="seritem" onmouseover="this.style.border='1px solid green'" onmouseout="this.style.border=''" name="seritem" type="text" value="${ seritem }"/></td>
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
                              <th scope="col" abbr="设备号">机号</th>
                              <th scope="col" abbr="SIM卡号">账号</th>
                              <th scope="col" abbr="报警时间">报警时间</th>
                              <th scope="col" abbr="报警项目">报警项目</th>
                           </tr>
                           
                           <c:if test="${fn:length(servicealarmlist)==0}">
                              <tr><td align='center' colspan='10'><font color='red'>无记录</font></td></tr>
                           </c:if>
                           
                           <c:forEach items="${servicealarmlist}" var="servicealarm" varStatus="status">
                              <tr>
                                 <td>
                                    ${ servicealarm.vehicleid }
                                 </td>
                                 <td>
                                    ${ servicealarm.account }
                                 </td>
                                 <td>
                                    <fmt:formatDate value="${ servicealarm.expiretime }" pattern="yyyy年MM月dd日 "/>
                                 </td>
                                 <td>
                                    ${ servicealarm.items }
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
function gotofirst() {
   var servehicleid = document.getElementById("servehicleid").value;
   var seraccount = document.getElementById("seraccount").value;
   var seritem = document.getElementById("seritem").value;
   var page_no = 1;
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/alarm/ServiceAlarm.page?servehicleid=" + servehicleid + "&seraccount=" + seraccount + "&seritem=" + seritem + "&page_no=" + page_no + "&page_num=" + page_num;
}

function gotoback() {
   var servehicleid = document.getElementById("servehicleid").value;
   var seraccount = document.getElementById("seraccount").value;
   var seritem = document.getElementById("seritem").value;
   var page_no = Number(document.getElementById("page_no").value) - 1;
   if(page_no <= 0) {
      page_no = 1;
   }
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/alarm/ServiceAlarm.page?servehicleid=" + servehicleid + "&seraccount=" + seraccount + "&seritem=" + seritem + "&page_no=" + page_no + "&page_num=" + page_num;
}

function gotonext() {
   var servehicleid = document.getElementById("servehicleid").value;
   var seraccount = document.getElementById("seraccount").value;
   var seritem = document.getElementById("seritem").value;
   var page_no = Number(document.getElementById("page_no").value) + 1;
   var tot_page = Number(document.getElementById("tot_page").value);
   if(page_no > tot_page) {
      page_no = tot_page;
   }
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/alarm/ServiceAlarm.page?servehicleid=" + servehicleid + "&seraccount=" + seraccount + "&seritem=" + seritem + "&page_no=" + page_no + "&page_num=" + page_num;
}

function gotolast() {
   var servehicleid = document.getElementById("servehicleid").value;
   var seraccount = document.getElementById("seraccount").value;
   var seritem = document.getElementById("seritem").value;
   var page_no = document.getElementById("tot_page").value;
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/alarm/ServiceAlarm.page?servehicleid=" + servehicleid + "&seraccount=" + seraccount + "&seritem=" + seritem + "&page_no=" + page_no + "&page_num=" + page_num;
}

function gotopage() {
   var servehicleid = document.getElementById("servehicleid").value;
   var seraccount = document.getElementById("seraccount").value;
   var seritem = document.getElementById("seritem").value;
   var page_no = Number(document.getElementById("go_page_no").value);
   var tot_page = Number(document.getElementById("tot_page").value);
   if(page_no > tot_page) {
      page_no = tot_page;
   } else if(page_no <= 0) {
      page_no = 1;
   }
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/alarm/ServiceAlarm.page?servehicleid=" + servehicleid + "&seraccount=" + seraccount + "&seritem=" + seritem + "&page_no=" + page_no + "&page_num=" + page_num;
}

function reset() {
   document.getElementById("serdeviceid").value = "";
   document.getElementById("seraccount").value = "";
   document.getElementById("seritem").value = "";
}

</script>
</html>



<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
      <link href="<%=path %>/css/toolbars.css" rel="stylesheet" type="text/css"  media="all"/>      
      <style type="text/css">
         html, body {
            margin: 0px 0px;
            width: 100%;
            height: 100%;
            background: #E6EAE9;
         }
         iframe {
            margin: 0px 0px;
            width: 100%;
            height: 100%;
         }
         #div_list{
            height:auto;
         }
      </style>
   
   </head>
  
   <body>  
      <br/>  
      <div>
         <form id="serform" action="<%=path%>/jsp/statisanaly/DeviceInf.page"  method="post">
            <table style="border-collapse:collapse;border-spacing:0;">
               <tr>
                  <td style="text-align:right;">机号</td>
                  <td><input id="servehicleid" onmouseover="this.style.border='1px solid green'" onmouseout="this.style.border=''" name="servehicleid" type="text" value="${ servehicleid }"/></td>
                  <td style="text-align:right;">设备号</td>
                  <td><input id="serdeviceid" onmouseover="this.style.border='1px solid green'" onmouseout="this.style.border=''" name="serdeviceid" type="text" value="${ serdeviceid }"/></td>
                  <td>
                     <input id="type" name="type" type="hidden" value="${ type }"/>
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
                              <th scope="col" abbr="序号">序号</th>
                              <th scope="col" abbr="机号">机号</th>
                              <th scope="col" abbr="设备号">设备号</th>
                              <th scope="col" abbr="机型">机型</th>
                              <th scope="col" abbr="机型">机械种类</th>
                              <th scope="col" abbr="最终用户">最终用户</th>
                              <th scope="col" abbr="SIM卡号">SIM卡号</th>
                           </tr>
                           
                           <c:if test="${fn:length(vehiclelist)==0}">
                              <tr><td align='center' colspan='10'><font color='red'>无记录</font></td></tr>
                           </c:if>
                           
                           <c:forEach items="${vehiclelist}" var="relation" varStatus="status">
                              <tr>
                                 <td scope="row" abbr="序号">
                                    ${(page_no - 1) * page_num + status.index + 1}
                                 </td>
                                 <td>
                                    <a href="<%=path%>/jsp/statisanaly/${ servletName }.page?deviceid=${ relation.deviceid }&vehicleid=${ relation.vehicleid }" target="imageFrame">${ relation.vehicleid }</a>
                                 </td>
                                 <td>
                                    ${ relation.deviceid }
                                 </td>
                                 <td>
                                    ${ relation.typename }
                                 </td>
                                 <td>
                                    ${ relation.type }
                                 </td>
                                 <td>
                                    ${ relation.ownername }
                                 </td>
                                 <td>
                                    ${ relation.sim }
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
      <iframe id="imageFrame" name="imageFrame" height="100" style="border-top:0px;border-left:1px solid #CCCCFF;border-right:1px solid #CCCCFF;width:99%;height:110%;margin-left:5px;" src=""></iframe>
   </body>
   
<script type="text/javascript">
function gotofirst() {
   var servehicleid = document.getElementById("servehicleid").value;
   var serdeviceid = document.getElementById("serdeviceid").value;
   var type = document.getElementById("type").value;
   var page_no = 1;
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/statisanaly/DeviceInf.page?type=" + type + "&servehicleid=" + servehicleid + "&serdeviceid=" + serdeviceid + "&page_no=" + page_no + "&page_num=" + page_num;
}

function gotoback() {
   var servehicleid = document.getElementById("servehicleid").value;
   var serdeviceid = document.getElementById("serdeviceid").value;
   var type = document.getElementById("type").value;
   var page_no = Number(document.getElementById("page_no").value) - 1;
   if(page_no <= 0) {
      page_no = 1;
   }
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/statisanaly/DeviceInf.page?type=" + type + "&servehicleid=" + servehicleid + "&serdeviceid=" + serdeviceid + "&page_no=" + page_no + "&page_num=" + page_num;
}

function gotonext() {
   var servehicleid = document.getElementById("servehicleid").value;
   var serdeviceid = document.getElementById("serdeviceid").value;
   var type = document.getElementById("type").value;
   var page_no = Number(document.getElementById("page_no").value) + 1;
   var tot_page = Number(document.getElementById("tot_page").value);
   if(page_no > tot_page) {
      page_no = tot_page;
   }
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/statisanaly/DeviceInf.page?type=" + type + "&servehicleid=" + servehicleid + "&serdeviceid=" + serdeviceid + "&page_no=" + page_no + "&page_num=" + page_num;
}

function gotolast() {
   var servehicleid = document.getElementById("servehicleid").value;
   var serdeviceid = document.getElementById("serdeviceid").value;
   var type = document.getElementById("type").value;
   var page_no = document.getElementById("tot_page").value;
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/statisanaly/DeviceInf.page?type=" + type + "&servehicleid=" + servehicleid + "&serdeviceid=" + serdeviceid + "&page_no=" + page_no + "&page_num=" + page_num;
}

function gotopage() {
   var servehicleid = document.getElementById("servehicleid").value;
   var serdeviceid = document.getElementById("serdeviceid").value;
   var type = document.getElementById("type").value;
   var page_no = Number(document.getElementById("go_page_no").value);
   var tot_page = Number(document.getElementById("tot_page").value);
   if(page_no > tot_page) {
      page_no = tot_page;
   } else if(page_no <= 0) {
      page_no = 1;
   }
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/statisanaly/DeviceInf.page?type=" + type + "&servehicleid=" + servehicleid + "&serdeviceid=" + serdeviceid + "&page_no=" + page_no + "&page_num=" + page_num;
}

function reset() {
   document.getElementById("servehicleid").value = "";
   document.getElementById("serdeviceid").value = "";
}

</script>
</html>



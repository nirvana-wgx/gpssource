<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
String path = request.getContextPath();
%>

<!DOCTYPE HTML>
<html>
   <head>
	    
	   <title>车辆保养历史</title>
	    
	   <meta http-equiv="pragma" content="no-cache">
	   <meta http-equiv="cache-control" content="no-cache">
	   <!--
	   <link rel="stylesheet" type="text/css" href="styles.css">
	   -->
	   <link href="<%=path%>/css/toolbars.css" rel="stylesheet" type="text/css" />
	   <link href="<%=path%>/css/common.css" rel="stylesheet" type="text/css" />
	   <script type="text/javascript" src="<%=path%>/plugs/My97DatePicker/WdatePicker.js"></script>
	   
	   <style type="text/css">
	      body { 
	         background: #E6EAE9;
	      }
	      #div_list{
	         height:auto;
	      }
	   </style>
	   
   </head>
  
   <body>
      <div>
         
	      <form id="serform" action="<%=path%>/jsp/vechiclemanager/singlevehicle/MaintenaceInfo.page?type=2"  method="post">
	         <input id="deviceid" name="deviceid" type="hidden" value="${ deviceid }"/>
	         <table style="border-collapse:collapse;border-spacing:0;">
	            <tr>
<!-- 	               <td style="text-align:right;">车辆编号</td> -->
<!-- 	               <td style="text-align:left;"> -->
<!-- 	                  <input id="vehicleid" name="vehicleid" type="text" onmouseover="this.style.border='1px solid green'" onmouseout="this.style.border=''"/> -->
<!-- 	               </td> -->
	               <td style="text-align:right;">保养配件</td>
	               <td style="text-align:left;">
	                  <input id="fitting" name="fitting" type="text" onmouseover="this.style.border='1px solid green'" onmouseout="this.style.border=''"/>
	               </td>
	               <td style="text-align:right;">保养日期</td>
	               <td style="text-align:left;">
	                  <input class="Wdate" type="text" id="maintenancedate" onmouseover="this.style.border='1px solid green'" onmouseout="this.style.border=''" name="maintenancedate" value="${ maintenancedate }" onFocus="WdatePicker({isShowClear:false,readOnly:false})"/>
	               </td>
<!-- 	               <td style="text-align:right;">是否超时</td> -->
<!-- 	               <td> -->
<!-- 	                  <select id="isovertime" name="isovertime" onmouseover="this.style.border='1px solid green'" onmouseout="this.style.border=''"> -->
<!-- 	                     <option value="" -->
<!--                               <c:if test="${ isovertime == '' || isovertime == null }"> -->
<!--                                  selected -->
<!--                               </c:if> -->
<!--                            >不限 -->
<!--                         </option> -->
<!--                         <option value="0" -->
<!--                               <c:if test="${ isovertime == '0' }"> -->
<!--                                  selected -->
<!--                               </c:if> -->
<!--                             >否 -->
<!--                          </option> -->
<!--                         <option value="1" -->
<!--                               <c:if test="${ isovertime == '1' }"> -->
<!--                                  selected -->
<!--                               </c:if> -->
<!--                            >是 -->
<!--                         </option> -->
<!-- 	                  </select> -->
<!-- 	               </td> -->
	               <td>
	                  <a href="javascript:document.forms['serform'].submit();" onclick="" id="btn_add"> <span
	                     class="toolbar_btn"><span
	                        class="toolbar_btn_ico toolbar_btn_search">查询</span></span></a>
	                  <a href="javascript:void(0)" onclick="reset();" id="btn_add"><span
	                     class="toolbar_btn"><span
	                        class="toolbar_btn_ico toolbar_btn_clear">重置</span>
	                  </span></a>
	               </td>
	            </tr>
	         </table>
	   
	         <table style="border-collapse:collapse;border-spacing:0;">
	            <tr>
	               <td class="left" colspan="99" style="height:20px;border-bottom:0px;">
	                  <a href="javascript:exportExcel();">导出</a>&nbsp;&nbsp;&nbsp;&nbsp;
	               </td>
	            </tr>
	            <tr>
	               <td colspan="99" style="border-bottom:0px;">
	                  <div id="div_list">
	                     <table id="tab_list" style="border-collapse:collapse;border-spacing:0;">
	                        <tr>
	                           <th scope="col" abbr="序号" style="border-left:0px;">序号</th>
	                           <th scope="col" abbr="机号">机号</th>
	                           <th scope="col" abbr="保养配件">保养配件</th>
	                           <th scope="col" abbr="预警时间">预警日期</th>
	                           <th scope="col" abbr="保养时间">保养日期</th>
	                           <th scope="col" abbr="保养动作">保养动作</th>
	                           <th scope="col" abbr="保养完成日期">保养完成日期</th>
<!-- 	                           <th scope="col" abbr="是否超时">是否超时</th> -->
	                           <th scope="col" abbr="备注" style="border-right:0px;">备注</th>
	                        </tr>
	                        
	                        <c:if test="${fn:length(maintenancelist)==0}">
	                           <tr><td align='center' colspan='10' style="border-left:0px;border-right:0px;"><font color='red'>无记录</font></td></tr>
	                        </c:if>
	                        
	                        <c:forEach items="${maintenancelist}" var="maintenance" varStatus="status">
	                           <tr>
	                              <th scope="row" abbr="序号" style="border-left:0px;">
	                                 ${(page_no - 1) * page_num + status.index + 1}
	                              </th>
	                              <td>
	                                 ${ maintenance.vehicleid }
	                              </td>
	                              <td>
	                                 ${ maintenance.fitting }
	                              </td>
	                              <td>
	                                 <fmt:formatDate value="${ maintenance.expiretime }" pattern="yyyy年MM月dd日"/>
	                              </td>
	                              <td>
	                                 <fmt:formatDate value="${ maintenance.maintenancetime }" pattern="yyyy年MM月dd日"/>
	                              </td>
	                              <td>
	                                 ${ maintenance.action }
	                              </td>
	                              <td>
                                    <fmt:formatDate value="${ maintenance.finishtime }" pattern="yyyy年MM月dd日"/>
                                 </td>
<!-- 	                              <td> -->
<!-- 	                                 <c:if test="${ maintenance.isovertime == 0}">否</c:if> -->
<!-- 	                                 <c:if test="${ maintenance.isovertime == 1}">是</c:if> -->
<!-- 	                              </td> -->
	                              <td style="border-right:0px;">
	                                 ${ maintenance.remark }
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
      var deviceid = document.getElementById("deviceid").value;
      var fitting = document.getElementById("fitting").value;
      var maintenancedate = document.getElementById("maintenancedate").value;
//       var isovertime = document.getElementById("isovertime").value;
      var page_no = 1;
      var page_num = document.getElementById("page_num").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/MaintenaceInfo.page?type=2" + "&deviceid=" + deviceid + "&fitting=" + fitting + "&maintenancedate=" + maintenancedate + "&isovertime="+ "&page_no=" + page_no + "&page_num=" + page_num;
   }
   
   function gotoback() {
      var deviceid = document.getElementById("deviceid").value;
      var fitting = document.getElementById("fitting").value;
      var maintenancedate = document.getElementById("maintenancedate").value;
//       var isovertime = document.getElementById("isovertime").value;
      var page_no = Number(document.getElementById("page_no").value) - 1;
      if(page_no <= 0) {
         page_no = 1;
      }
      var page_num = document.getElementById("page_num").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/MaintenaceInfo.page?type=2" + "&deviceid=" + deviceid + "&fitting=" + fitting + "&maintenancedate=" + maintenancedate + "&isovertime="+ "&page_no=" + page_no + "&page_num=" + page_num;
   }
   
   function gotonext() {
      var deviceid = document.getElementById("deviceid").value;
      var fitting = document.getElementById("fitting").value;
      var maintenancedate = document.getElementById("maintenancedate").value;
//       var isovertime = document.getElementById("isovertime").value;
      var page_no = Number(document.getElementById("page_no").value) + 1;
      var tot_page = Number(document.getElementById("tot_page").value);
      if(page_no > tot_page) {
         page_no = tot_page;
      }
      var page_num = document.getElementById("page_num").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/MaintenaceInfo.page?type=2" + "&deviceid=" + deviceid + "&fitting=" + fitting + "&maintenancedate=" + maintenancedate + "&isovertime="+ "&page_no=" + page_no + "&page_num=" + page_num;
   }
   
   function gotolast() {
      var deviceid = document.getElementById("deviceid").value;
      var fitting = document.getElementById("fitting").value;
      var maintenancedate = document.getElementById("maintenancedate").value;
//       var isovertime = document.getElementById("isovertime").value;
      var page_no = document.getElementById("tot_page").value;
      var page_num = document.getElementById("page_num").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/MaintenaceInfo.page?type=2" + "&deviceid=" + deviceid + "&fitting=" + fitting + "&maintenancedate=" + maintenancedate + "&isovertime="+ "&page_no=" + page_no + "&page_num=" + page_num;
   }
   
   function gotopage() {
      var deviceid = document.getElementById("deviceid").value;
      var fitting = document.getElementById("fitting").value;
      var maintenancedate = document.getElementById("maintenancedate").value;
//       var isovertime = document.getElementById("isovertime").value;
      var page_no = Number(document.getElementById("go_page_no").value);
      var tot_page = Number(document.getElementById("tot_page").value);
      if(page_no > tot_page) {
         page_no = tot_page;
      } else if(page_no <= 0) {
         page_no = 1;
      }
      var page_num = document.getElementById("page_num").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/MaintenaceInfo.page?type=2" + "&deviceid=" + deviceid + "&fitting=" + fitting + "&maintenancedate=" + maintenancedate + "&isovertime="+ "&page_no=" + page_no + "&page_num=" + page_num;
   }
   
   function reset() {
      document.getElementById("fitting").value = "";
      document.getElementById("maintenancedate").value = "";
//       document.getElementById("isovertime").value = "";
   }
   
   function exportExcel() {
      var deviceid = document.getElementById("deviceid").value;
      var fitting = document.getElementById("fitting").value;
//       var isovertime = document.getElementById("isovertime").value;
      var maintenancedate = document.getElementById("maintenancedate").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/MaintenaceHistoryDownload.page?" + "deviceid=" + deviceid + "&fitting=" + fitting + "&maintenancedate=" + maintenancedate + "&isovertime=";
   }

</script>
</html>

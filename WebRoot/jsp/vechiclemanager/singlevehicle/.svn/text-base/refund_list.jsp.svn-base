<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<link href="<%=path%>/css/toolbars.css" rel="stylesheet" type="text/css" />
        <link href="<%=path%>/css/common.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<%=path%>/plugs/My97DatePicker/WdatePicker.js"></script>
      <style type="text/css">
         #div_list{
            height:auto;
         }
      </style>
	</head>
	<body>
		<div>
		      
		    <form id="serform" action="<%=path%>/jsp/vechiclemanager/singlevehicle/Refund.page"  method="post">
		       <input type="hidden" id="deviceid" name="deviceid" value="${ deviceid }"/>
		       <table style="border-collapse:collapse;border-spacing:0;">
               <tr>
                  <td style="text-align:right;">起始时间：</td>
                  <td>
                     
                     <input type="text" id="serstarttime" name="serstarttime" onmouseover="this.style.border='1px solid green'" onmouseout="this.style.border=''" class="Wdate" id="d412" onFocus="WdatePicker({isShowClear:false,readOnly:false,dateFmt:'yyyy-MM-dd'})" value="${ serstarttime }"/>
                  </td>
                  <td style="text-align:right;">结束时间：</td>
                  <td>
                     <input type="text" id="serendtime" name="serendtime" onmouseover="this.style.border='1px solid green'" onmouseout="this.style.border=''" class="Wdate" id="d412" onFocus="WdatePicker({isShowClear:false,readOnly:false,dateFmt:'yyyy-MM-dd'})" value="${ serendtime }"/>
                  </td>
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
                  <td class="left" colspan="99" style="height:20px;border-bottom:0px;text-algin:rigth">
                     <a href="javascript:exportExcel();">导出</a>&nbsp;&nbsp;&nbsp;&nbsp;
                  </td>
               </tr>
               <tr>
                  <td colspan="99" style="border-bottom:0px;">
                     <div id="div_list">
                        <table id="tab_list" style="border-collapse:collapse;border-spacing:0;">
                           <tr>
                              <th scope="col" abbr="序号" style="border-left:0px;">序号</th>
                              <th scope="col" abbr="还款金额">还款金额(元)</th>
                              <th scope="col" abbr="还款时间">还款时间</th>
                              <th scope="col" abbr="剩余金额" style="border-right:0px;">剩余金额(元)</th>
                           </tr>
                           
                           <c:if test="${fn:length(refundlist)==0}">
                              <tr><td align='center' colspan='10' style="border-left:0px;border-right:0px;"><font color='red'>无记录</font></td></tr>
                           </c:if>
                           
                           <c:forEach items="${refundlist}" var="refund" varStatus="status">
                              <tr>
                                 <th scope="row" abbr="序号" style="border-left:0px;">
                                    ${(page_no - 1) * page_num + status.index + 1}
                                 </th>
                                 <td>
                                    ${ refund.refundmoney }
                                 </td>
                                 <td>
                                    ${ refund.refundtime }
                                 </td>
                                 <td style="border-right:0px;">
                                    ${ refund.remainmoney }
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
   var serstarttime = document.getElementById("serstarttime").value;
   var serendtime = document.getElementById("serendtime").value;
   var page_no = 1;
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/Refund.page?" + "&deviceid=" + deviceid + "&serstarttime=" + serstarttime + "&serendtime=" + serendtime + "&page_no=" + page_no + "&page_num=" + page_num;
}

function gotoback() {
   var deviceid = document.getElementById("deviceid").value;
   var serstarttime = document.getElementById("serstarttime").value;
   var serendtime = document.getElementById("serendtime").value;
   var page_no = Number(document.getElementById("page_no").value) - 1;
   if(page_no <= 0) {
      page_no = 1;
   }
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/Refund.page?" + "&deviceid=" + deviceid + "&serstarttime=" + serstarttime + "&serendtime=" + serendtime + "&page_no=" + page_no + "&page_num=" + page_num;
}

function gotonext() {
   var deviceid = document.getElementById("deviceid").value;
   var serstarttime = document.getElementById("serstarttime").value;
   var serendtime = document.getElementById("serendtime").value;
   var page_no = Number(document.getElementById("page_no").value) + 1;
   var tot_page = Number(document.getElementById("tot_page").value);
   if(page_no > tot_page) {
      page_no = tot_page;
   }
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/Refund.page?" + "&deviceid=" + deviceid + "&serstarttime=" + serstarttime + "&serendtime=" + serendtime + "&page_no=" + page_no + "&page_num=" + page_num;
}

function gotolast() {
   var deviceid = document.getElementById("deviceid").value;
   var serstarttime = document.getElementById("serstarttime").value;
   var serendtime = document.getElementById("serendtime").value;
   var page_no = document.getElementById("tot_page").value;
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/Refund.page?" + "&deviceid=" + deviceid + "&serstarttime=" + serstarttime + "&serendtime=" + serendtime + "&page_no=" + page_no + "&page_num=" + page_num;
}

function gotopage() {
   var deviceid = document.getElementById("deviceid").value;
   var serstarttime = document.getElementById("serstarttime").value;
   var serendtime = document.getElementById("serendtime").value;
   var page_no = Number(document.getElementById("go_page_no").value);
   var tot_page = Number(document.getElementById("tot_page").value);
   if(page_no > tot_page) {
      page_no = tot_page;
   } else if(page_no <= 0) {
      page_no = 1;
   }
   var page_num = document.getElementById("page_num").value;
   window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/Refund.page?" + "&deviceid=" + deviceid + "&serstarttime=" + serstarttime + "&serendtime=" + serendtime + "&page_no=" + page_no + "&page_num=" + page_num;
}

function reset() {
   document.getElementById("serendtime").value = "";
   document.getElementById("serstarttime").value = "";
}

function exportExcel() {
   var deviceid = document.getElementById("deviceid").value;
   var serstarttime = document.getElementById("serstarttime").value;
   var serendtime = document.getElementById("serendtime").value;
   window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/RefundDownload.page?" + "&deviceid=" + deviceid + "&serstarttime=" + serstarttime + "&serendtime=" + serendtime;
}
</script>
</html>

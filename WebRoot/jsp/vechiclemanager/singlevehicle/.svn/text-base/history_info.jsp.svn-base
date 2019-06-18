<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
String path = request.getContextPath();
%>

<!DOCTYPE html>
<html>
   <head>
    
      <title>车辆历史信息</title>
    
      <meta http-equiv="pragma" content="no-cache">
      <meta http-equiv="cache-control" content="no-cache">
      <!--
      <link rel="stylesheet" type="text/css" href="styles.css">
      -->
      <link href="<%=path %>/css/toolbars.css" rel="stylesheet" type="text/css" />
      <link rel="stylesheet" href="<%=path%>/css/layout.css" type="text/css" media="all" />
      <link rel="stylesheet" href="<%=path%>/css/common.css" type="text/css" media="all" />
      <script src="<%=path%>/scripts/jquery-laster.js"></script>
      <script src="<%=path%>/scripts/jquery.utils.js"></script>
      <script src="<%=path%>/scripts/jquery.ui.tab.js"></script>
      <script type="text/javascript" src="<%=path%>/plugs/My97DatePicker/WdatePicker.js"></script>
      <script type="text/javascript">
         $(function() {      
            $('.tabs_wrapper').tab('init');
         });
      </script>
      <style type="text/css">
         html, body {
            margin: 0px 0px;
            width: 100%;
            height: 100%;
            background: #E6EAE9;
         }
         .tabs_group {
            margin-top: 0px;
            width:100%;
         }
         #div_list{
            height:auto;
         }
      </style>
   </head>
  
   <body>
      <!-- ======================= demo .content_header ======================= -->
      <div class="content_header" style="border:0px;width:100%;margin-left:0px;">
         <!-- 标签封装 -->
         <div class="tabs_wrapper" style="border:0px;width:100%;margin-left:0px;">
            <div class="tabs_group_container" style="border:0px;width:100%;margin-left:0px;">
               <!-- 标签组 -->
               <ul class="tabs_group">
                  <!-- 当前选中的标签 -->
                     <li 
                        <c:if test="${ historytype == 1 }">
                           class="tabs_actived"
                        </c:if>
                     >
                        <form id="form1" action="<%=path%>/jsp/vechiclemanager/singlevehicle/HistoryInf.page?historytype=1&deviceid=${ deviceid }" method="post">
                        <a href="javascript:document.forms['form1'].submit();"><span class="tabs_icons">车辆数据</span></a>
                        </form>
                        </li>
                        
                     <!-- 未选中的标签 -->
                     <li style="list-style-type:none;"
                        <c:if test="${ historytype == 2 }">
                           class="tabs_actived"
                        </c:if>
                     >
                     <form id="form2" action="<%=path%>/jsp/vechiclemanager/singlevehicle/HistoryInf.page?historytype=2&deviceid=${ deviceid }" method="post">
                        <a href="javascript:document.forms['form2'].submit();"><span class="tabs_icons">指令数据</span></a>
                     </form>
                     </li>
               </ul>
            </div> <!-- .tabs_group_container end -->
         </div> <!-- .tabs_wrapper end -->
      </div><!-- demo .content_header end -->
      <br/>      
      <div style="width:98%;margin-left:1%;">
         <form id="serform" action="<%=path%>/jsp/vechiclemanager/singlevehicle/HistoryInf.page"  method="post">
            <input type="hidden" name="deviceid" id="deviceid" value="${ deviceid }"/>
            <input type="hidden" name="historytype" id="historytype" value="${ historytype }"/>
            <table style="border-collapse:collapse;border-spacing:0;">
               <tr>
                  <td style="text-align:right;">起始时间：</td>
                  <td>
                     <input type="text" id="serstarttime" name="serstarttime" onmouseover="this.style.border='1px solid green'" onmouseout="this.style.border=''" class="Wdate" id="d412" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'1900-03-08 11:30:00',maxDate:'2100-03-10 20:59:30'})" value="${ serstarttime }"/>
                  </td>
                  <td style="text-align:right;">结束时间：</td>
                  <td>
                     <input type="text" id="serendtime" name="serendtime" onmouseover="this.style.border='1px solid green'" onmouseout="this.style.border=''" class="Wdate" id="d412" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'1900-03-08 11:30:00',maxDate:'2100-03-10 20:59:30'})" value="${ serendtime }"/>
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
               <tr>
                  <td class="left" colspan="99" style="height:14px;border-bottom:0px;"></td>
               </tr>
               <tr>
            </table>
      
<!--             <table style="border-collapse:collapse;border-spacing:0; -->
<!--                <c:if test="${ historytype == 2 }"> -->
<!--                   display:none; -->
<!--                </c:if> -->
<!--             "> -->
<!--                <tr> -->
<!--                   <td class="left" colspan="99" style="height:14px;border-bottom:0px;"></td> -->
<!--                </tr> -->
<!--                <tr> -->
<!--                   <td colspan="99" style="border-bottom:0px;"> -->
                     <div id="div_list" style="overflow:auto;height:auto;width:99.9%;border:0px;border-right: 1px solid #CCCCFF;
                        <c:if test="${ historytype == 2 }">
                           display:none;
                        </c:if>
                     ">
                        <table id="tab_list" style="width:2000px;border-collapse:collapse;border-spacing:0;">
                           <tr>
                              <th scope="col" abbr="序号" style="border-left:0px;width:auto;">序号</th>
                              <th scope="col" abbr="接收时间">接收时间</th>
                              <th scope="col" abbr="命令码">命令码</th>
                              <th scope="col" abbr="SIM卡" style="border-right:0px;">SIM卡</th>
                           </tr>
                           
                           <c:if test="${fn:length(messageoriginlist)==0}">
                              <tr><td align='center' colspan='10' style="border-left:0px;border-right:0px;"><font color='red'>无记录</font></td></tr>
                           </c:if>
                           
                           <c:forEach items="${messageoriginlist}" var="messageorigin" varStatus="status">
                              <tr>
                                 <th scope="row" abbr="序号" style="border-left:0px;width:auto;">
                                    ${(page_no - 1) * page_num + status.index + 1}
                                 </th>
                                 <td>
                                    <fmt:formatDate value="${ messageorigin.receivetime }" pattern="yyyy-MM-dd HH:mm:ss"/>
                                 </td>
                                 <td>
                                    ${ messageorigin.message }
                                 </td>
                                 <td style="border-right:0px;">
                                    ${ messageorigin.sim }
                                 </td>
                              </tr>
                           </c:forEach>
                        </table>
                     </div>
            
<!--                   </td> -->
<!--                </tr> -->
            <table style="border-collapse:collapse;border-spacing:0;
               <c:if test="${ historytype == 2 }">
                  display:none;
               </c:if>
            ">
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
            
            
            <table style="border-collapse:collapse;border-spacing:0;
               <c:if test="${ historytype == 1 }">
                  display:none;
               </c:if>
            ">
               <tr>
                  <td colspan="99" style="border-bottom:0px;">
                     <div id="div_list">
                        <table id="tab_list" style="border-collapse:collapse;border-spacing:0;">
                           <tr>
                              <th scope="col" abbr="序号" style="border-left:0px;">序号</th>
                              <th scope="col" abbr="命令码">命令码</th>
                              <th scope="col" abbr="信息备注">信息备注</th>
                              <th scope="col" abbr="发送时间">发送时间</th>
                              <th scope="col" abbr="发送状态">发送状态</th>
                              <th scope="col" abbr="用户" style="border-right:0px;">用户</th>
                           </tr>
                           
                           <c:if test="${fn:length(commandoriginlist)==0}">
                              <tr><td align='center' colspan='10' style="border-right:0px;border-left:0px;"><font color='red'>无记录</font></td></tr>
                           </c:if>
                           
                           <c:forEach items="${commandoriginlist}" var="commandorigin" varStatus="status">
                              <tr>
                                 <th scope="row" abbr="序号" style="border-left:0px;">
                                    ${(page_no - 1) * page_num + status.index + 1}
                                 </th>
                                 <td style="border-left:0px;">
                                    ${ commandorigin.command }
                                 </td>
                                 <td>
                                    ${ commandorigin.description }
                                 </td>
                                 <td>
                                    <fmt:formatDate value="${ commandorigin.sendtime }" pattern="yyyy-MM-dd HH:mm:ss"/>
                                 </td>
                                 <td>
                                    ${ commandorigin.state }
                                 </td>
                                 <td style="border-right:0px;">
                                    ${ commandorigin.username }
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
      var historytype = document.getElementById("historytype").value;
      var serstarttime = document.getElementById("serstarttime").value;
      var serendtime = document.getElementById("serendtime").value;
      var page_no = 1;
      var page_num = document.getElementById("page_num").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/HistoryInf.page?deviceid=" + deviceid + "&historytype=" + historytype + "&serstarttime=" + serstarttime + "&serendtime=" + serendtime + "&page_no=" + page_no + "&page_num=" + page_num;
   }
   
   function gotoback() {
      var deviceid = document.getElementById("deviceid").value;
      var historytype = document.getElementById("historytype").value;
      var serstarttime = document.getElementById("serstarttime").value;
      var serendtime = document.getElementById("serendtime").value;
      var page_no = Number(document.getElementById("page_no").value) - 1;
      if(page_no <= 0) {
         page_no = 1;
      }
      var page_num = document.getElementById("page_num").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/HistoryInf.page?deviceid=" + deviceid + "&historytype=" + historytype + "&serstarttime=" + serstarttime + "&serendtime=" + serendtime + "&page_no=" + page_no + "&page_num=" + page_num;
   }
   
   function gotonext() {
      var deviceid = document.getElementById("deviceid").value;
      var historytype = document.getElementById("historytype").value;
      var serstarttime = document.getElementById("serstarttime").value;
      var serendtime = document.getElementById("serendtime").value;
      var page_no = Number(document.getElementById("page_no").value) + 1;
      var tot_page = Number(document.getElementById("tot_page").value);
      if(page_no > tot_page) {
         page_no = tot_page;
      }
      var page_num = document.getElementById("page_num").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/HistoryInf.page?deviceid=" + deviceid + "&historytype=" + historytype + "&serstarttime=" + serstarttime + "&serendtime=" + serendtime + "&page_no=" + page_no + "&page_num=" + page_num;
   }
   
   function gotolast() {
      var deviceid = document.getElementById("deviceid").value;
      var historytype = document.getElementById("historytype").value;
      var serstarttime = document.getElementById("serstarttime").value;
      var serendtime = document.getElementById("serendtime").value;
      var page_no = document.getElementById("tot_page").value;
      var page_num = document.getElementById("page_num").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/HistoryInf.page?deviceid=" + deviceid + "&historytype=" + historytype + "&serstarttime=" + serstarttime + "&serendtime=" + serendtime + "&page_no=" + page_no + "&page_num=" + page_num;
   }
   
   function gotopage() {
      var deviceid = document.getElementById("deviceid").value;
      var historytype = document.getElementById("historytype").value;
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
      window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/HistoryInf.page?deviceid=" + deviceid + "&historytype=" + historytype + "&serstarttime=" + serstarttime + "&serendtime=" + serendtime + "&page_no=" + page_no + "&page_num=" + page_num;
   }
   
   function reset() {
      document.getElementById("serendtime").value = "";
      document.getElementById("serstarttime").value = "";
      document.getElementById("maintenancedate").value = "";
      document.getElementById("isovertime").value = "";
   }

</script>
</html>

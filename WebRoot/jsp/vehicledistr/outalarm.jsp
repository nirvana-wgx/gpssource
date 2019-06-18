<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>越界报警列表</title>
    
   <meta http-equiv="pragma" content="no-cache">
   <meta http-equiv="cache-control" content="no-cache">
   <!--
   <link rel="stylesheet" type="text/css" href="styles.css">
   -->
   <link href="<%=basePath%>/css/toolbars.css" rel="stylesheet" type="text/css" />
   
   <link href="<%=path%>/css/common.css" rel="stylesheet" type="text/css" />
   
  </head>
  
  <body>    
    <div style="width:99%;margin-left:5px;">
      <form id="serform" action="<%=basePath%>jsp/statisanaly/DeviceInf.page?type=${ type }" method="post">
         <table cellspacing="0">
            <tr>
               <th colspan='99' align="left">查询条件：</th>
            </tr>
            <tr>
               <td>机号</td>
               <td><input type="text"/></td>
               <td>设备号</td>
               <td><input type="text"/></td>
               <td>
                  <a href="javascript:void(0)" onclick="" id="btn_add"> <span
                                class="toolbar_btn"><span
                                    class="toolbar_btn_ico toolbar_btn_search">查询</span></span></a>
                            <a href="javascript:void(0)" onclick="" id="btn_add"><span
                                class="toolbar_btn"><span
                                    class="toolbar_btn_ico toolbar_btn_clear">重置</span>
                            </span></a>
               </td>
            </tr>
         </table>
       
      <table id="mytable" cellspacing="0">
        <tr><td colspan="99">
                <div id="div_list">
                <table id="tab_list" cellspacing="0">
                <tr>
                    <th>
                        序号
                    </th>
                    <th>
                        机号
                    </th>
                    <th>
                        设备号
                    </th>
                    <th>
                        机型
                    </th>
                    <th>
                        机械种类
                    </th>
                    <th>
                        最终用户
                    </th>
                    <th>
                        报警时间
                    </th>
                    <th>
                        数据时间
                    </th>
            
                </tr>
                <c:if test="${fn:length(vehiclelist)==0}">
                    <tr><td align='center' colspan='10' style="border-left:0px;border-right:0px;"><font color='red'>无记录</font></td></tr>
                </c:if>
                           
                <c:forEach items="${vehiclelist}" var="relation" varStatus="status">
                <tr>
                    <c:choose>
                        <c:when test="${status.index%2 == 0}">
                            <th scope="row" abbr="序号" class="spec" style="border-left:0px;">${status.index + 1}</th>
                        </c:when>
                        <c:otherwise>
                            <th scope="row" abbr="序号" class="specalt" style="border-left:0px;">${status.index + 1}</th>
                        </c:otherwise>
                    </c:choose>
                    <td <c:if test="${status.index%2 == 1}">class="alt"</c:if>>
                        ${ outlist.vehicleid }
                    </td>
                    <td <c:if test="${status.index%2 == 1}">class="alt"</c:if>>
                        ${ outlist.deviceid }
                    </td>
                    <td <c:if test="${status.index%2 == 1}">class="alt"</c:if>>
                        ${ outlist.type }
                    </td>
                    <td <c:if test="${status.index%2 == 1}">class="alt"</c:if>>
                        ${ outlist.model }
                    </td>
                    <td <c:if test="${status.index%2 == 1}">class="alt"</c:if>>
                        ${ outlist.ownername }
                    </td>
                    <td <c:if test="${status.index%2 == 1}">class="alt"</c:if> style="border-right:0px;">
                        ${ outlist.alarmtime }
                    </td>
                    <td <c:if test="${status.index%2 == 1}">class="alt"</c:if> style="border-right:0px;">
                        ${ outlist.creattime }
                    </td>
                </tr>
                </c:forEach>
                </table>
                </div>
                </td></tr>
         
         <tr>
                     <td colspan="99" class="jpaginate">
                        <a href="#"><img src="<%=path%>/images/sprevious.png" /></a>
                        <a href="#"><img src="<%=path%>/images/previous.png" /></a>
                        <span>第<input type="text" value="1" />页/22页</span>
                        <a href="#"><img src="<%=path%>/images/next.png" /></a>
                        <a href="#"><img src="<%=path%>/images/snext.png" /></a> 
                        <span>每页<input type="text" value="15" />条</span>
                        <a href="#"><img src="<%=path%>/images/Refresh.gif"/></a> </td>
                </tr>
      </table>
      </form>
    </div>
  </body>
</html>

<script type="text/javascript">

   function reset() {
      document.getElementById("servehicleid").value = "";
      document.getElementById("serdeviceid").value = "";
   }
</script>

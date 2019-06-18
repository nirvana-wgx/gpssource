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
    
      <title>快速查询</title>
    
      <meta http-equiv="pragma" content="no-cache">
      <meta http-equiv="cache-control" content="no-cache">
      <!--
      <link rel="stylesheet" type="text/css" href="styles.css">
      -->
      <link href="<%=path %>/css/toolbars.css" rel="stylesheet" type="text/css" />
      <link href="<%=path %>/css/common.css" rel="stylesheet" type="text/css" />
      <script type="text/javascript" src="<%=path %>/plugs/My97DatePicker/WdatePicker.js"></script>
      <style type="text/css">
         body { background: #E6EAE9; }
         fieldset { background: #FFFFFF }
         .dis_none {border: 0 none;color: red;margin-top: 5px;text-align: center;}
         .state{clear:both;margin-left:16%;margin-top:20px; overflow:hidden;padding:5px 0 ;width:750px;font-size:12px;border:0px;}
	      .state ul li{list-style:none;float:left;width:72px;height:28px;padding:6px 8px 7px 5px; line-height:14px;text-align:center;font-size:12px;background:#FFFFFF}
	      .state ul li.normal{background:url(<%=path %>/images/state_grey.gif) no-repeat left top;color:#5a646e; }
	      .state ul li.normal span{ display:block;color:#333; font-weight:bold;margin-left: 20px;}
	      .state ul li.warning{background:url(<%=path %>/images/state_red.gif) no-repeat left top;color:#000; }
	      .state ul li.warning span{ display:block;color:#000; font-weight:bold;margin-left: 20px;}
	      .state ul li.on{background:url(<%=path %>/images/state_green.gif) no-repeat left top;color:#000; }
	      .state ul li.on span{ display:block;color:#000; font-weight:bold;margin-left: 20px;}
	      .state2{clear:both;border:0px;margin-left:23%;margin-top:5px; overflow:hidden;padding:5px;width:580px;text-align:center;font-size:12px;}
	      .state2 ul li{list-style:none;float:left;width:72px;height:28px;padding:6px 8px 7px 5px; line-height:14px;text-align:center; }
	      .state2 ul li.normal{background:url(<%=path %>/images/state_grey.gif) no-repeat left top;color:#5a646e; }
	      .state2 ul li.normal span{ display:block;color:#333; font-weight:bold;margin-right:0px;}
	      .state2 ul li.warning{background:url(<%=path %>/images/state_red.gif) no-repeat left top;color:#000; }
	      .state2 ul li.warning span{ display:block;color:#000; font-weight:bold;margin-right:0px;}
	      .state2 ul li.on{background:url(<%=path %>/images/state_green.gif) no-repeat left top;color:#000; }
	      .state2 ul li.on span{ display:block;color:#000; font-weight:bold;margin-right:0px;}
         td { border:1px solid #CCCCFF;text-align:center; }
         th { border:1px solid #CCCCFF;background: #f5fafa;font-size: 12px;padding: 0px;margin:0px;color: #5C5C5C;font-weight: bloder;}
      </style>
   </head>
  
   <body>
      <fieldset>
         <legend>快速查询条件</legend>
         <form id="form1" action="<%=path %>/jsp/vechiclemanager/singlevehicle/FastTips.page" method="post">
            <input type="hidden" name="deviceid" value="${ deviceid }"/>
            <table style="border-collapse:collapse;border-spacing:0;">
               <tr>
                  <td style="text-align:right;">时间</td>
                  <td style="text-align:left;">
                     <input type="text" id="serchdate" name="serchdate" class="Wdate" style="width:160px" id="d412" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'1900-03-08 11:30:00',maxDate:'2100-03-10 20:59:30'})" value="${ serchdate }"/>
                  </td>
                  <td>
                     <a href="javascript:document.forms['form1'].submit();" onclick="" id="btn_add"> <span
                        class="toolbar_btn"><span
                           class="toolbar_btn_ico toolbar_btn_search">查询</span></span></a>
                     <a href="javascript:void(0)" onclick="reset();" id="btn_add"><span
                        class="toolbar_btn"><span
                           class="toolbar_btn_ico toolbar_btn_clear">重置</span>
                     </span></a>
                  </td>
               </tr>
            </table>
         </form>
      </fieldset>
      <br/>
      <fieldset>
         <legend>详细信息</legend>
         <table style="border-collapse:collapse;border-spacing:0;">
            <tbody>
               <tr>
                  <th colspan='1' style="border-right:1px solid #CCCCFF;">数据采集时间</th>
                  <th colspan='1' style="border-right:1px solid #CCCCFF;border-left:1px solid #CCCCFF;">信息类型</th>
                  <th colspan='2' style="border-right:1px solid #CCCCFF;border-left:1px solid #CCCCFF;">位置</th>
                  <th colspan='1' style="border-left:1px solid #CCCCFF;">工作小时</th>   
               </tr>
               <tr>
                  <td colspan='1' style="color:red;font-weight:bold;"><fmt:formatDate value="${ messagebm.collecttime }" pattern="yyyy年MM月dd日  HH:mm:ss"/></td>
                  <td colspan='1'>${ messagebm.infotype }</td>
                  <td colspan='2'>${ messagebm.positioninfo }</td>
                  <td colspan='1'><b style="color:red">${ messagebm.worktime }</b></td>
               </tr>
               <tr>
                  <th style="border-right:1px solid #CCCCFF;">自锁车状态</th>
                  <th style="border-right:1px solid #CCCCFF;border-left:1px solid #CCCCFF;">锁车状态</th>
                  <th style="border-right:1px solid #CCCCFF;border-left:1px solid #CCCCFF;">冷却水温</th>
                  <th style="border-right:1px solid #CCCCFF;border-left:1px solid #CCCCFF;">液压油温</th>
                  <th style="border-left:1px solid #CCCCFF;">油位</th>
               </tr>
               <tr>
                  <!-- 自锁车状态:参考messagebm.getAutoLockString() -->
                  <td
                     <c:if test="${ AutoLockString != '正常' }">
                        style="font-weight:normal;font-size:12px;"
                     </c:if>
                   >
                     ${ AutoLockString }
                  </td>
                  <!-- 锁车状态：参考messagebm.getLockString() -->
                  <td
                     <c:if test="${ LockString != '正常' }">
                        style="color:red;"
                     </c:if>
                  >
                     ${ LockString }
                  </td>
                  <td>${ messagebm.watertemperature }</td>
                  <td>${ messagebm.oiltemperature }</td>  
                  <td>${ messagebm.oillevel }</td> 
               </tr>
               <tr>
                  <th style="border-right:1px solid #CCCCFF;">电源电压</th>
                  <th style="border-right:1px solid #CCCCFF;border-left:1px solid #CCCCFF;">机油压力</th>
                  <th style="border-right:1px solid #CCCCFF;border-left:1px solid #CCCCFF;">芯片温度</th>
                  <th style="border-right:1px solid #CCCCFF;border-left:1px solid #CCCCFF;">后备电池电压</th>
                  <th style="border-left:1px solid #CCCCFF;">转速</th>   
               </tr>
               <tr>
                  <td>${ messagebm.voltage }</td>
                  <td>${ messagebm.oilpressure }</td>
                  <td>${ messagebm.envtemperature }</td>
                  <td>${ messagebm.backup }</td>
                  <td>${ messagebm.rotaryspeed }</td>    
               </tr>
            </tbody>
         </table>
      </fieldset>
      <br/>
      <fieldset>
         <legend>设备状态详细信息</legend>
         
         <div class="dis_none"
           <c:if test="${ messagebm.deviceid != '' && messagebm.deviceid != null }">
              style="display:none;"
           </c:if>
        >
           当前无数据
        </div>
        
         <div class="state2"
            <c:if test="${ messagebm.deviceid == '' || messagebm.deviceid == null }">
              style="display:none;"
            </c:if>
         >
        <ul>
           <c:choose>
             <c:when test="${ messagebm.carkey == '' || messagebm.carkey == null || messagebm.carkey == '关闭' }">
               <li class="normal" style="list-style-type:none;"><span>车钥匙</span>关闭</li>
             </c:when>
             <c:otherwise>
               <li class="on" style="margin-left:5px;"><span>车钥匙</span>开启</li>
             </c:otherwise>
           </c:choose>

           <c:choose>
               <c:when test="${ messagebm.gpsantenna == '' || messagebm.gpsantenna == null || messagebm.gpsantenna != '正常' }">
                  <li class="warning"><span>GPS天线</span>${ messagebm.gpsantenna }</li>
               </c:when>
               <c:otherwise>
                  <li class="on"><span>GPS天线</span>正常</li>
               </c:otherwise>
           </c:choose>

            <c:choose>
               <c:when test="${ messagebm.gpsshell == '' || messagebm.gpsshell == null || messagebm.gpsshell == '外壳打开' }">
                  <li class="warning"><span>外壳</span>外壳打开</li>
               </c:when>
               <c:otherwise>
                  <li class="on"><span>外壳</span>外壳闭合</li>
               </c:otherwise>
            </c:choose>
            
            <!-- 是否终端报警:参考messagebm.isWarnZDBJ() -->
            <c:choose>
               <c:when test="${ isWarnZDBJ == 1 }">
                  <li class="warning"><span>终端设备</span>报警</li>
               </c:when>
               <c:otherwise>
                  <li class="on"><span>终端设备</span>正常</li>
               </c:otherwise>
            </c:choose>
            
            <c:choose>
               <c:when test="${ fn:substringBefore(messagebm.voltage,'.') < 5 }">
                  <li class="warning"><span>电源电压</span>报警</li>
               </c:when>
               <c:otherwise>
                  <li class="on"><span>电源电压</span>正常</li>
               </c:otherwise>
            </c:choose>
            
            <c:choose>
               <c:when test="${ messagebm.outalarm == 1 }">
                  <li class="warning"><span>越界状态</span>出界报警</li>
               </c:when>
               <c:when test="${ messagebm.outalarm == 2 }">
                  <li class="warning"><span>越界状态</span>入界报警</li>
               </c:when>
               <c:otherwise>
                  <li class="on"><span>越界状态</span>正常</li>
               </c:otherwise>
            </c:choose>
          </ul>
        </div>
        
        
          <div class="state"
             <c:if test="${ messagebm.deviceid == '' || messagebm.deviceid == null }">
                style="display:none;"
             </c:if>
          >
            <ul>  
               <c:choose>
                  <c:when test="${ messagebm.warnys != null && messagebm.warnys == '报警' }">
                     <li class="warning" style="list-style-type:none"><span>油水</span>报警</li>
                  </c:when>
                  <c:otherwise>
                     <li class="on" style="list-style-type:none"><span>油水</span>正常</li>
                  </c:otherwise>
               </c:choose>
                
               <c:choose>
                  <c:when test="${ messagebm.warncd != null && messagebm.warncd == '报警' }">
                     <li class="warning"><span>充电</span>报警</li>
                  </c:when>
                  <c:otherwise>
                     <li class="on"><span>充电</span>正常</li>
                  </c:otherwise>
               </c:choose>
               
               <c:choose>
                  <c:when test="${ messagebm.warnry != null && messagebm.warnry == '报警' }">
                     <li class="warning"><span>油位</span>报警</li>
                  </c:when>
                  <c:otherwise>
                     <li class="on"><span>油位</span>正常</li>
                  </c:otherwise>
               </c:choose>
               
               <c:choose>
                  <c:when test="${ messagebm.warnyy != null && messagebm.warnyy == '报警' }">
                     <li class="warning"><span>油压</span>报警</li>
                  </c:when>
                  <c:otherwise>
                     <li class="on"><span>油压</span>正常</li>
                  </c:otherwise>
               </c:choose>
               
               <c:choose>
                  <c:when test="${ messagebm.warnsw != null && messagebm.warnsw == '报警' }">
                     <li class="warning"><span>水温</span>报警</li>
                  </c:when>
                  <c:otherwise>
                     <li class="on"><span>水温</span>正常</li>
                  </c:otherwise>
               </c:choose>
               
               <c:choose>
                  <c:when test="${ messagebm.warnyw != null && messagebm.warnyw == '报警' }">
                     <li class="warning"><span>油温</span>报警</li>
                  </c:when>
                  <c:otherwise>
                     <li class="on"><span>油温</span>正常</li>
                  </c:otherwise>
               </c:choose>
               
               <c:choose>
                  <c:when test="${ messagebm.warnyl != null && messagebm.warnyl == '报警' }">
                     <li class="warning"><span>油滤</span>报警</li>
                  </c:when>
                  <c:otherwise>
                     <li class="on"><span>油滤</span>正常</li>
                  </c:otherwise>
               </c:choose>
               
               <c:choose>
                  <c:when test="${ messagebm.warnkl != null && messagebm.warnkl == '报警' }">
                     <li class="warning"><span>空滤</span>报警</li>
                  </c:when>
                  <c:otherwise>
                     <li class="on"><span>空滤</span>正常</li>
                  </c:otherwise>
               </c:choose>
               
               
             </ul>
          </div>
      </fieldset>
  <script type="text/javascript">
  function reset() {
   document.getElementById("serchdate").value = "";
}
  </script>
   </body>
</html>

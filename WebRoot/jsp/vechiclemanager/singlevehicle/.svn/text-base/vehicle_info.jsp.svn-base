<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();

%>

<html>
  <head>
    
    <title>车辆基本信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<!-- 	<link href="<%=path %>/css/toolbars.css" rel="stylesheet" type="text/css" /> -->
   <link href="<%=path %>/css/common.css" rel="stylesheet" type="text/css" />
   <script type="text/javascript" src="<%=path %>/scripts/jquery-1.7.1.min.js" > </script>
	
	<style type="text/css">
	   body { background: #E6EAE9; background-image:url(<%=path %>/images/006.jpg) }
      fieldset { background: #FFFFFF;filter:alpha(opacity=70);-moz-opacity: 0.70; opacity: 0.70;  }
      .dis_none {border: 0 none;color: red;margin-top: 20px;text-align: center;}
      .state{clear:both;margin-left:16%;overflow:hidden;padding:5px 0 ;width:700px;font-size:12px;border:0px;}
      .state ul li{list-style:none;float:left;width:72px;height:28px;padding:6px 8px 7px 5px; line-height:14px;text-align:center;font-size:12px;background:#FFFFFF}
      .state ul li.normal{background:url(<%=path %>/images/state_grey.gif) no-repeat left top;color:#5a646e; }
      .state ul li.normal span{ display:block;color:#333; font-weight:bold;margin-left: 20px;}
      .state ul li.warning{background:url(<%=path %>/images/state_red.gif) no-repeat left top;color:#000; }
      .state ul li.warning span{ display:block;color:#000; font-weight:bold;margin-left: 20px;}
      .state ul li.on{background:url(<%=path %>/images/state_green.gif) no-repeat left top;color:#000; }
      .state ul li.on span{ display:block;color:#000; font-weight:bold;margin-left: 20px;}
      .state2{clear:both;border:0px;margin-left:-48px;overflow:hidden;width:106%;text-align:left;font-size:12px;height:90px;}
      .state2 ul li{list-style:none;float:left;width:72px;height:28px;padding:5px 3px 8px 6px;line-height:14px;text-align:center; }
      .state2 ul li.normal{background:url(<%=path %>/images/state_grey.gif) no-repeat left top;color:#5a646e; }
      .state2 ul li.normal span{ display:block;color:#333; font-weight:bold;margin-right:0px;}
      .state2 ul li.warning{background:url(<%=path %>/images/state_red.gif) no-repeat left top;color:#000; }
      .state2 ul li.warning span{ display:block;color:#000; font-weight:bold;margin-right:0px;}
      .state2 ul li.on{background:url(<%=path %>/images/state_green.gif) no-repeat left top;color:#000; }
      .state2 ul li.on span{ display:block;color:#000; font-weight:bold;margin-right:0px;}
   </style>	   
  </head>
  
  <body>
    <!--主休内容 开始-->
    <fieldset>
      <legend>设备详细信息</legend>
      <table id="tab_list">
            <tr>
               <th>机械种类</th>
               <th>机型</th>
               <th>机号</th>
               <th>设备号</th>
               <th>SIM卡号</th>
            </tr>
            <tr>
               <td>${ type_name }</td>
               <td>${ relation.typename }</td>
               <td>${ relation.vehicleid }</td>
               <td>${ relation.deviceid }</td>
               <td>${ relation.sim }</td>
            </tr>
            <tr>
                <th>车辆状态</th>
                <th>所属账号</th>
                <th>最终用户</th>
                <th>联系方式</th>
                <th>录入时间</th>
            </tr>
            <tr>
                <td>${ relation.carstate }</td>
                <td>${ relation.account }</td>
                <td>${ relation.ownername }</td>
                <td>${ relation.ownerphone }</td>
                <td>${ relation.createtime }</td>
            </tr>
        </table>
      </fieldset>
        <br/>
        <fieldset>
        <legend>位置信息</legend>
        <table id="tab_list">
            <tr>
               <th width="10%">定位时间：</th>
               <td width="25%"><b style="color:red;"><fmt:formatDate value="${ messagebm.collecttime }" pattern="yyyy年MM月dd日  HH:mm:ss"/></b></td>
               <th width="8%">经度：</th>
               <td width="17%">${ messagebm.longitude }</td>
               <th width="8%">纬度：</th>
               <td width="17%">${ messagebm.latitude }</td>
               <th width="10%">可用星数：</th>
               <td width="5%">${ messagebm.satelliteusable }</td>
            </tr>
            <tr>
                <th width="10%">位置：</th>
                <td colspan="5">
                     <a class="positionMap" href="javascript:void(0);">
                        ${ messagebm.positioninfo }
                     </a>
                </td>
                <td colspan="2"><a class="positionMap" href="javascript:void(0);"><img style="border:0px;" src="<%=path %>/images/map_button.gif" alt="地图"></a></td>
            </tr>
        </table>
         <!-- 
         <img src="../images/btn_detail02.gif" alt="航片"></a>&nbsp;&nbsp;<a href="#"><img src="../images/btn_detail03.gif" alt="轨迹回放"></a>
          -->
       </fieldset>     
       <br/>  
       <fieldset>
       <legend>数据信息</legend>
       
       <table id="tab_list">
            <tr>
                <th>信息上传时间</th>
                <th>信息类型</th>
                <th>工作小时</th>
                <th>油位</th>
                <th>自锁车状态</th>
                <th>冷却水温</th>
                <th>机油压力</th>
            </tr>
            <tr>
                <td><b style="color:red;"><fmt:formatDate value="${ messagebm.receivetime }" pattern="yyyy年MM月dd日  HH:mm:ss"/></b></td>
                <td>${ messagebm.infotype }</td>
                <td><b style="color:red;">${ messagebm.worktime }</b></td>
                <td>${ messagebm.oillevel }</td>
                
                <!-- 自锁车状态:参考messagebm.getAutoLockString() -->
                <td
                  <c:if test="${ AutoLockString != '正常' }">
                     style="font-weight:normal;font-size:12px;"
                  </c:if>
                >
                  ${ AutoLockString }
                </td>
                <td>${ messagebm.watertemperature }</td>
                <td>${ messagebm.oilpressure }</td>
            </tr>
            <tr>
                <th>数据采集时间</th>
                <th>电源电压</th>
                <th>芯片温度</th>
                <th>转速</th>
                <th>后备电池电压</th>
                <th>锁车状态</th>
                <th>液压油温</th>
            </tr>
            <tr>
                <td><b style="color:red;"><fmt:formatDate value="${ messagebm.collecttime }" pattern="yyyy年MM月dd日  HH:mm:ss"/></b></td>
                <td>${ messagebm.voltage }</td>
                <td>${ messagebm.envtemperature }</td>
                <td>${ messagebm.rotaryspeed }</td>
                <td>${ messagebm.backup }</td>
                <!-- 锁车状态：参考messagebm.getLockString() -->
                <td
                  <c:if test="${ LockString != '正常' }">
                     style="color:red;"
                  </c:if>
                >
                  ${ LockString }
                </td>
                <td>${ messagebm.oiltemperature }</td>
            </tr>
        </table>
        
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
               <li class="normal"><span>车钥匙</span>关闭</li>
             </c:when>
             <c:otherwise>
               <li class="on"><span>车钥匙</span>开启</li>
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
            
            <c:choose>
                  <c:when test="${ messagebm.warnys != null && messagebm.warnys == '报警' }">
                     <li class="warning"><span>油水</span>报警</li>
                  </c:when>
                  <c:otherwise>
                     <li class="on"><span>油水</span>正常</li>
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
<!--主休内容 结束-->
<script type="text/javascript">
   $(document).ready(function(){
      $(".positionMap").click(function(){
         window.top.document.getElementById("singleleftframe").contentWindow.openMap();
      });
   });
</script>
  </body>
</html>
